//
//  ViewController.swift
//  Music Memory
//
//  Created by Justin Gluska on 12/23/19.
//  Copyright © 2019 Justin Gluska. All rights reserved.
//

import UIKit
import MediaPlayer
import StoreKit
import Foundation
import UserNotifications

struct OverviewData {
    var totalPlays: Int
}

extension Date {

    func totalDistance(from date: Date, resultIn component: Calendar.Component) -> Int? {
        return Calendar.current.dateComponents([component], from: self, to: date).value(for: component)
    }

    func compare(with date: Date, only component: Calendar.Component) -> Int {
        let days1 = Calendar.current.component(component, from: self)
        let days2 = Calendar.current.component(component, from: date)
        return days1 - days2
    }

    func hasSame(_ component: Calendar.Component, as date: Date) -> Bool {
        return self.compare(with: date, only: component) == 0
    }
}

class ViewController: UIViewController {

    var songName = [String]()
    var songArtist: Array = [""]
    var songPlays: Array = [""]
    var dataSource : [MusicWithDate] = []
    var test: UIImage!
    
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var hopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hopButton.layer.cornerRadius = 20
        helpButton.layer.cornerRadius = 20
        registerLocal()
        scheduleLocal()
    }
    
    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()

        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Approved")
            } else {
                print("Denied")
            }
        }
    }

    @objc func scheduleLocal() {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Hoppity Hop"
        content.body = "Hey! Have you checked your previous hops today?"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default

        var dateComponents = DateComponents()
        dateComponents.hour = 13
        dateComponents.minute = 05
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (UserDefaults.standard.value(forKey: "isFirstLaunch") as? Bool) != nil {
            print("Not First Launch")
        } else {
            UserDefaults.standard.set(false, forKey: "isFirstLaunch")
            UserDefaults.standard.synchronize()

            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "PageViewController")
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    
    
    var calendar = Calendar.current
    let date = Date()
    @IBAction func addToList(_ sender: Any) {
        guard let songs = MPMediaQuery.songs().items
                   else {
                   return
               }
        
        var songName = [String]()
        let dateGroup = MusicWithDate()
        
                for song in songs {
                let today = Date()
                    
                    let then = song.dateAdded
                    let day = calendar.component(.day, from: then)
                    let month = calendar.component(.month, from:then)
                    if (month == calendar.component(.month, from: today)){
                        if (day == calendar.component(.day, from: today)){
                            songName.append(song.title!)
                            dateGroup.date = song.dateAdded
                            dateGroup.music.append(song)
                            dataSource.append(dateGroup)
                            }
                        }
                }
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let resultVC = main.instantiateViewController(withIdentifier: "CardViewController") as? InterestsViewController
        resultVC?.dataSource = dateGroup
        resultVC?.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        self.present(resultVC!, animated: true, completion: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    var songArray: NSMutableArray = []
    
}

class MusicWithDate {
    var date : Date = Date()
    var music : [MPMediaItem] = []
}

