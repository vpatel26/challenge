//
//  ViewController.swift
//  idk
//
//  Created by A.M. Student on 11/14/19.
//  Copyright © 2019 JessicaMontes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var pointtotal = 0
    var pointup = 1
    @IBOutlet weak var points: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func make(_ sender: Any) {
        pointtotal += pointup
        points.text = "\(pointtotal)"
        print("\(pointtotal)")
    }


}

