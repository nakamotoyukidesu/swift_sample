//
//  SearchTweetRequest.swift
//  RamenInfo
//
//  Created by anonymous on 2021/04/29.
//

import Foundation

class SearchTweetRequest:TwitterApiRequest{
    var url: String?
    
    var query_item: Dictionary<String, String> = [
        "maxResults" : "50",
        "fromDate" : "20180101000"
    ]
    
    init(query:String) {
        self.url = "https://api.twitter.com/1.1/tweets/search/30day/SampleDatabase.json"
        self.query_item.updateValue(query, forKey: "query")
    }
}
