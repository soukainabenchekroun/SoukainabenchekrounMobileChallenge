//
//  Owner.swift
//  SoukainabenchekrounMobileChallenge
//
//  Created by Soukaina benchekroun on 02/10/2018.
//  Copyright © 2018 Soukaina benchekroun. All rights reserved.
//

import UIKit

class Owner : Codable {
    let login : String
    let avatar_url : String
    init(login : String, avatar_url : String) {
        self.login = login
        self.avatar_url = avatar_url
    }
}
