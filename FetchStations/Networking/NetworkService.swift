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

    func fetchGeocodeData() async throws -> Data {
        let urlString = "https://transit.hereapi.com/v8/stations?in=-33.8651,151.2093&apiKey=\(apiKey)"
        let url = URL(string: urlString)!
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
            throw APIError.invalidResponse
        }

        return data
    }


    func fetchStationData() async -> Result<StationResponse, Error> {
        do {
            let data = try await fetchGeocodeData()
            print(String(data: data, encoding: .utf8) ?? "Empty data")
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            let response = try decoder.decode(StationResponse.self, from: data)
            return .success(response)
        } catch {
            return .failure(error)
        }
    }

}
