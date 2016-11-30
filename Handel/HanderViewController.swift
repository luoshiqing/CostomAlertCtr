//
//  HanderViewController.swift
//  Handel
//
//  Created by sqluo on 2016/11/30.
//  Copyright © 2016年 sqluo. All rights reserved.
//

import UIKit


public enum LActionStlye {
    case `default`
    case cancel
    case destructive
}

struct Ace {
    var title: String!
    var hander: (UIButton) -> Swift.Void
    var style: LActionStlye = .default
}



class HanderViewController: UIViewController {

    
    
    fileprivate var myName: String?
    
    //标题
    var name: String? {
        get{
            return myName
        }
    }
    //消息
    var meesage: String?
    
    init(name: String? ,meesage: String?){
        super.init(nibName: nil, bundle: nil)
        
        self.myName = name
        self.meesage = meesage
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //添加的按钮数组
    fileprivate var addArray = [Ace]()
    //标题高度
    fileprivate var tititH: CGFloat = 0
    //消息高度
    fileprivate var messageH: CGFloat = 0
    //分界线的高度
    fileprivate var dividingLineH: CGFloat = 0.5
    //显示的view
    fileprivate var myView: UIView?
    
    //记录按钮的高度
    fileprivate var someBtnH: CGFloat = 0
    
    
    
    //外部添加按钮的方法
    func addAction(title: String, style: LActionStlye, hander: @escaping (UIButton) -> Swift.Void){
        
        let ace = Ace(title: title, hander: hander, style: style)
        addArray.append(ace)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(white: 0.7, alpha: 0.6)
        
        
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapAct(send:)))
        self.view.addGestureRecognizer(tap)
        self.view.tag = 0
        
