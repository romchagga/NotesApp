//
//  ViewController.swift
//  ToDoList
//
//  Created by macbook on 11.12.2022.
//
import UIKit

class ViewController: UIViewController {
    
    // MARK: Creating properties
    var notes: [Note] = []  { 
        didSet {
            countOfNotes.text = notes.count > 1 ? "\(notes.count) notes" : "\(notes.count) note"
            DispatchQueue.main.async {
                self.noteTableView.reloadData()
            }
        }
    }
    
    var filteredNotes: [Note] = []  {
        didSet {
            DispatchQueue.main.async {
                self.noteTableView.reloadData()
            }
        }
    }
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchC.searchBar.text else {return false}
        return text.isEmpty
    }
    var isFiltering: Bool {
        return searchC.isActive && !searchBarIsEmpty
    }
    
    var editNote = Note()
    
    private let searchC = UISearchController()
    
    let noteTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let addNewNoteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        button.tintColor = .black
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var countOfNotes: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configViews()
        
        notes = CoreDataManager.shared.fetchNotes()
        
        addNewNoteButton.addTarget(self, action: #selector(addNewNoteButtonTapped), for: .touchUpInside)
    }
    
    @objc func addNewNoteButtonTapped() {
        let addVC = EditAddNoteViewController()
        addVC.delegate = self
        navigationController?.pushViewController(addVC, animated: true)
    }
    
    func configViews() {
        view.backgroundColor = UIColor(red: 242/255, green: 241/255, blue: 248/255, alpha: 1)
        countOfNotes.text = notes.count > 1 ? "\(notes.count) notes" : "\(notes.count) note"
        
        setConstraints()
        configNavC()
        configSearchC()
        configNoteTVC()
        
    }
    
    // MARK: Config views
    private func configNavC() {
        navigationItem.title = "Мои заметки"
    }
    
    private func configSearchC() {
        searchC.searchResultsUpdater = self
        searchC.obscuresBackgroundDuringPresentation = false
        searchC.searchBar.placeholder = "Search"
        navigationItem.searchController = searchC
    }
    
    private func configNoteTVC() {
        noteTableView.delegate = self
        noteTableView.dataSource = self
        noteTableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.idCell)
        noteTableView.backgroundColor = .clear
        noteTableView.separatorStyle = .none
    }
}



extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filteredNotes = notes.filter({$0.text?.lowercased().contains((searchController.searchBar.text?.lowercased())!) ?? true })
        DispatchQueue.main.async {
            self.noteTableView.reloadData()
        }
    }
}


extension ViewController: DataDelegate {
    func updateAdd(note: Note) {
        notes.insert(note, at: 0)
    }
}
