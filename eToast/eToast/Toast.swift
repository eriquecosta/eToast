//
//  Toast.swift
//  UtilsSSPMO
//
//  Created by Erique Costa on 22/02/2018.
//  Copyright © 2018 SERPRO. All rights reserved.
//

import Foundation
import UIKit

public class Toast: NSObject {
    
    let DURATION = 1
    let SHOWTIME = 1
    let BGUPCOLOR : UIColor = UIColor.black.withAlphaComponent(0.7)
    let BGDWCOLOR = UIColor.black.withAlphaComponent(0.85)
    let BORDERCOLOR = UIColor.white.withAlphaComponent(1)
    let TEXTCOLOR = UIColor.white.withAlphaComponent(1)
    
    var text : String
    var label : UILabel!
    var bgDwColor, bgUpColor, borderColor, textColor : UIColor
    var duration : Int!
    
    public init(withText: String, duration : Int = 0) {
        
        self.text = withText
        
        bgDwColor = BGDWCOLOR
        bgUpColor = BGUPCOLOR
        borderColor = BORDERCOLOR
        textColor = TEXTCOLOR
        if duration == 0 {
            self.duration = DURATION
        } else {
            self.duration = duration
        }
    }
    
    // Método básico para exibir o toast
    public func show() {
        showAndHide(after: SHOWTIME)
    }
    
    class func makeText(_ _text: String) -> Toast {
        let toast = Toast(withText: _text)
        return toast
    }
    
    // Método para remover o toast
    @objc func hide() {
        UIView.animate(withDuration: TimeInterval(duration), animations: {() -> Void in
            self.label?.alpha = 0.0
        })
    }
    
    func showAndHide(after seconds: Int) {
        let window: UIWindow? = UIApplication.shared.windows[0]
        let font: UIFont? = UIFont.systemFont(ofSize: 16)
        let textRect: CGRect = text.boundingRect(with: CGSize(width: 245, height: 80), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        //    CGSize textSize = [text sizeWithFont:font constrainedToSize:CGSizeMake(245, 80)];
        let width: Int = Int(textRect.size.width + 50)
        let height: Int = Int(textRect.size.height + 8)
        let point = CGPoint(x: (window?.frame.size.width)! / 2, y: (window?.frame.size.height)! - 65)
        showAndHide(with: point, withSeconds: seconds, with: window!, with: font!, withTextSize: textRect.size, withWidth: width, andHeight: height)
    }
    
    func showAndHide(after seconds: Int, inHeight _height: CGFloat) {
        let window: UIWindow? = UIApplication.shared.windows[0]
        let font: UIFont? = UIFont.systemFont(ofSize: 16)
        let textRect: CGRect = text.boundingRect(with: CGSize(width: 245, height: 100), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        let width: Int = Int(textRect.size.width + 20)
        let height: Int = Int(textRect.size.height + 8)
        let point = CGPoint(x: (window?.frame.size.width)! / 2, y: CGFloat((window?.frame.size.height)! - _height))
        showAndHide(with: point, withSeconds: seconds, with: window!, with: font!, withTextSize: textRect.size, withWidth: width, andHeight: height)
    }
    
    func showAndHide(with point: CGPoint, withSeconds seconds: Int, with window: UIWindow, with font: UIFont, withTextSize textSize: CGSize, withWidth width: Int, andHeight height: Int) {
        label = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat(width), height: CGFloat(height)))
        label?.center = point
        let labelGradient = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat(width), height: CGFloat(height)))
        labelGradient.backgroundColor = UIColor.clear
        labelGradient.textColor = textColor
        labelGradient.font = font
        labelGradient.text = text
        labelGradient.numberOfLines = 0
        labelGradient.textAlignment = .center
        let gradientViewH = UIView(frame: CGRect(x: 0, y: 0, width: CGFloat(width), height: CGFloat(height)))
        let gradientH = CAGradientLayer()
        gradientH.frame = gradientViewH.bounds
        gradientH.colors = [(bgUpColor.cgColor as? Any), (bgDwColor.cgColor as? Any)]
        gradientViewH.layer.insertSublayer(gradientH, at: 0)
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.layer.borderWidth = 2.0
        label.layer.borderColor = borderColor.cgColor
        label.insertSubview(gradientViewH, at: 0)
        label.insertSubview(labelGradient, at: 1)
        window.addSubview(label)
        perform(#selector(self.hide), with: nil, afterDelay: TimeInterval(seconds))
    }
    func showAndHideAfterSeconds(inCenter seconds: Int) {
        showAndHide(after: seconds, inHeight: UIScreen.main.bounds.size.height / 2)
    }
}

