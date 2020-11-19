//
//  WalletViewController.swift
//  MiDokter User
//
//  Created by Vinod Reddy Sure on 12/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit
import ObjectMapper

class WalletViewController: UIViewController {

    @IBOutlet weak var labelAvailableBalanceValue: UILabel!
    @IBOutlet weak var textFieldAmount: HoshiTextField!
    @IBOutlet weak var buttonAddMoney: UIButton!
    @IBOutlet weak var topView: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLoads()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.setValues()
    }

    func setupAction(){
        self.buttonAddMoney.addTap {
            self.view.endEditing(true)
            if self.textFieldAmount.text?.isEmpty ?? false{
                showToast(msg: "Enter Valid amount to add wallet")
            }else{
                self.addMoney(amount: self.textFieldAmount.getText)
            }
        }
    }

    private func setValues(){
       let profile : ProfileModel = profileDetali
            self.labelAvailableBalanceValue.text = "$ \(profile.patient?.wallet_balance ?? 0) "
       
    }
}

extension WalletViewController {
    func initialLoads() {
        setupNavigationBar()
        self.setupAction()

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.topView.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 15.0)
    }
    
    private func setupNavigationBar() {
         self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Wallet"
         Common.setFont(to: self.navigationItem.title!, isTitle: true, size: 18)
         self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
         self.navigationController?.navigationBar.isTranslucent = false
         self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.02583951317, green: 0.1718649864, blue: 0.4112361372, alpha: 1)

    }
}


//Api calls
extension WalletViewController : PresenterOutputProtocol{
    func showSuccess(api: String, dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        switch String(describing: modelClass) {
            case model.type.CommonModel:
                 let data = dataDict as? CommonModel
                 showToast(msg: data?.message ?? "")
                
                 self.textFieldAmount.text = ""
                 
                break
            
            default: break
            
        }
    }
    
    func showError(error: CustomError) {
        
    }
    
    func addMoney(amount : String){
        self.presenter?.HITAPI(api: Base.addWallet.rawValue, params: ["amount" : amount], methodType: .POST, modelClass: CommonModel.self, token: true)
    }
    
    func cancelAppointment(id : String){
        self.presenter?.HITAPI(api: Base.cancelAppointment.rawValue, params: ["id" : id], methodType: .POST, modelClass: CommonModel.self, token: true)
    }
}
