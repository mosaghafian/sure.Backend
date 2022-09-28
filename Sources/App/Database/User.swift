//
//  File.swift
//  
//
//  Created by Mohammad Saghafian on 2022-09-24.
//

import Foundation
import Vapor

final class User: Codable, Content{
    let id: String?;
    var name: String;
    let phoneNumber: String;
    var chats: [String]?
    var tasks: [String]?
    
    init(id: String, name: String, phoneNumber: String, chats: [String], tasks: [String]){
        self.id = id;
        self.name = name
        self.phoneNumber = phoneNumber;
        self.tasks = tasks
        self.chats = chats
    }
    
    init(name: String, phoneNumber: String){
        self.id = UUID().uuidString;
        self.name = name;
        self.phoneNumber = phoneNumber;
    }
    
}
