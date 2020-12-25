//
//  ViewController.swift
//  WelcomeApp
//
//  Created by Aashish John on 12/15/20.
//

import UIKit

class ViewController: UIViewController
{
    func askTokenRepeat() // Used when token request to server fails
    {
        
        let alert = UIAlertController(title: "Token Error", message:"The token was not accepted. Please double check that the token is correct or try again in a few minutes", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in self.askToken()}))
        
        present(alert, animated: true)
        guard let popover = alert.popoverPresentationController else {return}
        popover.sourceView = view
        popover.sourceRect = view.bounds
    }
    
    func showTokenTextAlert () // Empty token field
    {
        let alert = UIAlertController(title: "Welcome Set", message:"Please enter a valid token!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler:  {_ in self.askToken()}))
        
        present(alert, animated: true)
        guard let popover = alert.popoverPresentationController else {return}
        popover.sourceView = view
        popover.sourceRect = view.bounds
    }
    
    
    func askToken () // Ask user for token on startup
    {
        
        let enter = UIAlertController(title: "Enter Token", message:"Please enter a bot token generated for your Slack workspace:", preferredStyle: .alert)
        
        enter.addTextField(configurationHandler: { (textField: UITextField) in textField.placeholder = "Enter your token here"})
        
        func submitHandler(_ action:UIAlertAction) // Checks server response (simulated currently - see RequestHandler for details_
        {
            guard let token = enter.textFields![0].text else {return}
            if !myRequestHandler.postToken(token) {askTokenRepeat()}
        }
        
        enter.addAction(UIAlertAction(title: "Submit", style: .default, handler: submitHandler))
        
        present(enter, animated: true)
        guard let popover = enter.popoverPresentationController else {return}
        popover.sourceView = view
        popover.sourceRect = view.bounds
    }

    override func viewDidAppear(_ animated: Bool)
    {
        askToken()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    let myRequestHandler = RequestHandler("https://slack-welcome-bot25.herokuapp.com") // Heroku server address
    @IBOutlet weak var txtWelcomeMessage: UITextView!
    @IBOutlet weak var txtChannel: UITextField!
    
    @IBAction func btnSubmitClick(_ sender: UIButton)
    {
        guard let userMessage = txtWelcomeMessage.text else {showAlert(sender: sender, inputSuccess: false, serverSuccess: false, channel: ""); return}
        
        guard let userChannel = txtChannel.text else {showAlert(sender: sender, inputSuccess: false, serverSuccess: false, channel: ""); return}
        
        let posted = myRequestHandler.postMessage(message: userMessage, channel: userChannel) // Checks server response (simulated currently - see RequestHandler for details_
        
        showAlert(sender: sender, inputSuccess: true, serverSuccess: posted, channel: userChannel)
    }
    
    func showAlert(sender: UIButton, inputSuccess:Bool, serverSuccess:Bool, channel:String) // Changes based on errors when submitting message
    {
        var alertMessage = ""
        if inputSuccess
        {
            if serverSuccess {alertMessage = "Your welcome message for " + channel + " has successfully been set"}
            
            else {alertMessage = "Welcome message was not set as the server is down. Please try again in a few minutes."}
        }
        else{alertMessage = "Please enter a valid channel name and a welcome message!"}
        
        let alert = UIAlertController(title: "Welcome Set", message:alertMessage, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in}))
        
        present(alert, animated: true)
        guard let popover = alert.popoverPresentationController else {return}
        popover.sourceView = view
        popover.sourceRect = sender.bounds
    }
}

