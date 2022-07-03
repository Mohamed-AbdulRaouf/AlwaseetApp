//
//  CategoriesData.swift
//  AlwaseetApp
//
//  Created by mohamed on 7/1/22.
//

import Foundation

struct CategoriesData: Identifiable, Hashable {
    //MARK: - Properties
    var id = UUID().uuidString
    var name: String
    
    //MARK: - Init
    init(name: String? = nil) {
        self.name = name ?? ""
    }
}
