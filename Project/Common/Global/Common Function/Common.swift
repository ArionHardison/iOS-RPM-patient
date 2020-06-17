//
//  Common.swift
//  User
//
//  Created by imac on 1/1/18.
//  Copyright © 2018 Appoets. All rights reserved.
//

import UIKit
import MessageUI
import KWDrawerController

class Common {
    
    class func isValid(email : String)->Bool{
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@","[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
        return emailTest.evaluate(with: email)
        
    }
    
    class func getBackButton()->UIBarButtonItem{
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        return backItem// This will show in the next view controller being pushed
    }
    
//    class func GMSAutoComplete(fromView : GMSAutocompleteViewControllerDelegate?)->GMSAutocompleteViewController{
//
//    let gmsAutoCompleteFilter = GMSAutocompleteFilter()
//    gmsAutoCompleteFilter.country =  GMSCountryCode
//    gmsAutoCompleteFilter.type = .city
//    let gmsAutoComplete = GMSAutocompleteViewController()
//    gmsAutoComplete.delegate = fromView
//    gmsAutoComplete.autocompleteFilter = gmsAutoCompleteFilter
//    return gmsAutoComplete
//    }
    
    
    class func setDrawerController()->UIViewController {
           
          let drawerController =  DrawerController()
        
           if let sideBarController = Router.main.instantiateViewController(withIdentifier: Storyboard.Ids.SideBarTableViewController) as? SideBarTableViewController  {
               //let drawerSide : DrawerSide = selectedLanguage == .arabic ? .right : .left
               let mainController = Router.main.instantiateViewController(withIdentifier: Storyboard.Ids.LaunchNavigationController)
               drawerController.modalPresentationStyle = .currentContext
               drawerController.setViewController(sideBarController, for: .left)
               drawerController.setViewController(sideBarController, for: .right)
               drawerController.setViewController(mainController, for: .none)
               drawerController.getSideOption(for: .left)?.isGesture = true
               drawerController.getSideOption(for: .right)?.isGesture = true
           }
           return drawerController
       }
    
    class func getCurrentCode()->String?{
        
       return (Locale.current as NSLocale).object(forKey:  NSLocale.Key.countryCode) as? String
  
    }
    
    
    
    //MARK:- Get Countries from JSON
    
    class func getCountries()->[Country]{
        
        var source = [Country]()
        
        if let data = NSData(contentsOfFile: Bundle.main.path(forResource: "countryCodes", ofType: "json") ?? "") as Data? {
            do{
                source = try JSONDecoder().decode([Country].self, from: data)
                
            } catch let err {
                print(err.localizedDescription)
            }
        }
        return source
    }
    
    
    
    class func getRefreshControl(intableView tableView : UITableView, tintcolorId  : Int = Color.primary.rawValue, attributedText text : NSAttributedString? = nil)->UIRefreshControl{
       
        let rc = UIRefreshControl()
        rc.tintColorId = tintcolorId
        rc.attributedTitle = text
        tableView.addSubview(rc)
        return rc
        
    }
    
    // MARK:- Set Font
    
    class func setFont(to field :Any, isTitle : Bool = false, size : CGFloat = 0) {
        
        let customSize = size > 0 ? size : (isTitle ? 16 : 14)
        let font = UIFont(name: isTitle ? FontCustom.bold.rawValue : FontCustom.meduim.rawValue, size: customSize)
        
        switch (field.self) {
        case is UITextField:
            (field as? UITextField)?.font = font
        case is UILabel:
            (field as? UILabel)?.font = font
        case is UIButton:
            (field as? UIButton)?.titleLabel?.font = font
        case is UITextView:
            (field as? UITextView)?.font = font
        default:
            break
        }
    }

    
   
    
    // MARK:- Make Call
    class func call(to number : String?) {
        
        if let providerNumber = number, let url = URL(string: "tel://\(providerNumber)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIScreen.main.focusedView?.make(toast: Constants.string.cannotMakeCallAtThisMoment.localize())
        }
        
    }
    
    // MARK:- Send Email
    class func sendEmail(to mailId : [String], from view : UIViewController & MFMailComposeViewControllerDelegate) {
        
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = view
            mail.setToRecipients(mailId)
            view.present(mail, animated: true)
        } else {
            UIScreen.main.focusedView?.make(toast: Constants.string.couldnotOpenEmailAttheMoment.localize())
        }
        
    }
    
    // MARK:- Send Message
    
