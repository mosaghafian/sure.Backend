//
//  File.swift
//  
//
//  Created by Mohammad Saghafian on 2022-09-23.
//

import Foundation
import Vapor
import MongoDBVapor

extension Request{
    var quoteCollection: MongoCollection<Quote> {
        self.application.mongoDB.client.db("home").collection("quote", withType: Quote.self)
    }
    
    var discussionCollection: MongoCollection<Discussion> {
        self.application.mongoDB.client.db("home").collection("discussion", withType: Discussion.self)
    }
    
    var userCollection: MongoCollection<User> {
        self.application.mongoDB.client.db("home").collection("user", withType: User.self)
    }
    
    var taskCollection: MongoCollection<TaskModel> {
        self.application.mongoDB.client.db("home").collection("task", withType: TaskModel.self)
    }
    
    var chatCollection: MongoCollection<Chat> {
        self.application.mongoDB.client.db("home").collection("chat", withType: Chat.self)
    }
}
