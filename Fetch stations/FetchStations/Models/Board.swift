//
//  Board.swift
//  FetchStations
//
//  Created by Waylan Sands on 3/5/2023.
//

import Foundation

struct DepartureResponse: Codable {
    let boards: [Board]
}

struct Board: Codable {
    let place: Place
    let departures: [Departure]?
}

struct Departure: Codable {
    let time: String
    let transport: Transport
}

struct Transport: Codable {
    let mode: String
    let name: String
    let color: String
    let textColor: String
    let headsign: String
}
