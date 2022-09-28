//
//  File.swift
//  
//
//  Created by Mohammad Saghafian on 2022-09-24.
//

import Foundation
import Vapor

final class TaskModel: Codable, Content{
    var id: UUID
    var title: String
    var priority: Int16
    var completion: Bool
    var note: String
    var creator: String
    var assignedID: UUID
    var dueDate: Date
    var creatorID: UUID
    var date: Date
    var color: String
    var assigned: String
    init(id: UUID, title: String, priority: Int16, completion: Bool, note: String, creator: String, assignedID: UUID, dueDate: Date, creatorID: UUID, color: String, date: Date, assigned: String) {
        self.id = id
        self.title = title
        self.priority = priority
        self.completion = completion
        self.note = note
        self.creator = creator
        self.assignedID = assignedID
        self.dueDate = dueDate
        self.creatorID = creatorID
        self.color = color
        self.date = date
        self.assigned = assigned
    }
}
