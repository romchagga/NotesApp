//
//  Delegate:Datasource.swift
//  NotesApp
//
//  Created by macbook on 25.01.2023.
//

import Foundation
import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = isFiltering ? filteredNotes.count : notes.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.idCell, for: indexPath) as! TableViewCell
        let object = isFiltering ? filteredNotes[indexPath.row] : notes[indexPath.row]
        cell.setup(note: object)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if isFiltering {
            let deleteFilteredNotes = filteredNotes[indexPath.row]
            filteredNotes = filteredNotes.filter({$0 != deleteFilteredNotes})
            notes = notes.filter({$0 != deleteFilteredNotes})
            CoreDataManager.shared.deleteNote(note: deleteFilteredNotes)
        } else {
            let deleteNotes = notes[indexPath.row]
            notes = notes.filter({$0 != deleteNotes})
            CoreDataManager.shared.deleteNote(note: deleteNotes)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let editVC = storyboard.instantiateViewController(withIdentifier: "EditAddNoteViewController") as? EditAddNoteViewController else {return}
        editVC.delegate = self
        editNote = isFiltering ? filteredNotes[indexPath.row] : notes[indexPath.row]
        editVC.note.text = editNote.text
        editVC.note.date = editNote.date
        navigationController?.pushViewController(editVC, animated: true)
        CoreDataManager.shared.deleteNote(note: editNote)
        notes = notes.filter({$0 != editNote})
    }
}
