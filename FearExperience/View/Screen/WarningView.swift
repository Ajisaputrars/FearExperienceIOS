//
//  WarningView.swift
//  FearExperience
//
//  Created by Aji Saputra Raka Siwi on 25/03/20.
//  Copyright © 2020 Untitled. All rights reserved.
//

import UIKit

class WarningView: BaseView {
    
    let showWarning: UIImageView = {
        let warning = UIImage(named: "Warning")
        let warningPrompt = UIImageView(image: warning)
        warningPrompt.contentMode = .scaleAspectFit
        warningPrompt.translatesAutoresizingMaskIntoConstraints = false
        return warningPrompt
    } ()
    
    let continueButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("CONTINUE", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = .red
        button.layer.cornerRadius = 8
        button.startAnimatingPressActions()
        
        return button
    }()
    
    override func setupView() {
        self.backgroundColor = .black
        
        self.addSubview(showWarning)
        self.addSubview(continueButton)

        showWarning.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        showWarning.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        showWarning.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        showWarning.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -60).isActive = true

        continueButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -60).isActive = true
        continueButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        continueButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        continueButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
}
