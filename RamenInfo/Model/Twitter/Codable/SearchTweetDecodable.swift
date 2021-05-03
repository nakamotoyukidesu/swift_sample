//
//  SearchTweetDecodable.swift
//  RamenInfo
//
//  Created by anonymous on 2021/04/27.
//

import Foundation
class SearchTweetDecodable:TweetDataCodable{
    func json_decode(data: Data) -> [TweetModel] {
        var search_tweet:[TweetModel] = []
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
                        search_tweet.append(SearchTweet.of(text: extend_tweet.full_text, url: url, profile_image: one_tweet.user.profile_image_url_https, username: one_tweet.user.screen_name, name: one_tweet.user.name, created_at: one_tweet.created_at.toString()))
                    }else{
                        if let entities = one_tweet.entities{
                            if let media = entities.media {
                                for one_media in media {
                                    url.append(one_media.media_url_https)
                                }
                            }
                        }
                        search_tweet.append(SearchTweet.of(text: one_tweet.text, url: url, profile_image: one_tweet.user.profile_image_url_https, username: one_tweet.user.screen_name, name: one_tweet.user.name, created_at: one_tweet.created_at.toString()))
                    }
                }
            }
            print("サーチツイートの出力")
            for tweet in search_tweet {
                print(tweet.text)
            }
        }catch{
            print("error")
            print(error.localizedDescription)
        }
        return search_tweet
    }
    
    
}
