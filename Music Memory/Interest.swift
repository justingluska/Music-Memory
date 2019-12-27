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
    
   
    
    var title = ""
    var featuredImage: UIImage
    
    init(title: String, featuredImage: UIImage){
        self.title = title
        self.featuredImage = featuredImage
    }
    
    static func fetchInterests() -> [Interest]
    {
        
        return [
            
            Interest(title: "Hot (feat. Travis Scott)", featuredImage: UIImage(named: "image")!)           ,
            Interest(title: "Boy Back (feat. Nav)", featuredImage: UIImage(named: "image2")!),
            Interest(title: "Hot (feat. Travis Scott)", featuredImage: UIImage(named: "image")!)
        ]
    }
}

