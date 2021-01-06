//
//  SummaryViewController.swift
//  MiDokter User
//
//  Created by AppleMac on 13/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit
import ObjectMapper
import SDWebImage

class SummaryViewController: UIViewController {
    
    
    @IBOutlet weak var backBtn : UIButton!
    @IBOutlet weak var titleLbl : UILabel!
    @IBOutlet weak var proceedTPayBtn : UIButton!
    @IBOutlet weak var feeLbl : UILabel!
    @IBOutlet weak var offerPriceLbl : UILabel!
    @IBOutlet weak var orginalPrieLbl : UILabel!
    @IBOutlet weak var applyBtn : UIButton!
    @IBOutlet weak var moneyBack : UILabel!
    @IBOutlet weak var promoCode : UITextField!
    
    @IBOutlet weak var verifiedLbl : UILabel!
    @IBOutlet weak var chatoutLbl : UILabel!
    @IBOutlet weak var userCollection : UICollectionView!
    @IBOutlet weak var bottomView : UIView!
    @IBOutlet weak var strickView : UIView!
    @IBOutlet weak var selectedPaymentMode: UILabel!
    @IBOutlet weak var changePaymentButton: UIButton!
    
    
    var selectedCategory : Category = Category()
    var doctors : DoctorsDetailModel = DoctorsDetailModel()
    var proceedAmount : String = "0"
    var message : String = ""
    var offerPrice : String = ""
    var price : String = ""
    var selectedPaymentType : String = "wallet"
    var cardId : String = ""
    
    private lazy var loader  : UIView = {
        return createActivityIndicator(self.view)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialsetup()
        self.proceedAmount = self.offerPrice
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.getDoctorsList(id: selectedCategory.id?.description ?? "")
    }
    
    
    func initialsetup(){
        self.setupAction()
        self.setupFont()
        self.setupCollectionViewCell()
        self.navigationController?.isNavigationBarHidden = true
        
        
        bottomView.clipsToBounds = true
        bottomView.layer.cornerRadius = 20
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.changePaymentButton.addTarget(self, action: #selector(changePaymentAction(_sender:)), for: .touchUpInside)
       
    }
    
    func setupAction(){
        self.backBtn.addTap {
            self.navigationController?.popViewController(animated: true)
        }
        
        self.proceedTPayBtn.addTap {
            self.proceedToPay(id: (self.doctors.specialities?.id ?? 0).description, message: self.message, Amount: self.proceedAmount, promo_id: "1", speciality_id:  (self.doctors.specialities?.id ?? 0).description)
        }
        
        self.applyBtn.addTap {
            guard let promo : String = self.promoCode.text, promo.isEmpty != true else {
                showToast(msg: "Enter PromoCode")
                return
            }
            self.applyPromo(id: (self.doctors.specialities?.id ?? 0).description, promocode: self.promoCode.getText)
        }
    }
    
    
    func setupFont(){
//        Common.setFont(to: titleLbl, isTitle: true, size: 20)
//        Common.setFont(to: feeLbl, isTitle: true, size: 18)
//        Common.setFont(to: proceedTPayBtn, isTitle: true, size: 20)
//        Common.setFont(to: backBtn, isTitle: true, size: 20)
//        Common.setFont(to: offerPriceLbl, isTitle: false, size: 17)
//        Common.setFont(to: orginalPrieLbl, isTitle: false, size: 15)
//        Common.setFont(to: moneyBack, isTitle: false, size: 14)
//        Common.setFont(to: verifiedLbl, isTitle: false, size: 16)
//        Common.setFont(to: chatoutLbl, isTitle: false, size: 16)
//        Common.setFont(to: promoCode, isTitle: false, size: 18)
    }
    
    func setSeatchCountLbl(price : Int = 0,offer : Int){
        let attrs1 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : UIColor.black]
        
        let attrs2 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : UIColor.AppBlueColor]
        
        let attributedString1 = NSMutableAttributedString(string:" $ \(price) ", attributes:attrs1)
        
        let attributedString2 = NSMutableAttributedString(string:"(\(offer) off)", attributes:attrs2)
        
        attributedString1.append(attributedString2)
        self.orginalPrieLbl.attributedText = attributedString1
    }

    override func viewWillDisappear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    
}


extension SummaryViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.doctors.specialities?.doctor_profile?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: XIB.Names.PhotosCell, for: indexPath) as! PhotosCell
        cell.photoImage.setURLImage(self.doctors.specialities?.doctor_profile?[indexPath.row].profile_pic ?? "")
