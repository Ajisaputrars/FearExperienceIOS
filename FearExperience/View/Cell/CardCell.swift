//
//  CardViewCell.swift
//  FearExperience
//
//  Created by Ganang Arief Pratama on 23/03/20.
//  Copyright © 2020 Untitled. All rights reserved.
//

import UIKit

class CardCell: BaseCell {
    
    var view: UIViewController?

    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    let fearExperienceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    func blurImage(image: UIImage, blurAmount: CGFloat) -> UIImage?
    {
        guard let ciImage = CIImage(image: image) else
        {
            return nil
        }
        
        let blurFilter = CIFilter(name: "CIGaussianBlur")
        blurFilter?.setValue(ciImage, forKey: kCIInputImageKey)
        blurFilter?.setValue(blurAmount, forKey: kCIInputRadiusKey)
        
        guard let outputImage = blurFilter?.outputImage else
        {
            return nil
        }
        
        return UIImage(ciImage: outputImage)
    }
    
    let translucentLayer: UIImageView = {
        let image = UIImage(named: "untitled")
        //guard let layer = self.blurImage(image: image, blurAmount: 20) else
        //{
        //    return 0
        //}
        //let imageView = UIImageView(image: layer)
        let imageView = UIImageView(image: image)
        imageView.isOpaque = true
        imageView.alpha = 0.5
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()

    lazy var buttonPlay: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.fill")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("PLAY", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = UIColor(red:0.00, green:0.76, blue:0.38, alpha:1.00)
        button.layer.cornerRadius = 16
        button.setImage(image, for: UIControl.State.normal)
        button.tintColor = .white
        button.contentMode = .scaleAspectFit
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top:0, left: 0, bottom:0, right: -85)
        button.titleEdgeInsets = UIEdgeInsets(top:0, left: -15, bottom:0, right:20)
        button.addTarget(self, action:#selector(onClickPlay), for: .touchUpInside)
        button.startAnimatingPressActions()
        
        return button

    }()
    
    @objc func onClickPlay() {
        let experienceView = ExperienceController()
        experienceView.modalPresentationStyle = .fullScreen
        view?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        view?.navigationController?.pushViewController(experienceView, animated: true)
    }
    
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        containerView.addSubview(fearExperienceImageView)
        fearExperienceImageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        fearExperienceImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        fearExperienceImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        fearExperienceImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        addSubview(buttonPlay)
        buttonPlay.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        buttonPlay.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        buttonPlay.widthAnchor.constraint(equalToConstant: 100).isActive = true
        buttonPlay.heightAnchor.constraint(equalToConstant: 37.5).isActive = true
        
        containerView.addSubview(translucentLayer)
        containerView.sendSubviewToBack(fearExperienceImageView)
        translucentLayer.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        
    }
}
