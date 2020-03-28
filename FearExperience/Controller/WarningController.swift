//
//  WarningViewController.swift
//  FearExperience
//
//  Created by Ganang Arief Pratama on 23/03/20.
//  Copyright © 2020 Untitled. All rights reserved.
//

import UIKit

class WarningController: UIViewController {
    
    private var warningView: WarningView!
    var delegate: WarningProceedDelegate?
    
    override func viewDidLoad() {
        self.warningView = WarningView(frame: self.view.frame)
        self.view = self.warningView
        
        self.warningView.continueButton.addTarget(self, action:#selector(onClickContinue), for: .touchUpInside)
        Utils.lockOrientation(.portrait)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        Utils.lockOrientation(.portrait)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    @objc func onClickContinue() {
        delegate?.warningProceeded()
        self.dismiss(animated: true, completion: nil)
    }
}
