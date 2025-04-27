import Foundation
import UIKit

class SearchView: UIView {
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        return searchBar
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        
        return spinner
    }()
    
    private let noResultView: SearchNoResultsView = {
        let view = SearchNoResultsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func setupViews() {        
        addSubviews(searchBar, noResultView)
        addConstraints()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 58)
        ])
        
        NSLayoutConstraint.activate([
            noResultView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            noResultView.bottomAnchor.constraint(equalTo: bottomAnchor),
            noResultView.trailingAnchor.constraint(equalTo: trailingAnchor),
            noResultView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
}
