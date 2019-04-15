//
//  SearchModels.swift
//  SwiftTwitter
//
//  Created by Matheus Lima on 11/04/19.
//  Copyright (c) 2019 Matheus Lima. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum Search {
    
    // MARK: - Use Cases
    
    enum SearchTweets {
        struct Request {
            var searchText: String
        }
        
        struct Response {
            var tweets: [Tweet]
        }
        
        struct ViewModel {
            var displayedTweets: [DisplayedTweet]?
            var error: String?
            
            struct DisplayedTweet {
                var authorName: String
                var authorUsername: String
                var authorProfileImageUrl: String?
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
