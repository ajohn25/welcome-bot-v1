//
//  WelcomeBot.swift
//  WelcomeBot
//
//  Created by Sahara John on 12/12/20.
//

import Foundation
import SlackKit

class WelcomeBot
{
    let bot:SlackKit
    
    init(token : String)
    {
        bot = SlackKit()
        bot.addRTMBotWithAPIToken(token)
        
        // Register for event notifications
        bot.notificationForEvent(.message)
        { (event, _) in
            // Your bot logic here
            guard let message = event.message else {return}
            print(message)
        }
    }
}
