//
//  Logo.swift
//  Logo-Quiz
//
//  Created by Vishal Singh on 10/04/21.
//

import Foundation

struct Logo: Decodable {

    let name: String
    let imageURL: URL
}

extension Logo {

    enum CodingKeys: String, CodingKey {
        case imageURL = "imgUrl"
        case name
    }
}
