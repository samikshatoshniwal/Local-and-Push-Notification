//
//  ViewController.swift
//  LocalAndPushNotification
//
//  Created by Samiksha on 21/06/17.
//  Copyright © 2017 Samiksha. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet weak var localNotificationLabel: UILabel!
    
    var center: UNUserNotificationCenter!
    let options: UNAuthorizationOptions = [.alert, .sound, .badge];
    let notificationDelegate = TestNotificationDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        addAction()
        addActionToNotification()
        requestAuthorization()
        getNotificationSetting()
    }
    
    func setup() {
        center = UNUserNotificationCenter.current()
        center.delegate = notificationDelegate
    }
    
    func addAction() {
        let touchGestureRecognizerForLocalNotificationLabel = UITapGestureRecognizer.init(target: self, action:#selector(ViewController.createContentAndTrigger))
        touchGestureRecognizerForLocalNotificationLabel.numberOfTapsRequired = 1
        localNotificationLabel.isUserInteractionEnabled = true
        localNotificationLabel.addGestureRecognizer(touchGestureRecognizerForLocalNotificationLabel)
    }
    
    func addActionToNotification() {
        let openAppAction = UNNotificationAction.init(identifier: "OpenAppAction", title: "Open App", options: [.foreground])
        let deleteAction = UNNotificationAction.init(identifier: "DeleteAction",
                                                     title: "Delete", options: [.destructive])
        
        let category = UNNotificationCategory(identifier: "TestReminderCategory",
                                              actions: [openAppAction,deleteAction],
                                              intentIdentifiers: [], options: [])
        center.setNotificationCategories([category])
    }
    
    func requestAuthorization() {
        center.requestAuthorization(options: options) {
            (granted, error) in
            if !granted {
                print("Something went wrong")
            }
        }
    }
    
    func getNotificationSetting() {
        center.getNotificationSettings { (settings) in
            guard settings.authorizationStatus == .authorized else { return }
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    func createContentAndTrigger() {
        let content = UNMutableNotificationContent()
        content.title = "Workout reminder"
        content.body = "Go for a walk at 10.30am."
        content.sound = UNNotificationSound.default()
        content.categoryIdentifier = "TestReminderCategory"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: false)
        
        let identifier = "TestLocalNotification"
        let request = UNNotificationRequest(identifier: identifier,
                                            content: content, trigger: trigger)
        center.add(request, withCompletionHandler: { (error) in
            if error != nil {
                print("\(error?.localizedDescription)")
            }
        })
    }
}

