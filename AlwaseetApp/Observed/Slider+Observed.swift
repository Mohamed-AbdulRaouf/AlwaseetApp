//
//  Slider+Observed.swift
//  AlwaseetApp
//
//  Created by mohamed on 6/30/22.
//

import SwiftUI

//MARK: - Protocol
protocol SliderProtocol: AnyObject {
    var sliders: [SlidersData] { get set }
    func getSliders()
}

extension HomeView {
    
    class MainViewObserved: ObservableObject, SliderProtocol {
        //MARK: - Properties
        @Published var sliders: [SlidersData] = {
            let slider = [SlidersData(imageUrl: "")]
            return slider
        }()
        
        //MARK: - Func
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
