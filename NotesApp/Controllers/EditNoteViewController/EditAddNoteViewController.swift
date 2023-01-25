//
//  EditAddNoteViewController.swift
//  ToDoList
//
//  Created by macbook on 11.12.2022.
//

import UIKit

class EditAddNoteViewController: UIViewController {
    
    weak var delegate: DataDelegate?
    
    var note = Note(context: CoreDataManager.shared.viewContext)
    
                
    let textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.backgroundColor = UIColor(red: 242/255, green: 241/255, blue: 248/255, alpha: 1)
        textView.contentInset.left = 20
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 242/255, green: 241/255, blue: 248/255, alpha: 1)
        navigationController?.navigationBar.tintColor = .black
       
        textView.text = note.text
        
        setConstraints()
        passedDataDelegate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        textView.text = ""
    }
    
    func passedDataDelegate() {
        navigationItem.backAction = UIAction(handler: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
            if let text = self?.textView.text, !text.isEmpty,
               let note = self?.note {
                note.text = text
                note.date = Date().format()
                CoreDataManager.shared.save()
                self?.delegate?.updateAdd(note: (note))
            }
        }
      )
    }
    
}
