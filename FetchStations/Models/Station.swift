//
//  Station.swift
//  FetchStations
//
//  Created by Waylan Sands on 3/5/2023.
//

import Foundation

struct Station: Codable {
    let place: Place
    let transports: [Transport]?
    let accessPoints: [AccessPoint]?
}

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

struct Transport: Codable {
    let textColor: String
    let headsign: String
    let color: String
    let mode: String
    let name: String
}

struct AccessPoint: Codable {
    let location: Location
    let name: String
    let type: String
}
