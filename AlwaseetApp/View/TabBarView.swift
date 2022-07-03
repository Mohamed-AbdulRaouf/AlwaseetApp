//
//  TabBarView.swift
//  SwiftUIStarterKitApp
//
//  Created by Osama Naeem on 02/08/2019.
//  Copyright © 2019 NexThings. All rights reserved.
//

import SwiftUI

struct TabbarView: View {
    var body: some View {
        TabView {
            NavigationView {
//                ActivitiesContentView(activtiesData: Activities(data: ActivitiesMockStore.activityData, items: ActivitiesMockStore.activities))
                HomeView()
            }
            .tag(0)
            .tabItem {
                Image("home")
                    .resizable()
                Text("Home")
            }
            
            NavigationView {
//                ActivitiesCartView(ShoppingCartItemsData: ActivitiesCart(data: ActivitiesMockStore.shoppingCartData))
                MyAdvsView()
            }
            .tag(1)
            .tabItem {
                Image("activity-1")
                Text("My Advs")
            }
            
            NavigationView {
                     AccountView()
//                ProfileView()
                  }
                   .tag(2)
                    .tabItem {
                    Image("profile-glyph-icon")
                    Text("Account")
                }
        }
    }
}



