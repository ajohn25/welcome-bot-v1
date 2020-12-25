import Vapor

func routes(_ app: Application) throws {

    app.get("current")
    { req -> String in
        return "Retrieving dictionary"
        // myBot.getMessages()
        // should actually return WelcomeBot dictionary
    }
    
    app.post("change", String.parameter)
    { req -> String in
        let token = try req.parameters.next(String.self)
        return "New WelcomeBot created!"
        // myBot = myBot (token)
        // should actually instantiate a new WelcomeBot
    }
    
    app.post("new", String.parameter)
    { req -> String in
        let message = try req.parameters.next(String.self)
        let channel = try req.parameters.next(String.self)
        return "WelcomeBot Messages updated!"
        // myBot.updateMessages(channel, message)
        // should actually update the WelcomeBot dictionary
    }
   
}
