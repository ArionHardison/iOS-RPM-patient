//
//  ShowRecordViewController.swift
//  MiDokter User
//
//  Created by Sethuram Vijayakumar on 02/12/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class ShowRecordViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var viewFileButton: UIButton!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var titleString : String = ""
    var descriptionText : String = ""
    var Imagestring : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.intiatlLoads()
       
        
    }
    
}

extension ShowRecordViewController {
    
    private func intiatlLoads(){
        self.setupNavigationBar()
        self.setLocalization()
        self.titleTextField.text = self.titleString
        self.descriptionTextView.text = self.descriptionText
        self.viewFileButton.addTarget(self, action: #selector(viewFileAction(sender:)), for: .touchUpInside)
    }
    
    private func setLocalization(){
        self.titleLabel.text = "Patient Test/Past Prescription"
        self.descriptionLabel.text = "Description/Instruction"
    }
    
    
    private func setupNavigationBar() {
         self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Patient Records"
         Common.setFontWithType(to: self.navigationItem.title!, size: 18)
         self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
         self.navigationController?.navigationBar.isTranslucent = false
         self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.02583951317, green: 0.1718649864, blue: 0.4112361372, alpha: 1)
    }
    
    @IBAction private func viewFileAction(sender:UIButton)
    {
            let newImageView = UIImageView()
            newImageView.setURLImage(Imagestring)
            newImageView.enableZoom()
            newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
            newImageView.contentMode = .scaleAspectFit
            newImageView.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage(sender:)))
            newImageView.addGestureRecognizer(tap)
            self.view.addSubview(newImageView)
            self.navigationController?.isNavigationBarHidden = true
            self.tabBarController?.tabBar.isHidden = true
    }
  @objc func dismissFullscreenImage(sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    
}


extension UIImageView {
  func enableZoom() {
    let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
    isUserInteractionEnabled = true
    addGestureRecognizer(pinchGesture)
  }

  @objc
  private func startZooming(_ sender: UIPinchGestureRecognizer) {
    let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
    guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
    sender.view?.transform = scale
    sender.scale = 1
  }
}
