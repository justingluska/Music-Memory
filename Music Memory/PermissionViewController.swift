//
//  PermissionViewController.swift
//  Music Memory
//
//  Created by Justin Gluska on 1/4/20.
//  Copyright © 2020 Justin Gluska. All rights reserved.
//

import UIKit
import MediaPlayer

class PermissionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            guard let songs = MPMediaQuery.songs().items
                else {
                return
            }
        }
        
    }

}
