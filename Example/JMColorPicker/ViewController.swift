//
//  ViewController.swift
//  JMColorPicker
//
//  Created by JayachandraA on 06/07/2017.
//  Copyright (c) 2017 JayachandraA. All rights reserved.
//

import UIKit
import JMColorPicker

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    @IBAction func showColorPicker(_ sender: Any) {
        JMColorManager().show(from: nil) { (status, hexColor) in
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

