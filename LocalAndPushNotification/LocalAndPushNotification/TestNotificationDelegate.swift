//
//  TestNotificationDelegate.swift
//  LocalAndPushNotification
//
//  Created by Samiksha on 21/06/17.
//  Copyright © 2017 Samiksha. All rights reserved.
//

import UIKit
import UserNotifications

class TestNotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound])
    }
    
    private func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNTextInputNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        // Determine the user action
        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            print("Dismiss Action")
        case UNNotificationDefaultActionIdentifier:
            print("Default")
        case "OpenAppAction":
            print("Open App")
        case "Delete":
            print("Delete")
        default:
            print("Unknown action")
        }
//        let alert = UIAlertController(title: "Notification received", message: response.userText, preferredStyle: .alert)
//        let action = UIAlertAction.init(title: NSLocalizedString("OK_BUTTON", comment: ""), style: .default)
//        alert.addAction(action)
//        DispatchQueue.main.async {
//            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
//        }
        completionHandler()
    }
    
}
