//
//  Model.swift
//  ToDoListing
//
//  Created by Stanislav Makhmoudov on 26.03.2020.
//  Copyright © 2020 GennadyMakhmudov. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit

var ToDoItems: [[String: Any]] {
    set{
        UserDefaults.standard.set(newValue, forKey: "ToDoDataKey")
           UserDefaults.standard.synchronize()
    }
    get{
        if let arraya = UserDefaults.standard.array(forKey: "ToDoDataKey") as? [[String: Any]] {
            return arraya
        }else{
            return []
        }
    }
}

func addItem(nameItem: String, isCompleted: Bool){
    ToDoItems.append(["Name":nameItem, "isCompleted":false])
    setBadge()
}
func removeItem(at index: Int){
    ToDoItems.remove(at: index)
    setBadge()
}
func changeState(at item: Int) -> Bool{
    ToDoItems[item]["isCompleted"] = !(ToDoItems[item]["isCompleted"] as! Bool)
    setBadge()
    return (ToDoItems[item]["isCompleted"] as! Bool)
}
func moveItem(fromIndex: Int, toIndex: Int){
    let from = ToDoItems[fromIndex]
    ToDoItems.remove(at: fromIndex)
    ToDoItems.insert(from, at: toIndex)
}

func requestForNotification(){
    UNUserNotificationCenter.current().requestAuthorization(options: [.badge]){
        (isEnabled, error) in
        if isEnabled{
            print("Согласие получено")
        }else{
            print("Пришел отказ")
        }
    }
}
func setBadge (){
    var totalBadgeNumber = 0
    for item in ToDoItems{
      if (item["isCompleted"] as? Bool) == false{
            totalBadgeNumber+=1
        }
    }
    UIApplication.shared.applicationIconBadgeNumber = totalBadgeNumber
}
