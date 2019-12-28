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


struct OverviewData {
    var topGenre: String
    var topArtist: String
    var topSong: String
    var totalPlays: Int
    var totalTime: TimeInterval
    var numTracks: Int
    var avgDuration: TimeInterval
    var avgPlays: Float
    var avgSkips: Float
    var explicitRatio: Float
    //var dateAdded: Date
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
    
    @IBOutlet weak var imageViewOutlet: UIImageView!
    var test: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        try? VideoBackground.shared.play(view: view, videoName: "newstart", videoType: "mp4")
        fetchOverview()
        //Grab the controller
    }
    
    
    @IBOutlet weak var buttonOutlet: UIButton!
    
    @IBAction func buttonTest(_ sender: Any) {
        
    }
    
    @IBOutlet weak var label: UITextView!
    
    
    
    
   func fetchOverview() -> OverviewData? {
    guard let songs = MPMediaQuery.songs().items else {
        return nil
    }
    var topGenre: (String, Int) = ("None", -1)
    var topArtist = ("None", -1)
    var topSong = ("None", -1)
    var totalPlays: Int = 0
    var totalTime: TimeInterval = 0
    var totalDiscSize: Int = 0
    var totalDurations: TimeInterval = 0
    var totalExplicit: Int = 0
    var totalSkips: Int = 0
    
    
    var all:String = ""
    let today = Date()
    let cal = Calendar.current
    let day = cal.ordinality(of: .day, in: .year, for: today)

    
    print(today)
    print(day)
    var totals:Int = 0
    var onThisDay: String = ""
    for song in songs{
        let then = song.dateAdded
        let calendar = Calendar.current

        let hour = calendar.component(.hour, from: then)
        let day = calendar.component(.day, from: then)
        let year = calendar.component(.year, from: then)
        let month = calendar.component(.month, from:then)
        
        if (month == calendar.component(.month, from: today)){
            //onThisDay = onThisDay + "\n\(song.title!) in DEC \(day) -> \(year)"
            if (day == calendar.component(.day, from: today)){
                songName.append("\(song.title!)")
                songArtist.append("\(song.artist!)")
                songPlays.append(String(song.playCount))
                totals += 1
                buttonOutlet.setTitle("SHARE \(song.albumArtist!)", for: .normal)
                imageViewOutlet.image = song.artwork?.image(at: imageViewOutlet.frame.size)
                if (year == calendar.component(.year, from: today)){
                    onThisDay = onThisDay + ("\nIN \(year) -> \(song.title!) by \(song.artist!)\n")
                }
                else {
                    onThisDay = onThisDay + ("\nIN \(year) -> \(song.title!) by \(song.artist!)\n")
                }
//                var displayImage = UIImage()
//                let artwork = MPMediaItemArtwork.init(boundsSize: displayImage.size, requestHandler: { (size) -> UIImage in
//                        return displayImage
//                })
//                buttonOutlet.setImage(displayImage, for: .normal)

            }
        }
        
        
        
//        let minutes = calendar.component(.minute, from: then)
//        let seconds = calendar.component(.second, from: then)
       label.text = onThisDay
        //all = all + ("\n\(String(day))->\(song.title!)->\(song.dateAdded)")
        //label.text = all
    }
//    for number in 0..<(totals-1){
//        print("\(songName[number]) -> \(songArtist[number]) -> PLAYS: \(songPlays[number])")
//    }
    
    
    return OverviewData(
        topGenre: topGenre.0,
        topArtist: topArtist.0,
        topSong: topSong.0,
        totalPlays: totalPlays,
        totalTime: totalTime,
        numTracks: songs.count,
        avgDuration: totalDurations / Double(songs.count),
        avgPlays: Float(totalPlays) / Float(songs.count),
        avgSkips: Float(totalSkips) / Float(songs.count),
        explicitRatio: Float(totalExplicit) / Float(songs.count)
    )
    }
    
    
    @IBAction func artistClicked(_ sender: Any) {
        shareMusic()
    }
    
    func shareMusic(){
        var songString:String = ""
        for element in songName.indices.dropLast() {
            songString = songName[element] + ", " + songString
        }
        songString = songString + "and " + songName[(songName.count-1)]
        let items: [Any] = ["I discovered the music \(songString) on this day a year ago. See your throwback songs by downloading musicHop! ", URL(string: "https://www.justingluska.com")!]
        /// To add the album artwork, use the code below
        // , imageViewOutlet.image!
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
}