    class func sendMessage(to numbers : [String], text : String, from view : UIViewController & MFMessageComposeViewControllerDelegate) {
        
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = text
            controller.recipients = numbers
            controller.messageComposeDelegate = view
            view.present(controller, animated: true, completion: nil)
        }
    }
    
    // MARK:- Bussiness Image Url
    class func getImageUrl (for urlString : String?)->String {
        
        return baseUrl+"/storage/"+String.removeNil(urlString)
    }
    
    
    //MARK: Timestamp fomater
    class func formateDate(date: String?) -> String? {
        
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: nullStringToEmpty(string: date))!
        dateFormatter.dateFormat = "dd-MM-yyyy" //hh:mm:ss"
        dateFormatter.locale = tempLocale // reset the locale
        let dateString = dateFormatter.string(from: date)
        print("EXACT_DATE : \(dateString)")
        
        return nullStringToEmpty(string: dateString)
    }
    
    
    //Create QRCode Image
    class func CreateQrCodeForyourString (string:String)-> UIImage{
        let stringData = string.data(using: .utf8, allowLossyConversion: false)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(stringData, forKey: "inputMessage")
        filter?.setValue("H", forKey: "inputCorrectionLevel")
        let qrCIImage = filter?.outputImage
        let colorFilter = CIFilter(name: "CIFalseColor")!
        colorFilter.setDefaults()
        colorFilter.setValue(qrCIImage, forKey: "inputImage")
        colorFilter.setValue(CIColor(red: 0, green: 0, blue: 0), forKey: "inputColor0")
        colorFilter.setValue(CIColor(red: 1, green: 1, blue: 1), forKey: "inputColor1")
        
        let codeImage = UIImage(ciImage: (colorFilter.outputImage!.transformed(by: CGAffineTransform(scaleX: 5, y: 5))))
        return codeImage
    }
    
}


public func nullStringToEmpty(string: String?) -> String {
    
    if string == nil {
        return ""
    }
    else {
        return string!
    }
}


//MARK: Timestamp fomater
extension Date {
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}


//Image tint colour change
public func withRenderingMode(originalImage: UIImage, imgView: UIImageView, imgTintColur: UIColor) {
    
    let tintedImage = originalImage.withRenderingMode(.alwaysTemplate)
    imgView.tintColor = imgTintColur
    imgView.image = tintedImage
    
}

func showToast(msg : String ) {
    let window = UIApplication.shared.keyWindow!
    let toastLabel = PaddingLabel()
    
    toastLabel.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
    toastLabel.textColor = UIColor.white
    toastLabel.translatesAutoresizingMaskIntoConstraints = false
    toastLabel.textAlignment = .center;
    toastLabel.font = UIFont.systemFont(ofSize: 14)
    toastLabel.text = msg
    
    toastLabel.alpha = 1.0
    toastLabel.numberOfLines = 0
    toastLabel.lineBreakMode = .byWordWrapping
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    toastLabel.removeFromSuperview()
    window.addSubview(toastLabel)
    toastLabel.bringSubview(toFront: window)
    NSLayoutConstraint.activate([
        toastLabel.leadingAnchor.constraint(greaterThanOrEqualTo: window.leadingAnchor, constant: 20),
        toastLabel.trailingAnchor.constraint(lessThanOrEqualTo: window.trailingAnchor,constant: -20),
        toastLabel.bottomAnchor.constraint(greaterThanOrEqualTo: window.bottomAnchor, constant:  -100),
        toastLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30),
        toastLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 150),
        toastLabel.centerXAnchor.constraint(equalTo: window.centerXAnchor)
        
    ])
    UIView.animate(withDuration: 8.0, delay: 0.0, options: .curveEaseOut, animations: {
        toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
}

func dateConvertor(_ date: String, _input: DateTimeFormate, _output: DateTimeFormate) -> String
{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = _input.rawValue
    let dates = dateFormatter.date(from: date)
    dateFormatter.dateFormat = _output.rawValue
    let datestr = dateFormatter.string(from: dates ?? Date())
    
    return  dateFormatter.string(from: dates ?? Date())
}

enum DateTimeFormate : String{
    case DMY_Time = "dd MMM YYYY, EEE hh:mm a"
    case DMY = "dd MMM YYYY"
    case MY = "MM/YYYY"
    case R_hour = "HH:mm"
    case N_hour = "hh:mm a"
    case date_time = "yyyy-MM-dd HH:mm:ss"
    case DM = "dd MMM"
}
