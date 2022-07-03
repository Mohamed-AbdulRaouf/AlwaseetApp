//
//  SettingsView.swift
//  AlwaseetApp
//
//  Created by mohamed on 6/14/22.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
//                HeaderBackgroundSliders()
                ProfileSettings()
            }
            .navigationBarTitle(Text("Settings"))
            .navigationBarItems(
                trailing:
                    Button (
                        action: {
                            self.presentationMode.wrappedValue.dismiss()
                        },
                        label: {
                            Text("Done")
                        }
                    )
            )
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

struct ProfileSettings: View {
//    @AppStorage("name") var name = DefaultSettings.name
//    @AppStorage("subtitle") var subtitle = DefaultSettings.subtitle
//    @AppStorage("description") var description = DefaultSettings.description
    
    var body: some View {
        Section(header: Text("Profile")) {
            Button (
                action: {
                    // Action
                },
                label: {
                    Text("Pick Profile Image")
                }
            )
            TextField("Name", text: UserLoginData.shared.$userName)
            TextField("Subtitle", text: UserLoginData.shared.$userPhone)
            TextField("Email", text: UserLoginData.shared.$userEmail)
        }
    }
}
