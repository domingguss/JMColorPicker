//
//  JMColorManager.swift
//  Pods
//
//  Created by Jayachandra Agraharam on 07/06/17.
//
//

import UIKit


public typealias JMColorManagerCompletion = (_ status:Bool, _ color:String?) ->Void

public class JMColorManager: NSObject,JMColorSliderDelegate,UITextFieldDelegate {
    
    public var completion: JMColorManagerCompletion?
    var input:UITextField?
    var okAction: UIAlertAction?
    
    public func show(from viewController: UIViewController?, completionHandler:JMColorManagerCompletion?){
        self.completion = completionHandler
        let alert = UIAlertController(title: "Color Picker", message: "Move slider to choose your color selection or add hexa color manually \n\n\n\n", preferredStyle: .alert)
        okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            if let lCompletion = self.completion{
                lCompletion(true,self.input?.text)
            }
        }
        okAction?.isEnabled = false
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { (action) in
            if let lCompletion = self.completion{
                lCompletion(false,nil)
            }
        }
        
        let me = JMColorSlider(frame: CGRect(x: 5, y: 90, width: 260, height: 100))
        me.delegate = self
        alert.addTextField { (colorInput) in
            colorInput.placeholder = "Add hexa color code"
            self.input = colorInput
            colorInput.delegate = self
        }
        
        alert.view.addSubview(me)
        alert.addAction(cancelAction)
        alert.addAction(okAction!)
        guard let controller = viewController else {UIApplication.topViewController()?.present(alert, animated: true, completion: nil); return }
        controller.present(alert, animated: true, completion: nil)
    }
    
    fileprivate func colorToRGB(_ color: UIColor) -> String{
        let redValue = (color.cgColor.components?[0])! * 255
        let greenValue = (color.cgColor.components?[1])! * 255
        let blueValue = (color.cgColor.components?[2])! * 255
        let rgbString = String.init(format: "rgb(%.0f,%.0f,%.0f)", redValue, greenValue, blueValue)
        return rgbString
    }
    
    fileprivate func colorToHex(_ color: UIColor) -> String{
        let red = color.cgColor.components?[0]
        let green = color.cgColor.components?[1]
        let blue = color.cgColor.components?[2]
        
        let hexString = String(format: "%02lX%02lX%02lX",
                               lroundf(Float(red! * 255)),
                               lroundf(Float(green! * 255)),
                               lroundf(Float(blue! * 255)))
        return hexString
    }
    
    func colorSlider(slider: JMColorSlider, color: UIColor) {
        input?.text = colorToHex(color)
        okAction?.isEnabled = true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        
        let newLength = text.utf16.count + string.utf16.count - range.length
        if newLength < 6 {
            okAction?.isEnabled = false
        }else{
            okAction?.isEnabled = true
        }
        return newLength <= 6
    }
}


extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
