//
//  UserTimelineRequest.swift
//  RamenInfo
//
//  Created by anonymous on 2021/04/26.
//

import Foundation

class UserTimelineRequest:TwitterApiRequest{
    var url:String?
    var query_item:Dictionary<String,String> = [
        "expansions" : "attachments.media_keys,author_id,referenced_tweets.id",
        "media.fields" : "url",
        "exclude" : "retweets,replies",
        "user.fields" : "username,profile_image_url",
        "tweet.fields" : "created_at"
    ]
    
    init(id:String) {
        self.url = "https://api.twitter.com/2/users/\(id)/tweets"
    }
    
}
