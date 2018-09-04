//
//  CHExtension.swift
//  CHAlert
//
//  Created by Jemmy on 2018/8/28.
//  Copyright © 2018年 Jemmy. All rights reserved.
//

/// 常用UI扩展
import UIKit

// 屏幕参数
let SCREEN_W = UIScreen.main.bounds.size.width
let SCREEN_H = UIScreen.main.bounds.size.height
let STATUS_H = UIApplication.shared.statusBarFrame.size.height

// MARK: - view 扩展
typealias CView = UIView
extension CView{
    var csize : CGSize{
        get{
            return bounds.size
        }
    }
    var cwidth : CGFloat{
        get{
            return csize.width
        }
    }
    var cheight:CGFloat{
        get{
            return csize.height
        }
    }
    var ccenterX:CGFloat{
        get{
            return center.x
        }
    }
    var ccenterY:CGFloat{
        get{
            return center.y
        }
    }
    func ch_addSubViews(_ views:[UIView]){
         _ = views.map({addSubview($0)})
    }
    
}
// MARK: - label 扩展
class InsetLabel : UILabel{
    var textInset:UIEdgeInsets!
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, textInset))
    }
    class var insetLabel : InsetLabel {
        let label = InsetLabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        return label
    }
}
typealias CHLabel = UILabel
extension CHLabel{
    class var baseLabel : UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        
        return label
    }
    
    // 链式扩展
    @discardableResult
    func ctext(_ ctext:String) -> UILabel{
        text = ctext
        return self
    }
    @discardableResult
    func ctextColor(_ color:UIColor)->UILabel{
        textColor = color
        return self
    }
    @discardableResult
    func ctextAlignment(_ alignment:NSTextAlignment) -> UILabel{
        textAlignment = alignment
        return self
    }
    @discardableResult
    func cfont(_ cfont:CGFloat) -> UILabel{
        font = UIFont.systemFont(ofSize: cfont)
        return self
    }
    @discardableResult
    func cbgColor(_ bgcolor:UIColor) -> UILabel{
        backgroundColor = bgcolor
        return self
    }
    @discardableResult
    func isNewLine(_ newLine:Bool) -> UILabel{
        numberOfLines = newLine ? 0 : 1
        return self
    }
    
    
}
// MARK: - button 扩展
typealias CHButton = UIButton
private var StateKey = "BtnState"
extension CHButton{

  private  var chState : UIControlState {
        get{
            return objc_getAssociatedObject(self, &StateKey) as! UIControlState
        }
        set{
            objc_setAssociatedObject(self, &StateKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    class var baseButton : UIButton {
        let btn = UIButton(type: .custom)
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btn.chState = .normal
        return btn
    }
    func config(state:UIControlState, title:String?, titleColor:UIColor?,image:UIImage?){
        setImage(image ?? UIImage(), for: state)
        setTitle(title ?? "", for: state)
        setTitleColor(titleColor ?? .black, for: state)
    }
    // 链式扩展
   @discardableResult
    func cstate(_ state:UIControlState) -> UIButton{
        chState = state
     return self
    }
    @discardableResult
    func cbgImage(_ image:UIImage , for state:UIControlState) -> UIButton{
        setBackgroundImage(image, for: chState)
        return self
    }
    @discardableResult
    func ctitle(_ title:String) -> UIButton{
            setTitle(title, for: chState)
        return self
    }
    @discardableResult
    func ctitleColor(_ color:UIColor) -> UIButton{
            setTitleColor(color, for: chState)
        return self
    }
    @discardableResult
    func cfont(_ cfont:CGFloat) -> UIButton{
        titleLabel?.font = UIFont.systemFont(ofSize: cfont)
        return self
    }
    @discardableResult
    func ctarget(_ target:Any, action:Selector) -> UIButton{
        addTarget(target, action: action, for: .touchUpInside)
        return self
    }
    @discardableResult
    func cbgColor(_ bgColor:UIColor) -> UIButton{
        backgroundColor = bgColor
        return self
    }
    
}

// MARK: - color 扩展
typealias CHColor = UIColor
extension CHColor{
    /// 十六进制颜色
    ///
    /// - Parameter hex: 颜色值
    /// - Returns: 返回颜色
    class func color(hex:Int) -> UIColor{
        /// 除数
        let divisor = CGFloat(255.0)
        /// 通过移位转换成十进制数
        let red = CGFloat((hex & 0xFF0000) >> 16) / divisor
        let green = CGFloat((hex & 0x00FF00) >> 8) / divisor
        let blue = CGFloat((hex & 0x0000FF)) / divisor
        return UIColor.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    /// rgb颜色
    class func rgb(_ r:CGFloat, _ g:CGFloat, _ b:CGFloat) -> UIColor{
        let divisor = CGFloat(255.0)
        return UIColor.init(red: r / divisor, green: g / divisor, blue: b / divisor, alpha: 1.0)
    }
}
// MARK: - image 扩展
typealias CHImage = UIImage
extension CHImage{
    /// 颜色转图片
    ///
    /// - Parameter color: 颜色
    class func image(from color:UIColor) -> UIImage{
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

// MARK: - string 扩展
typealias CHString = String
extension CHString{
    
    /// 检验是否为全中文
    public var isAllChinese: Bool {
        let chineseRegex = "^[\\u4e00-\\u9fa5]{0,}$"
        let chinesePredicate = NSPredicate(format: "SELF MATCHES %@", chineseRegex)
        return chinesePredicate.evaluate(with: self)
    }
    
    /// 检验是否为全数字
    public var isAllNumber: Bool {
        for index in 0..<self.count {
            let string = (self as NSString).character(at: index)
            if isdigit(Int32(string)) != 0 {
                return true
            }
        }
        return false
    }
    
    //是否是手机号
    func isTelNumber()->Bool
    {
        if self.count != 11 {
            return false
        }
        let mobile = "^1((3[0-9]|4[57]|5[0-35-9]|7[0678]|8[0-9])\\d{8}$)"
        let  CM = "(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
        let  CU = "(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
        let  CT = "(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        if ((regextestmobile.evaluate(with: self) == true)
            || (regextestcm.evaluate(with: self)  == true)
            || (regextestct.evaluate(with: self) == true)
            || (regextestcu.evaluate(with: self) == true))
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    // 是否是车牌号
    func isCarNum() ->  Bool{
        
        if self.count == 7 || self.count == 8{  // 普通车牌号
            let regexStr = self.count == 7 ? "^[\\u4e00-\\u9fa5]{1}[a-hj-np-zA-HJ-NP-Z]{1}[a-hj-np-zA-HJ-NP-Z0-9]{4}[a-hj-np-zA-HJ-NP-Z0-9\\u4e00-\\u9fa5]$" : "^[\\u4e00-\\u9fa5]{1}[a-hj-np-zA-HJ-NP-Z]{1}([0-9]{5}[d|f|D|F]|[d|f|D|F][a-hj-np-zA-HJ-NP-Z0-9][0-9]{4})$" // 新能源车牌号
            let carRegex = NSPredicate(format: "SELF MATCHES %@", regexStr)
            return carRegex.evaluate(with:self)
        }
        return false
    }
}

