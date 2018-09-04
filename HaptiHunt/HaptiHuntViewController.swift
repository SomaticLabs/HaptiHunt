//
//  HaptiHuntViewController.swift
//  HaptiHunt
//
//  Created by Jacob Rockland on 4/11/18.
//  Copyright © 2018 Somatic Labs. All rights reserved.
//

import UIKit
import SwiftyZorb

/**
 Custom view controller for adding haptic effects to Google Cardboard demo
 */
class HaptiHuntViewController: UIViewController, GVRRendererViewControllerDelegate {
    
    /// Method called after view has loaded
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Set background color to white
        self.view.backgroundColor = UIColor.white
        
        // Embedded (widget) view with its own view controller.
        let renderer = HaptiHuntRenderer()
        let viewController = GVRRendererViewController(renderer: renderer)
        viewController?.delegate = self
        viewController?.view.frame = CGRect(x: 20, y: 50, width: self.view.bounds.width - 40, height: 200)
        viewController?.view.autoresizingMask = UIViewAutoresizing.flexibleWidth
        self.view.addSubview((viewController?.view)!)
        self.addChildViewController(viewController!)

        // Attempt to create a connection to Moment device
        SwiftyZorb.forget()
        SwiftyZorb.connect { result in
            switch result {
            case .success:
                // We were able to connect
                print("Connected to Moment!")
            case .failure(let error):
                // We were not able to connect
                print("Failed to connect!")

                // Show error message to user
                self.presentInfoAlert(withTitle: "Connection error", andMessage: error.localizedDescription)
            }
        }
    }
    
    /// Method to easily present an info alert with a given title and message
    func presentInfoAlert(withTitle title: String, andMessage message: String) {
        // Create the AlertController
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // Create and add the OK action
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel) { action -> Void in
            // Just dismiss the action sheet
        }
        alertController.addAction(okAction)
        
        // Present the Alert Controller
        present(alertController, animated: true, completion: nil)
    }
    
    /// Set rendered use by view controller
    func renderer(for displayMode: GVRDisplayMode) -> GVRRenderer! {
        // Use custom rendered for adding haptic effects
        // Always present (not push) view controller for fullscreen landscape right VR mode
        return HaptiHuntRenderer()
    }

}

