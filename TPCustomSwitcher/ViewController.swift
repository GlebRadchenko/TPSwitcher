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
        initSwitcher()
    }
    func initSwitcher() {
        let switcher = TPSwitcher(titles: ["First", "Second", "Third"])
        switcher.borderColor = .white
        switcher.borderWidth = 1.0
        switcher.sliderMargin = 2.0
        switcher.backgroundColor = .blue
        switcher.selectedColor = .white
        switcher.selectedTextColor = .blue
        switcher.textColor = .white
        
        switcher.setSelected(0, animated: false)
        
        switcher.frame = CGRect(x: 10, y: 100, width: 300, height: 30)
        self.view.addSubview(switcher)
        
        switcher.addTarget(self,
                           action: #selector(self.switcherValueChanged(sender:)),
                           for: .valueChanged)
    }
    
    func switcherValueChanged(sender: AnyObject?) {
        guard let switcher = sender as? TPSwitcher else {
            return
        }
        switch switcher.selectedIndex {
        case 0:
            switcher.backgroundColor = .blue
            switcher.selectedTextColor = .blue
            break
        case 1:
            switcher.backgroundColor = .gray
            switcher.selectedTextColor = .gray
            break
        default:
            switcher.backgroundColor = .red
            switcher.selectedTextColor = .red
            break
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