//        let imageUrl = imageURL + (self.doctors.specialities?.doctor_profile?[indexPath.row].profile_pic ?? "")
//        cell.photoImage.sd_setImage(with: URL(string:imageUrl), placeholderImage: #imageLiteral(resourceName: "userPlaceholder-2"))
//
//        Cache.image(forUrl: imageUrl) { (image) in
//                        if image != nil {
//                           DispatchQueue.main.async {
//                            cell.photoImage.image = image
//                     }
//                }x
//        }
//        cell.photoImage.makeRoundedCorner()
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 60)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupCollectionViewCell(){
        self.userCollection.delegate = self
        self.userCollection.dataSource = self
        self.userCollection.registerCell(withId: XIB.Names.PhotosCell)
    }
    
    @IBAction private func changePaymentAction(_sender:UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.PaymentSelectViewController) as! PaymentSelectViewController
        vc.modalPresentationStyle = .automatic
        vc.onSelectPaymentType = { (paymentType,card_id,lastfour) in
            self.selectedPaymentType = paymentType
            self.cardId = card_id
            if self.selectedPaymentType == "stripe"{
                self.selectedPaymentMode.text = "XXXX-XXXX-XXXX-\(lastfour)"
            }else{
            self.selectedPaymentMode.text = paymentType
            }
            vc.dismiss(animated: true, completion: nil)
            
        }
        let nav = UINavigationController(rootViewController: vc)
        self.navigationController?.present(nav, animated: true, completion: nil)
        
    }
    
}



//Api calls
extension SummaryViewController : PresenterOutputProtocol{
    func showSuccess(api: String, dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        switch String(describing: modelClass) {
            case model.type.DoctorsDetailModel:
                self.loader.isHideInMainThread(true)
                let data = dataDict as? DoctorsDetailModel
                self.doctors = data!
                self.setupData()
                break
            
                
            case model.type.PromoCodeEntity:
                let data = dataDict as? PromoCodeEntity
                self.updatePromoDetail(data: data!)
            break
        case model.type.CardSuccess:
            let data = dataDict as? CardSuccess
            let alert  = showAlert(message: data?.message) { (_) in
                for controller in self.navigationController!.viewControllers as Array {
                        if controller.isKind(of: HomeViewController.self) {
                            _ =  self.navigationController!.popToViewController(controller, animated: true)
                            break
                        }
                    }
            }
            self.present(alert, animated: true, completion: nil)
            default: break
            
        }
    }
    
    func setupData(){
        self.userCollection.reloadData()
        if self.doctors.specialities?.offer_fees != "0.00"{
            self.proceedAmount = self.offerPrice//(self.doctors.specialities?.offer_fees ?? "")
            self.offerPriceLbl.text = currency + (self.offerPrice)
            self.orginalPrieLbl.text = currency + "\(self.price)"
            self.orginalPrieLbl.isHidden = false
        }else{
            self.proceedAmount = "\(self.doctors.specialities?.offer_fees ?? "0")"
            self.offerPriceLbl.text = currency + "\(self.doctors.specialities?.fees ?? 0)"
            self.orginalPrieLbl.isHidden = true
            self.strickView.isHidden = true
        }
    }
    
    func updatePromoDetail(data : PromoCodeEntity){
        showToast(msg: data.message ?? "")
        self.offerPriceLbl.text = currency + (data.final_fees ?? 0).description
        self.proceedAmount = (data.final_fees ?? 0).description
        self.setSeatchCountLbl(price: Int(self.doctors.specialities?.fees ?? 0) , offer: data.promo_discount ?? 0)
    }
    
    func showError(error: CustomError) {
        
    }
    
    func getDoctorsList(id : String){
        self.presenter?.HITAPI(api: Base.catagoryList.rawValue + "/\(id )", params: nil, methodType: .GET, modelClass: DoctorsDetailModel.self, token: true)
        self.loader.isHidden = false
    }
    
    func applyPromo(id : String,promocode : String){
        self.presenter?.HITAPI(api: Base.chatPromo.rawValue, params: ["id" : id, "promocode" : promocode], methodType: .POST, modelClass: PromoCodeEntity.self, token: true)
    }
    
    func proceedToPay(id : String,message : String,Amount:String,promo_id : String,speciality_id : String){
        var params = [String:Any]()
        params.updateValue(id, forKey: "id")
        params.updateValue(message, forKey: "message")
        params.updateValue(Amount, forKey: "amount")
        params.updateValue("CHAT", forKey: "pay_for")
        params.updateValue(id, forKey: "speciality_id")
        params.updateValue(promo_id, forKey: "promo_id")
        params.updateValue(selectedPaymentType == "stripe" ? "False" : "True", forKey: "use_wallet")
        params.updateValue(selectedPaymentType, forKey: "payment_mode")
        if selectedPaymentType == "stripe"{
        params.updateValue(cardId, forKey: "card_id")
        }
        self.presenter?.HITAPI(api: Base.proceedToPay.rawValue, params: params, methodType: .POST, modelClass: CardSuccess.self, token: true)
        
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.CardsListViewController) as! CardsListViewController
//        vc.amount = Amount
//        vc.isFromWallet = false
//        vc.id = id
//        vc.promoCode = promo_id
//        vc.message = message
//        self.navigationController?.pushViewController(vc, animated:true)
    }
  
}
