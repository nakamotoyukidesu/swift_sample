//
//  TwitterApiRequest.swift
//  RamenInfo
//
//  Created by anonymous on 2021/04/26.
//

import Foundation

protocol TwitterApiRequest{
    var url:String? { get set }
    var query_item:Dictionary<String,String> { get set }
}
