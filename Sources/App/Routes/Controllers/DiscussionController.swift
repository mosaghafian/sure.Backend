//
//  File 3.swift
//  
//
//  Created by Mohammad Saghafian on 2022-09-24.
//

import Foundation
import Vapor

class DiscussionController{
    static func routes(_ app: Application){
        app.group("discussion") { route in
            create(route)
            delete(route)
            insert(route)
            update(route)
        }
    }
    static func create(_ route: RoutesBuilder){
        route.post("create") { req -> String in
            return ""
        }
    }
    
    static func delete(_ route: RoutesBuilder){
        route.delete("delete"){ req -> String in
            return ""
        }
        
    }
    
    static func insert(_ route: RoutesBuilder){
        route.post("insert") { req -> String in
            return ""
        }
    }
    
    static func update(_ route: RoutesBuilder){
        route.post("update") { req  -> String in
            return ""
        }
    }
}
