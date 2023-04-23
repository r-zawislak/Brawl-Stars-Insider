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
    @Binding private var show: Bool
    
    @State private var statsViewYOffset = 0.0
    @State private var showBrawlers = false
    
    private let scrollViewCoordinateSpaceName = "detailsScrollView"
    private let imageViewToScreenHeightProportion = 0.4
    private let animation: Namespace.ID
    
    init(map: Event.Map, animation: Namespace.ID, show: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: MapDetailsViewModel(map: map))
        _show = show
        self.animation = animation
    }
    
    var body: some View {
        ZStack {
            Color.background
            content
                .animationEnd(of: statsViewYOffset) {
                    showBrawlers = true
                }
        }
        .task {
            try? await viewModel.fetchDetails()
        }
    }
    
    private var content: some View {
        GeometryReader { geo in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    imageTopView
                        .frame(height: geo.size.height * imageViewToScreenHeightProportion)
                    Group {
                        Rectangle()
                            .foregroundColor(.background)
                        statsView
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 24)
                                    .foregroundColor(.secondaryBackground)
                            )
                            .background(Rectangle().foregroundColor(.background))
                            .offset(y: statsViewYOffset)
                    }
                }
            }
            .onAppear {
                statsViewYOffset = geo.size.height
                
                withAnimation(.linear.delay(0.25)) {
                    statsViewYOffset = 0
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .coordinateSpace(name: scrollViewCoordinateSpaceName)
        }
    }
    
    private var statsView: some View {
        VStack(spacing: 24) {
            Text("Brawlers")
                .font(.title)
                .horizontalAlignment(.leading)
            
            LazyVGrid(
                columns: [brawlerColumn],
                alignment: .leading,
                spacing: 24
            ) {
                ForEach(viewModel.stats) {
                    BrawlerStatView(stat: $0)
                    // TODO: Refactor
                        .offset(y: showBrawlers ? 0 : 400)
                        .animation(.linear, value: showBrawlers)
                }
            }
        }
    }
    
    private var brawlerColumn: GridItem {
        GridItem(.adaptive(minimum: 60), spacing: 16)
    }
    
    private var imageTopView: some View {
        GeometryReader { geo in
            let minY = geo.frame(in: .named(scrollViewCoordinateSpaceName)).minY
            KFImage(viewModel.map.imageUrl)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: geo.size.width, height: geo.size.height + (minY > 0 ? minY : 0), alignment: .center)
            
            //                .overlay(content:  {
            //                    gradient(forProgress: minY)
            //                })
                .clipped()
                .offset(y: -minY)
                .matchedGeometryEffect(id: viewModel.map.id, in: animation)
        }
    }
    
    private func gradient(forProgress progress: CGFloat) -> LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: (1...10).map { index in
                Color.background.opacity(Double(index) * 0.1 - progress)
            }),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}


struct MapDetailsView_Previews: PreviewProvider {
    
    @Namespace static var animation
    
    static var previews: some View {
        NavigationView {
            MapDetailsView(map: .mock, animation: animation, show: .constant(true))
                .preferredColorScheme(.dark)
        }
    }
}
