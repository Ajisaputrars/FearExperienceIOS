//
//  FearExperienceModel.swift
//  FearExperience
//
//  Created by Aji Saputra Raka Siwi on 26/03/20.
//  Copyright © 2020 Untitled. All rights reserved.
//

import Foundation

struct FearExperienceModel: Codable {
    let title: String
    let time: Int
    let mainImageString: String
    let detailImageString: String
    let fileBundleString: String
    let tag: [FearExperienceTag]
}

struct FearExperienceTag: Codable {
    let tag: String
}
