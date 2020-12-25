//
//  Slack.swift
//  WelcomeBot
//
//  Created by Aashish John on 12/12/20.
//

import Foundation
import SlackKit

func initCall()
{
    let bot = SlackKit()
    bot.addRTMBotWithAPIToken("xoxb-SLACK-BOT-TOKEN")
    // Register for event notifications
    bot.notificationForEvent(.message)
    { (event, _) in
        // Your bot logic here
        guard let message = event.message else {return}
        print(message)
    }
}


