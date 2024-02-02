//
//  RandomVideoViewController.swift
//  d
//
//  Created by t2023-m0024 on 2/1/24.
//
struct Video: Codable {
    let videoUrl: String
}

import UIKit
import AVKit

class RandomVideoViewController: UIViewController {
    
    var player: AVPlayer?
    var playerController = AVPlayerViewController()
    
    let playButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Play", for: .normal)
        button.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(playButton)
        
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        loadVideoURL()
    }
    
    func loadVideoURL() {
        let url = URL(string: "https://gist.githubusercontent.com/poudyalanil/ca84582cbeb4fc123a13290a586da925/raw/14a27bd0bcd0cd323b35ad79cf3b493dddf6216b/videos.json")!

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else {
                print("Network error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let videos = try JSONDecoder().decode([Video].self, from: data)
                if let firstVideoUrl = videos.first?.videoUrl, let url = URL(string: firstVideoUrl) {
                    DispatchQueue.main.async {
                        self.player = AVPlayer(url: url)
                    }
                }
            } catch {
                print("JSON parsing error: \(error.localizedDescription)")
            }
        }

        task.resume()
    }

    
    @objc func playButtonTapped() {
        guard let player = player else { return }
        
        playerController.player = player
        self.present(playerController, animated: true) {
            player.play()
        }
    }
}
