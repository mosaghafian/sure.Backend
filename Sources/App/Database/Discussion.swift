//
//  File.swift
//  
//
//  Created by Mohammad Saghafian on 2022-09-23.
//

import Foundation
import Vapor
import Fluent
import FluentMongoDriver


final class Discussion: Codable, Content{
    let id : String
    let topic : String
    let createdDate: Date
    let creatorID: String
    var rating: Int = 0
    let comments: [String]?
    
    init(id: String, topic: String,createdDate:Date, created: String, creatorID: String, comments: [String]) {
        self.id = id
        self.topic = topic
        self.createdDate = createdDate
        self.creatorID = creatorID
        self.comments = comments
    }
    init(id: String, topic: String,createdDate:Date, created: String, creatorID: String, comments: [String], rating: Int) {
        self.id = id
        self.topic = topic
        self.createdDate = createdDate
        self.creatorID = creatorID
        self.comments = comments
        self.rating = rating
    }
    
}
