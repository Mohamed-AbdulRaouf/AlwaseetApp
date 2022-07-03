//
//  SlidersData.swift
//  AlwaseetApp
//
//  Created by mohamed on 6/30/22.
//

import Foundation

struct SlidersData: Identifiable, Hashable {
    //MARK: - Properties
    var id = UUID().uuidString
    var imageUrl: String
    
    //MARK: - Init
    init(imageUrl: String? = nil) {
        self.imageUrl = imageUrl ?? ""
    }
}
