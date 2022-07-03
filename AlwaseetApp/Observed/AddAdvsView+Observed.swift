//
//  AddAdvsViewObserved.swift
//  AlwaseetApp
//
//  Created by mohamed on 7/3/22.
//

import SwiftUI

//MARK: - Protocol
protocol AddAdvsViewProtocol: AnyObject {
    func addNewAdvs(adv: AdvsData)
}

extension AddAdvsView {
    
    class AddAdvsViewObserved: ObservableObject, AddAdvsViewProtocol {
        
        //MARK: - Properties
        @Published var isAdvsAdded = false
        
        //MARK: - Func
        func addNewAdvs(adv: AdvsData) {
            NetworkManager.shared.addAdvs(advs: adv) { isAdvsAdd, error in
                guard let isAdvsAdd = isAdvsAdd else {return}
                if isAdvsAdd {
                    DispatchQueue.main.async {
                        self.isAdvsAdded = true
                    }
                }
            }
        }
    }
}
