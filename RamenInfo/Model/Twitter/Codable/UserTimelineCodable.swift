//
//  UserTimelineCodable.swift
//  RamenInfo
//
//  Created by 中元優希 on 2021/01/25.
//

import Foundation

struct UserTimelineCodable:Codable{
    var data:[TweetData]
    var includes:Includes
    struct TweetData:Codable {
        var text:String?
        var id:String?
        var attachments:Attachment?
        var created_at:Date
        struct Attachment:Codable {
            var media_keys:[String]?
        }
    }
    struct Includes:Codable {
        var media:[Media]?
        var users:[Users]
        struct Media:Codable {
            var media_key:String?
            var url:String?
        }
        struct Users:Codable {
            var profile_image_url:String
            var username:String
            var name:String
        }
    }
}
