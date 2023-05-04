//
//  DepartuesViewController.swift
//  FetchTravel
//
//  Created by Waylan Sands on 4/5/2023.
//

import UIKit

class DepartureViewController: UIViewController {
    let viewModel: DeparturesViewModel

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DepartureTableViewCell.self, forCellReuseIdentifier: DepartureTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    init(viewModel: DeparturesViewModel) {
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

    private func configureSubviews() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
}

extension DepartureViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DepartureTableViewCell.reuseIdentifier, for: indexPath) as? DepartureTableViewCell else {
            return UITableViewCell()
        }

        let depature = viewModel.departures[indexPath.row]
        cell.setup(with: depature)

        return cell
    }
}

extension DepartureViewController: ReactiveDataDelegate {
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

