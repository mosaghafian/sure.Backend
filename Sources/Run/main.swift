import App
import Vapor
import Fluent
import FluentMongoDriver
import MongoDBVapor

//struct CreateQuote: AsyncMigration{
//    func prepare(on database: Database) async throws {
//        try await database.schema("quote")
//            .id()
//            .field("test", .string)
//            .field("quote", .string)
//            .create()
//    }
//    // Optionally reverts the changes made in the prepare method.
//    func revert(on database: Database) async throws {
//        try await database.schema("quote")
//    }
//                                  
//}

var env = try Environment.detect()
try LoggingSystem.bootstrap(from: &env)
let app = Application(env)
defer {
    app.mongoDB.cleanup()
    cleanupMongoSwift()
    app.shutdown() }
try configure(app)

try app.run()


