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
    
    var swifterAuthenticated: Swifter? = {
        if let userAccessToken =
            UserDefaults.standard.value(forKey: Constants.TwitterAPI.UserDefaults.OAuthTokenKey) as? String,
            let userSecretToken =
            UserDefaults.standard.value(forKey: Constants.TwitterAPI.UserDefaults.OAuthSecretKey) as? String {
            return Swifter(
                consumerKey: Constants.TwitterAPI.ConsumerAPIKey,
                consumerSecret: Constants.TwitterAPI.ConsumerAPISecretKey,
                oauthToken: userAccessToken,
                oauthTokenSecret: userSecretToken
            )
        }
        return nil
    }()
    
    func fetchUserTimeline(forUserID: String, completionHandler: @escaping (TweetsStoreResult<[Tweet]>) -> Void) {
        swifter.getTimeline(for: UserTag.id(forUserID), count: 100, includeRetweets: false, tweetMode: .extended, success: { (responseJSON) in
            guard let dataArray = responseJSON.array else {
                completionHandler(.Failure(.CannotDecode(Constants.DefaultErrorMessages.CannotDecode)))
                return
            }
            
            var tweets: [Tweet] = []
            
            for tweetJSON in dataArray {
                let tweet = self.makeTweet(from: tweetJSON)
                tweets.append(tweet)
            }
            
            tweets.isEmpty
                ? completionHandler(.Failure(.NoData("No tweets")))
                : completionHandler(.Success(tweets))
        }) { (error) in
            completionHandler(.Failure(.CannotFetch(error.localizedDescription)))
        }
    }
    
    func searchTweets(searchText: String, completionHandler: @escaping (TweetsStoreResult<[Tweet]>) -> Void) {
        swifter.searchTweet(using: "\(searchText) -filter:retweets", count: 100, tweetMode: .extended, success: { (responseJSON, nextJSON) in
            
            guard let dataArray = responseJSON.array else {
                completionHandler(.Failure(.CannotDecode(Constants.DefaultErrorMessages.CannotDecode)))
                return
            }
            
            var tweets: [Tweet] = []
            
            for tweetJSON in dataArray {
                let tweet = self.makeTweet(from: tweetJSON)
                tweets.append(tweet)
            }
            
            tweets.isEmpty
                ? completionHandler(.Failure(.NoData("No results for \"\(searchText)\"")))
                : completionHandler(.Success(tweets))
        }) { (error) in
            completionHandler(.Failure(.CannotFetch(error.localizedDescription)))
        }
    }
    
    func loginAuth(completionHandler: @escaping (TweetsStoreResult<Credential.OAuthAccessToken>) -> Void) {
        guard let callbackURL = URL(string: Constants.TwitterAPI.CallbackURL) else {
            return completionHandler(.Failure(.CannotDecode("callback URL failed")))
        }
        
        swifter.authorize(withCallback: callbackURL, presentingFrom: nil, success: { accessToken, response in
            guard let accessToken = accessToken else {
                return completionHandler(.Failure(.NoData("Access Token not found")))
            }
            completionHandler(.Success(accessToken))
        }, failure: { error in
            completionHandler(.Failure(.CannotFetch(error.localizedDescription)))
        })
    }
    
    func verifyCredentials(completionHandler: @escaping (TweetsStoreResult<[String: String?]>) -> Void) {
        guard let swifterAuth = swifterAuthenticated else {
            return completionHandler(.Failure(.UserNotLogged("Please, sign in")))
        }
        
        swifterAuth.verifyAccountCredentials(success: { (resultJSON) in
            guard let userID = resultJSON["id_str"].string else {
                return completionHandler(.Failure(.UserNotLogged("Please, sign in")))
            }
            let response = [
                "userID": userID,
                "userProfileImageURL": resultJSON["profile_image_url"].string
            ]
            
            completionHandler(.Success(response))
        }) { (error) in
            completionHandler(.Failure(.UnknownReason(error.localizedDescription)))
        }
    }
}

// MARK: - Convenience Methods

extension TwitterAPI {
    private func makeTweet(from tweetJSON: JSON) -> Tweet {
        let userJSON = tweetJSON["user"]
        let user = self.makeUser(from: userJSON)
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
        
        return tweet
    }
    
    private func makeUser(from userJSON: JSON) -> User {
        let user = User(
            id: userJSON["id_str"].string,
            username: userJSON["screen_name"].string,
            name: userJSON["name"].string,
            profileImageURL: userJSON["profile_image_url_https"].string,
            profileBackgroundColor: userJSON["profile_background_color"].string,
            followersCount: userJSON["followers_count"].integer,
            friendsCount: userJSON["friends_count"].integer,
            statusesCount: userJSON["statuses_count"].integer,
            description: userJSON["description"].string,
            bannerImageURL: userJSON["profile_banner_url"].string,
            location: userJSON["location"].string,
            createdAt: userJSON["created_at"].string
        )
        
        return user
    }
}
