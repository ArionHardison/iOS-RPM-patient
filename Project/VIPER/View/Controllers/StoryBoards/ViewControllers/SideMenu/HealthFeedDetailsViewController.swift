//
//  HealthFeedDetailsViewController.swift
//  Mi Dokter
//
//  Created by Mithra Mohan on 17/03/20.
//  Copyright © 2020 Mithra Mohan. All rights reserved.
//

import UIKit
import ObjectMapper

class HealthFeedDetailsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timelineLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var titleImage: UIImageView!
    
    var titleText : String = ""
      var descriptionText : String = ""
    var timeText : String = ""
    var imageTitle : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoads()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
       
    }
    

}

extension HealthFeedDetailsViewController {
    
    func initialLoads() {
        setupNavigationBar()

    }
    private func setupNavigationBar() {
         self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Articles"
         Common.setFont(to: self.navigationItem.title!, isTitle: true, size: 18)
         self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
         self.navigationController?.navigationBar.isTranslucent = false
         self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.02583951317, green: 0.1718649864, blue: 0.4112361372, alpha: 1)
        self.timelineLabel.text = timeText
        self.titleLabel.text = titleText
        self.descriptionTextView.text = descriptionText
        self.titleImage.setURLImage(imageTitle)
    }
}

