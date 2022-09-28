
import Foundation
import Vapor
import SwiftBSON


func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }
    
    app.post("test") { req -> String in
        let name: String? = try req.content.get(at: "name")
        return name ?? "No this is not working";
    }
    
    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    app.post("addquote") { req -> Quote in
        let quote = try req.content.decode(Quote.self)
        try await req.quoteCollection.insertOne(quote)
        return quote;
    }
    app.get("retrieve") { req async -> String in
        let string  = "hellow"
        
        DispatchQueue.global(qos: .userInitiated).async {
            for i in 0...2000 {
                print(i)
                sleep(4)
                let url = URL(string: "https://zenquotes.io/api/random")
                let semaphore = DispatchSemaphore(value: 0)
                
                Task {
                    var quoteDB : Quote?
                    
                    print(quoteDB)
                    let (data, response) = try await URLSession.shared.data(from: url!)
                    let json = try JSONSerialization.jsonObject(with: data) as! [Any]
                    let quote = json[0]
                    let dict = quote as! [String: String]
                    
                    
                    quoteDB = Quote(text: dict["q"]!, author: dict["a"]!)
                    let query : BSONDocument = [
                        "text": .string(quoteDB!.text)
                    ]
                    print(quoteDB?.text)
                    let quoteRec = try await req.quoteCollection.findOne(query)
                    if quoteRec == nil{
                        try await req.quoteCollection.insertOne(quoteDB!)
                    } else {
                        print("had this quote")
                    }
                    semaphore.signal()
                }
                
                semaphore.wait()
                
                
            }
        }
        
        return "getting the quotes"
    }
    app.group("quote") { quote in
        quote.get("random") { req -> Quote in
            let query : BSONDocument = [
                "author": "Steve Jobs"
            ]
            let quote = try await req.quoteCollection.findOne(query)
            print(quote?.author)
            return quote ?? Quote(text: "No quote found", author: "Me")
        }
        
        quote.get("loadTextFile") {req -> String in
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
                var fileURL : URL
                if #available(macOS 13.0, *) {
                    fileURL = dir.appending(path: "quotes.txt")
                } else {
                    fileURL = dir.appendingPathComponent("quotes.txt")
                }
                do{
                    print(fileURL)
                    var text2 = try String(contentsOf: fileURL, encoding: .utf8)
                    var listOfQuote: [String ] = text2.split(separator: "\n").map(String.init)
                    for i in 0..<listOfQuote.count{
                        if i % 2 == 0{
                            if(listOfQuote[i+1].first != "z" && listOfQuote[i+1].last != "o"){
                                var Quote = Quote(text: listOfQuote[i], author: listOfQuote[i+1])
                                try await req.quoteCollection.insertOne(Quote)
                            }
                        }
                    }
                    //print(listOfQuote)
                }
                catch{
                    print("error thrown")
                }
                
            }
            
            return "quotes loaded"
        }
    }
    
    UserController.routes(app)
    ChatController.routes(app)
    DiscussionController.routes(app)
    QuoteController.routes(app)
    TaskController.routes(app)
    
}
