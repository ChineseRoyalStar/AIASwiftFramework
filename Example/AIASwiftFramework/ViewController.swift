//
//  ViewController.swift
//  AIASwiftFramework
//
//  Created by Leon Guo on 04/04/2018.
//  Copyright (c) 2018 Leon Guo. All rights reserved.
//

import UIKit
import AIASwiftFramework

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let gesture = UITapGestureRecognizer.init();
        gesture.add { (obj) in
            print("111")
        }
        self.view.addGestureRecognizer(gesture)
        
        var label = UILabel.init()
        label.characterSpace = 1
        label.lineSpace = 1
        label.keywords = "123"
        label.keywordsFont  = UIFont.boldSystemFont(ofSize: 0)
        label.keywordsColor = UIColor.red;
        label.underlineStr = "456"
        label.underlineColor = UIColor.gray
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

