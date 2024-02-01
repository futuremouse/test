import UIKit

class ProfileDesignViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: - Properties
    var collectionView: UICollectionView?
    
    var arrImageName: [String] = ["image1","image2","image3","image4","image5","image6","image7","image8","image9","image10","image11","image12","image13","image14","image15","image16","image17","image18","image19","image20"]
    
    var userName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "NABAECAMP".uppercased()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var menuButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBackground
        button.setImage(UIImage(named: "Menu"), for: .normal)
        return button
    }()
    
    
    let profileImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.image = UIImage(named:"Icon")
        return imageview
    }()
    
    let name: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "르탄이"
        label.textColor = UIColor(named: "#252525")
        label.font = UIFont(name: "OpenSans-Bold", size: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let bioLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "iOS Developer 🍎"
        label.textColor = UIColor(named: "#252525")
        label.font = UIFont(name: "OpenSans", size: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let linkBioLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let letterSpacing: CGFloat = -0.5
        let attributedString = NSMutableAttributedString(string: "spartacodingclub.kr")
        attributedString.addAttribute(.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedString.length))
        
        label.attributedText = attributedString
        label.textColor = UIColor(named: "#10467D")
        label.font = UIFont(name:"OpenSans", size: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    lazy var postsStatusLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textColor = .black
        label.font = UIFont(name: "OpenSans", size: 16.5)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var followersStatusLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textColor = .black
        label.font = UIFont(name: "OpenSans", size: 16.5)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var followingStatusLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textColor = .black
        label.font = UIFont(name: "OpenSans", size: 16.5)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var postsLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "post"
        label.textColor = UIColor.black
        label.font = UIFont(name: "OpenSans", size: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var followersLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "follower"
        label.textColor = UIColor.black
        label.font = UIFont(name: "OpenSans", size: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var followingLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "following"
        label.textColor = UIColor.black
        label.font = UIFont(name: "OpenSans", size: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var followButton : UIButton = {
        let v = UIButton()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.setTitle("follow", for: .normal)
        v.setTitleColor(UIColor(named: "WhiteColor"), for: .normal)
        v.titleLabel?.font = UIFont(name: "OpenSans", size: 14)
        v.titleLabel?.textAlignment = .center
        v.backgroundColor = UIColor(red: 56/255, green: 152/255, blue: 243/255, alpha: 1.0)
        v.layer.cornerRadius = 4.0
        
        return v
    }()
    
    lazy var messageButton : UIButton = {
        let v = UIButton()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.setTitle("message", for: .normal)
        v.setTitleColor(UIColor.black, for: .normal)
        v.titleLabel?.font = UIFont(name: "OpenSans", size: 14)
        v.titleLabel?.textAlignment = .center
        v.backgroundColor = .white
        v.layer.cornerRadius = 4.0
        v.layer.borderWidth = 1.5
        v.layer.borderColor = UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1.0).cgColor
        return v
    }()
    
    let moreButton: UIButton = {
        let v = UIButton()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .systemBackground
        v.setImage(UIImage(named: "More"), for: .normal)
        return v
    }()
    
    let barImage: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 219/255, green: 219/255, blue: 219/255, alpha: 1.0) // 배경색 설정
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 2).isActive = true
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor(red: 219/255, green: 219/255, blue: 219/255, alpha: 1.0).cgColor
        return view
    }()
    
    let gridButton: UIButton = {
        let v = UIButton()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .systemBackground
        v.setImage(UIImage(named: "Grid"), for: .normal)
        return v
    }()
    
//    let profileButton: UIButton = {
//        let v = UIButton()
//        v.translatesAutoresizingMaskIntoConstraints = false
//        v.backgroundColor = .systemBackground
//        v.setImage(UIImage(named: "profile"), for: .normal)
//        return v
//    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        
//        let tabBarController = UITabBarController()
//        
//        // Create view controllers for each tab
//        let firstTabViewController = ProfileDesignViewController()
//        firstTabViewController.title = "First"
//        let secondTabViewController = ProfileViewController()
//        secondTabViewController.title = "Profile"
//        
//        tabBarController.viewControllers = [firstTabViewController, secondTabViewController]
//        
//        // Set the tab bar controller as a child view controller
//        addChild(tabBarController)
//        view.addSubview(tabBarController.view)
//        tabBarController.didMove(toParent: self)
//
//        
        setupViews()
    }
    
    // MARK: - Setup Methods
    private func setupViews() {
        setupProfileView()
        setupProfileStackView()
        setupButtonStackView()
        setupCollectionView()
    }
    
    private func setupProfileView() {
        
        self.view.addSubview(userName)
        self.view.addSubview(menuButton)
        
        self.view.addSubview(profileImageView)
        
        self.view.addSubview(postsStatusLabel)
        self.view.addSubview(followersStatusLabel)
        self.view.addSubview(followingStatusLabel)
        
        self.view.addSubview(postsLabel)
        self.view.addSubview(followersLabel)
        self.view.addSubview(followingLabel)
        
        self.view.addSubview(barImage)
        self.view.addSubview(gridButton)
        
//        self.view.addSubview(profileButton)
        
        self.view.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            
            userName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userName.heightAnchor.constraint(equalToConstant: 25),
            userName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
   
            menuButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 14),
            menuButton.widthAnchor.constraint(equalToConstant: 21),
            menuButton.heightAnchor.constraint(equalToConstant: 17.5),
            menuButton.leadingAnchor.constraint(equalTo: userName.trailingAnchor, constant: 102),
            menuButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            postsStatusLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 72),
            postsStatusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 152),
            
            followersStatusLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 72),
            followersStatusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 232),
            
            followingStatusLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 72),
            followingStatusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 314),
            
            postsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 94),
            postsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 143),
            
            followersLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 94),
            followersLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 213),
            
            followingLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 94),
            followingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 290),
     
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 49),
            profileImageView.widthAnchor.constraint(equalToConstant: 88),
            profileImageView.heightAnchor.constraint(equalToConstant: 88),
            profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            
            barImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 261),
            barImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            barImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            gridButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 271),
            gridButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 52),
            
