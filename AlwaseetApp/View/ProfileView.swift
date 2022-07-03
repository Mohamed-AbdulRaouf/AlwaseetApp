//
//  ProfileView.swift
//  AlwaseetApp
//
//  Created by mohamed on 6/14/22.
//

import SwiftUI

struct ProfileView: View {
    @State var isPresented: Bool = false
    
    var body: some View {
        VStack {
            VStack {
                //                Header()
                
                ProfileText()
            }
            Spacer()
            Button (
                action: { self.isPresented = true },
                label: {
                    Label("Edit", systemImage: "pencil")
                })
                .sheet(isPresented: $isPresented, content: {
                    SettingsView()
                })
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

struct ProfilePicture: View {
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .frame(width: 100, height: 100)
            .clipShape(Circle())
    }
}


struct ProfileText: View {
    //    @AppStorage("name") var name = UserLoginData.shared.userName
    //    @AppStorage("subtitle") var subtitle = UserLoginData.shared.userPhone
    //    @AppStorage("description") var description = UserLoginData.shared.userEmail
    
    var body: some View {
        VStack(spacing: 15) {
            VStack(spacing: 5) {
                Text(UserLoginData.shared.userName)
                    .bold()
                    .font(.title)
                Text(UserLoginData.shared.userPhone)
                    .font(.body)
                    .foregroundColor(.secondary)
            }.padding()
            Text(UserLoginData.shared.userEmail)
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
        }
    }
}
