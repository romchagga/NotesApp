//
//  Constraints.swift
//  NotesApp
//
//  Created by macbook on 25.01.2023.
//

import Foundation
import UIKit

extension TableViewCell {
    func setConstraints() {
        
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
            writtenTextLabel.centerYAnchor.constraint(equalTo: customView.centerYAnchor, constant: -10)
        ])
        
        customView.addSubview(dateText)
        NSLayoutConstraint.activate([
            dateText.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 10),
            dateText.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -10),
            dateText.centerYAnchor.constraint(equalTo: customView.centerYAnchor,constant: 15)
        ])
    }
}
