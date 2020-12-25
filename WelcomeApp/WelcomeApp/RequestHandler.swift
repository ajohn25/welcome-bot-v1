//
//  RequestHandler.swift
//  WelcomeApp
//
//  Created by Sahara John on 12/17/20.
//

import Foundation

class RequestHandler
{
    let session: URLSession
    let URLString:String
    var token:String
    
    init(_ address:String)
    {
        session = URLSession.shared
        URLString =  address
        token = ""
    }
    
    func getMessages(_ userToken:String) -> Dictionary<String, String>?
    {
        var request = URLRequest(url: URL(string: URLString + "/current")!)// Set up request
        request.httpMethod = "GET"
        let body = ["token": userToken]
        let bodyData = try? JSONSerialization.data(withJSONObject: body, options: [])
        request.httpBody = bodyData
        var messageDict:Dictionary<String, String>? = nil
        
        func successHandler(data:Data?, response:URLResponse?, error: Error?)
        {
            if error == nil
            {
                guard let responseData = data else{return}
                messageDict = try? JSONSerialization.jsonObject(with: responseData, options: []) as? Dictionary<String, String>
            }
        }
        
        session.dataTask(with: request, completionHandler: successHandler)
        
        //return messageDict
        // *** Set here to simulate a good server response since the current server configuration will return an error since it can't handle this request
        messageDict = Dictionary<String,String>()
        guard var realDict = messageDict else {return nil}
        realDict["#sample"] = "Sample message"
        realDict["#something"] = "Welcome to a new channel! Check out what's going on!"
        realDict["#something2"] = "Another new channel! Hello there!"
        return realDict
    }
    
    func postToken(_ userToken:String) -> Bool
    {
        var request = URLRequest(url: URL(string: URLString + "/change")!) // Set up request
        request.httpMethod = "POST"
        let body = ["token": userToken]
        let bodyData = try? JSONSerialization.data(withJSONObject: body, options: [])
        request.httpBody = bodyData
        var success = false
        
        func successHandler(data:Data?, response:URLResponse?, error: Error?)
        {
            if error != nil {success = false}
            else {success = true; token = userToken}
        }
        
        session.dataTask(with: request, completionHandler: successHandler)
        
        success = true // *** Set here to simulate a good server response since the current server configuration will return an error since it can't handle this request
        return success
    }
    
    func postMessage(message:String, channel:String) -> Bool
    {
        var request = URLRequest(url: URL(string: URLString + "/new")!) // Set up request
        request.httpMethod = "POST"
        let body = ["message": message, "channel": channel]
        let bodyData = try? JSONSerialization.data(withJSONObject: body, options: [])
        request.httpBody = bodyData
        var success = false
        
        func successHandler(data:Data?, response:URLResponse?, error: Error?)
        {
            if error != nil {success = false}
            else {success = true}
        }
        
        session.dataTask(with: request, completionHandler: successHandler)
        
        success = true // *** Set here to simulate a good server response since the current server configuration will return an error since it can't handle this request
        return success
    }
}
