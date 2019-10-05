//
//  MainTabBarController.swift
//  Music-App
//
//  Created by Michael Sidoruk on 29/09/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit
import SwiftUI

protocol MainTabBarControllerDelegate: class {
    func minimazeTrackDetailController()
    func maximazeTrackDetailController(viewModel: SearchViewModel.Cell?)
}

class MainTabBarController: UITabBarController {
    
    private let searchViewController: SearchViewController = SearchViewController.loadFromStoryboard()
    let trackDetailView: TrackDetailView = TrackDetailView.loadFromNib()
    
    private var minTopAnchorConstraints: NSLayoutConstraint!
    private var maxTopAnchorConstraints: NSLayoutConstraint!
    private var bottomAnchorConstraints: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = #colorLiteral(red: 1, green: 0, blue: 0.3764705882, alpha: 1)
        
        setupTrackDetailView()
        searchViewController.tabBarDelegate = self
        
        var library = Library()
        library.tabBarDelegate = self
        
        let hostVC = UIHostingController(rootView: library)
        hostVC.tabBarItem.image = #imageLiteral(resourceName: "library")
        hostVC.tabBarItem.title = "Library"
        
        viewControllers = [
            hostVC,
            generateViewController(rootViewController: searchViewController, image: #imageLiteral(resourceName: "search"), title: "Search")
        ]
    }
    
    private func generateViewController(rootViewController: UIViewController, image: UIImage, title: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        rootViewController.navigationItem.title = title
        navigationVC.navigationBar.prefersLargeTitles = true
        return navigationVC
    }
    
    private func setupTrackDetailView() {
        print("setuptrackdetailview")
        
        trackDetailView.tabBarDelegate = self
        trackDetailView.delegate = searchViewController
        view.insertSubview(trackDetailView, belowSubview: tabBar)
        
        // use autolayout
        trackDetailView.translatesAutoresizingMaskIntoConstraints = false
        
        maxTopAnchorConstraints = trackDetailView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height)
        minTopAnchorConstraints = trackDetailView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64)
        bottomAnchorConstraints = trackDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height)
        bottomAnchorConstraints.isActive = true
        maxTopAnchorConstraints.isActive = true
        
        trackDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        trackDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
    }
    
}

extension MainTabBarController: MainTabBarControllerDelegate {
    
    func maximazeTrackDetailController(viewModel: SearchViewModel.Cell?) {
        
        minTopAnchorConstraints.isActive = false
        maxTopAnchorConstraints.isActive = true
        maxTopAnchorConstraints.constant = 0
        bottomAnchorConstraints.constant = 0
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut, animations: {
                        self.view.layoutIfNeeded()
                        self.tabBar.alpha = 0
                        self.trackDetailView.miniTrackView.alpha = 0
                        self.trackDetailView.maxStackView.alpha = 1
        },
                       completion: nil)
        guard let viewModel = viewModel else { return }
        self.trackDetailView.set(viewModel: viewModel)
    }
    
    func minimazeTrackDetailController() {
        
        maxTopAnchorConstraints.isActive = false
        bottomAnchorConstraints.constant = view.frame.height
        minTopAnchorConstraints.isActive = true
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut, animations: {
                        self.view.layoutIfNeeded()
                        self.tabBar.alpha = 1
                        self.trackDetailView.miniTrackView.alpha = 1
                        self.trackDetailView.maxStackView.alpha = 0
        },
                       completion: nil)
    }
    
    
}
