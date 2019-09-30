//
//  SearchPresenter.swift
//  Music-App
//
//  Created by Michael Sidoruk on 30/09/2019.
//  Copyright (c) 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

protocol SearchPresentationLogic {
    func presentData(response: Search.Model.Response.ResponseType)
}

class SearchPresenter: SearchPresentationLogic {
    weak var viewController: SearchDisplayLogic?
    
    func presentData(response: Search.Model.Response.ResponseType) {
        switch  response {
        case .some:
            print("Presenter .some")
        case .presentTracks(let results):
            let cells = results?.results.map({ (track) in
                cellViewModel(from: track)
            }) ?? []
            
            let searchViewModel = SearchViewModel.init(cells: cells)
            print("Presenter .presentTracks")
            
            viewController?.displayData(viewModel: Search.Model.ViewModel.ViewModelData.displayTracks(searchViewModel: searchViewModel))
        }
    }
    
    private func cellViewModel(from track: Track) -> SearchViewModel.Cell {
        return SearchViewModel.Cell.init(iconUrlString: track.artworkUrl100,
                                         trackName: track.trackName,
                                         collectionName: track.collectionName ?? "",
                                         artistName: track.artistName,
                                         previewUrl: track.previewUrl)
    }
    
}
