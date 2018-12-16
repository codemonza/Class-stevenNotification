//
//  ViewController.swift
//  stevenNotification
//
//  Created by Monza on 6/27/18.
//  Copyright © 2018 Yan Yan. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    // shouldn't this go into a userdefault/setting?
    var isGrantedNotification:Bool = false
    
    // IMPORTANT: call the notification using this function at all times!
    func addNotification(trigger:UNNotificationTrigger?, content: UNMutableNotificationContent, identifier:String) {
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                print("error adding notification: \(error!.localizedDescription)")
            }
        }
        
    }
    

    // use time interval
    @IBAction func schedulePizza(_ sender: UIButton) {
        let content = UNMutableNotificationContent()
        //content.title = "badge badge"
        content.userInfo = ["test":"yes"]
        content.badge = 4
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        addNotification(trigger: trigger, content: content, identifier: "badgetesting")
    }
    
    // use calendar
    @IBAction func makePizza(_ sender: UIButton) {
        let content = UNMutableNotificationContent()
        content.title = "calendar note"
        content.userInfo = ["test":"yes"]
        content.badge = 8
        
        let unitFlags:Set<Calendar.Component> = [.minute,.hour,.second]
        var  date = Calendar.current.dateComponents(unitFlags, from: Date())
        date.second = date.second! + 10
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
        addNotification(trigger: trigger, content: content, identifier: "calendar-testing")
    }
    @IBAction func nextPizzaStep(_ sender: UIButton) {
        UIApplication.shared.applicationIconBadgeNumber = 11
    }
    @IBAction func viewPending(_ sender: UIButton) {
    }
    @IBAction func viewDelivered(_ sender: UIButton) {
    }
    @IBAction func Remove(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            self.isGrantedNotification = granted
            if !granted {
                // tell user they can't use app
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

