//
//  ExperienceVideoView.swift
//  FearExperience
//
//  Created by Ganang Arief Pratama on 26/03/20.
//  Copyright © 2020 Untitled. All rights reserved.
//

import UIKit
import AVFoundation

class VideoExperienceView: UIView {
    let videoUrl: String
    let videoPlayerView = VideoPlayerView()
    var isPlaying = false
    var timeObserverToken: Any?
  
    // 9 Add player
    @objc private let player = AVQueuePlayer()

    init(videoUrl: String) {
        self.videoUrl = videoUrl
    
        super.init(frame: .zero)
    
        // 10 Set up the player
        initializePlayer()
        addGestureRecognizers()
    }
    
    deinit {
        removePeriodicTimeObserver()
    }
  
    // 10 Set up player
    private func initializePlayer() {
        videoPlayerView.playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPlayerView.player = player
     
        addVideoToPlayer()

        player.volume = 1.0
        player.play()
        isPlaying = true
        addPeriodicTimeObserver()
    }
  
    // 11 Create player items from video URLs and insert them into the player's list
    private func addVideoToPlayer() {
        guard let videoURL = URL(string: videoUrl)  else { print("url error"); return }
        let asset = AVURLAsset(url: videoURL)
        let item = AVPlayerItem(asset: asset)
        player.insert(item, after: player.items().last)
    }
  
    // 12 Add methods to pause and play when the view leaves the screen
    func pause() {
        player.pause()
    }

    func play() {
        player.play()
    }
  
    // MARK - Gestures
  
    // 13 Add single and double tap gestures to the video looper
    func addGestureRecognizers() {
        // 1
        let tap = UITapGestureRecognizer(target: self, action: #selector(VideoExperienceView.wasTapped))
        let doubleTap = UITapGestureRecognizer(target: self,
                                               action: #selector(VideoExperienceView.wasDoubleTapped))
        doubleTap.numberOfTapsRequired = 2
        
        // 2
        tap.require(toFail: doubleTap)

        // 3
        addGestureRecognizer(tap)
        addGestureRecognizer(doubleTap)
    }
  
    // 13a Single tapping should toggle the volume
    @objc func wasTapped() {
        isPlaying ? pause() : play()
        isPlaying = !isPlaying
    }
  
    // MARK - Unnecessary Code
    @objc func wasDoubleTapped() {
    }
  
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addPeriodicTimeObserver() {
        // Notify every half second
        let timeScale = CMTimeScale(NSEC_PER_SEC)
        let time = CMTime(seconds: 0.5, preferredTimescale: timeScale)

        timeObserverToken = player.addPeriodicTimeObserver(forInterval: time,
                                                          queue: .main) {
            [weak self] time in print("TIME", time)
        }
    }
    
    func removePeriodicTimeObserver() {
        if let timeObserverToken = timeObserverToken {
            player.removeTimeObserver(timeObserverToken)
            self.timeObserverToken = nil
        }
    }
}

extension VideoExperienceView {
    override func layoutSubviews() {
        super.layoutSubviews()
    
        videoPlayerView.frame = bounds
        addSubview(videoPlayerView)
    }
}
