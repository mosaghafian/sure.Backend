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

final class Quote: Codable, Content{

    var id: Int
    var text: String
    var author: String
    init(text: String, author: String){
        self.id = Int.random()
        self.text = text
        self.author = author
    }
}
