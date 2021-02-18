//
//  TwitterApi.swift
//  RamenInfo
//
//  Created by 中元優希 on 2021/01/25.
//

import Foundation
class TwitterApi: TwitterApiProtocol {
    var bearer_token: String = "AAAAAAAAAAAAAAAAAAAAAEMJKwEAAAAAt1EUD%2BsavxO4Dmm7baoGHIryJCU%3DPjAY9TPbRvUnmk9ExxS9n3J6dik1SK7vcylj1HpkT1HI7N111A"
    
    func get_user_timeline(id:String,completion: @escaping ([UserTimeline]) -> Void) {
        var urlComponents = URLComponents(string: "https://api.twitter.com/2/users/\(id)/tweets")
        urlComponents?.queryItems = [
            URLQueryItem(name: "expansions", value: "attachments.media_keys,author_id,referenced_tweets.id"),
            URLQueryItem(name: "media.fields", value: "url"),
            URLQueryItem(name: "exclude", value: "retweets,replies"),
            URLQueryItem(name: "user.fields", value: "username,profile_image_url"),
            URLQueryItem(name: "tweet.fields", value: "created_at")
            
        ]
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
//               print("ツイート取得\(String(bytes: data, encoding: .utf8))")
                do{
                    var decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(.iso8601api2)
                    let tweets:UserTimelineCodable = try decoder.decode(UserTimelineCodable.self, from: data)
                    let encoder = JSONEncoder()
                    encoder.outputFormatting = .prettyPrinted
//                    print("エンコード")
                    let encoded = try! encoder.encode(tweets)
                    var tweet_model:[UserTimeline] = []
                    for tweet in tweets.data {
                        var url:[String] = []
                        if let media_keys = tweet.attachments?.media_keys{
                            for media_key in media_keys {
                                for media in tweets.includes.media!{
                                    if media_key == media.media_key{
                                        url.append(media.url ?? "a")
                                    }
                                }
                            }
                        }
                        url.append("a")
                        tweet_model.append(UserTimeline(text: tweet.text!, url: url, profile_image: tweets.includes.users.first!.profile_image_url, username: tweets.includes.users.first!.username, name: tweets.includes.users.first!.name, created_at: tweet.created_at.toString()))
                    }
//                    print("ツイートモデルのカウント\(tweet_model.count)")
                    completion(tweet_model)
                }catch{
                    print(error.localizedDescription)
                    print("error")
                }
            }

        }
        task.resume()
    }
    
    func search_tweet(query:String,completion: @escaping ([SearchTweet]) -> Void) {
        var urlComponents = URLComponents(string: "https://api.twitter.com/1.1/tweets/search/30day/SampleDatabase.json")
        urlComponents?.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "maxResults", value: "50"),
        //    URLQueryItem(name: "fromDate", value: "20180101000")
            
        ]
        var request = URLRequest(url: urlComponents!.url!)
        request.addValue("Bearer \(bearer_token)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request){ data, response, error in
            if let error = error{
                print(error)
                print("エラーです")
            }
            if let response = response {
//                print("レスポンスの中身")
//                print(response)
            }
            if let data = data {
//                print("サーチツイートは、\(String(bytes: data, encoding: .utf8))")
//                print("クエリは、\(query)")
                var search_tweet:[SearchTweet] = []
                do{
                    var decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(.iso8601api1)
                    let tweet:SearchTweetCodable = try decoder.decode(SearchTweetCodable.self, from: data)
                    for one_tweet in tweet.results {
                        if one_tweet.in_reply_to_status_id == nil && one_tweet.retweeted_status == nil {
                            var url:[String] = []
                            if let extend_tweet = one_tweet.extended_tweet {
                                if let media = extend_tweet.entities.media {
                                    for one_media in media {
                                        url.append(one_media.media_url_https)
                                    }
                                }
                                search_tweet.append(SearchTweet(text: extend_tweet.full_text, url: url, name: one_tweet.user.name, user_name: one_tweet.user.screen_name, profile_image_jurl: one_tweet.user.profile_image_url_https, created_at: one_tweet.created_at.toString()))
                            }else{
                                if let entities = one_tweet.entities{
                                    if let media = entities.media {
                                        for one_media in media {
                                            url.append(one_media.media_url_https)
                                        }
                                    }
                                }
                                search_tweet.append(SearchTweet(text: one_tweet.text, url: url, name: one_tweet.user.name, user_name: one_tweet.user.screen_name, profile_image_jurl: one_tweet.user.profile_image_url_https, created_at: one_tweet.created_at.toString()))
                            }
                        }
                    }
                    print("サーチツイートの出力")
                    for tweet in search_tweet {
//                        print(tweet.text)
                    }
                    completion(search_tweet)
                }catch{
                    print("error")
                    print(error.localizedDescription)
                }
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
