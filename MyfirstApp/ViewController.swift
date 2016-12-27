//
//  ViewController.swift
//  MyfirstApp
//
//  Created by 方振宇 on 15/12/29.
//  Copyright © 2015年 fzy. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {

    
    @IBOutlet weak var textsear: UITextField!
    @IBOutlet weak var tableviews: UITableView!
    //var count1:[[String:AnyObject]]!
    var count1:[[String:Any]]!
    //activityIndicator定义
    let activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    var d:sqlite=sqlite()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textsear.placeholder="请输入计量或设备编号，名称进行查询"
        creatActivityIndicator()

    }
    func creatActivityIndicator(){
        let myx = UIScreen.main.bounds.midX
        let myy = UIScreen.main.bounds.midY
        activity.frame=CGRect(x: myx, y: myy, width: 0, height: 0)
        activity.hidesWhenStopped=true
        self.view.addSubview(activity)
        self.view.bringSubview(toFront: activity)
        activity.color=UIColor.black// 颜色

        
    }
    override func viewDidAppear(_ animated: Bool) {
        if let str=textsear.text{
            if !str.isEmpty{
                search()
            
            }}
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
   
    @IBAction func search() {
        
            if let str=textsear.text{
                activity.startAnimating()
                //let qos=Int(QOS_CLASS_USER_INITIATED.rawValue)
                let queue=DispatchQueue(label: "firstqueue")
                queue.async {
                    self.count1=self.d.search(str)
                    DispatchQueue.main.async {
                        [unowned me=self] in
                        me.tableviews.reloadData()
                        me.activity.stopAnimating()
                        
                    }
                }
        }
    }
    
    
   
    
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let _=count1{
                        return count1.count
                        }else{
                        return 0
                        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        if textsear.text != nil{
            search()}
        return true
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
//        let cell=UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier:"cell")
//        if let _=count1{
//            let date1=count1[indexPath.row]
//            cell.textLabel?.text=date1["总编号"] as? String
//            if let dateyx=date1["下次检定时间"],name=date1["名称 "]
//                
//            {   if dateyx==nil{cell.detailTextLabel?.text = "\(name!)"
//                    }else{         cell.detailTextLabel?.text = "\(name!)有效期：\((dateyx as? String)!)"}}
//        }
    let cell=self.tableviews.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        let label1=cell.viewWithTag(1) as! UILabel
        let label2=cell.viewWithTag(2) as! UILabel
//        label1.text=""
//        label2.text=""
        if let _=count1{
            let date1=count1[indexPath.row]
            label1.text="\((date1["总编号"] as? String)!)   状态为:\((date1["状态"] as? String)!)"
            switch (date1["状态"] as? String)!{
            case "过期"  :cell.backgroundColor=UIColor.red
            case "报废","遗失","停用"  : cell.backgroundColor=UIColor.gray
            default: cell.backgroundColor=UIColor.white
            }
                       if let name=(date1["名称"] as? String){
                        
                            label2.text = "\(name)"
                        if let dateyx=(date1["下次检定时间"] as? String){
                            label2.text = label2.text!+" 有效期：\(dateyx)"
                        }}else{
                            label2.text=" "
                        }
            }

        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
       // performSegue(withIdentifier : "itemDetail", sender : count1[indexPath.row] as Any? )
//        var s:Dictionary<String,AnyObject>=Dictionary<String,AnyObject>()
//        for key in count1[indexPath.row].keys{
//            
//            if let rawvalue = count1[indexPath.row][key]{
//            s[key as String]=rawvalue as AnyObject
//            }
//            
//        }
        performSegue(withIdentifier: "itemDetail", sender: count1[indexPath.row]  )
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepareforsegue")
        if segue.identifier=="itemDetail"{
            let destination:ItemDetailViewContoller=segue.destination as! ItemDetailViewContoller
            destination.detail = sender as AnyObject?
                                }
        }

    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?{
        return "删除"
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        var message1=""
        if let _=self.count1{
            message1 = count1[indexPath.row]["总编号"] as! String
        }
        
        let alert=UIAlertController(title: "注意", message: "确认删除\(message1)", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "删除", style: UIAlertActionStyle.destructive){
            (UIAlertAction) -> Swift.Void in
            print("确认删除")
            if let _=self.count1{
                let id = self.count1[indexPath.row]["总编号"] as! String
                //                self.tableview.reloadData()
                self.count1.remove(at: indexPath.row)
                self.tableviews.deleteRows(at: [indexPath], with: .fade)
                self.d.delete(id: id)
            }
            
        }
        alert.addAction(deleteAction)
        let cancelAction=UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
        
        
    }

}
