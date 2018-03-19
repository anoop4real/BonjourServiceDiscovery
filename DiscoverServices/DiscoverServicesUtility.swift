//
//  DiscoverServicesUtility.swift
//  DiscoverServices
//
//  Created by anoop mohanan on 19/03/18.
//  Copyright © 2018 com.anoopm. All rights reserved.
//

import Foundation

class DiscoverServicesUtility: NSObject {
    
    fileprivate var isSearching = false
    // Array to hold the list of netservices
    fileprivate var services = [NetService]()
    fileprivate var type: String!
    fileprivate var domain: String!
    fileprivate weak var uiPresenter :DiscoverServicesUIProtocol?
    fileprivate var netServiceBrowser:NetServiceBrowser!
    
    init?(type:String?, domain: String?, uiPresenter: DiscoverServicesUIProtocol?){
        super.init()
        guard let typeVal = type, let domainVal = domain, let uiPresenterVal = uiPresenter else { return nil }
        // All values are must have
        self.type = typeVal
        self.domain = domainVal
        self.uiPresenter = uiPresenterVal
        self.netServiceBrowser = NetServiceBrowser()
        self.netServiceBrowser.delegate = self
    }
    
    // Method to start searching for services
    
    func startSearching(){
        
        self.netServiceBrowser.searchForServices(ofType: self.type, inDomain: self.domain)
    }
    
}

extension DiscoverServicesUtility: NetServiceBrowserDelegate{
    
    func netServiceBrowserWillSearch(_ browser: NetServiceBrowser){
        // Search is commencing
        self.isSearching = true
        self.uiPresenter?.updateUIWithSearch(status: self.isSearching)
    }
    
    
    func netServiceBrowserDidStopSearch(_ browser: NetServiceBrowser){
        
        self.isSearching = false
        self.uiPresenter?.updateUIWithSearch(status: self.isSearching)
    }
    
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didNotSearch errorDict: [String : NSNumber]){
        
        self.isSearching = false
        if let err = errorDict[NetService.errorCode]{
            self.handleError(errCode: err)
        }else{
            // Unknown error
            self.handleError(errCode: NSNumber(value: 999))
        }
        
        
    }
    
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didFindDomain domainString: String, moreComing: Bool){
        
    }
    
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool){
        
        print("Service found with \(service) with host name \(String(describing: service.hostName))")
        self.services.append(service)
        
        if (!moreComing){
            
            self.uiPresenter?.updateUIWith(services: self.services)
        }
    }
    
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didRemoveDomain domainString: String, moreComing: Bool){
        
    }
    
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didRemove service: NetService, moreComing: Bool){
        self.services.index(of: service).map{self.services.remove(at: $0)}
        
        if (!moreComing){
            
            self.uiPresenter?.updateUIWith(services: self.services)
        }
    }
    
    func handleError(errCode:NSNumber){
        
        var errorMessage = "Unknown"
        switch errCode.intValue {
        case 999:
            errorMessage = "Unknown"
        default:
            break
        }
        self.uiPresenter?.updateUIWith(message: errorMessage)
    }
}
