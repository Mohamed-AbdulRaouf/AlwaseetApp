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
//                AsyncImage(url: URL(string: self.advData.background_image))
//                    .opacity(0.8)
//                .background(Color.black)
                
                AsyncImage(
                               url: URL(string: self.advData.background_image),
                               content: { image in
                                   image.resizable()
                                        .aspectRatio(contentMode: .fill)
//                                        .frame(maxWidth: 300, maxHeight: 100)
                               },
                               placeholder: {
                                   ProgressView()
                               }
                           )
                
                VStack(alignment: .center) {
                    Text("Title: \(self.advData.title)")
                        .font(.system(size: 16, weight: .bold, design: Font.Design.default))
                        .frame(width: 150)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                    
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
            .background(Color.gray.opacity(0.5))
            .cornerRadius(25)
        }
    }
}
