//
//  User.swift
//  SwiftTwitter
//
//  Created by Matheus Lima on 11/04/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import Foundation

struct User: Equatable {
    var id: String?
    var username: String? // "@..."
    var name: String?
    var profileImageURL: String?
    var profileBackgroundColor: String?
    var followersCount: Int?
    var friendsCount: Int? // "Following"
    var statusesCount: Int? // "Quantity of user tweets"
    var description: String?
    var bannerImageURL: String?
    var location: String?
    var createdAt: String?
}
