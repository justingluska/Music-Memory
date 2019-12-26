//
//  Interest.swift
//  Music Memory
//
//  Created by Justin Gluska on 12/25/19.
//  Copyright © 2019 Justin Gluska. All rights reserved.
//

import UIKit

class Interest {
    
    var title = ""
    var featuredImage: UIImage
    var color: UIColor
    
    init(title: String, featuredImage: UIImage, color: UIColor){
        self.title = title
        self.featuredImage = featuredImage
        self.color = color
    }
    
    static func fetchInterests() -> [Interest]
    {
        return [
            Interest(title: "Traveling Around The World", featuredImage: UIImage(named: "image")!, color:UIColor(red: 63/255.0, green: 71/255.0, blue:80/255.0, alpha:0.8))
        
        ]
    }
}
