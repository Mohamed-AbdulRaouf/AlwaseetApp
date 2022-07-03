//
//  UserData.swift
//  AlwaseetApp
//
//  Created by mohamed on 6/30/22.
//

import Foundation
import RealmSwift

class UserData: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name = ""
    @Persisted var phone = ""
    @Persisted var email = ""
    
    convenience init(name: String, phone: String, email: String) {
        self.init()
        self.name = name
        self.phone = phone
        self.email = email
    }
}

import ObjectMapper

class User22 : Object, Mappable {

    dynamic var userId: String!
    dynamic var emailId: String!

    override class func primaryKey() -> String? {
        return "userId"
    }

    required convenience init?(map: ObjectMapper.Map) {
        self.init()
    }

    func mapping(map: ObjectMapper.Map) {
        userId <- map["userId"]
        emailId <- map["email"]
    }
}
