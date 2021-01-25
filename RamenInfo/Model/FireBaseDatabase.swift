//
//  FireBaseDatabase.swift
//  RamenInfo
//
//  Created by 河原広夢 on 2021/01/21.
//

import UIKit
import FirebaseDatabase

class FireBaseDatabase: NSObject {
        var ref: DatabaseReference!
        
        //    var ramen_data:Array<String>!
        override init() {
            super.init()
        }
        
        func set_ramen_object(completion: @escaping (RamenData) -> Void) {
            self.ref = Database.database().reference()
            self.ref.child("ramen").observeSingleEvent(of: .value, with: { (snapshot) in
                var ramen_object = RamenData()
                let natural_value = snapshot.value as! NSArray
                for data in natural_value{
                    var multi_data:[String:String] = data as! [String : String]
                    ramen_object.set_data(data: multi_data)
                }
                completion(ramen_object)
            })
        }
        
        
    }


