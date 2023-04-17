//
//  MapDetailsView.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 14/04/2023.
//

import SwiftUI
import Kingfisher

struct MapDetailsView: View {
    @StateObject private var viewModel: MapDetailsViewModel
    
    private let scrollViewCoordinateSpaceName = "detailsScrollView"
    
    init(map: Event.Map) {
        _viewModel = StateObject(wrappedValue: MapDetailsViewModel(map: map))
    }

    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    imageTopView
                        .frame(height: geo.size.height * 0.4)
                    
                    statsView
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .navigationTitle(viewModel.map.name)
            .navigationBarTitleDisplayMode(.inline)
            .coordinateSpace(name: scrollViewCoordinateSpaceName)
        }
    }
    
    private var statsView: some View {
        VStack() {
            Text("Brawlers")
            
            LazyVGrid(
                columns: [brawlerColumn],
                alignment: .center,
                spacing: 8
          ) {
                ForEach(viewModel.stats) {
                    BrawlerStatView(stat: $0)
                }
            }
            
        }
    }
    
    private var brawlerColumn: GridItem {
        GridItem(.adaptive(minimum: 100, maximum: 100), spacing: 16)
    }
    
    private var imageTopView: some View {
        GeometryReader { geo in
            let minY = geo.frame(in: .named(scrollViewCoordinateSpaceName)).minY
            let _ = print(geo.frame(in: .local).width)
            KFImage(viewModel.map.imageUrl)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: geo.size.width, height: geo.size.height + (minY > 0 ? minY : 0), alignment: .center)
                .clipped()
                .offset(y: -minY)
        }
    }
}


struct MapDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MapDetailsView(map: .mock)
                .preferredColorScheme(.dark)
        }
    }
}
