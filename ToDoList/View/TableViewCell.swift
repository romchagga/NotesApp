//
//  TableViewCell.swift
//  ToDoList
//
//  Created by macbook on 11.12.2022.
//

import UIKit

import UIKit

class TableViewCell: UITableViewCell {
    
    // MARK: Creating properties
    static let idCell = "idCell"
    
    let writtenTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let customView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: Life cycles
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
        
        self.backgroundColor = .clear

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Config views
    private func setConstraints() {
        
        self.addSubview(customView)
        NSLayoutConstraint.activate([
            customView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            customView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            customView.heightAnchor.constraint(equalToConstant: 50)
        ])

        
        customView.addSubview(writtenTextLabel)
        NSLayoutConstraint.activate([
            writtenTextLabel.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 10),
            writtenTextLabel.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -10),
            writtenTextLabel.centerYAnchor.constraint(equalTo: customView.centerYAnchor)
        ])
    }
    
}
