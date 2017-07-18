//
//  MongoDB.swift
//  mongokit
//
//  Created by Michael Vilabrera on 7/18/17.
//
//

import Foundation
import MongoKitten
import LoggerAPI


public class MongoDB {
    public var uri: String
    static let defaultURI = "mongodb://localhost:27017"
    
    public init(uri: String = MongoDB.defaultURI) {
        self.uri = uri
    }
    
    static var shared = MongoDB()
    
    lazy var server: Server = {
        let server: Server!
        
        do {
            server = try Server(mongoURL: self.uri)
        } catch {
            // unable to connect
            Log.error("MongoDB is not available on the given host and port")
            exit(1)
        }
        return server
    }()
    
    var database: Database {
        let db = self.server["mongokitdb"]
        return db
    }
    
    lazy var kiteSpotCollection: MongoKitten.Collection = {
        self.database["mongokitcollection"]
    }()
    
    func findOneKiteSpot() -> Document? {
        do {
            let doc = try self.kiteSpotCollection.findOne()
            return doc
        } catch {
            Log.error("Could not find spot")
            return nil
        }
    }
}