        self.loadMyView()
        
    }
    
    //重新布局
    override func viewDidLayoutSubviews() {
        for view in self.view.subviews {

            let w = view.frame.width
            let h = view.frame.height
            
            let x = (self.view.frame.width - w) / 2
            let y = (self.view.frame.height - h) / 2
            
            let rect = CGRect(x: x, y: y, width: w, height: h)
            view.frame = rect
            
        }
    }
    
    
    @objc fileprivate func tapAct(send: UITapGestureRecognizer){
        
        if send.view!.tag == 0 {
            self.dismiss(animated: true, completion: nil)
        }else{
            print("不做处理？")
        }
    
    }

    fileprivate let viewX: CGFloat = 60
    
    fileprivate func loadMyView(){

        //创建一个主要显示区域的视图
        if myView == nil {
            
            let w: CGFloat = self.view.frame.width - viewX * 2
            let h: CGFloat = self.view.frame.height / 3
            let y: CGFloat = (self.view.frame.height - h) / 2
            
            
            myView = UIView(frame: CGRect(x: viewX, y: y, width: w, height: h))
            
            myView?.backgroundColor = UIColor.white
            
            myView?.layer.cornerRadius = 8
            myView?.layer.masksToBounds = true
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapAct(send:)))
            self.myView?.addGestureRecognizer(tap)
            self.myView?.tag = 1
            
            self.view.addSubview(myView!)
        }
        
        
        //初始化标题
        if self.myName != nil {
            
            self.tititH = 30
            
            let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.myView!.frame.width, height: tititH))
            titleLabel.text = self.myName!
            titleLabel.textColor = UIColor.black
            titleLabel.font = UIFont.systemFont(ofSize: 17)
            titleLabel.textAlignment = .center
            self.myView?.addSubview(titleLabel)
        }
        //初始化消息
        if self.meesage != nil {
            let messageLabel = UILabel(frame: CGRect(x: 0, y: tititH, width: self.myView!.frame.width, height: 0))
            
            messageLabel.textColor = UIColor(red: 128/255.0, green: 128/255.0, blue: 128/255.0, alpha: 1)
            messageLabel.font = UIFont.systemFont(ofSize: 12)
            messageLabel.text = self.meesage!
            
            messageLabel.numberOfLines = 0
            
            messageLabel.sizeToFit()
            
            //更新frame
            let frame = CGRect(x: (self.myView!.frame.width - messageLabel.frame.width) / 2, y: tititH, width: messageLabel.frame.width, height: messageLabel.frame.height)
            messageLabel.frame = frame
            
            messageLabel.backgroundColor = UIColor.clear
            self.messageH = messageLabel.frame.height
            self.myView?.addSubview(messageLabel)
        }

        //添加一条分界线
        //起点
        let lineY: CGFloat = self.tititH + self.messageH
        let lineView = UIView(frame: CGRect(x: 0, y: lineY, width: self.myView!.frame.width, height: self.dividingLineH))
        lineView.backgroundColor = UIColor(red: 196/255.0, green: 209/255.0, blue: 205/255.0, alpha: 1)
        self.myView?.addSubview(lineView)

        //初始化按钮
        if !self.addArray.isEmpty {
            
            //计算出起始Y点
            let startY: CGFloat = self.tititH + self.messageH + self.dividingLineH
            //按钮的高度
            let h: CGFloat = 35
            
            //判断是否为两个
            if self.addArray.count == 2 {
                //两个 并排显示
                //中间添加一条分割线
                //分割线的宽度
                let lineW: CGFloat = 0.5
                let lineX: CGFloat = (self.myView!.frame.width - lineW) / 2
                let lineV = UIView(frame: CGRect(x: lineX, y: startY, width: lineW, height: h))
                lineV.backgroundColor = UIColor(red: 196/255.0, green: 209/255.0, blue: 205/255.0, alpha: 1)
                self.myView?.addSubview(lineV)
 
                //按钮的宽度
                let btnW: CGFloat = (self.myView!.frame.width - lineW) / 2
               
                //创建按钮
                for i in 0..<self.addArray.count {
                    
                    let ace = self.addArray[i]
                    
                    //y不变，x变化
                    let x: CGFloat = CGFloat(i) * (btnW + lineW)
                    
                    let btn = UIButton(frame: CGRect(x: x, y: startY, width: btnW, height: h))
                    
                    btn.setTitle(ace.title, for: UIControlState())
                    btn.tag = i
                    
                    var titleColor = UIColor.white
                    //设置颜色
                    switch ace.style {
                    case .cancel:
                        titleColor = UIColor.red
                    case .default:
                        titleColor = UIColor(red: 125/255.0, green: 134/255.0, blue: 130/255.0, alpha: 1)
                    case .destructive:
                        titleColor = UIColor(red: 55/255.0, green: 157/255.0, blue: 162/255.0, alpha: 1)
                    }
                    
                    
                    btn.setTitleColor(titleColor, for: UIControlState())
                    
                    btn.setBackgroundImage(UIImage.createImagFromColor(UIColor.clear), for: UIControlState())
                    btn.setBackgroundImage(UIImage.createImagFromColor(UIColor(red: 227/255.0, green: 227/255.0, blue: 227/255.0, alpha: 1)), for: .highlighted)

                    
                    btn.addTarget(self, action: #selector(self.btnAct(send:)), for: .touchUpInside)
                    
                    self.myView?.addSubview(btn)
 
                }
  
                
                self.someBtnH = h
                
            }else{
                
                for i in 0..<self.addArray.count {
                    
                    let ace = self.addArray[i]
                    
                    let x: CGFloat = 0
                    let w: CGFloat = self.myView!.frame.width
                    
                    let y: CGFloat = CGFloat(i) * h + startY
                    
                    
                    let btn = UIButton(frame: CGRect(x: x, y: y, width: w, height: h))
                    
                    btn.setTitle(ace.title, for: UIControlState())
                    btn.tag = i
                    
                    var titleColor = UIColor.white
                    //设置颜色
                    switch ace.style {
                    case .cancel:
                        titleColor = UIColor.red
                    case .default:
                        titleColor = UIColor(red: 125/255.0, green: 134/255.0, blue: 130/255.0, alpha: 1)
                    case .destructive:
                        titleColor = UIColor(red: 55/255.0, green: 157/255.0, blue: 162/255.0, alpha: 1)
                    }
                    
                    
                    btn.setTitleColor(titleColor, for: UIControlState())
                    
                    btn.setBackgroundImage(UIImage.createImagFromColor(UIColor.clear), for: UIControlState())
                    btn.setBackgroundImage(UIImage.createImagFromColor(UIColor(red: 227/255.0, green: 227/255.0, blue: 227/255.0, alpha: 1)), for: .highlighted)
                    
                    
                    
                    btn.addTarget(self, action: #selector(self.btnAct(send:)), for: .touchUpInside)
                    
                    self.myView?.addSubview(btn)
                    
                    self.someBtnH += h
                }
            }
    
    
        }
        
        //更新 myView frame
        let viewy: CGFloat = self.tititH + self.messageH + self.someBtnH + self.dividingLineH
        self.myView?.frame = CGRect(x: self.viewX, y: (self.view.frame.height - viewy) / 2, width: self.view.frame.width - self.viewX * 2, height: viewy)
    }
    
  
    
    
    //按钮点击事件
    @objc fileprivate func btnAct(send: UIButton){
        
        let tag = send.tag
        
        let ace = self.addArray[tag]
        let hander = ace.hander
        //回调方法
        hander(send)
        //返回上一级
        self.dismiss(animated: true, completion: nil)
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}




extension UIViewController {
    

    func myPresent(viewCtr: UIViewController, animated: Bool, completion: (() -> Void)?){
        
        viewCtr.modalPresentationStyle = .overFullScreen
        viewCtr.modalTransitionStyle = .crossDissolve
        
        self.present(viewCtr, animated: animated, completion: completion)
    }

    
}
extension UIImage {
    //颜色转图片
    class func createImagFromColor(_ color: UIColor) -> UIImage{
        
        let size = CGSize(width: 1, height: 1)
        
        UIGraphicsBeginImageContext(size)
        
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(color.cgColor)
        
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        
        context?.fill(rect)
        
        let theImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return theImage!
        
    }
}
