//
//  Token.swift
//  RamenInfo
//
//  Created by anonymous on 2022/12/01.
//

import Foundation

class Token {
    var bearer_token = "AAAAAAAAAAAAAAAAAAAAAEMJKwEAAAAA1ikyAZw%2F%2B809osq70v%2FKco93%2B3E%3DruzJdDfhSLXdWTeMSye7iUZPSPJhVLyk2x5Ivuh0Lcf8m2wyTi"
    
    func get_token() -> String{
        return self.bearer_token;
    }
}
