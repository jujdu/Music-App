//
//  FooterView.swift
//  Music-App
//
//  Created by Michael Sidoruk on 01/10/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

class FooterView: UIView {
    
    private var myLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.631372549, green: 0.6470588235, blue: 0.662745098, alpha: 1)
        return label
    }()
    
    private var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        return loader
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        set()
    }
    
    private func set() {
        addSubview(myLabel)
        addSubview(loader)
        
        loader.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        loader.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        loader.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
        myLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        myLabel.topAnchor.constraint(equalTo: loader.bottomAnchor, constant: 8).isActive = true
    }
    
    func showLoader() {
        loader.startAnimating()
        myLabel.text = "Loading"
    }
    
    func hideLoader() {
        loader.stopAnimating()
        myLabel.text = ""
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
