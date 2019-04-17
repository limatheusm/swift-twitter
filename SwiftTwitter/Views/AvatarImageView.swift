//
//  AvatarImageView.swift
//  SwiftTwitter
//
//  Created by Matheus Lima on 15/04/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import UIKit

class AvatarImageView: UIImageView {

    override func awakeFromNib() {
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
    }

}

class ProfileImageView: AvatarImageView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 3.0
        layer.borderColor = UIColor.white.cgColor
    }
}
