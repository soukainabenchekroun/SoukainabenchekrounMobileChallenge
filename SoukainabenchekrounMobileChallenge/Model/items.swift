//
//  items.swift
//  SoukainabenchekrounMobileChallenge
//
//  Created by Soukaina benchekroun on 02/10/2018.
//  Copyright © 2018 Soukaina benchekroun. All rights reserved.
//

import UIKit

class items: Codable {
    var name : String
    var owner : Owner
    var description : String
    var stargazers_count : Int
    
    init(name : String,owner : Owner, description: String,stargazers_count : Int ) {
        self.name = name
        self.owner = owner
        self.description = description
        self.stargazers_count = (stargazers_count)
    }
}
