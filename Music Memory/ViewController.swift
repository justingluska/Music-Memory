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

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchOverview()
        
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
    
    for song in songs{
        all = all + ("\n\(song.title!)->\(song.dateAdded)")
        label.text = all
    }
    
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
    
}

