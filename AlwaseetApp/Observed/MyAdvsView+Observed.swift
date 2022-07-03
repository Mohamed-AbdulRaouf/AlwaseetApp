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
//    func addNewAdvs(adv: AdvsData)
    func getAdvsMy()
}

extension MyAdvsView {
    
    
    
    class MyAdvsViewObserved: ObservableObject, MyAdvsViewProtocol {
        
        //MARK: - Properties
        @Published var myAdvsData = [AdvsData]()
//        @Published var isAdvsAdded = false
        
        //MARK: - Func
//        func addNewAdvs(adv: AdvsData) {
//            NetworkManager.shared.addAdvs(advs: adv) { isAdvsAdd, error in
//                guard let isAdvsAdd = isAdvsAdd else {return}
//                if isAdvsAdd {
//                    self.isAdvsAdded = true
//                }
//            }
//        }
        
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
