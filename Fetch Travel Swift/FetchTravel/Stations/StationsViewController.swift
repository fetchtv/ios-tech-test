//
//  StationsViewController.swift
//  FetchTravel
//
//  Created by Waylan Sands on 4/5/2023.
//

import UIKit
import CoreLocation

class StationsViewController: UIViewController {

    let viewModel: StationsViewModel

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(StationTableViewCell.self, forCellReuseIdentifier: StationTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    lazy var locationManager = CLLocationManager()

    init(viewModel: StationsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
        self.title = viewModel.title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
    }

    override func viewWillAppear(_ animated: Bool) {
        configureLocationManager()
    }

    private func configureLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }

    private func configureSubviews() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
}

extension StationsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StationTableViewCell.reuseIdentifier, for: indexPath) as? StationTableViewCell else {
            return UITableViewCell()
        }

        let station = viewModel.stations[indexPath.row]
        cell.setup(with: station)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < viewModel.stations.count else {
            return
        }
        let station = viewModel.stations[indexPath.row]
        getDepartures(with: station.place.id)
    }

    private func getDepartures(with id: String) {
        let departuresViewModel = DeparturesViewModel(networkService: NetworkService())
        let departureViewController = DepartureViewController(viewModel: departuresViewModel)

        Task {
            await departuresViewModel.fetchDepartures(with: id)
            navigationController?.pushViewController(departureViewController, animated: true)
        }
    }
}

extension StationsViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined, .restricted, .denied:
            print("Handle") // Show specific alert to user
        case .authorizedAlways, .authorizedWhenInUse:
            Task {
                await refeshStations()
            }
        @unknown default:
            print("Handle") // Show Alert to user
        }
    }

    func refeshStations() async {
        let londonDummyLocation = CLLocation(latitude: 51.5074, longitude: -0.1278)
        let location = locationManager.location ?? londonDummyLocation
        await viewModel.fetchStationsFrom(location: location)
    }
}

extension StationsViewController: ReactiveDataDelegate {
    func updateTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

    func alertUserWith(_ error: Error) {
        DispatchQueue.main.async {
            // Show Alert to user
            print("error: \(error.localizedDescription)")
        }
    }
}

