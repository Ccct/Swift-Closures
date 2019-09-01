//
//  ViewController.swift
//  SwiftClosuresDemo
//
//  Created by Helios on 2019/8/18.
//  Copyright © 2019 Helios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    // MARK: 逃逸闭包
    
    //定义一个数组，存“()->void”类型的闭包
    var completionHandlers: [() -> Void] = []
    
    // 逃逸闭包：下面的闭包被方法外的数组引用，也就意味着，这个闭包在函数执行完后还可能被调用，所以必须使用逃逸闭包，不然编译不过去
    func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
        completionHandlers.append(completionHandler)
        completionHandler()
    }
    // 非逃逸闭包
    func someFunctionWithNoneEscapingClosure(closure: () -> Void) {
        closure()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        someFunctionWithEscapingClosure {
            
            print("逃逸闭包")
        }
        someFunctionWithNoneEscapingClosure {
            
            print("非逃逸闭包")
        }
        completionHandlers.first?()
        
        
        
        // MARK: 利用 逃逸闭包 传递数据，类似OC中的Block
        let vc = NewController()
        vc.delegate = self
        //第一种
        vc.ClosureMethond { (result) in
            
            print("result:\(result)")
        }
        //第二种
        vc.pass = { str in
            
            print("闭包 数据传递过来啦:\(str)")
        }
        self.navigationController?.pushViewController(vc, animated: true)
        
        
        
        
        
        
        testClosure()
    }
    
    func testClosure(){
     
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        //嵌套函数
        func backword(str1:String,str2:String) -> Bool{
            return str1 > str2
        }
        
        // sorted函数的参数是一个闭包，下面传了一个方法名，由此说明：嵌套函数是一个有名字,并可以捕获其封闭函数域内值的闭包
        var reversedNames = names.sorted(by: backword)
        
        // MARK: 普通闭包
        
        // 普通闭包格式：{(参数: 参数类型,参数: 参数类型 ..) -> 返回值类型 in return 内容}
        reversedNames = names.sorted(by: {(str1:String,str2:String) -> Bool in return str1 > str2})
        
        // 简写1： 根据Swift的类型推断，参数类型、参数括号、返回值类型 可以去掉
        reversedNames = names.sorted(by: {str1,str2 in return str1 > str2})
        
        // 简写2： 可以去掉return
        reversedNames = names.sorted(by: {str1,str2 in str1 > str2})
        
        // 简写3:  使用参数名缩写：参数和in也可以去掉 $0 是第一个参数，$1是第二个参数
        reversedNames = names.sorted(by: {$0 > $1})
        
        // 简写4:  使用运算符：Swift中为字符串重载了大于号小于号
        reversedNames = names.sorted(by: >)
        
        
        
        // MARK: 尾随闭包
        
        // 尾随闭包1：前提是闭包必须是函数的最后一个参数
        reversedNames = names.sorted(){$0 > $1}
        
        // 尾随闭包2：闭包是函数唯一参数时，可以省掉参数括号
        reversedNames = names.sorted {$0 > $1}
        
        print("reversedNames:\(reversedNames)")
        
        
        
        // MARK: 值捕获示例
        
        func makeIncrementer(forIncrement amount: Int) -> () -> Int{
            
            var runningTotal = 0
            
            //嵌套函数incrementer本身没有参数，它却捕获了外围的参数 runningTotal 和 amount
            func incrementer() -> Int{
                
                runningTotal += amount
                return runningTotal
            }
            
            return incrementer
        }
        
        let makeIncrementByTen = makeIncrementer(forIncrement: 10)

        var ret = makeIncrementByTen()
        print("ret + 10 第一次:\(ret)")

        ret = makeIncrementByTen()
        print("ret + 10 第二次:\(ret)")

        ret = makeIncrementByTen()
        print("ret + 10 第三次:\(ret)")

        let makeIncrementBySeven = makeIncrementer(forIncrement: 7)

        ret = makeIncrementBySeven()
        print("ret + 7 第一次:\(ret)")

        ret = makeIncrementByTen()
        print("ret + 10 第四次:\(ret)")
        // 同一个闭包连续调用，值会递增原因：闭包是引用类型，同一个闭包捕获的变量并没有释放
    }
}

extension ViewController:newControllerDelegate{
    
    func delegatePassValue(str: String) {
        
        print("代理传数据过来了:\(str)")
    }
}



