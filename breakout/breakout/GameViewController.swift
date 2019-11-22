//
//  GameViewController.swift
//  breakout
//
//  Created by A.M. Student on 11/7/19.
//  Copyright © 2019 A.M. Student. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import CoreLocation
import UserNotifications
let center = UNUserNotificationCenter.current()
let locationManager = CLLocationManager()

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    

    
     override func viewDidAppear(_ animated: Bool)  {
//       // Create the action buttons for the alert.
//       let defaultAction = UIAlertAction(title: "Agree",
//                            style: .default) { (action) in
//        // Respond to user selection of the action.
//       }
//       let cancelAction = UIAlertAction(title: "Disagree",
//                            style: .cancel) { (action) in
//        // Respond to user selection of the action.
//       }
//
//       // Create and configure the alert controller.
//       let alert = UIAlertController(title: "Terms and Conditions",
//             message: "Click Agree to accept the terms and conditions.",
//             preferredStyle: .alert)
//       alert.addAction(defaultAction)
//       alert.addAction(cancelAction)
//
//       self.present(alert, animated: true) {
//          // The alert was presented
        locationManager.requestAlwaysAuthorization()
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
        }


       }
    }

