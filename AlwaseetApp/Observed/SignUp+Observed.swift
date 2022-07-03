//
//  SignUp+Observed.swift
//  AlwaseetApp
//
//  Created by mohamed on 7/1/22.
//

import SwiftUI

//MARK: - Protocol
protocol SignUpProtocol: AnyObject {
    func register(name: String, phone: String, email: String, password: String)
}

extension SignUpView {
    
    class SignUpObserved: ObservableObject, SignUpProtocol {
        
        
        //MARK: - Properties
        @Published var isuserRegister = false
        
        //MARK: - Func
        func register(name: String, phone: String, email: String, password: String) {
            NetworkManager.shared.register(name: name, phone: phone, email: email, password: password) { isRegister, error in
                guard let isRegister = isRegister else {return}
                if isRegister {
                    UserLoginData.shared.userPhone = phone
                    UserLoginData.shared.userName = name
                    Constants.shared.isUserLogin = true
                    self.isuserRegister = true
                }
            }
        }
    }
}
