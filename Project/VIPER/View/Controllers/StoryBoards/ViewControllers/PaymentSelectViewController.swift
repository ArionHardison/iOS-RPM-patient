//
//  PaymentSelectViewController.swift
//  MiDokter User
//
//  Created by Sethuram Vijayakumar on 17/12/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit
import ObjectMapper

class PaymentSelectViewController: UIViewController {
    @IBOutlet weak var paymentTableView: UITableView!
    @IBOutlet weak var addCardsButton: UIButton!
    var cardsList : [CardsModel]?
    var onSelectPaymentType : ((String,String,String)->Void)?
    
    private lazy var loader : UIView = {
        return createActivityIndicator(UIScreen.main.focusedView ?? self.view)
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialLoads()

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.getCards()
    }
    

}


extension PaymentSelectViewController {
    
    private func initialLoads(){
        self.paymentTableView.register(UINib(nibName: XIB.Names.PaymentModeTableViewCell, bundle: nil), forCellReuseIdentifier: XIB.Names.PaymentModeTableViewCell)
        self.paymentTableView.delegate = self
        self.paymentTableView.dataSource = self
        self.addCardsButton.addTarget(self, action: #selector(addCardsAction(_sender:)), for: .touchUpInside)
        self.setNavigationBar()
        self.addCardsButton.setTitle("Add Cards For Payment", for: .normal)
        
    }
    private func getCards(){
        let url = "\(Base.addCard.rawValue)?user_type=patient"
        self.presenter?.HITAPI(api: url, params: nil, methodType: .GET, modelClass: CardsModel.self, token: true)
        self.loader.isHidden = false
    }
    
    @IBAction private func addCardsAction(_sender:UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier:Storyboard.Ids.AddCardViewController) as! AddCardViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setNavigationBar(){
        
             self.navigationController?.isNavigationBarHidden = false
            self.navigationItem.title = "Payment View"
             Common.setFont(to: self.navigationItem.title!, isTitle: true, size: 18)
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
             self.navigationController?.navigationBar.isTranslucent = false
             self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.02583951317, green: 0.1718649864, blue: 0.4112361372, alpha: 1)
        
    }
    
}

extension PaymentSelectViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else if section == 1{
            return cardsList?.count ?? 0
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.PaymentModeTableViewCell, for: indexPath) as! PaymentModeTableViewCell
        if indexPath.section == 0{
            cell.paymentImageView.image = #imageLiteral(resourceName: "wallet")
            cell.paymentTitleLabel.text = "Wallet"
            return cell
        }else{
            cell.paymentImageView.image = #imageLiteral(resourceName: "CardIcon")
            cell.paymentTitleLabel.text = "XXXX-XXXX-XXXX-\(self.cardsList?[indexPath.row].last_four ?? "")"
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            self.onSelectPaymentType?("wallet","","")
        }else if indexPath.section == 1{
            self.onSelectPaymentType?("stripe",self.cardsList?[indexPath.row].card_id ?? "",self.cardsList?[indexPath.row].last_four ?? "")
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = Bundle.main.loadNibNamed("FaqHeaderView", owner: self, options: nil)?.first as? FaqHeaderView
        if section == 0{
        headerView?.titleLbl.text = "Payment Modes"
        }else{
            headerView?.titleLbl.text = "Available Cards"
        }
        headerView?.plusLbl.isHidden = true
        headerView?.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0.1))
        view.backgroundColor = .clear //UIColor(named: "TextForegroundColor")
        return view
    }
    
}


extension PaymentSelectViewController : PresenterOutputProtocol {
    func showSuccess(api: String, dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        switch String(describing: modelClass) {
        case model.type.CardsModel:
           
            let data = dataArray as? [CardsModel]
            self.cardsList = data ?? []
            self.paymentTableView.reloadInMainThread()
            self.loader.isHideInMainThread(true)
            break
            
        default:
            break
        }
    }
    
    func showError(error: CustomError) {
        showToast(msg: error.localizedDescription)
    }
    
    
}
