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
    @State var title = ""
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
                TextField("Title", text: $title)
                TextField("Category Type", text: $categoryType)
                TextField("address", text: $address)
                TextField("price", text: $price)
                TextField("Background Image Url", text: $backgroundImage)
            }
            Spacer()
            VStack (spacing: 10) {
                Button {
                    let advsData = AdvsData(title: title, category_type: categoryType, background_image: backgroundImage, address: address, phone: UserLoginData.shared.userPhone, price: price, images: [""])
                    self.observed.addNewAdvs(adv: advsData)
                } label: {
                    Text("Add new advs")
                        .foregroundColor(.white)
                        .frame(width: 300, height: 45, alignment: .center)
                }.background(Color.blue)
                    .cornerRadius(20)
                    .padding([.leading, .trailing], 20)
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                        .frame(width: 300, height: 45, alignment: .center)
                }.background(Color.gray)
                    .cornerRadius(20)
                    .padding([.leading, .trailing], 20)
                
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
