//
//  sbMainViewController.swift
//  Music Memory
//
//  Created by Justin Gluska on 1/3/20.
//  Copyright © 2020 Justin Gluska. All rights reserved.
//

import UIKit

class sbMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func letsTransition(_ sender: Any) {
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "main") as UIViewController
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: false, completion: nil)
    }
    
   

}
