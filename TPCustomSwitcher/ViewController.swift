//
//  ViewController.swift
//  TPCustomSwitcher
//
//  Created by GlebRadchenko on 11/18/16.
//  Copyright © 2016 Applikator. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var switcher: TPSwitcher!
    override func viewDidLoad() {
        super.viewDidLoad()
        switcher.titles = ["First","Second", "Fourth", "Fifth"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func switcherValueChanged(_ sender: Any) {
        
    }
}

