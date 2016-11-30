//
//  ViewController.swift
//  Handel
//
//  Created by sqluo on 2016/11/30.
//  Copyright © 2016年 sqluo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let btn = UIButton(frame: CGRect(x: (self.view.frame.width - 100) / 2, y: 200, width: 100, height: 30))
        
        btn.setTitle("点击", for: UIControlState())
        btn.backgroundColor = UIColor.red
        btn.setTitleColor(UIColor.white, for: UIControlState())
        
        btn.addTarget(self, action: #selector(self.btnAct(send:)), for: .touchUpInside)
        
        self.view.addSubview(btn)
    }
    
    func btnAct(send: UIButton){
        
        let handerVC = HanderViewController(name: "测试", meesage: "历史了深刻到家了健康路附近，历史了深刻到家了健康路附近，历史了深刻到家了健康路附近，历史了深刻到家了健康路附近")

//        handerVC.addAction(title: "123456", style: .default, hander: { (btn) in
//            print("12345645666")
//        })
//        
//        
//        handerVC.addAction(title: "skljklajlf", style: .destructive, hander: { (btn) in
//            print("12345645666")
//        })
        
        handerVC.addAction(title: "cancel", style: .cancel, hander: { (btn) in
            print("cancel")
        })
        
        
        self.myPresent(viewCtr: handerVC, animated: true, completion: nil)
        
        
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

