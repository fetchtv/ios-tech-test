//
//  DepartureResponse.swift
//  FetchTravel
//
//  Created by Waylan Sands on 4/5/2023.
//

import Foundation

struct DepartureResponse: Codable {
    let boards: [Board]
}

struct Board: Codable {
    let departures: [Departure]?
}

struct Departure: Codable {
    let transport: Transport
    let delay: Double?
    let time: String
}

struct Transport: Codable {
    let shortName: String
    let headsign: String
    let category: String
}

