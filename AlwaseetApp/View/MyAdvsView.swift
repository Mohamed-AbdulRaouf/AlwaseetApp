//
//  MyAdvsView.swift
//  AlwaseetApp
//
//  Created by mohamed on 7/1/22.
//

import SwiftUI

struct MyAdvsView: View {
    
    @StateObject private var observed = MyAdvsViewObserved()
    @State var isAddNewAdv: Bool = false
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack (spacing: 10) {
                    ForEach(self.observed.myAdvsData, id: \.id) { item in
                        AdvsCell(advData: item)
                    }.frame(minWidth: 300, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
                    
                }.padding(.leading, 30)
                    .padding(.trailing, 30)
                    .padding(.bottom, 10)
                
            }
        }
        .sheet(isPresented: $isAddNewAdv, onDismiss: {
            self.observed.getAdvsMy()
        }, content: {
            AddAdvsView()
        })
        .onAppear {
            self.observed.getAdvsMy()
        }
        .navigationBarTitle("My Advs", displayMode: .inline)
        .navigationBarItems(leading: (
            Button(action: {
                withAnimation {
                    self.isAddNewAdv.toggle()
                }
            }) {
                Image(systemName: "pencil")
                    .imageScale(.large)
                    .foregroundColor(.black)
                    .background(Color.green)
                    .cornerRadius(10)
                    .font(.title2)
            }
        ))
    } // NavigationView
    
}

struct MyAdvsView_Previews: PreviewProvider {
    static var previews: some View {
        MyAdvsView()
    }
}
