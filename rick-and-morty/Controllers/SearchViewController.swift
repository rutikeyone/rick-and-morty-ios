//
//  SearchViewController.swift
//  rick-and-morty
//
//  Created by Andrew on 15.02.2025.
//

import UIKit

class SearchViewController: UIViewController {

    private let viewModel: SearchViewModel
    
    init(config: Config) {
        self.viewModel = SearchViewModel(config: config)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func viewDidLoad() {
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .systemBackground
        
        title = switch(viewModel.config.type) {
        case .characters:
            "Search characters"
        case .episodes:
            "Search episodes"
        case .locations:
            "Search locations"
        }
        
        super.viewDidLoad()
    }
    

}
