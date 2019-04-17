//
//  FollowButton.swift
//  SwiftTwitter
//
//  Created by Matheus Lima on 15/04/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import UIKit

class FollowButton: UIButton {
    override func awakeFromNib() {
        layer.cornerRadius = 16.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor(named: "Primary")?.cgColor
        tintColor = UIColor(named: "Primary")
    }
}
