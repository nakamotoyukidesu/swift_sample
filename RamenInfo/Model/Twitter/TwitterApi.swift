//
//  TwitterApi.swift
//  RamenInfo
//
//  Created by 中元優希 on 2021/01/25.
//

import Foundation
class TwitterApi: TwitterApiProtocol {

    
    var bearer_token: String = "AAAAAAAAAAAAAAAAAAAAAEMJKwEAAAAA1ikyAZw%2F%2B809osq70v%2FKco93%2B3E%3DruzJdDfhSLXdWTeMSye7iUZPSPJhVLyk2x5Ivuh0Lcf8m2wyTi"
    
    func get_tweet(api_request:TwitterApiRequest,tweet_codable:TweetDataCodable,completion: @escaping ([TweetModel]) -> Void) {
        print(api_request.url!)
        print(type(of: api_request.url))
        var urlComponents = URLComponents(string: api_request.url!)
        var query_items:[URLQueryItem] = []
        for (key,value) in api_request.query_item{
            query_items.append(URLQueryItem(name: key, value: value))
        }
        urlComponents?.queryItems = query_items
        print(urlComponents?.queryItems)
        var request = URLRequest(url: urlComponents!.url!)
        request.addValue("Bearer \(bearer_token)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request){ data, response, error in
            if let error = error{
                print(error)
                print("エラーです")
            }
            if let response = response {
                print("レスポンスの中身")
                print(response)
            }
            if let data = data {
               print("ツイート取得\(String(bytes: data, encoding: .utf8))")
                completion(tweet_codable.json_decode(data: data))
            }
        }
        task.resume()
    }
    
}

extension DateFormatter{
    static let iso8601api1:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_us_POSIX")
        return formatter
    }()
}
extension DateFormatter{
    static let iso8601api2:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_us_POSIX")
        return formatter
    }()
}
extension Date{
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        formatter.dateFormat = "MM-dd-HH:mm:ss"
        return formatter.string(from: self)
    }
}
