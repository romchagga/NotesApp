//
//  Constraints.swift
//  NotesApp
//
//  Created by macbook on 25.01.2023.
//

import Foundation
import UIKit


extension ViewController {
    
    func setConstraints() {
       view.addSubview(noteTableView)
       NSLayoutConstraint.activate([
           noteTableView.topAnchor.constraint(equalTo: view.topAnchor),
           noteTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
           noteTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
           noteTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
       ])
       view.addSubview(addNewNoteButton)
       NSLayoutConstraint.activate([
           addNewNoteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
           addNewNoteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
           addNewNoteButton.widthAnchor.constraint(equalToConstant: 21),
           addNewNoteButton.heightAnchor.constraint(equalToConstant: 18)
       ])
       view.addSubview(countOfNotes)
       NSLayoutConstraint.activate([
           countOfNotes.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
           countOfNotes.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
           countOfNotes.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
       ])
   }
    
}
