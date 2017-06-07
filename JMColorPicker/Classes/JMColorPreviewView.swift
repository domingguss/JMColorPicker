//
//  JMColorPreviewView.swift
//  Pods
//
//  Created by Jayachandra Agraharam on 07/06/17.
//
//

import UIKit

class JMColorPreviewView: UIView {
    
    var colorView: UIView?
    var arrowView: UIView?
    
    var color: UIColor = UIColor.black{
        didSet{
            colorView?.backgroundColor = color
        }
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        colorView = UIView(frame: bounds.insetBy(dx: CGFloat(3), dy: CGFloat(3)))
        colorView?.layer.cornerRadius = (colorView?.frame.width)! / 2
        addSubview(colorView!)
        arrowView = UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(19), height: CGFloat(18)))
        var rect: CGRect = arrowView!.frame
        rect.origin.y = bounds.height - 15
        rect.origin.x = bounds.midX - round((arrowView?.frame.width)! / 2)
        arrowView?.frame = rect
        arrowView?.transform = CGAffineTransform(rotationAngle: CGFloat((Double.pi/2) / 2))
        arrowView?.layer.cornerRadius = 4
        addSubview(arrowView!)
        sendSubview(toBack: arrowView!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tintColorDidChange() {
        backgroundColor = tintColor
        arrowView?.backgroundColor = tintColor
    }
}
