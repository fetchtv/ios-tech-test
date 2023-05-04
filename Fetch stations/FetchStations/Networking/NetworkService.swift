//
//  NetworkService.swift
//  FetchStations
//
//  Created by Waylan Sands on 3/5/2023.
//

import Foundation

enum APIError: Error {
    case invalidResponse
}

@objc class NetworkService: NSObject {
    let apiKey = "vLCKJbdVz94Wskr_X3hLV3bk7aYD5Fm6eDiTSbpuIcg"
}
