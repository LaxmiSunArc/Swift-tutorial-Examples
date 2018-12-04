//
//  Menu.swift
//  NestedJSONRealm
//
//  Created by Anand Suthar on 03/12/18.
//  Copyright © 2018 Anand Suthar. All rights reserved.
//

import Foundation
import RealmSwift


class Menu:Object {
    
   @objc dynamic var id: String?
   @objc dynamic var parentId: String?
   @objc dynamic var name: String?
   @objc dynamic var isActive: Bool = false
   @objc dynamic var position: String?
   @objc dynamic var level: String?
   @objc dynamic var productCount: String?
  // @objc dynamic var childernMenu = [Menu]()
   //@objc dynamic var rawChildernData: Any?
    
    let rawChildrenDatas = List<RawChildren>()
    
    func initWithJSON(json: Any) {
        
        let jsonResult = json as! [String: Any]
        
        
        id              = jsonResult["id"] as? String
        parentId        = jsonResult["parent_id"] as? String
        name            = jsonResult["name"] as? String
        isActive        = jsonResult["is_active"] as! Bool
        position        = jsonResult["position"] as? String
        level           = jsonResult["level"] as? String
        productCount    = jsonResult["product_count"] as? String
       let rawChildernData = jsonResult["children_data"]as! [[String: Any]]
       // if rawChildernData?.count ?? 1 > 0{
     
        for rawdata in rawChildernData {
            let rawchildren = RawChildren()
            print(rawdata)
            rawchildren.initWithJSON(json: rawdata)
            self.rawChildrenDatas.append(rawchildren)
            
            
        }
        
        
        
//        for subMenu in rawChildernData {
//            let newSubMenu = RawChildren()
//            newSubMenu.initWithJSON(json: subMenu)
//            rawChildrenDatas.append(newSubMenu)
//            //print(childernMenu.description)
//            }
//
//
        
        //}
    }
    override static func primaryKey() -> String? {
        return "id"
    }
}

class RawChildren:Object{
    
    
    @objc dynamic var id: Int = 0
    @objc dynamic var parentId: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var isActive: Bool = false
    @objc dynamic var position: Int = 0
    @objc dynamic var level: Int = 0
    @objc dynamic var productCount: Int = 0
    let menus = LinkingObjects(fromType: Menu.self, property: "rawChildrenDatas")
   // let rawsubChliderdata:List<RawChildren>? = nil
    func initWithJSON(json: Any) {
        
        let jsonResult = json as! [String: Any]
        
        
        id              = jsonResult["id"] as! Int
        parentId        = jsonResult["parent_id"] as! Int
        name            = jsonResult["name"] as! String
        isActive        = jsonResult["is_active"] as! Bool
        position        = jsonResult["position"] as! Int
        level           = jsonResult["level"] as! Int
        productCount    = jsonResult["product_count"] as! Int
     //  let rawdata      = jsonResult["children_data"]
        let  rawChildernDatas = jsonResult["children_data"] as! [[String:Any]]
        for r in rawChildernDatas {
            let menu = Menu()
            menu.initWithJSON(json: r)
            
            
        }
        
        
//
//        for subMenu in (rawdata as? [[String: Any]])! {
//            let newSubMenu = RawChildren()
//            newSubMenu.initWithJSON(json: subMenu)
//            rawsubChliderdata?.append(newSubMenu)
//            //print(childernMenu.description)
//        }
        
    }
    override static func primaryKey() -> String? {
        return "id"
    }
}

