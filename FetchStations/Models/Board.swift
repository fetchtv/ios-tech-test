//
//  Board.swift
//  FetchStations
//
//  Created by Waylan Sands on 3/5/2023.
//

import Foundation

struct Board: Codable {
    let place: Place
    let departures: [Departure]?
}

struct Departure: Codable {
    let time: String
    let transport: Transport
    let agency: Agency
}

struct Agency: Codable {
    let id: String
    let name: String
    let website: String
}
