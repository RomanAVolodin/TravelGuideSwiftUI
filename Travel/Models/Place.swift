//
//  Place.swift
//  Travel
//
//  Created by Roman Vol on 08.11.2020.
//

import Foundation


struct Place: Decodable, Hashable {
    let id: Int
    let name, thumbnail: String
}
