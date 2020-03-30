//
//  ExperienceViewController.swift
//  FearExperience
//
//  Created by Ganang Arief Pratama on 23/03/20.
//  Copyright © 2020 Untitled. All rights reserved.
//

import UIKit
import AVKit

class ExperienceController: UIViewController {
    
    var alreadyPlayVideo = false
    var videoPlayerView = VideoPlayerView()
    var videoExperienceView = VideoExperienceView(videoUrl: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
    var duration: Double?
    var progressTime: Double?
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "xmark")?.withRenderingMode(.alwaysTemplate)
        button.tintColor = .gray
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = UIColor(white: 1, alpha: 0.2)
        button.setImage(image, for: UIControl.State.normal)
        button.contentMode = .scaleAspectFit
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top:0, left: 0, bottom:0, right: 0)
        button.addTarget(self, action:#selector(onClickClose), for: .touchUpInside)
        
        return button
    }()
    
    @objc func onClickClose() {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.isToolbarHidden = true
        
        view.addSubview(videoExperienceView)
        view.addSubview(closeButton)
        
        videoExperienceView.translatesAutoresizingMaskIntoConstraints = false
        videoExperienceView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        videoExperienceView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        videoExperienceView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        videoExperienceView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        closeButton.layer.cornerRadius = 20
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveProgressData), name: NSNotification.Name(rawValue: "progress"), object: .none)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveDurationData), name: NSNotification.Name(rawValue: "duration"), object: .none)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("progress"), object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name("duration"), object: nil)
    }
    
    @objc func onDidReceiveDurationData(_ notification: Notification) {
        let userInfo = notification.userInfo
        duration = userInfo?["duration"] as? Double
        print(duration ?? 0.0)
    }
    
    @objc func onDidReceiveProgressData(_ notification: Notification) {
        let userInfo = notification.userInfo
        progressTime = userInfo?["progress"] as? Double
        print(progressTime ?? 0.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //? Start the looping video player when the view appears
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        videoExperienceView.play()
        alreadyPlayVideo = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if alreadyPlayVideo == true {
            let value = UIInterfaceOrientation.portrait.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
            videoExperienceView.pause()
        }
        self.navigationController?.navigationBar.isHidden = false
    }
    
}



