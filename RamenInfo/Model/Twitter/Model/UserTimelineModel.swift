//
//  UserTimeline.swift
//  RamenInfo
//
//  Created by 中元優希 on 2021/01/25.
//

import Foundation
class UserTimelineModel:TweetModel{
    
    init(text: String, url: [String], profile_image: String, username: String, name: String, created_at: String) {
        self.text = text
        self.url = url
        self.profile_image = profile_image
        self.username = username
        self.name = name
        self.created_at = created_at
    }
    static func of(text: String, url: [String], profile_image: String, username: String, name: String, created_at: String) -> Self {
        return UserTimelineModel(text: text, url: url, profile_image: profile_image, username: username, name: name, created_at: created_at) as! Self
    }
    
    var text:String
    var url:[String]?
    var profile_image:String
    var username:String
    var name:String
    var created_at:String
}
