//
//  VideoPlayerView.swift
//  FearExperience
//
//  Created by Ganang Arief Pratama on 26/03/20.
//  Copyright © 2020 Untitled. All rights reserved.
//

import UIKit

//4 Add the AVFoundation import so we can use AVPlayerLayer and AVPlayer
import AVFoundation

class VideoPlayerView: UIView {
    // 7 Add player property so the video the layer shows can be updated
    var player: AVPlayer? {
        get {
            return playerLayer.player
        }

        set {
            playerLayer.player = newValue
        }
    }
      
    // 5 Override the layerClass
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
      
    // 6 Add accessor for playerLayer so you don't need to
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
}
