//
//  RepoTableViewCell.swift
//  SoukainabenchekrounMobileChallenge
//
//  Created by Soukaina benchekroun on 02/10/2018.
//  Copyright © 2018 Soukaina benchekroun. All rights reserved.
//

import UIKit

class RepoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var repoNameLbl: UILabel!
    @IBOutlet weak var repoDescriptionTxt: UITextView!
    @IBOutlet weak var repoAvatarImg: UIImageView!
    @IBOutlet weak var numberOfStarsLbl: UILabel!
    @IBOutlet weak var repoOwnerNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
