//
//  RamenData.swift
//  RamenInfo
//
//  Created by 河原広夢 on 2021/01/21.
//

import UIKit

class RamenData: NSObject {
    var data:[Dictionary<String,String>]!
    override init() {
        self.data = []
    }
    
    func search_category(category:String) -> [Dictionary<String,String>] {
        var filter_data:[Dictionary<String,String>] = []
        for roop_data in self.data {
            if roop_data["category"] == category{
                filter_data.append(roop_data)
            }
        }
        print(filter_data)
        return filter_data
    }
    
    func set_data(data:Dictionary<String,String>) {
        self.data.append(data)
    }
    
    func get_data() -> Array<Dictionary<String,String>>{
        return self.data
    }

}
