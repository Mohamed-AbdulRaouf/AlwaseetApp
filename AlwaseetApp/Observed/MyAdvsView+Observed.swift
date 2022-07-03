//
//  MyAdvsView+Observed.swift
//  AlwaseetApp
//
//  Created by mohamed on 7/1/22.
//

import SwiftUI

//MARK: - Protocol
protocol MyAdvsViewProtocol: AnyObject {
    var myAdvsData: [AdvsData] { get set }
    func getAdvsMy()
}

extension MyAdvsView {
    
    class MyAdvsViewObserved: ObservableObject, MyAdvsViewProtocol {
        
        //MARK: - Properties
        @Published var myAdvsData = [AdvsData]()
        
        //MARK: - Func
        func getAdvsMy() {
            NetworkManager.shared.getMyAdvs() { advsData, error in
                guard let advsData = advsData else {return}
                if advsData.count == 0 {
                    return
                }
                DispatchQueue.main.async {
                    self.myAdvsData = advsData
                }
            }
        }
    }
}
