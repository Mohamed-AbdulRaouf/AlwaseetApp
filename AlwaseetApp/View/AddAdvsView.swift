//
//  AddAdvsView.swift
//  AlwaseetApp
//
//  Created by mohamed on 7/1/22.
//

import SwiftUI

struct AddAdvsView: View {
    
    @StateObject private var observed = AddAdvsViewObserved()
    @Environment(\.presentationMode) var presentationMode
    @State var categoryType = ""
    @State var address = ""
    @State var price = ""
    @State var backgroundImage = ""
    
    var body: some View {
        VStack {
            Spacer()
            Text("Please fill all data")
                .font(.system(size: 24))
            GroupBox() {
                TextField("Category Type", text: $categoryType)
                TextField("address", text: $address)
                TextField("price", text: $price)
                TextField("Background Image Url", text: $backgroundImage)
            }
            Spacer()
            VStack {
                Button {
                    let advsData = AdvsData(category_type: categoryType, background_image: backgroundImage, address: address, phone: UserLoginData.shared.userPhone, price: price, images: [""])
                    self.observed.addNewAdvs(adv: advsData)
                } label: {
                    Text("Add new advs")
                }
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                }
            }.alert("Your Advs added", isPresented: self.$observed.isAdvsAdded) {
                Button("OK", role: .cancel) { }
            }
        }
    }
}

struct AddAdvsView_Previews: PreviewProvider {
    static var previews: some View {
        AddAdvsView()
    }
}
