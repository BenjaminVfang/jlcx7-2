//
//  SqlDegelte.swift
//  MyfirstApp
//
//  Created by 方振宇 on 15/12/29.
//  Copyright © 2015年 fzy. All rights reserved.
//

import Foundation

class sqlite{
    var date:SQLiteDB!
    init(){
        date=SQLiteDB.sharedInstance
    }
    func search(_ text:String)->[[String:Any]]{

        
    let result = date.query(sql: "select * from bidate where 总编号 like'%\(text)%'or 状态 like '%\(text)%' or 名称 like '%\(text)%'or 设备编号 like '%\(text)%'")
        print(text)
        return result as [[String : Any]]
    }
//    func update(idnumber:String,_ date1:String,_ date2:String,_ youxiaoq:String){
//        
//        date.execute("update bidate set 下次检定时间='\(date1)',检定时间='\(date2)',周期=\(youxiaoq)  where 总编号 ='\(idnumber)'")
//    }
    func update(_ idnumber:String,_ date1:String,_ date2:String,_ youxiaoq:String,_ noOfEquioment:String ,_ dirunit:String,_ personLiable:String){
        
     let _ = date.execute(sql: "update bidate set 下次检定时间='\(date1)',检定时间='\(date2)',周期='\(youxiaoq)',设备编号='\(noOfEquioment)',直接单位='\(dirunit)',责任人='\(personLiable)'  where 总编号 ='\(idnumber)'")
    }
   
    func delete(id:String) {
        let _ = date.execute(sql: "delete from bidate where 总编号='\(id)'")
        
    }
    

}
