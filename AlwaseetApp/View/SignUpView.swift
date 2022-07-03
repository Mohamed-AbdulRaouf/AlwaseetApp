//
//  SignUpView.swift
//  SwiftUIStarterKitApp
//
//  Created by Osama Naeem on 03/08/2019.
//  Copyright © 2019 NexThings. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
//    @EnvironmentObject var settings: UserSettings
    @StateObject private var observed = SignUpObserved() // link between the view and logical data
    @State var emailAddress: String = ""
    @State var name: String = ""
    @State var phone: String = ""
    @State var password: String = ""
    @State var loggedIn: Bool = false
    @State var signUp: Bool = false
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack (alignment: .center){
                
                Text("Create an Account")
                    .font(.title)
                    .font(.system(size: 14, weight: .bold, design: Font.Design.default))
                    .padding(.bottom, 50)
                
                
                VStack {
                    TextField("Name", text: self.$name)
                        .frame(width: geometry.size.width - 45, height: 50)
                        .textContentType(.emailAddress)
                        .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
                        .accentColor(.red)
                        .background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
                        .cornerRadius(5)
                    
                    TextField("Email", text: self.$emailAddress)
                        .frame(width: geometry.size.width - 45, height: 50)
                        .textContentType(.emailAddress)
                        .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
                        .accentColor(.red)
                        .background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
                        .cornerRadius(5)
                    
                    TextField("Phone", text: self.$phone)
                        .frame(width: geometry.size.width - 45, height: 50)
                        .textContentType(.emailAddress)
                        .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
                        .accentColor(.red)
                        .background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
                        .cornerRadius(5)
                    
                    SecureField("Password", text: self.$password)
                        .frame(width: geometry.size.width - 45, height: 50)
                        .textContentType(.emailAddress)
                        .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
                        .accentColor(.red)
                        .background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
                        .cornerRadius(5)
                }
                
                Text("When you click on create account you will agree on Terms of Service and Privacy Policy")
                    .frame(width: geometry.size.width - 20, alignment: .center)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.blue)
                    .padding(.bottom, 40)
                    .font(.system(size: 12))
                
                Button(action: {
                    // your action here
//                    self.signUp.toggle()
                    self.observed.register(name: name, phone: phone, email: emailAddress, password: password)
                }) {
                    HStack {
                        Text("Create Account")
//                            .frame(width: geometry.size.width - 20, height: 40)
                    }
                    .padding()
                    .frame(width: geometry.size.width, height: 40)
                    .foregroundColor(Color.white)
                    .background(Color.blue)
//                    .cornerRadius(5)
                }
                
                Button(action: {
                    // your action here
                    self.loggedIn.toggle()
                }) {
                    HStack {
                        Text("Login")
//                            .frame(width: geometry.size.width - 20, height: 40)
                    }
                    .padding()
                    .frame(width: geometry.size.width, height: 40)
                    .foregroundColor(Color.white)
                    .background(Color.blue)
//                    .cornerRadius(5)
                }.padding(.bottom, 40)
                
                Spacer()
                
            }
            .fullScreenCover(isPresented: self.$observed.isuserRegister, onDismiss: nil, content: {
                TabbarView()
            })
            .fullScreenCover(isPresented: self.$loggedIn, onDismiss: nil, content: {
                LogInView()
            })
        }
    }
    
}
