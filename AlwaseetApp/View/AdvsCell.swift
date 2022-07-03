//
//  AdvsCell.swift
//  AlwaseetApp
//
//  Created by mohamed on 7/1/22.
//

import SwiftUI

struct AdvsCell: View {
    var advData: AdvsData
    var body: some View {
        GeometryReader { g in
            ZStack{
//                Image("\(self.resourceItems.resourceImage)")
                AsyncImage(url: URL(string: self.advData.background_image))
                .opacity(0.8)
                .background(Color.black)
                VStack(alignment: .center) {
                    Text("Price: \(self.advData.price)")
                        .font(.system(size: 16, weight: .bold, design: Font.Design.default))
                        .frame(width: 150)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                    
                    Text("Phone: \(self.advData.phone)")
                        .font(.system(size: 16, weight: .bold, design: Font.Design.default))
                        .frame(width: 150)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                    
                    Text("Address: \(self.advData.address)")
                        .font(.system(size: 16, weight: .bold, design: Font.Design.default))
                        .frame(width: 150)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                }
                        
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .cornerRadius(10)
        }
    }
}
