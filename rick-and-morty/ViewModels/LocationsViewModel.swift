//
//  LocationsViewModel.swift
//  rick-and-morty
//
//  Created by Andrew on 23.02.2025.
//

import Foundation

final class LocationsViewModel {
    
    private var isInitialLoading = false
    
    private var info: PageInfo?
    
    private(set) var locations: [Location] = []
    
    let initialLocationsBox = Box<[Location]>(value: [])
    let locationsBox = Box<([IndexPath], [Location])>(value: ([], []))
    
    let isLoadingMoreProgress = Box<Bool>(value: false)
    
    private var shouldLoadMore: Bool {
        get {
            let isLoadingMoreProgress = isLoadingMoreProgress.value
            let result = info?.next != nil && !isLoadingMoreProgress && !isInitialLoading
            
            return result
        }
    }
    
    init() {
        fetchLocationsByFirstPage()
    }
    
    private func fetchLocationsByFirstPage() {
        isInitialLoading = true
        
        let request = APIRequest.listLocationsRequest
        
        APIService.shared.execute(request, expecting: GetLocationsResponse.self) {
            [weak self] result in
            
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let data):
                let locations = data.results
                let info = data.info
                
                self.initialLocationsBox.value = locations
                self.info = info
                self.isInitialLoading = false
                
                self.locations.append(contentsOf: locations)
            case .failure(let error):
                self.isInitialLoading = false
                print(String(describing: error))
            }
        }
    }
    
    public func fetchLocationsByNextPage() {
        guard shouldLoadMore,
              let info = self.info,
              let next = info.next,
              let url = URL(string: next),
              let request = APIRequest.init(url: url) else { return }
        
        isLoadingMoreProgress.value = true
        
        APIService.shared.execute(request, expecting: GetLocationsResponse.self) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let response):
                let moreLocations = response.results
                let nextInfo = response.info
                
                let originalCount = locations.count
                let newCount = moreLocations.count
                let total = originalCount + newCount
                let startIndex = total - newCount
                let endIndex = startIndex + newCount
                let arrayRange = Array(startIndex..<endIndex)
                
                let indexPathsToAdd: [IndexPath] = arrayRange.compactMap ({
                    return IndexPath(row: $0, section: 0)
                })
                
                self.info = nextInfo
                self.isLoadingMoreProgress.value = false
                
                self.locationsBox.value = (indexPathsToAdd, moreLocations)
                self.locations.append(contentsOf: moreLocations)
                
            case .failure(let error):
                self.isLoadingMoreProgress.value = false
                
                print(String(describing: error))
            }
            
        }
    }
    
    func locationByIndex(index: Int, callback: ((Location) -> Void)) {
        guard let location = locations[safe: index] else {
            return
        }
        
        callback(location)
    }
    
}
