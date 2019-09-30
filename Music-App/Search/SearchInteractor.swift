//
//  SearchInteractor.swift
//  Music-App
//
//  Created by Michael Sidoruk on 30/09/2019.
//  Copyright (c) 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

protocol SearchBusinessLogic {
    func makeRequest(request: Search.Model.Request.RequestType)
}

class SearchInteractor: SearchBusinessLogic {
        
    var presenter: SearchPresentationLogic?
    var service: SearchService?
    
    var networkService = NetworkService()
    
    func makeRequest(request: Search.Model.Request.RequestType) {
        if service == nil {
            service = SearchService()
        }
        
        switch request {
        case .some:
            print("Interactor .some")
        case .getTracks(let searchText):
            print("Interactor .getTracks")
            networkService.fetchTracks(searchText: searchText) { [weak self] (response) in
                self?.presenter?.presentData(response: Search.Model.Response.ResponseType.presentTracks(response: response))
            }
        }
        
    }
    
}
