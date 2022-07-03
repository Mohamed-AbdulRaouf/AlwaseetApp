//
//  LogInView.swift
//  SwiftUIStarterKitApp
//
//  Created by Osama Naeem on 02/08/2019.
//  Copyright © 2019 NexThings. All rights reserved.
//

import SwiftUI

struct LogInView: View {
//    @EnvironmentObject var settings: UserSettings
    @StateObject private var observed = LoginViewObserved() // link between the view and logical data
    @State  private var phoneNumber: String = ""
    @State  private var password: String = ""
    @State var loggedIn: Bool = false
    @State var signUp: Bool = false
    
    var loginIsValid: Bool {
        return !phoneNumber.isEmpty && phoneNumber != ""
    }
    
    var body: some View {
    GeometryReader { geometry in
            VStack (alignment: .center){
                HStack {
                    Image("2")
                    .resizable()
                    .frame(width: 20, height: 20)
                    Text("Alwaseet App")
                        .font(.system(size: 25))
                        
                }.padding(.top, 30)
                .padding(.bottom, 10)
                
                Text("Log Into Your Account")
                    .font(.title)
                    .font(.system(size: 14, weight: .bold, design: Font.Design.default))
                    .padding(.bottom, 50)
                
                TextField("Mobile", text: self.$phoneNumber)
                    .frame(width: geometry.size.width - 45, height: 50)
                    .textContentType(.emailAddress)
                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
                    .accentColor(.red)
                    .background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
                    .cornerRadius(5)
                
                
                SecureField("Password", text: self.$password)
                    .frame(width: geometry.size.width - 45, height: 50)
                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
                    .foregroundColor(.gray)
                    .background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
                    .textContentType(.password)
                    .cornerRadius(5)
                
                 Button(action: {
                     self.observed.login(phone: phoneNumber, password: password)

                 }) {
                        HStack {
                            Text("Log In")
                        }
                            .padding()
                            .frame(width: geometry.size.width - 40, height: 40)
                            .foregroundColor(Color.white)
                            .background(Color.blue)
                            .cornerRadius(5)
                            .disabled(!loginIsValid)
                    }
                
                Button(action: {
                    self.signUp.toggle()
                }) {
                       HStack {
                           Text("Sign Up")
                       }
                           .padding()
                           .frame(width: geometry.size.width - 40, height: 40)
                           .foregroundColor(Color.white)
                           .background(Color.blue)
                           .cornerRadius(5)
                   }
                
                     .padding(.bottom, 40)
                
                Divider()
                
//                Button(action: {
//                        print("Take to forget password VC")
//                        }) {
//                        Text("Forgot your password?")
//                }
                
                Spacer()
                Text("\(self.observed.loginMessage)")
                    .foregroundColor(.red)
                    .font(.title2)
            }.onAppear(perform: {
                NetworkManager.shared.connectToServer()
            })
            .fullScreenCover(isPresented: self.$observed.loggedIn, onDismiss: nil, content: {
                TabbarView()
            })
            .fullScreenCover(isPresented: self.$signUp, onDismiss: nil, content: {
                SignUpView()
            })
        
            .padding(.bottom, 90)
            }
    }
}





