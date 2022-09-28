import Vapor
import MongoDBVapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    try app.mongoDB.configure("mongodb+srv://momo:Parvardegar@cluster0.yrzsy.mongodb.net/?retryWrites=true&w=majority")
    // register routes
    try socket(app)
    try routes(app);
}
