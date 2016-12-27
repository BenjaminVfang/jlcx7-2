//
//  ItemDetailViewContoller.swift
//  MyfirstApp
//
//  Created by 方振宇 on 15/12/31.
//  Copyright © 2015年 fzy. All rights reserved.
//

import UIKit

class ItemDetailViewContoller: UIViewController,UIScrollViewDelegate{
    
    @IBAction func update(_ sender: AnyObject) {
        let d:sqlite=sqlite()
        //d.update(总编号.text!,有效日期.text!,检定日期.text!,周期.text!，)
        //detail["检定时间"]=检定日期.text!
        if !(有效日期.text!.isEmpty||检定日期.text!.isEmpty||周期.text!.isEmpty){
            d.update(总编号.text!,有效日期.text!,检定日期.text!,周期.text!,设备编号.text!,直接单位.text!,责任人.text!)
//            let alertView:UIAlertView=UIAlertView(title: "", message: "修改成功", delegate: self, cancelButtonTitle: "Yes")
//            alertView.show()
            let alertcontroller=UIAlertController(title: "提示", message: "修改成功", preferredStyle: .alert)
            alertcontroller.addAction(UIAlertAction(title: "确定", style: .default, handler: {(action:UIAlertAction)-> Void in print("成功")}))
            alertcontroller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alertcontroller, animated: true, completion: {print("alert成功，显示")})
            
        }else{
//            let alertView:UIAlertView=UIAlertView(title: "", message: "数据不全修改失败", delegate: self, cancelButtonTitle: "Yes")
//            alertView.show()
            let alertcontroller=UIAlertController(title: "提示", message: "数据不全修改失败", preferredStyle: .actionSheet)
            alertcontroller.addAction(UIAlertAction(title: "知道了", style: .destructive, handler: {(action:UIAlertAction)-> Void in print("失败")}))
            alertcontroller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alertcontroller, animated: true, completion: {print("alert失败，显示")})
            
        }
    }
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var viewinscrollview: UIView!
    @IBOutlet weak var 设备编号: UITextField!
    @IBOutlet weak var 有效日期: UITextField!
    @IBOutlet weak var 周期: UITextField!
    @IBOutlet weak var 检定日期: UITextField!
    @IBOutlet weak var 名称: UITextField!
    
    @IBOutlet weak var 直接单位: UITextField!
    @IBOutlet weak var 总编号: UITextField!
  
    @IBOutlet weak var 出厂编号: UITextField!
    @IBOutlet weak var 责任人: UITextField!
    @IBOutlet weak var a1: UITextField!
//    let scrollview=UIScrollView()//2016年07月26日16:22:29
    var detail:AnyObject?
        

    override func viewDidLoad() {
        super.viewDidLoad()
        /* 2016年07月26日16:22:49
        scrollview.frame=self.view.bounds
        scrollview.tag=0
        scrollview.backgroundColor=UIColor.white()
        scrollview.isPagingEnabled=false
        scrollview.isScrollEnabled=true
        scrollview.contentSize=CGSize(width: self.view.frame.width, height: (600>self.view.frame.height ? 600 :self.view.frame.height))
        scrollview.bounces=true
        scrollview.alwaysBounceHorizontal=false
        scrollview.alwaysBounceVertical=true
        view.addSubview(scrollview)
        for ui in view.subviews{
            if ui.tag == 1 {
                scrollview.addSubview(ui)
            }
        }*/
        
        if let ss = detail{
            navigationItem.title=ss["名称"] as? String
            总编号.text=ss["总编号"] as? String
            总编号.isUserInteractionEnabled = false//用户无法编辑
            名称.text=ss["名称"] as? String
             有效日期.text=ss["下次检定时间"] as? String
            检定日期.text=ss["检定时间"] as? String
            设备编号.text=ss["设备编号"] as? String
            a1.text=ss["状态"] as? String
            a1.isUserInteractionEnabled = false//用户无法编辑
           if let zq=(ss["周期"] as? Int) ,zq != 0{
            
                周期.text=String(zq)
            }else{
                if let zq=ss["周期"] as? String,zq != "0"{
                     周期.text=zq
                }
            }
            直接单位.text=ss["直接单位"] as? String
            责任人.text=ss["责任人"] as? String
            出厂编号.text=ss["出厂编号"] as? String
            出厂编号.isUserInteractionEnabled=false//用户无法编辑
        }else{
            print("nothing")
            
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        scrollview.frame=CGRect(x: 0, y: 0, width: size.width, height: size.height)
//        scrollview.contentSize=CGSize(width: size.width, height: (700>size.height ? 700 :size.height))
//    }//2016年07月26日16:23:49
    func viewForZooming(in scrollView: UIScrollView) -> UIView?{
        return viewinscrollview
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        for touch in touches {
        if touch.tapCount==2{
            print(2)
//            let x=touch.location(in:viewinscrollview)
//            viewinscrollview.center=x
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.4)
            scrollview.zoomScale=(scrollview.zoomScale==1.0 ? 3.0:1.0 )
            UIView.commitAnimations()
        }
        }
    }
    
}
