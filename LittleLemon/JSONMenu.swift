//
//  JSONMenu.swift
//  LittleLemon
//
//  Created by hicham fakir on 3/11/2026.
//

import Foundation

struct JSONMenu: Codable {
    let menu: [MenuItem]
}

struct MenuItem: Codable, Identifiable {
    var id = UUID()
    let title: String
    let price: String
    let description: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case price
        case description
        case image
    }
}
