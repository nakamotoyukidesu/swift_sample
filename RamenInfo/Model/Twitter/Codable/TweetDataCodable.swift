//
//  TweetDataCodable.swift
//  RamenInfo
//
//  Created by anonymous on 2021/04/26.
//

import Foundation

protocol TweetDataCodable{
    func json_decode(data:Data)->[TweetModel]
}
