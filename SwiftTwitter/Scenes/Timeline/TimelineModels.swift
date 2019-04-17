//
//  TimelineModels.swift
//  SwiftTwitter
//
//  Created by Matheus Lima on 15/04/19.
//  Copyright (c) 2019 Matheus Lima. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum Timeline {
    
    // MARK: Use cases
    
    enum GetUser {
        struct Request {}
        struct Response {
            var user: User
        }
        struct ViewModel {
            struct DisplayedUser {
                var id: String
                var name: String
                var username: String
                var description: String
                var profileBackgroundColor: UIColor
                var location: String
                var avatarURL: URL?
                var coverURL: URL?
                var followersCount: String
                var followingCount: String
                var tweetsCount: String
                var joinedDate: String
            }
            
            var displayedUser: DisplayedUser
        }
    }
    
    enum FetchUserTimeline {
        struct Request {}
        struct Response {
            var tweets: [Tweet]
        }
        struct ViewModel {
            var displayedTweets: [DisplayedTweet]?
            var error: String?
            
            struct DisplayedTweet {
                var authorName: String
                var authorUsername: String
                var authorProfileImageUrl: URL?
                var replyToUsername: NSMutableAttributedString?
                var text: String
                var date: String
                var retweetCount: String
                var favoriteCount: String
                var replyCount: String
            }
        }
    }
}
