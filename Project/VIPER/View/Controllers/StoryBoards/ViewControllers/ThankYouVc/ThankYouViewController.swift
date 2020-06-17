//
//  ThankYouViewController.swift
//  Project
//
//  Created by Hari Haran on 03/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class ThankYouViewController: UIViewController {
    
    @IBOutlet weak var thankYouImage: UIImageView!
    @IBOutlet weak var thankYouLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var thanksView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupAction()
        setTextFont()
        addTargetToImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
}

//MARK: Design Setup
extension ThankYouViewController {
    
    private func setupNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setTextFont() {
        Common.setFont(to: thankYouLabel, isTitle: true, size: 18)
        Common.setFont(to: titleLabel)
        Common.setFont(to: subTitleLabel)
        self.thanksView.makeRoundedCorner()
    }
    
    func setupAction(){
        self.view.addTap {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    private func addTargetToImage() {
        thankYouImage.isUserInteractionEnabled = true
        thankYouImage.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(goBackToHome)))
    }
    
    @objc private func goBackToHome() {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: HomeViewController.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    
}
