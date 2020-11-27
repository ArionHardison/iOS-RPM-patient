//
//  AllergiesListViewController.swift
//  MiDokter User
//
//  Created by Basha's MacBook Pro on 23/11/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class AllergiesListViewController: UIViewController {

    @IBOutlet weak var allergyTableView : UITableView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var toptitleView: UIView!

    @IBOutlet weak var titleLbl: PaddingLabel!
    
    @IBOutlet weak var allergySearchBar: UISearchBar!
    
//    var dataStr = ["Lacoste","Soy","SeaFood","Nut","Fish","Mushroom","Gut","Pencillin","Others"]
    var allergy : [Allergies] = profileDetali.allergies ?? []
    var allergyID = [Int]()
    var allergyName = [String]()
    var onClickDone : (([String])->Void)?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpnavigation()
        
//        self.allergyID += [allergy.count]
//        self.allergyName += [""]

        self.allergyTableView.register(UINib(nibName: "FAQCell", bundle: nil), forCellReuseIdentifier: "FAQCell")
        self.allergyTableView.allowsMultipleSelection = true
    
//        Common.setFont(to: self.navigationItem.title!, isTitle: true, size: 18)

        // Do any additional setup after loading the view.
    }
    
    
        
    func setUpnavigation() {

        self.navigationController?.isNavigationBarHidden = true

        
        Common.setFontWithType(to: doneBtn, size: 16, type: .regular)
        Common.setFontWithType(to: allergySearchBar, size: 16, type: .regular)
        Common.setFontWithType(to: titleLbl, size: 16, type: .meduim)
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        self.titleLbl.roundCorners(corners: [.topLeft,.topRight], radius: 15.0)

    }
    func addAction(){
        
        
    }
    
    @IBAction private func backAction (sender : UIButton){
     
        self.dismiss(animated: true, completion: nil)

    }
    
    @IBAction private func doneAction (sender : UIButton){
        
        
        print(allergyName)
        self.onClickDone?(allergyName)
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
extension AllergiesListViewController {
    
    
}

extension AllergiesListViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = Bundle.main.loadNibNamed("FaqHeaderView", owner: self, options: nil)?.first as? FaqHeaderView
        headerView?.titleLbl.text = "Suggestions"
        headerView?.plusLbl.isHidden = true
        headerView?.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0.1))
        view.backgroundColor = .clear //UIColor(named: "TextForegroundColor")
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allergy.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FAQCell", for: indexPath) as? FAQCell
        cell?.textLbl.text = self.allergy[indexPath.row].name
        cell?.accessoryType = .none
        cell?.tintColor = .AppBlueColor

        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as? FAQCell
        cell?.accessoryType = .checkmark
        self.allergyID.append(self.allergy[indexPath.row].id ?? 0)
        self.allergyName.append(self.allergy[indexPath.row].name ?? "")

    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as? FAQCell
        cell?.accessoryType = .none
        let names = self.allergy[indexPath.row].name
        let ids = self.allergyName.lastIndex{$0 == names}
        self.allergyName.remove(at: ids!)
        self.allergyID.remove(at: ids!)


    }

    
}


 
