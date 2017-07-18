//
//  Controller.swift
//  mongokit
//
//  Created by Michael Vilabrera on 7/18/17.
//
//

import Foundation
import Kitura
import SwiftyJSON
import LoggerAPI
import CloudFoundryEnv

public class Controller {
    
    let router: Router
    let appEnv: AppEnv
    
    var port: Int {
        get { return appEnv.port }
    }
    
    var url: String {
        get { return appEnv.url }
    }
    
    init() throws {
        appEnv = try CloudFoundryEnv.getAppEnv()
        
        // all web apps need a Router instance to define routes
        router = Router()
        
        // serve static content from "public" 
        router.all("/", middleware: StaticFileServer())
        
        // get request
        router.get("/hello", handler: getHello)
        
        // post request
        router.post("/hello", handler: postHello)
        
        // JSON get
        router.get("/json", handler: getJSON)
    }
    
    public func getHello(request: RouterRequest,
                         response: RouterResponse,
                         next: @escaping () -> Void) throws {
        
        Log.debug("GET - /hello route handler")
        response.headers["Content-type"] = "text/plain; charset=utf-8"
        let kiteSpot = MongoDB.shared.findOneKiteSpot()
        try response.status(.OK).send("Kitura / MongoDB hello \(String(describing: kiteSpot))")
    }
    
    public func postHello(request: RouterRequest,
                          response: RouterResponse,
                          next: @escaping () -> Void) throws {
        
        Log.debug("POST - /hello route handler")
        response.headers["Content-type"] = "text/plain charset=utf-8"
        if let name = try request.readString() {
            try response.status(.OK).send("Hello \(name), from Kitura & Mongo").end()
        } else {
            try response.status(.OK).send("Kitura & Mongo received a POST request!").end()
        }
    }
    
    public func getJSON(request: RouterRequest,
                        response: RouterResponse,
                        next: @escaping () -> Void) throws {
        
        Log.debug("GET - /json route handler")
        response.headers["Content-type"] = "application/json; charset=utf-8"
        var jsonResponse = JSON([:])
        jsonResponse["framework"].stringValue = "Kitura"
        jsonResponse["applicationName"].stringValue = "mongokit"
        jsonResponse["company"].stringValue = "IBM"
        jsonResponse["organization"].stringValue = "iX @ IBM"
        jsonResponse["location"].stringValue = "NYC, NY"
        try response.status(.OK).send(json: jsonResponse).end()
    }
}
