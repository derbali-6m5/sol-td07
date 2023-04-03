//
//  ViewController.swift
//  sol-td07
//
//  Created by admin on 2023-03-24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let banqueRestApi = BanqueRestAPI()
        banqueRestApi.getAll()
    }


}

