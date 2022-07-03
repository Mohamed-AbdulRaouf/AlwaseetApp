//
//  AlwaseetAppApp.swift
//  AlwaseetApp
//
//  Created by mohamed on 6/29/22.
//

import SwiftUI

@main
struct AlwaseetAppApp: App {
    var body: some Scene {
        WindowGroup {
            if Constants.shared.isOnboardShow {
                if Constants.shared.isUserLogin {
                    TabbarView()
                } else {
                    LogInView()
                }
            } else {
                let settings = UserSettings()
                StartView().environmentObject(settings)
            }
        }
    }
}
