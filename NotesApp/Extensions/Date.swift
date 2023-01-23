//
//  Date.swift
//  ToDoList
//
//  Created by macbook on 11.12.2022.
//

import Foundation

extension Date {
    func format() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, HH:mm"
        return formatter.string(from: self)
    }
}
