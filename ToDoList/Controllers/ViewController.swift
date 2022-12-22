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
    var editNote = Note()
    
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
    private var isFiltering: Bool {
        return searchC.isActive && !searchBarIsEmpty
    }
    
    private let searchC = UISearchController()
    
    private let noteTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let addNewNoteButton: UIButton = {
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
    // MARK: Life cycles
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 242/255, green: 241/255, blue: 248/255, alpha: 1)
        
        configNavC()
        configSearchC()
        configNoteTVC()
   
        addNewNoteButton.addTarget(self, action: #selector(addNewNoteButtonTapped), for: .touchUpInside)
        
        countOfNotes.text = notes.count > 1 ? "\(notes.count) notes" : "\(notes.count) note"
        
        notes = CoreDataManager.shared.fetchNotes()
    }
    
    @objc func addNewNoteButtonTapped() {
        let addVC = EditAddNoteViewController()
        addVC.delegate = self
        navigationController?.pushViewController(addVC, animated: true)
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
    
    private func setConstraints() {
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

// MARK: Extentions
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
            filteredNotes.remove(at: indexPath.row)
            notes.remove(at: indexPath.row)
        } else {
            notes.remove(at: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let editVC = storyboard.instantiateViewController(withIdentifier: "EditAddNoteViewController") as? EditAddNoteViewController else {return}
        editVC.delegate = self
        editNote = notes[indexPath.row]
        editVC.note = editNote
        navigationController?.pushViewController(editVC, animated: true)
        notes.remove(at: indexPath.row)
    }
}
extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filteredNotes = notes.filter({$0.text!.lowercased().contains((searchController.searchBar.text?.lowercased())!)})
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
