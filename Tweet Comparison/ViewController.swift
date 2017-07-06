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
        client.loadTweet(withID: "844896595179180034") { (tweet, error) in
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

