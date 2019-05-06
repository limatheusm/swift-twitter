//
//  RoundedButton.swift
//  SwiftTwitter
//
//  Created by Matheus Lima on 02/05/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    override func awakeFromNib() {
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
    }
}