//            profileButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 720),
//            profileButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 50),
//            profileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
    }
    
    private func setupButtonStackView() {
        let buttonStackView = UIStackView(arrangedSubviews: [followButton, messageButton, moreButton])
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 8.0 // 버튼 사이의 간격을 8로 설정
        
        view.addSubview(buttonStackView)
        
        // 동일한 너비 제약 추가
        let buttonWidthConstraint = followButton.widthAnchor.constraint(equalTo: messageButton.widthAnchor)
        buttonWidthConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 221),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            moreButton.trailingAnchor.constraint(equalTo: buttonStackView.trailingAnchor)
        ])
        
    }
    
    func setupProfileStackView() {
        let profileStackView = UIStackView(arrangedSubviews: [name, bioLabel, linkBioLabel])
        profileStackView.translatesAutoresizingMaskIntoConstraints = false
        profileStackView.axis = .vertical
        
        view.addSubview(profileStackView)
        
        NSLayoutConstraint.activate([
            profileStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 151),
            profileStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            profileStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
        ])
    }
    
    private func setupCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        let width = (view.frame.width - 20) / 3
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumInteritemSpacing = 2 // 셀 간의 가로 간격
        layout.minimumLineSpacing = 2 // 셀 간의 세로 간격
        
        // 여백 추가
        let inset = (view.frame.width - (width * 3 + 2 * 2)) / 2 // 총 가로 여백에서 셀과 가로 간격의 합을 빼서 2로 나눔
        layout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        
        // collectionView를 초기화하고 속성을 설정
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 363, width: view.bounds.width, height: width * 3), collectionViewLayout: layout)
        
        
        if let collectionView = collectionView {
            collectionView.isScrollEnabled = true // 스크롤 활성화
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
            
            view.addSubview(collectionView)
            
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 348),
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                collectionView.heightAnchor.constraint(equalToConstant: width * 3)
            ])
        }
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImageName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 셀을 재사용 큐에서 가져오거나 새로 생성합니다.
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as? CollectionViewCell else {
            fatalError("Unable to dequeue CollectionViewCell")
        }
        
        let imageName = arrImageName[indexPath.row]
        
        cell.setImage(named: imageName)
        
        return cell
    }
    
    
    // MARK: - UICollectionViewDelegateFlowLayout
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //
    //        let width: CGFloat = (view.frame.width - 20) / 3
    //
    //        return CGSize(width: width, height: width)
    //    }
    //
    //    // CollectionView Cell의 위아래 간격
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    //        return 2.0
    //    }
    //
    //    // CollectionView Cell의 옆 간격
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    //        return 2.0
    //    }
    
}
