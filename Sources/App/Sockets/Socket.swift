//
//  File.swift
//  
//
//  Created by Mohammad Saghafian on 2022-09-24.
//

import Foundation
import Vapor

func socket(_ app: Application)throws{
    
    var message : String? = "hello"
    app.webSocket("chat") { req, ws in
        print(req)
        ws.onText { ws, str in
            
        }
    }
    app.webSocket("echo", ":user") { req, ws  in
        let name = req.parameters.get("user")!
        Room.shared.connections[name] = ws
        print("ws: \(ws)")
        print("req: \(req)")

        ws.onText { ws, text in
            
            print("Text onText \(text)")
            Room.shared.send(username: name, message: text)

        }
        ws.onPing { ws in
            print(ws)
            ws.send("on ping \(ws)")
        }

        ws.onPong { ws in
            print("on pong: \(ws)")
        }
        
        ws.onClose.whenComplete { result in
            print(result)
            print("socket is closed by the user")
        }
    }
    
    app.webSocket("client", ":id") { req, ws in
        print(ws)
        let name = req.parameters.get("id")!
        print("id: \(name)")
        ws.onText { ws, text in
            
            Thread.sleep(forTimeInterval: 1)
            ws.send("receiver: \(text)")
        }
        for i in 0...30{
            Thread.sleep(forTimeInterval: 5)
            ws.send("\(i)")
        }
        
        ws.onPing { ws in
            print(ws)
        }

        ws.onPong { ws in
            print(ws)
        }
        ws.onClose.whenComplete { result in
            print(result)
        }
    }
}
