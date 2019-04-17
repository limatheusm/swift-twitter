//
//  BackButton.swift
//  SwiftTwitter
//
//  Created by Matheus Lima on 15/04/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import UIKit

class BackButton: UIButton {
    let width: CGFloat = 30
    let height: CGFloat = 30
    
    override func awakeFromNib() {
        backgroundColor = UIColor(named: "DarkTransparent")
        layer.cornerRadius = width / 2
        setImage(UIImage(named: "ic_back"), for: .normal)
        imageEdgeInsets = UIEdgeInsets(top: 8, left: 6, bottom: 8, right: 8)
        
        let widthContraints =  NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width)
        let heightContraints = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height)
        NSLayoutConstraint.activate([heightContraints,widthContraints])
    }
}
