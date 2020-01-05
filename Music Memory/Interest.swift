//
//  Interest.swift
//  Music Memory
//
//  Created by Justin Gluska on 12/25/19.
//  Copyright © 2019 Justin Gluska. All rights reserved.
//

import UIKit
import Foundation
import MediaPlayer
import StoreKit


class Interest {
    
   
    var today = [""]
    var title = ""
    var featuredImage: UIImage
    
    init(title: String, featuredImage: UIImage){
        self.title = title
        self.featuredImage = featuredImage
    }
    
    
    static func fetchInterests() -> [Interest]
    {

        return [
            
            Interest(title: "Yeah", featuredImage: UIImage(named: "image")!),
            //Interest(title: "Sin (feat. Jaden Smith)", featuredImage: UIImage(named: "sin")!),
            Interest(title: "Hot (feat. Travis Scott)\nAdded in 2019", featuredImage: UIImage(named: "image")!)           ,
            Interest(title: "Boy Back (feat. Nav)\nAdded in 2019", featuredImage: UIImage(named: "image2")!),
            Interest(title: "Hot (feat. Travis Scott)\nAdded in 2019", featuredImage: UIImage(named: "image")!)
        ]
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
    
    
    
}
