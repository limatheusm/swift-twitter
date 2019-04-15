//
//  Tweet.swift
//  SwiftTwitter
//
//  Created by Matheus Lima on 11/04/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import Foundation

struct Tweet: Equatable {
    var id: String?
    var fullText: String?
    var createdAt: String?
    var replyToUsername: String?
    
    // MARK: - Count info
    var retweetCount: Int?
    var favoriteCount: Int?
    var replyCount: Int?
    
    var user: User
}
