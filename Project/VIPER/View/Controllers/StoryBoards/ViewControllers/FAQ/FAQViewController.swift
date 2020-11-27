//
//  FAQViewController.swift
//  MiDokter User
//
//  Created by Basha's MacBook Pro on 19/11/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit
import ObjectMapper

class FAQViewController: UIViewController {

    @IBOutlet weak var faqTableView: UITableView!
    var hiddenSections = Set<Int>()
//    var section = 0

    var faq = [Faq]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpnavigation()
        
        self.presenter?.HITAPI(api: Base.faq.rawValue, params: nil, methodType: .GET, modelClass: FAQModel.self, token: true)
        for value in 0..<faq.count { self.hideSection(section: value)}
        
        
        self.faqTableView.register(UINib(nibName: "FAQCell", bundle: nil), forCellReuseIdentifier: "FAQCell")
        


//        Common.setFont(to: self.navigationItem.title!, isTitle: true, size: 18)

        // Do any additional setup after loading the view.
    }
    
    
    
    func setUpnavigation() {
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.02583951317, green: 0.1718649864, blue: 0.4112361372, alpha: 1)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "FAQ"
        //
        
        let button: UIButton = UIButton(type: .custom)
        //set image for button
        button.setImage(UIImage(systemName: "headphones"), for: .normal)
        button.tintColor = .white
        //add function for button
        button.addTarget(self, action: #selector(doneAction(sender:)), for: .touchUpInside)
        //set frame
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
   
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneAction(sender:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        Common.setFontWithType(to: self.navigationItem.title!, size: 18, type: .regular)

    }
    
    @IBAction private func doneAction (sender : UIBarButtonItem){

        let alert = UIAlertController(title: "Conact our Help center", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Chat", style: .default, handler: { (Void) in
        }))
        alert.addAction(UIAlertAction(title: "Call", style: .default, handler: { (Void) in
        }))
        alert.addAction(UIAlertAction(title: "Web", style: .default, handler: { (Void) in
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
        alert.view.tintColor = .AppBlueColor
        self.present(alert, animated: true, completion: nil)

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
extension FAQViewController {
    
    private func hideSection(section:Int) {
        let section = section
        

        
        func indexPathsForSection() -> [IndexPath] {
                var indexPaths = [IndexPath]()
                
                for row in 0..<1 {
                    indexPaths.append(IndexPath(row: row,
                                                section: section))
                }
                
                return indexPaths
            }
        
        
        if self.hiddenSections.contains(section) {
            self.hiddenSections.remove(section)
            self.faqTableView.insertRows(at: indexPathsForSection(),
                                      with: .fade)
        } else {
            self.hiddenSections.insert(section)
            self.faqTableView.deleteRows(at: indexPathsForSection(),
                                      with: .fade)
        }

    }
    
    
}




extension FAQViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return faq.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = Bundle.main.loadNibNamed("FaqHeaderView", owner: self, options: nil)?.first as? FaqHeaderView
        headerView?.titleLbl.text = faq[section].question
        headerView?.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50)
        headerView?.addTap {
            self.hideSection(section: section)
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0.3))
        view.backgroundColor = UIColor(named: "TextForegroundColor")
        return view
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.hiddenSections.contains(section) {
            return 0
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FAQCell", for: indexPath) as? FAQCell
        cell?.textLbl.text = faq[indexPath.section].answer
        return cell!
    }
    
}


extension FAQViewController : PresenterOutputProtocol {
    func showSuccess(api: String, dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        DispatchQueue.main.async {
            switch String(describing: modelClass) {
                case model.type.FAQModel:
                    
                    let data = dataDict as? FAQModel
                    self.faq = data?.faq ?? []
                    self.faqTableView.reloadInMainThread()
                    
                    break
                
                default: break
                
            }
            
        }
    }
    
    func showError(error: CustomError) {
        showToast(msg:error.localizedDescription)
    }
    
    
}
