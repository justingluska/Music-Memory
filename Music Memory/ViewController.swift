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
import SwiftVideoBackground
import GoogleMobileAds

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
    var interstitial: GADInterstitial!
    var test: UIImage!
    
    
    
    @IBOutlet weak var hopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-9134328104554845/9661741527")
        let request = GADRequest()
        interstitial.load(request)
        hopButton.layer.cornerRadius = 20
        
    }
    override func viewDidAppear(_ animated: Bool) {
        if let isFirstStart = UserDefaults.standard.value(forKey: "isFirstLaunch") as? Bool {
            print("this is not the first launch")
        } else {
            print("this is the first launch")
            UserDefaults.standard.set(false, forKey: "isFirstLaunch")
            UserDefaults.standard.synchronize()

            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "PageViewController") as! UIViewController
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Today's record
        
//        if let todaysRecord = self.dataSource.filter({ (dateGroup) -> Bool in
//            let order = Calendar.current.compare(Date(), to: dateGroup.date, toGranularity: .day)
//            switch order {
//            case .orderedDescending:
//                //print("DESCENDING")
//                return false
//            case .orderedAscending:
//                //print("ASCENDING")
//                return false
//            case .orderedSame:
//                //print("SAME")
//                return true
//            }
//        }).first {
//            //Show the name
//            var timeListened = Double(todaysRecord.music.first?.playbackDuration ?? 0)
//            timeListened = (timeListened / 60) * Double(todaysRecord.music.first?.playCount ?? 0)
//            timeListened = Double(round(100*timeListened)/100) / 60
//            let newTime = String(format: "%.1f", timeListened)
//            textDisplay.text = "\(todaysRecord.music.first?.title ?? "")\nby \(todaysRecord.music.first?.artist ?? "")\n\(todaysRecord.music.first?.albumTitle ?? "")\n\(todaysRecord.music.first?.playCount ?? 0) Plays\nHours Listened: \(newTime)"
//            if let image = todaysRecord.music.first?.artwork?.image(at: imageViewOutlet.frame.size) {
//                self.imageViewOutlet.image = image
//            } else {
//                self.imageViewOutlet.image = UIImage.init(named: "image")
//            }
//        }
    }
    
    @IBOutlet weak var textDisplay: UITextView!
    
    
    @IBOutlet weak var label: UITextView!
    
    var songArray: NSMutableArray = []
    
    func groupSongs() {
        ///
        guard let songs = MPMediaQuery.songs().items
            else {
            return
        }
        /// ^ Above will be displayed at the page view controller
        for eachSong in songs {
            //print("Date: \(eachSong.dateAdded), Title: \(eachSong.title)")
            if let dateGroup = self.dataSource.filter({ (dateGroup) -> Bool in
                let order = Calendar.current.compare(eachSong.dateAdded, to: dateGroup.date, toGranularity: .day)
                switch order {
                case .orderedDescending:
                    //print("DESCENDING")
                    return false
                case .orderedAscending:
                    //print("ASCENDING")
                    return false
                case .orderedSame:
                    //print("SAME")
                    return true
                }
            }).first {
                dateGroup.music.append(eachSong)
            } else {
                let dateGroup = MusicWithDate()
                dateGroup.date = eachSong.dateAdded
                dateGroup.music.append(eachSong)
                self.dataSource.append(dateGroup)
            }
        }
        self.dataSource.sort(by: { $0.date.compare($1.date) == .orderedDescending })
    }
    
    @IBAction func didTapOpenCardView(_ sender: Any) {
        if interstitial.isReady {
          interstitial.present(fromRootViewController: self)
        }
        else{
            print("not ready")
        }
        self.groupSongs()
        if let todaysRecord = self.dataSource.filter({ (dateGroup) -> Bool in
            let order = Calendar.current.compare(Date(), to: dateGroup.date, toGranularity: .day)
            switch order {
            case .orderedDescending:
                //print("DESCENDING")
                return false
            case .orderedAscending:
                //print("ASCENDING")
                return false
            case .orderedSame:
                //print("SAME")
                return true
            }
        }).first {
            let main = UIStoryboard(name: "Main", bundle: nil)
            let resultVC = main.instantiateViewController(withIdentifier: "CardViewController") as? InterestsViewController
            resultVC?.dataSource = todaysRecord
            self.present(resultVC!, animated: true, completion: nil)
        }
        
    }
    
    
    
}

class MusicWithDate {
    var date : Date = Date()
    var music : [MPMediaItem] = []
}

