//
//  File.swift
//  
//
//  Created by Mohammad Saghafian on 2022-09-24.
//

import Foundation
import Vapor
import SwiftBSON


class UserController{
    static func routes(_ app: Application){
        
        app.group("user") { route in
            create(route)
            delete(route)
            insert(route)
        }
    }
    
    static func insert(_ route: RoutesBuilder){
        route.post("insert") { req -> String in
            let user = try req.content.decode(User.self)
            try await req.userCollection.insertOne(user)
            return "User inserted"
        }
    }
    static func delete(_ route: RoutesBuilder){
        route.post("delete") { req -> String in
            let user = try req.content.decode(User.self)
            let query : BSONDocument = [
                "id": .string(user.id!)
            ]
            let res = try await req.userCollection.deleteOne(query)
            print(res);
            return "User Deleted";
        }
    }
    static func create(_ route: RoutesBuilder){
        route.post("create") { req -> String in
            
            let user: User? = try req.query.decode(User.self)
            
            if let phonenumber = user?.phoneNumber  {
                let query : BSONDocument = [
                    "phonenumber" : .string(phonenumber)
                ]
                let user = try await req.userCollection.findOne(query)
                
                if let user = user {
                    req.logger.info("User found, authentication needed")
                    return "user \(user.name)";
                    
                } else {

                    req.logger.info("No user found, going for creating one")
                    return "User was not found"
                }
                
                //return "User Created"
            } else {
                return "Bad Request. No Phone Number found"
            }
            
        }
    }
}
