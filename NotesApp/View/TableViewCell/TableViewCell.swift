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
    
    let dateText: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let customView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configViews()
    }
    
    // MARK: Config views
    
    func setup(note: Note) {
        writtenTextLabel.text = note.text
        dateText.text = note.date
    }
    
    func configViews() {
        self.backgroundColor = .clear
        setConstraints()
    }
    
}
