//
//  ViewController.swift
//  Tweet Comparison
//
//  Created by Sahil Agarwal on 7/5/17.
//  Copyright © 2017 Sahil Agarwal. All rights reserved.
//

import UIKit
import TwitterKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var tweetNumberSelector: UIPickerView!
    @IBOutlet weak var obamaTweet: TWTRTweetView!
    @IBOutlet weak var trumpTweet: TWTRTweetView!
    
    var nums = ["1", "2", "3", "4", "5", "6", "7", "8"]
    //populate nums

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        let client = TWTRAPIClient()
        
        //barry o
        client.loadTweet(withID: "870695481290117120") { (tweet, error) in
            if let t = tweet {
                print("success")
                self.obamaTweet.configure(with: t)
            } else if let error = error {
                print("Failed to load Tweet: \(error.localizedDescription)")
            }
        }
        //trump
        client.loadTweet(withID: "882558219285131265") { (tweet, error) in
            if let t = tweet {
                print("success")
                self.trumpTweet.configure(with: t)
                print(t.author.name)
            } else if let error = error {
                print("Failed to load Tweet: \(error.localizedDescription)")
            }
        }
        
        //API test - barack
        
        let statusesShowEndpoint = "https://api.twitter.com/1.1/statuses/user_timeline.json"
        var clientError : NSError?
        
        let barackParams = ["screen_name": "barackobama", "count" : "8"]
        let barackRequest = client.urlRequest(withMethod: "GET", url: statusesShowEndpoint, parameters: barackParams, error: &clientError)
        
        client.sendTwitterRequest(barackRequest) { (response, data, connectionError) -> Void in
            if connectionError != nil {
                print("Error: \(String(describing: connectionError))")
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print("json: \(json)")
            } catch let jsonError as NSError {
                print("json error: \(jsonError.localizedDescription)")
            }
        }
        
        //API test - trump
        
        
        let trumpParams = ["screen_name": "realDonaldTrump", "count" : "8"]
        let trumpRequest = client.urlRequest(withMethod: "GET", url: statusesShowEndpoint, parameters: trumpParams, error: &clientError)
        
        client.sendTwitterRequest(trumpRequest) { (response, data, connectionError) -> Void in
            if connectionError != nil {
                print("Error: \(String(describing: connectionError))")
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print("json: \(json)")
            } catch let jsonError as NSError {
                print("json error: \(jsonError.localizedDescription)")
            }
        }
        
        
        
        tweetNumberSelector.delegate = self
        tweetNumberSelector.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //picker view code
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return nums.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //code once the tweet# is selected
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return nums[row]
    }


}

