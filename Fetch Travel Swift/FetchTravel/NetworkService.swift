//
//  NetworkService.swift
//  FetchTravel
//
//  Created by Waylan Sands on 4/5/2023.
//

import Foundation
import CoreLocation

enum RequestError: Error {
    case invalidResponse
    case decodingError
    case invalidURL

    var localizedDescription: String {
        switch self {
        case .decodingError:
            return "Failed to decode the data"
        case .invalidURL:
            return "URL is invalid"
        case .invalidResponse:
            return "Was an error on the server side"
        }
    }
}

class NetworkService {

    let apiKey = "vLCKJbdVz94Wskr_X3hLV3bk7aYD5Fm6eDiTSbpuIcg"

    private func fetchStationDataWith(_ location: CLLocation) async throws -> Data {
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        let urlString = "https://transit.hereapi.com/v8/stations?in=\(lat),\(lon)&apiKey=\(apiKey)"

        guard let url = URL(string: urlString) else {
            throw RequestError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
            throw RequestError.invalidResponse
        }

        return data
    }

    /// Finds  stations within 500m of your provided location
    /// https://developer.here.com/documentation/public-transit/dev_guide/station-search/by-location-example.html
    ///
    func getStations(with location: CLLocation) async -> Result<StationResponse, Error> {
        do {
            let data = try await fetchStationDataWith(location)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            let response = try decoder.decode(StationResponse.self, from: data)
            return .success(response)
        } catch {
            return .failure(error)
        }
    }


    private func fetchDepartureData(with id: String) async throws -> Data {
        let urlString = "https://transit.hereapi.com/v8/departures?ids=\(id)&apiKey=\(apiKey)"

        guard let url = URL(string: urlString) else {
            throw RequestError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
            throw RequestError.invalidResponse
        }

        return data
    }

    /// Finds next departures from the selected station id passed in.
    /// https://developer.here.com/documentation/public-transit/dev_guide/next-departures/by-ids-example.html
    ///
    func getDepartures(with id: String) async -> Result<DepartureResponse, Error> {
        do {
            let data = try await fetchDepartureData(with: id)

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            let response = try decoder.decode(DepartureResponse.self, from: data)
            return .success(response)
        } catch {
            return .failure(error)
        }
    }

}
