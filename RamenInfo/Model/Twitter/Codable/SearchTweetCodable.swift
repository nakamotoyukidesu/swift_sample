//
//  SearchTweetCodable.swift
//  RamenInfo
//
//  Created by 中元優希 on 2021/01/25.
//

import Foundation
struct SearchTweetCodable:Decodable{
    var results:[TweetData]
    struct TweetData:Decodable {
        var created_at:Date
        var text:String
        var user:User
        var in_reply_to_status_id:Int?
        var retweeted_status:Retweet?
        var extended_tweet:ExtendedTweet?
        var entities:Entities?
        struct User:Decodable {
            var name:String
            var screen_name:String
            var profile_image_url:String
        }
        struct Retweet:Decodable{
            var text:String
        }
        struct ExtendedTweet:Decodable {
            var full_text:String
            var entities:Entities
            struct Entities:Decodable {
                var media:[Media]?
                struct Media:Decodable {
                    var media_url:String
                }
            }
        }
        struct Entities:Decodable {
            var media:[Media]?
            struct Media:Decodable {
                var media_url:String
            }
        }
    }
}
