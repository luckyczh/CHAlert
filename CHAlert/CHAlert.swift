//
//  CHAlert.swift
//  CHAlert
//
//  Created by Jemmy on 2018/8/31.
//  Copyright © 2018年 Jemmy. All rights reserved.
//

import UIKit
import SnapKit

let ButtonH = 40
let MainColor = UIColor.brown
let AnimalDuring = 0.3
var charlertKey = "\0"
extension UIView{
     var chalert:CHAlert{
        get{
            var alert = objc_getAssociatedObject(self, &charlertKey) as? CHAlert
            if alert == nil{
                alert = CHAlert()
            }
            addSubview(alert!)
            bringSubview(toFront: alert!)
            return alert!
        }
        set{
            objc_setAssociatedObject(self, &charlertKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
class CHAlert: UIView {

    let titleLabel = InsetLabel.insetLabel
    let customView = UIView()
    let contentView = UIView()
    typealias operationClosure = (_ sender:UIButton) -> Void
    typealias snpMakerClosure = (_ make:ConstraintMaker) -> Void
    var confirmAction : operationClosure?
    var cancelAction : operationClosure?
    var constrainsClosure : snpMakerClosure?
    
    init(){
        super.init(frame: UIScreen.main.bounds)
        initUI()
    }
    init(title:String){
        super.init(frame: UIScreen.main.bounds)
        titleLabel.cbgColor(MainColor).ctextColor(.white).text = title
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   private func initUI(){
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.ch_addSubViews([titleLabel,customView])
        addSubview(contentView)
        backgroundColor = UIColor.clear
        contentView.backgroundColor = .white
        titleLabel.textInset = UIEdgeInsetsMake(10, 10, 10, 10)
        updateCon()
    }
    
   private  func updateCon() {
        contentView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(ButtonH)
        }
        customView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.right.equalToSuperview()
        }
    }
    
   private func addButton(_ btns:[UIButton]){
        contentView.ch_addSubViews(btns)
        if btns.count == 1{
            btns[0].snp.makeConstraints { (make) in
                make.top.equalTo(customView.snp.bottom)
                make.right.left.bottom.equalToSuperview()
                make.height.equalTo(ButtonH)
            }
        }else{
            btns[0].snp.makeConstraints { (make) in
                make.top.equalTo(customView.snp.bottom)
                make.left.bottom.equalToSuperview()
                make.height.equalTo(ButtonH)
            }
            btns[1].snp.makeConstraints { (make) in
                make.top.equalTo(customView.snp.bottom)
                make.right.bottom.equalToSuperview()
                make.left.equalTo(btns[0].snp.right).offset(1)
                make.height.width.equalTo(btns[0])
            }
        }
        
    }
    // MARK: 菊花加载
    func hud(msg:String){
        
        alerAnimal(false,hud: true)
        let replicator = CAReplicatorLayer()
        replicator.bounds = CGRect(x: 0, y: 0, width: 60, height: 60)
        replicator.position = CGPoint(x: 40, y: 40)
        replicator.instanceCount = 10
        replicator.instanceDelay = 0.1
        customView.layer.addSublayer(replicator)
        customView.backgroundColor = .black
        let lay = CALayer()
        lay.bounds = CGRect(x: 0, y: 0, width: 3, height: 17)
        lay.position = CGPoint(x: 30, y: 5)
        lay.backgroundColor = UIColor.white.cgColor
        /** 光栅化，使绘制图案平滑*/
        lay.shouldRasterize = true
        lay.contentsScale = UIScreen.main.scale
        
        replicator.addSublayer(lay)
        let angle = CGFloat.pi * 2 / 10
        replicator.instanceAlphaOffset = 0.2
        replicator.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
        let anim = CABasicAnimation(keyPath: "opacity")
        anim.fromValue = 0.3
        anim.toValue = 1
        anim.duration = 1
        anim.repeatCount = HUGE
        lay.add(anim, forKey: "opacity")
        contentView.backgroundColor = .black
        contentView.snp.remakeConstraints { (make) in
            make.centerY.centerX.equalToSuperview()
            make.width.equalTo(120)
        }
        customView.snp.remakeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.width.height.equalTo(80)
        }
        let label = UILabel.baseLabel.ctextColor(.white).ctext(msg).isNewLine(true)
        label.adjustsFontSizeToFitWidth = true
        contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.right.left.equalToSuperview()
            make.top.equalTo(customView.snp.bottom)
            make.bottom.equalToSuperview().offset(-10)
        }
        
    }
    // MARK: 快速提示消息
    func alert(message:String, during:TimeInterval){
        backgroundColor = .clear
        alerAnimal(false,hud: true)
        let msg = message as NSString
        let size = msg.boundingRect(with: CGSize(width: SCREEN_W - 40, height: CGFloat.greatestFiniteMagnitude), options: [.usesLineFragmentOrigin,.usesFontLeading], attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 20)], context: nil).size
        titleLabel.cbgColor(.black).ctextColor(.white).isNewLine(true)
        titleLabel.layer.cornerRadius = 10
        titleLabel.layer.masksToBounds = true
        contentView.snp.remakeConstraints { (make) in
            make.centerY.centerX.equalToSuperview()
        }
        titleLabel.snp.remakeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(size.height + 20)
            make.width.equalTo(size.width + 30)
        }
        titleLabel.text = message

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + during) {
            self.alerAnimal(true,hud:true)
        }
    }
    // MARK: 菊花消失
    func hide(){
        _ = superview?.subviews.filter({$0 is CHAlert}).map({$0.removeFromSuperview()})
    }
    // MARK: 提示弹窗
    func alert(btnTitle:String,msg:String, handler:operationClosure?){
        if superview == nil{
            UIApplication.shared.keyWindow?.addSubview(self)
        }
        alerAnimal(false,hud:false)
        let textLabel = UILabel.baseLabel
        textLabel.text = msg
        customView.addSubview(textLabel)
        textLabel.snp.makeConstraints { (make) in
            make.right.left.top.bottom.equalToSuperview()
            make.height.equalTo(150)
        }
        let acButton = UIButton.baseButton
        acButton.ctitle(btnTitle).ctitleColor(.white).cbgColor(MainColor).ctarget(self, action: #selector(confirm(sender:)))
        addButton([acButton])
        confirmAction = handler
    }
    
    // MARK: 多操作弹窗
    func alert(_ leftbtn:String, _ leftHander:operationClosure?, msg:String, rightbtn:String, rightHander:operationClosure?){
        if superview == nil{
            UIApplication.shared.keyWindow?.addSubview(self)
        }
        alerAnimal(false,hud:false)
        let textLabel = UILabel.baseLabel
        textLabel.text = msg
        customView.addSubview(textLabel)
        textLabel.snp.makeConstraints { (make) in
            make.right.left.top.bottom.equalToSuperview()
            make.height.equalTo(150)
        }
        let leftButton = UIButton.baseButton
        leftButton.ctitle(leftbtn).ctitleColor(.white).cbgColor(MainColor).ctarget(self, action: #selector(confirm(sender:)))
        cancelAction = leftHander
        let rightButton = UIButton.baseButton
        rightButton.ctitle(rightbtn).ctitleColor(.white).cbgColor(MainColor).ctarget(self, action: #selector(confirm(sender:)))
        confirmAction = rightHander
        addButton([leftButton,rightButton])
        
    }
    // MARK: 添加自定义视图
    func alert(_ cView:UIView,leftBtn:String,leftHandler:operationClosure?,rightBtn:String,rightHandler:operationClosure?,alertConstrain:snpMakerClosure?){
        alert(leftBtn, leftHandler, msg: "", rightbtn: rightBtn, rightHander: rightHandler)
        _ = customView.subviews.map({$0.removeFromSuperview()})
        customView.addSubview(cView)
        cView.snp.makeConstraints { (make) in
            (alertConstrain == nil) ? _ = make.edges.equalToSuperview() : alertConstrain!(make)
        }
      
        
    }
    
    // MARK: 弹框动画
    private func alerAnimal(_ close:Bool, hud:Bool){
        if close{
            UIView.animate(withDuration: AnimalDuring, animations: {
                self.contentView.transform =  CGAffineTransform.init(scaleX: 0.01, y: 0.01)
                self.backgroundColor = UIColor.clear
            }) { (completion) in
                self.removeFromSuperview()
            }
        }else{
        contentView.transform = CGAffineTransform.init(scaleX: 0.01, y: 0.01)
            UIView.animate(withDuration: AnimalDuring, animations: {
                self.contentView.transform = CGAffineTransform.identity
                self.backgroundColor = hud ? .clear : UIColor.black.withAlphaComponent(0.3)
            }) { (completion) in
            }
        }
    }
    // MARK: 按钮操作
    @objc private func confirm(sender:UIButton){
        alerAnimal(true,hud: false)
        if confirmAction != nil{
            confirmAction!(sender)
        }
        if cancelAction != nil{
            cancelAction!(sender)
        }
    }

    deinit {
        print("我被释放了")
    }
}
