//
//  NotificationWrapper.swift
//  LocalAndPushNotification
//
//  Created by Samiksha on 22/06/17.
//  Copyright © 2017 Samiksha. All rights reserved.
//

import UIKit

class NotificationWrapper {
    static let shared = NotificationWrapper()
    
    func handleRecievedNotification(userInfo: [AnyHashable : Any]) {
        let alertDict = userInfo["aps"] as! Dictionary<String, AnyObject>
        let msgDict = alertDict["alert"] as! Dictionary<String, AnyObject>
        let contentToDisplay = "Title: \(msgDict["title"]!)\nMessage: \(String(describing: msgDict["body"]!))"
        let alert = UIAlertController(title: "Notification received", message: contentToDisplay, preferredStyle: .alert)
        let action = UIAlertAction.init(title: NSLocalizedString("OK", comment: ""), style: .default)
        alert.addAction(action)
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
}
