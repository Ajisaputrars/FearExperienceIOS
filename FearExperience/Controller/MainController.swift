//
//  MainViewController.swift
//  FearExperience
//
//  Created by Ganang Arief Pratama on 23/03/20.
//  Copyright © 2020 Untitled. All rights reserved.
//

import UIKit

class MainController: UIViewController{
    
    private var mainView: MainView!
    private var isWarningHasBeenShown = false
    private var fearExperiences = [FearExperienceModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Experiences"
                
        self.mainView = MainView(frame: self.view.frame)
        setFearExperiences()
        
        setupNavigationController()
        Utils.lockOrientation(.portrait)
        
        self.mainView.experienceCollectionView.delegate = self
        self.mainView.experienceCollectionView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        Utils.lockOrientation(.portrait)
    }
    
    private func setFearExperiences(){
        if let path = Bundle.main.path(forResource: "FearExperience", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let response = try Utils.fearExperienceJsonParser(data: data)
                self.fearExperiences = response!
            } catch let error {
                print(error)
            }
        } else {
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Utils.lockOrientation(.all)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if isWarningHasBeenShown == false {
            showWarning()
        }
    }
    
    private func showWarning(){
        let warningController = WarningController()
        warningController.delegate = self
        warningController.modalPresentationStyle = .fullScreen
        self.present(warningController, animated: true, completion: nil)
        
        self.isWarningHasBeenShown = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    func onClickPlay() {
        let experienceView = ExperienceController()
        navigationController?.pushViewController(experienceView, animated: true)
    }
    
    private func setupNavigationController(){
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isHidden = true
    }
}

extension MainController: UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.fearExperiences.count
    }
       
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: experienceCellId, for: indexPath) as! CardCell
        cell.view = self
        cell.fearExperienceImageView.image = UIImage(named: self.fearExperiences[indexPath.row].mainImageString)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width - 32, height: view.frame.height / 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 16
    }
}

extension MainController: WarningProceedDelegate {
    func warningProceeded() {
        self.view = self.mainView
        self.navigationController?.navigationBar.isHidden = false
    }
}
