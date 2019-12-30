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

class songStats{
    var title = ""
    var artist = ""
    var album = ""
    var plays = 0
    var hours = ""
    var artwork: UIImage
    
    init(title: String, artist: String, album: String, plays: Int, hours: String, artwork: UIImage){
        self.title = title
        self.artist = artist
        self.album = album
        self.plays = plays
        self.hours = hours
        self.artwork = artwork
    }
    
    func displayStats(){
        print(self.title)
        print(self.artist)
        print(self.album)
        print(self.plays)
        print(self.hours)
        print(type(of: self.artwork))
    }
}


struct OverviewData {
    var totalPlays: Int
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
//        var job = Interest(title: "lets see if this works", featuredImage: UIImage(named: "sin")!)
//        job.title = "yeah"
//        print(job.title)
    }
    
    @IBOutlet weak var textDisplay: UITextView!
    
    @IBOutlet weak var buttonOutlet: UIButton!
    
    @IBAction func buttonTest(_ sender: Any) {
        
    }
    
    @IBOutlet weak var label: UITextView!
    
    var songArray: NSMutableArray = []
    
    
   func fetchOverview() -> OverviewData? {
    guard let songs = MPMediaQuery.songs().items else {
        return nil
    }

    var totalPlays: Int = 0
    
    
    var all:String = ""
    let today = Date()
    let cal = Calendar.current
    let day = cal.ordinality(of: .day, in: .year, for: today)

    
    //print(today)
    //print(day!)
    var totals:Int = 0
    var onThisDay: String = ""
    for song in songs{
        let then = song.dateAdded
        let calendar = Calendar.current
        let day = calendar.component(.day, from: then)
        let year = calendar.component(.year, from: then)
        let month = calendar.component(.month, from:then)
        
        if (month == calendar.component(.month, from: today)){
            if (day == calendar.component(.day, from: today)){
                /// I want it to return all of the songs that get to this part in the CollectionView
                songName.append("\(song.title!)")
                songArtist.append("\(song.artist!)")
                songPlays.append(String(song.playCount))
                totals += 1
                buttonOutlet.setTitle("SHARE \(song.albumArtist!)", for: .normal)
                imageViewOutlet.image = song.artwork?.image(at: imageViewOutlet.frame.size)
                let tes = Interest(title: (song.title)!, featuredImage: UIImage(named: "image")!)
                
                /// FOR FIVERR: ^^^ CODE ABOVE
                /// I would like to return the title of the song and the background image of the album artwork in the collection view, instead of the default songs I have to specify in Interest.Swift
                /// Thank you!
                
                var timeListened = Double(song.playbackDuration)
                timeListened = (timeListened / 60) * Double(song.playCount)
                timeListened = Double(round(100*timeListened)/100) / 60
                let newTime = String(format: "%.1f", timeListened)
                
                
                let albumArt: UIImage = (song.artwork?.image(at: imageViewOutlet.frame.size))!
                let entry = songStats(title: song.title!, artist: song.artist!, album: song.albumTitle!, plays: song.playCount, hours: newTime, artwork: UIImage(named: "image")!)
                print(entry.displayStats())
                
                textDisplay.text = "\(song.title!)\nby \(song.artist!)\n\(song.albumTitle!)\n\(song.playCount) Plays\nHours Listened: \(newTime)"
                
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
        else {
            label.text = "No new songs today"
        }
        
        //mprint(entry.displayStats())
        
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
        totalPlays: totalPlays
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
        let items: [Any] = ["I discovered the music \(songString) on this day of the year. See your throwback songs by downloading musicHop! ", URL(string: "https://www.justingluska.com")!]
        /// To add the album artwork, use the code below
        // , imageViewOutlet.image!
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
}

