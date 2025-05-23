//
//  TextField.swift
//  User
//
//  Created by CSS on 08/01/18.
//  Copyright © 2018 Appoets. All rights reserved.
//

import UIKit

@IBDesignable
class TextField: UITextField {
    
    let layerr = CALayer()

    //MARK:- PlaceHolder Color
    
    
    
    
    //MARK:- Is Bottom Line Inverted
    
    @IBInspectable
    var isBottomLineInverted : Bool = false {
        
        didSet{
            addSubLayer()
        }
    }
    
    //MARK:- Bottom line color
    
    @IBInspectable
    var bottomLineColor : UIColor = .white{
        
        didSet{
            addSubLayer()
        }
        
    }
    
    //MARK:- Bottom Line
    
    @IBInspectable
    var bottomlineHeight : CGFloat = 0{
        
        didSet{
            addSubLayer()
        }
        
    }
    
    
    //MARK:- Button Text Color
    
    @IBInspectable
    var textColorId : Int = 0{
        
        didSet {
            
            self.textColor = {
                
                if let color = Color.valueFor(id: textColorId){
                    return color
                } else {
                    return textColor
                }
                
            }()
        }
        
    }
    
     func addSubLayer(){
        
        layerr.removeFromSuperlayer()
        
        layerr.frame = CGRect(origin: CGPoint(x: 0, y: isBottomLineInverted ?(self.frame.height-bottomlineHeight) : 0), size: CGSize(width: self.frame.width, height: bottomlineHeight))
        layerr.backgroundColor = bottomLineColor.cgColor
        
        self.layer.addSublayer(layerr)
        
    }
    
    
    

}


extension UITextField {
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
