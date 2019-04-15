//
//  TwitterAPI.swift
//  SwiftTwitter
//
//  Created by Matheus Lima on 12/04/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import Foundation
import Swifter

class TwitterAPI: TweetsStoreProtocol {
    let swifter = Swifter(
        consumerKey: Constants.TwitterAPI.ConsumerAPIKey,
        consumerSecret: Constants.TwitterAPI.ConsumerAPISecretKey
    )
    
    func searchTweets(searchText: String, completionHandler: @escaping (TweetsStoreResult<[Tweet]>) -> Void) {
        swifter.searchTweet(using: "\(searchText) -filter:retweets", count: 100, tweetMode: .extended, success: { (responseJSON, nextJSON) in
            
            guard let dataArray = responseJSON.array else {
                completionHandler(.Failure(.CannotDecode(Constants.DefaultErrorMessages.CannotDecode)))
                return
            }
            
            // Create tweets w/ Tweet model
            var tweets: [Tweet] = []
            
            for tweetJSON in dataArray {
                let userJSON = tweetJSON["user"]
                let user = User(
                    username: userJSON["screen_name"].string,
                    name: userJSON["name"].string,
                    profileImageURL: userJSON["profile_image_url_https"].string,
                    followersCount: userJSON["followers_count"].integer,
                    friendsCount: userJSON["friends_count"].integer,
                    description: userJSON["description"].string,
                    bannerImageURL: userJSON["profile_banner_url"].string,
                    location: userJSON["location"].string,
                    createdAt: userJSON["created_at"].string
                )
                let tweet = Tweet(
                    id: tweetJSON["id_str"].string,
                    fullText: tweetJSON["full_text"].string,
                    createdAt: tweetJSON["created_at"].string,
                    replyToUsername: tweetJSON["in_reply_to_screen_name"].string,
                    retweetCount: tweetJSON["retweet_count"].integer,
                    favoriteCount: tweetJSON["favorite_count"].integer,
                    replyCount: tweetJSON["reply_count"].integer,
                    user: user
                )
                
                tweets.append(tweet)
            }
            
            tweets.isEmpty
                ? completionHandler(.Failure(.NoData("No results for \"\(searchText)\"")))
                : completionHandler(.Success(tweets))
        }) { (error) in
            completionHandler(.Failure(.CannotFetch(error.localizedDescription)))
        }
    }
}
