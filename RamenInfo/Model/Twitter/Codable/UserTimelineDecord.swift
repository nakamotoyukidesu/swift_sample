//
//  UserTimelineDecord.swift
//  RamenInfo
//
//  Created by anonymous on 2021/04/27.
//

import Foundation
class UserTimelineDecord:TweetDataCodable{
    func json_decode(data:Data) -> [TweetModel] {
        var tweet_model:[TweetModel] = []
        do{
            var decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(.iso8601api2)
            let tweets = try decoder.decode(UserTimelineCodable.self, from: data)
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
                tweet_model.append(UserTimelineModel.of(text: tweet.text!, url: url, profile_image: tweets.includes.users.first!.profile_image_url, username: tweets.includes.users.first!.username, name: tweets.includes.users.first!.name, created_at: tweet.created_at.toString()))
            }
        }catch{
            print(error.localizedDescription)
            print("error")
        }
        return tweet_model
    }
}
