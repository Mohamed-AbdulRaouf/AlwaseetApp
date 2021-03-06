//
//  HomeView+Observed.swift
//  AlwaseetApp
//
//  Created by mohamed on 7/1/22.
//

import SwiftUI

//MARK: - Protocol
protocol HomeViewProtocol: AnyObject {
    var advsData: [AdvsData] { get set }
    var categories: [CategoriesData] { get set }
    func getAdvsBy(filter: AdvsFilter)
    
    var sliders: [SlidersData] { get set }
    func getSliders()
}

extension HomeView {
    
    
    
    class HomeViewObserved: ObservableObject, HomeViewProtocol {
        
        //MARK: - Properties
        @Published var advsData = [AdvsData]()
        @Published var categories = [CategoriesData(name: "All"),
                                     CategoriesData(name: "Cars"),
                                     CategoriesData(name: "Mobiles"),
                                     CategoriesData(name: "Labtops"),
                                     CategoriesData(name: "Homes"),
                                     CategoriesData(name: "Computers"),
                                     CategoriesData(name: "Animals")]
        
        //MARK: - Func
        func getAdvsBy(filter: AdvsFilter) {
            NetworkManager.shared.getAdvs(filterBy: filter) { advsData, error in
                guard let advsData = advsData else {return}
                DispatchQueue.main.async {
                    self.advsData = advsData
                }
            }
        }
        
        @Published var sliders: [SlidersData] = {
            let slider = [SlidersData(imageUrl: "")]
            return slider
        }()
        
        func getSliders() {
            NetworkManager.shared.getSlider { slider, error in
                DispatchQueue.main.async {
                    guard let slider = slider else {return}
                    self.sliders = slider
                }
            }
        }
        
    }
}

enum AdvsFilter: String {
    case all = ""
    case cars = "Cars"
    case mobiles = "Mobiles"
    case labtops = "Labtops"
    case homes = "Homes"
    case computers = "Computers"
    case animals = "Animals"
}
