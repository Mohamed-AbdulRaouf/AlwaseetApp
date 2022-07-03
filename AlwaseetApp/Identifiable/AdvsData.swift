//
//  AdvsData.swift
//  AlwaseetApp
//
//  Created by mohamed on 7/1/22.
//

import Foundation

struct AdvsData: Identifiable, Hashable {
    //MARK: - Properties
    var id = UUID().uuidString
    var title: String
    var category_type: String
    var background_image: String
    var address: String
    var phone: String
    var price: String
    var images: [String]
    
    //MARK: - Init
    init(title: String? = nil,
         category_type: String? = nil,
         background_image: String? = nil,
         address: String? = nil,
         phone: String? = nil,
         price: String? = nil,
         images: [String]? = []) {
        self.title = title ?? ""
        self.category_type = category_type ?? ""
        self.background_image = background_image ?? ""
        self.address = address ?? ""
        self.phone = phone ?? ""
        self.price = price ?? ""
        self.images = images ?? []
    }
}
