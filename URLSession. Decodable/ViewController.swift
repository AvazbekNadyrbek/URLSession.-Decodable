//
//  ViewController.swift
//  URLSession. Decodable
//
//  Created by Авазбек Надырбек уулу on 23.06.25.
//

import UIKit

class ViewController: UIViewController {
    
    private let networkService = NetworkLayer()
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        networkService.sendRequest()
    }


}

