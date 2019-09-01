//
//  NewController.swift
//  SwiftClosuresDemo
//
//  Created by Helios on 2019/8/18.
//  Copyright © 2019 Helios. All rights reserved.
//

import UIKit

//定义一个闭包
typealias passValue = (String)->()

//定义一个协议
protocol newControllerDelegate {
    func delegatePassValue(str: String)
}

class NewController: UIViewController {

    var pass:passValue? //实例化闭包对象
    var delegate:newControllerDelegate? ////实例化代理
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        button.backgroundColor = UIColor.red
        button.titleLabel?.text = "点我";
        button.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        view.addSubview(button)
    }
    
    func ClosureMethond(handler:(_ result:[String]) -> Void){
        
        let json = ["姓名","年龄","爱好"]
        handler(json)
    }
    
    @objc func btnAction(){
        
        //闭包 传值
//        pass?("数据数据数据")
        
        //代理 传值
        if delegate != nil {
            delegate?.delegatePassValue(str: "数据数据数据")
        }
    }
}
