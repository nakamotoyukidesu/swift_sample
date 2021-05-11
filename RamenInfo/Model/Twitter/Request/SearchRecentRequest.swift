//
//  SearchRecentRequest.swift
//  RamenInfo
//
//  Created by anonymous on 2021/04/26.
//

import Foundation

class SearchRecentRequest:TwitterApiRequest{
    var url: String?
    
    var query_item: Dictionary<String, String> = [
        "expansions" : "attachments.media_keys,author_id,referenced_tweets.id",
        "media.fields" : "url",
        "user.fields" : "username,profile_image_url",
        "tweet.fields" : "created_at"
    ]
    
    init(query:String) {
        self.url = "https://api.twitter.com/2/tweets/search/recent"
        self.query_item.updateValue(query, forKey: "query")
    }
    
}
