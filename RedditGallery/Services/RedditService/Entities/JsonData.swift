//
//  RedditData.swift
//  RedditGallery
//
//  Created by Andrea Cerra on 7/11/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import Foundation

struct JData: Decodable {
    
    let modhash: String
    let dist: Int
    let children: [Children]
}
