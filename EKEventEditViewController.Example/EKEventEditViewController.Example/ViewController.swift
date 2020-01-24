//
//  ViewController.swift
//  EKEventEditViewController.Example
//
//  Created by Filip Němeček on 24/01/2020.
//  Copyright © 2020 Filip Němeček. All rights reserved.
//

import UIKit
import EventKitUI

class ViewController: UIViewController, EKEventEditViewDelegate, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        switch EKEventStore.authorizationStatus(for: .event) {
        case .notDetermined:
            let eventStore = EKEventStore()
            eventStore.requestAccess(to: .event) { (granted, error) in
                if granted {
                    // do stuff
                    DispatchQueue.main.async {
                        self.showEventViewController()
                    }
                }
            }
        case .authorized:
            // do stuff
            DispatchQueue.main.async {
                self.showEventViewController()
            }
        default:
            break
        }
    }
    
    func showEventViewController() {
        let eventVC = EKEventEditViewController()
        eventVC.editViewDelegate = self // don't forget the delegate
        eventVC.eventStore = EKEventStore()
        
        let event = EKEvent(eventStore: eventVC.eventStore)
        event.title = "Hello calendar!"
        event.startDate = Date()
        
        eventVC.event = event

        present(eventVC, animated: true)
    }
    
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
            dismiss(animated: true, completion: nil)
    }
}

