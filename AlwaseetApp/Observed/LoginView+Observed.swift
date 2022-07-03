//
//  LoginView+Observed.swift
//  AlwaseetApp
//
//  Created by mohamed on 6/30/22.
//

import Foundation
import RealmSwift
import Realm

//MARK: - Protocol
protocol LoginViewProtocol: AnyObject {
    var user: UserData { get set }
    func login(phone: String, password: String)
}

extension LogInView {
    
    class LoginViewObserved: ObservableObject, LoginViewProtocol {
        //MARK: - Properties
        @Published var user = UserData()
        @Published var loggedIn = false
        @Published var loginMessage = ""
        
        //MARK: - Func
        func login(phone: String, password: String) {
            if phone == "" || password == "" {
                self.loginMessage = "please check from your account"
                return
            }
            DispatchQueue.main.async {
                NetworkManager.shared.login(phone: phone, password: password) { user, error in
                    if let error = error {
                        DispatchQueue.main.async {
                            self.loginMessage = "Please check from your account"
//                            print(error.localizedDescription)
                            return
                        }
                    }
                    guard let loginUser = user else {return}
                    if loginUser.name == "" {
                        DispatchQueue.main.async {
                            self.loginMessage = "please check from your account"
                            print("please check from your account")
                            return
                        }
                    } else {
                    UserLoginData.shared.userPhone = phone
                    UserLoginData.shared.userName = loginUser.name
                    Constants.shared.isUserLogin = true
                    self.user = loginUser
                    self.loggedIn = true
                    }
                }
            }
        }
    }
}
