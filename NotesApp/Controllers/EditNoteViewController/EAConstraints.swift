//
//  EAConstraints.swift
//  NotesApp
//
//  Created by macbook on 25.01.2023.
//

import Foundation
import UIKit

extension EditAddNoteViewController {
    func setConstraints() {
        view.addSubview(textView)
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
