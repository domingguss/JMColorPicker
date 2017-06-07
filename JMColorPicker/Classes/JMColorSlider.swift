//
//  JMColorSlider.swift
//  Pods
//
//  Created by Jayachandra Agraharam on 07/06/17.
//
//

protocol JMColorSliderDelegate {
    func colorSlider(slider:JMColorSlider, color: UIColor) ->Void
}
class JMColorSlider: UISlider {
    
    //    var color:UIColor{
    //        set{
    //            var hue: CGFloat = 0
    //            color.getHue(&hue, saturation: nil, brightness: nil, alpha: nil)
    //            value = Float(hue)
    //        }
    //
    //        get{
    //            return colorFromCurrentValue()
    //        }
    //    }
    
    var previewOffset: Int = 0
    var isShowPreview: Bool = false
    var colorTrackHeight: Int = 0
    var previewAppearAnimateDuration: Float = 0.0
    var previewDismissAnimateDuration: Float = 0.0
    
    var colorTrackImageView: UIImageView?
    var previewView: JMColorPreviewView?
    
    var delegate: JMColorSliderDelegate?
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        baseInit()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        baseInit()
        
    }
    
    func baseInit() {
        let imagePath = Bundle(for: JMColorSlider.self).path(forResource: "colorTrack", ofType: "png")
        let url = URL(fileURLWithPath: imagePath!)
        do{
            let data = try Data(contentsOf: url)
            let image = UIImage(data: data)
            colorTrackImageView = UIImageView(image: image)
            addSubview(colorTrackImageView!)
            sendSubview(toBack: colorTrackImageView!)
            previewOffset = -45
            isShowPreview = true
            previewAppearAnimateDuration = 0.07
            previewDismissAnimateDuration = 0.06
            colorTrackHeight = 2
            setMinimumTrackImage(self.image(from: UIColor.clear), for: .normal)
            setMaximumTrackImage(self.image(from: UIColor.clear), for: .normal)
        }catch{
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        colorTrackImageView?.frame = trackRect(forBounds: bounds)
        let center: CGPoint = colorTrackImageView!.center
        var rect: CGRect = colorTrackImageView!.frame
        rect.size.height = CGFloat(colorTrackHeight)
        colorTrackImageView?.frame = rect
        colorTrackImageView?.center = center
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let tracking: Bool = super.beginTracking(touch, with: event)
        if isShowPreview {
            if currentThumbRect().insetBy(dx: CGFloat(-8), dy: CGFloat(-8)).contains(touch.location(in: self)) {
                if !(previewView != nil) {
                    let rect: CGRect = currentThumbRect().insetBy(dx: CGFloat(-1), dy: CGFloat(-1)).offsetBy(dx: CGFloat(0), dy: CGFloat(previewOffset))
                    previewView = previewView(withFrame: rect, color: colorFromCurrentValue())
                    addSubview(previewView!)
                    UIView.animate(withDuration: TimeInterval(previewAppearAnimateDuration), animations: {() -> Void in
                        self.previewView?.alpha = 1
                    })
                }
            }
        }
        return tracking
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let con: Bool = super.continueTracking(touch, with: event)
        if isShowPreview {
            if isTracking {
                if !(previewView != nil) {
                    let rect: CGRect = currentThumbRect().insetBy(dx: CGFloat(-1), dy: CGFloat(-1)).offsetBy(dx: CGFloat(0), dy: CGFloat(previewOffset))
                    previewView = previewView(withFrame: rect, color: colorFromCurrentValue())
                    addSubview(previewView!)
                    UIView.animate(withDuration: TimeInterval(previewAppearAnimateDuration), animations: {() -> Void in
                        self.previewView?.alpha = 1
                    })
                }
                else {
                    var rect: CGRect = previewView!.frame
                    rect.origin.x = currentThumbRect().midX - rect.width / 2
                    previewView?.frame = rect
                    previewView?.color = colorFromCurrentValue()
                }
                
                if let lDelegate = self.delegate{
                    lDelegate.colorSlider(slider: self, color: colorFromCurrentValue())
                }
            }
        }
        return con
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        if isShowPreview {
            removePreview()
        }
    }
    
    override func cancelTracking(with event: UIEvent?) {
        super.cancelTracking(with: event)
        if isShowPreview {
            removePreview()
        }
    }
    
    func removePreview() {
        if let lDelegate = self.delegate{
            lDelegate.colorSlider(slider: self, color: colorFromCurrentValue())
        }
        
        var rect: CGRect = previewView!.frame
        rect.origin.x = currentThumbRect().midX - rect.width / 2
        previewView?.frame = rect
        previewView?.color = colorFromCurrentValue()
        UIView.animate(withDuration: TimeInterval(previewDismissAnimateDuration), delay: 0, options: [.curveLinear, .beginFromCurrentState], animations: {() -> Void in
            //self.previewView?.alpha = 0.0
        }, completion: {(_ finished: Bool) -> Void in
            if finished {
                //                if (self.previewView != nil) {
                //                    self.previewView?.removeFromSuperview()
                //                    self.previewView = nil
                //                }
            }
        })
    }
    
    func currentThumbRect() -> CGRect {
        return thumbRect(forBounds: bounds, trackRect: trackRect(forBounds: bounds), value: value)
    }
    
    func previewView(withFrame frame: CGRect, color: UIColor) -> JMColorPreviewView {
        let preview = JMColorPreviewView(frame: frame)
        preview.tintColor = UIColor.black
        preview.layer.cornerRadius = preview.frame.width / 2
        preview.alpha = 0.2
        preview.color = color
        return preview
    }
    
    func colorFromCurrentValue() -> UIColor {
        return UIColor(hue: CGFloat(value), saturation: CGFloat(1), brightness: CGFloat(1.0), alpha: CGFloat(1.0))
    }
    
    func image(from color: UIColor) -> UIImage {
        let rect = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(1), height: CGFloat(1))
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContext? = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
