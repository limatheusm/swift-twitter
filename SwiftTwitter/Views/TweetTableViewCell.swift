//
//  TweetTableViewCell.swift
//  SwiftTwitter
//
//  Created by Matheus Lima on 11/04/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    static let identifier = "TweetTableViewCell"
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var fullTextLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var replyCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var replyToUsernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        roundImage()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        profileImageView.image = nil
        nameLabel.text = nil
        usernameLabel.text = nil
        replyToUsernameLabel.text = nil
        dateLabel.text = nil
        fullTextLabel.text = nil
        replyCountLabel.text = nil
        retweetCountLabel.text = nil
        favoriteCountLabel.text = nil
    }
    
    private func roundImage() {
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.clipsToBounds = true
    }
}
