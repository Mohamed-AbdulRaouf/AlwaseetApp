//
//  Constants.swift
//  AlwaseetApp
//
//  Created by mohamed on 6/29/22.
//

import SwiftUI

class Constants {
    public static var shared = Constants()
    
    @AppStorage("isOnboardShow") var isOnboardShow: Bool = false
    @AppStorage("isUserLogin") var isUserLogin: Bool = false
}

class UserLoginData {
    
    public static var shared = UserLoginData()
    
    @AppStorage("userName") var userName: String = ""
    @AppStorage("userPhone") var userPhone: String = ""
    @AppStorage("userEmail") var userEmail: String = ""
}
