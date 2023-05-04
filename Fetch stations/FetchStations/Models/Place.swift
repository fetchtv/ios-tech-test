//
//  Place.swift
//  FetchStations
//
//  Created by Waylan Sands on 3/5/2023.
//

import Foundation

struct Place: Codable {
    let location: Location
    let name: String
    let type: String
    let id: String
}

struct Location: Codable {
    let lat: Double
    let lng: Double
}
