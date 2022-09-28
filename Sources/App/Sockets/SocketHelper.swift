//
//  File.swift
//  
//
//  Created by Mohammad Saghafian on 2022-09-27.
//

import Foundation
import Vapor

class SocketHelper{
    
}


class Room{
    
    static let shared = Room()
    var connections = [String: WebSocket]()
    func send(username: String, message: String){
        for (user, websocket) in connections{
            if user == username {continue}
            else{
                websocket.send(message)
            }
        }
    }
}
