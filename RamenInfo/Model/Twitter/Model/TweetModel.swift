//
//  TweetModel.swift
//  RamenInfo
//
//  Created by anonymous on 2021/04/26.
//

import Foundation

protocol TweetModel{
    var text:String {get set}
    var url:[String]? { get set }
    var profile_image:String { get set }
    var username:String { get set }
    var name:String { get set }
    var created_at:String { get set }
    
    static func of(text:String, url:[String], profile_image:String, username:String, name:String, created_at:String) -> Self
}
