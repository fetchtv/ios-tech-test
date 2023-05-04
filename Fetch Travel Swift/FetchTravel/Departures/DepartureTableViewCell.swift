//
//  DepartureTableViewCell.swift
//  FetchTravel
//
//  Created by Waylan Sands on 4/5/2023.
//

import UIKit

class DepartureTableViewCell: UITableViewCell {
    static let reuseIdentifier = "DepartureTableViewCell"

    private lazy var waitTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        return label
    }()

    private lazy var waitTimeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        return view
    }()

    private lazy var arrivalTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .natural
        label.textColor = .darkText
        return label
    }()

    private lazy var onTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .natural
        label.textColor = .lightGray
        return label
    }()

    private lazy var destinationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .right
        label.textColor = .darkText
        return label
    }()

    private lazy var serviceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .natural
        label.textColor = .lightGray
        return label
    }()


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configureSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureSubviews() {
        contentView.addSubview(waitTimeView)
        waitTimeView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        waitTimeView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        waitTimeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        waitTimeView.heightAnchor.constraint(greaterThanOrEqualToConstant: 80).isActive = true
        waitTimeView.widthAnchor.constraint(greaterThanOrEqualToConstant: 80).isActive = true

        contentView.addSubview(waitTimeLabel)
        waitTimeLabel.leadingAnchor.constraint(equalTo: waitTimeView.leadingAnchor, constant: 16).isActive = true
        waitTimeLabel.trailingAnchor.constraint(equalTo: waitTimeView.trailingAnchor, constant: -8).isActive = true
        waitTimeLabel.centerYAnchor.constraint(equalTo: waitTimeView.centerYAnchor).isActive = true

        contentView.addSubview(destinationLabel)
        destinationLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        destinationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true

        contentView.addSubview(arrivalTimeLabel)
        arrivalTimeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        arrivalTimeLabel.leadingAnchor.constraint(equalTo: waitTimeView.trailingAnchor, constant: 8).isActive = true
        arrivalTimeLabel.trailingAnchor.constraint(lessThanOrEqualTo: destinationLabel.leadingAnchor, constant: -16).isActive = true

        contentView.addSubview(serviceLabel)
        serviceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        serviceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true

        contentView.addSubview(onTimeLabel)
        onTimeLabel.leadingAnchor.constraint(equalTo: arrivalTimeLabel.leadingAnchor).isActive = true
        onTimeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
    }

    func setup(with departure: Departure) {
        waitTimeLabel.attributedText = attributedString(from: departure.time)
        arrivalTimeLabel.text = hourMinuteFormat(from: departure.time)
        destinationLabel.text = departure.transport.headsign
        serviceLabel.text = departure.transport.category

        let delaytime = Int(departure.delay ?? 0)
        onTimeLabel.text = delaytime == 0 ? "On time" : "Delayed by \(delaytime) minutes"
        onTimeLabel.textColor = delaytime == 0 ? .systemGreen : .red

    }

    func attributedString(from timestamp: String) -> NSAttributedString {
        let dateFormatter = ISO8601DateFormatter()
        guard let date = dateFormatter.date(from: timestamp) else {
            return NSAttributedString(string: "NA")
        }
        let timeInterval = date.timeIntervalSinceNow
        let minutesFromNow = Int(round(timeInterval / 60))
        let timeSuffix = minutesFromNow == 1 ? "min" : "mins"
        let attributedString = NSMutableAttributedString(string: "\(minutesFromNow) ")
        attributedString.append(NSAttributedString(string: timeSuffix, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11, weight: .light)]))
        return attributedString
    }

    func hourMinuteFormat(from timestamp: String) -> String {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Australia/Sydney")
        guard let date = dateFormatter.date(from: timestamp) else {
            return "NA"
        }

        let dateFormatter2 = DateFormatter()
        dateFormatter2.timeZone = TimeZone(identifier: "Australia/Sydney")
        dateFormatter2.dateFormat = "hh:mma"

        let formattedDate = dateFormatter2.string(from: date)

        return formattedDate.lowercased()
    }
}
