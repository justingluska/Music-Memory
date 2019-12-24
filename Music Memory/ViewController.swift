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


@objcMembers
class ViewController: UIViewController {

    /// The instance of `AuthorizationManager` used for querying and requesting authorization status.
    var authorizationManager: AuthorizationManager!
    
    /// The instance of `AuthorizationDataSource` that provides information for the `UITableView`.
    var authorizationDataSource: AuthorizationDataSource!
    
    /// A boolean value representing if a `SKCloudServiceSetupViewController` was presented while the application was running.
    var didPresentCloudServiceSetup = false

    @IBAction func authButton(_ sender: Any) {
        authorizationManager.requestCloudServiceAuthorization()
        
        authorizationManager.requestMediaLibraryAuthorization()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let controller = SKCloudServiceController()

        controller.requestStorefrontCountryCode { countryCode, error in
            // Use the value in countryCode for subsequent API requests
        }

        
    }


}

func requestAuthorization(_ handler: @escaping (MPMediaLibraryAuthorizationStatus) -> Void){
}
