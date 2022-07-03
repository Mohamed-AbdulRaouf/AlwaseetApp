//
//  HomeView.swift
//  AlwaseetApp
//
//  Created by mohamed on 6/30/22.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var observed = HomeViewObserved() // link between the view and logical data
    @State var index = 0
    
    var body: some View {
        GeometryReader { g in
            ScrollView{
                VStack(spacing: 20) {
                    PagingView(index: $index.animation(), maxIndex: observed.sliders.count - 1) {
                        ForEach(self.observed.sliders, id: \.self) { image in
                            AsyncImage(url: URL(string: image.imageUrl))
                        }
                    }
                    .aspectRatio(4/3, contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                .padding()
                
                VStack(alignment: .leading) {
                    Text("Categories")
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 20))
                        .padding(.top, 10)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack (spacing: 10){
                            ForEach(self.observed.categories, id: \.id) { item in
                                //                                ShopPromotionBannerView(activtiesItems: ActivitiesItem(id: 1, activityName: item.name, activityNameLabel: item.name, activityImage: item.name, selectedActivity: true), selectedActivity: ActivitySelected())
                                Button(action: {
                                    //                                    self.placeItemSelected = item
                                    //                                    self.isShowing = true
                                    print(item.name)
                                    
                                    self.observed.getAdvsBy(filter: AdvsFilter.init(rawValue: item.name) ?? .all)
                                }) {
//                                    ShopPromotionBannerView(activtiesItems: ActivitiesItem(id: 1, activityName: item.name, activityNameLabel: item.name, activityImage: "", selectedActivity: true), selectedActivity: ActivitySelected())
//                                        .frame(width: 120, height: 60)
                                    
                                    Text("\(item.name)")
                                        .frame(width: 120, height: 60)
                                        .font(.system(size: 14, weight: .bold, design: Font.Design.default))
                                        .foregroundColor(Color.white)
                                        .background(Color.black)
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                }
                            }
                        }.padding(.leading, 30)
                            .padding(.trailing, 30)
                            .padding(.bottom, 10)
                    }
                    .padding(.top, 10)
                }
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack (spacing: 10) {
                        ForEach(self.observed.advsData, id: \.id) { item in
                            AdvsCell(advData: item)
                        }.frame(minWidth: 300, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
                        
                    }.padding(.leading, 30)
                        .padding(.trailing, 30)
                        .padding(.bottom, 10)
                    
                }
                
                
            }.onAppear(perform: {
                self.observed.getSliders()
                self.observed.getAdvsBy(filter: .all)
            })
        }.navigationBarTitle("Alwaseet App")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
