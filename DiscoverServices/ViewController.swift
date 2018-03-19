//
//  ViewController.swift
//  DiscoverServices
//
//  Created by anoop mohanan on 19/03/18.
//  Copyright © 2018 com.anoopm. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startSearch()
    }
    func startSearch(){
        
        let ns = DiscoverServicesUtility(type: "_http._tcp.", domain: "local.", uiPresenter: self)
        ns?.startSearching()
    }

}

extension ViewController: DiscoverServicesUIProtocol{
    func updateUIWith(message: String) {
        
        print(message)
    }
    
    func updateUIWithSearch(status: Bool) {
        
        print("Update Search status")
    }
    
    func updateUIWith(services: [NetService]) {
        
        print(services)
    }
    
    
}

