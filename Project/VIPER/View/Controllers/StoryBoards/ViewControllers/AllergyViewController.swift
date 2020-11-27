//
//  AllergyViewController.swift
//  MiDokter User
//
//  Created by Basha's MacBook Pro on 23/11/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class AllergyViewController: UIViewController {
    
    @IBOutlet weak var topTitlelbl: UILabel!
    @IBOutlet weak var doneBtn: UIButton!
    
    @IBOutlet weak var addallergyView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: PaddingLabel!
    
    @IBOutlet weak var noView: UIView!
    @IBOutlet weak var toptitleView: UIView!

    @IBOutlet weak var addAllergyLbl: UILabel!
    @IBOutlet weak var noLbl: UILabel!
    
    var allergies = [String]()
    var onClickDone : (([String])->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setFont()
        self.addAction()

        
//        Common.setFont(to: self.navigationItem.title!, isTitle: true, size: 18)

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        self.titleLbl.roundCorners(corners: [.topLeft,.topRight], radius: 15.0)

    }
    func addAction(){
        
        noView.addTap {
            
//            let vc = self.storyboard?.instantiateViewController(identifier: "AllergiesListViewController") as? AllergiesListViewController
//            self.present(id: "AllergiesListViewController", animation: true)
            self.dismiss(animated: true, completion: nil)
        }
        
        addallergyView.addTap {
            
            let vc = self.storyboard?.instantiateViewController(identifier: "AllergiesListViewController") as! AllergiesListViewController
            vc.modalPresentationStyle = .overFullScreen
            vc.onClickDone = { allergies in
                self.allergies = allergies
                print(self.allergies )
                vc.dismiss(animated: true, completion: nil)
                
            }
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
    func setFont() {
        self.navigationController?.isNavigationBarHidden = true
//        self.titleLbl.roundCorners(corners: [.topLeft,.topRight], radius: 7.0)
        Common.setFontWithType(to: doneBtn, size: 16, type: .regular)
        Common.setFontWithType(to: topTitlelbl, size: 16, type: .regular)
        Common.setFontWithType(to: titleLbl, size: 16, type: .meduim)
        Common.setFontWithType(to: addAllergyLbl, size: 16, type: .regular)
        Common.setFontWithType(to: noLbl, size: 14, type: .meduim)

    }
    
    @IBAction private func doneAction (sender : UIButton){
        
        self.onClickDone?(self.allergies)

//        self.dismiss(animated: true, completion: nil)

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}




