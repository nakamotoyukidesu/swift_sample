//
//  TwitterApiProtocol.swift
//  RamenInfo
//
//  Created by 中元優希 on 2021/01/25.
//

import Foundation

protocol TwitterApiProtocol {
    var bearer_token:String {get}
//    本番環境ではtwitterアカウントの一意のid(String)を引数に受け取りURL中に代入
    func get_user_timeline(id:String,completion: @escaping([UserTimeline])->Void)
    func search_tweet(query:String,completion: @escaping([SearchTweet])->Void)
    
}
