//
//  MapsView.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 03/03/2023.
//

import SwiftUI
import Kingfisher

struct MapsView: View {
    @StateObject private var viewModel = MapsViewModel()
    
    private let localizations = Localizations.Maps.self
    private let tabItemHorizontalPadding: CGFloat = 8
    private let tabItemVerticalPadding: CGFloat = 12
    private let indicatorID = "indicator"
    private let sectionTitleHeight: CGFloat = 40
    private let scrollViewCoordinateSpaceName = "scrollView"
    
    @Namespace private var indicatorAnimation
    
    /// 1.0 is value if tab was tapped
    @State private var animationProgress = 0.0
    
    @State private var yTabOffset = 0.0
    @State private var tabBarHeight = 0.0

    var body: some View {
        NavigationStack {
            content
                .navigationTitle(localizations.Title.localized)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarBackground(Color.secondaryBackground, for: .navigationBar)
                .toolbarColorScheme(.dark, for: .navigationBar)
                .task {
                    try? await viewModel.fetchMaps()
                }
                .animationEnd(of: animationProgress) {
                    animationProgress = 0
                }
        }
    }
    
    private var content: some View {
        ScrollViewReader { proxy in
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ForEach(viewModel.gameModes) {
                        section(for: $0)
                    }
                }
                .rect(in: .named(scrollViewCoordinateSpaceName)) { rect in
                    yTabOffset = rect.minY - tabBarHeight
                }
            }
            .rect(in: .named(scrollViewCoordinateSpaceName)) { rect in
                tabBarHeight = rect.minY
            }
            .safeAreaInset(edge: .top) {
                tabsHeader(proxy: proxy)
                    .offset(y: yTabOffset > 0 ? yTabOffset : 0)
            }
            .coordinateSpace(name: scrollViewCoordinateSpaceName)
        }
    }
    
    private func section(for gameMode: Event.Map.GameMode) -> some View {
        VStack {
            gameModeView(gameMode: gameMode)
                .font(.title)
                .fontWeight(.semibold)
                .frame(height: sectionTitleHeight)
                .frame(maxWidth: .infinity, alignment: .leading)

            grid(for: viewModel.mapsForGameMode[gameMode] ?? [])
        }
        .id(viewModel.sectionID(for: gameMode))
        .rect(in: .named(scrollViewCoordinateSpaceName)) { rect in
            let wasTabTapped = animationProgress == 1
            let minY = rect.minY
            guard !wasTabTapped, minY < sectionTitleHeight && -minY < rect.midY / 2 && viewModel.activeGameMode != gameMode else {
                return
            }
            
            withAnimation {
                viewModel.activeGameMode = gameMode
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(.secondaryBackground)
        )
    }
    
    private func grid(for maps: [Event.Map]) -> some View {
        LazyVGrid(
            columns: [
                GridItem(.flexible(), spacing: 16),
                GridItem(.flexible(), spacing: 16),
            ],
            spacing: 16
        ) {
            ForEach(maps) { map in
                mapItem(map: map)
            }
        }
    }
    
    private func mapItem(map: Event.Map) -> some View {
        VStack {
            KFImage(map.imageUrl)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(map.name)
        }
    }
    
//    private var indicator: some View {
//        Capsule()
//            .fill(.white)
//            .padding(.horizontal, tabItemHorizontalPadding)
//            .frame(height: 4)
//            .offset(y: 8 + tabItemVerticalPadding)
//            .matchedGeometryEffect(id: indicatorID, in: indicatorAnimation)
//    }
    
    private func indicator(for gameMode: Event.Map.GameMode) -> some View {
        RoundedRectangle(cornerRadius: 8)
            .padding(.vertical, tabItemVerticalPadding / 1.5)
            .foregroundColor(Color(hex: gameMode.bgColor))
            .matchedGeometryEffect(id: indicatorID, in: indicatorAnimation)
    }
    
    private func tabsHeader(proxy: ScrollViewProxy) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(viewModel.gameModes) { gameMode in
                    gameModeView(gameMode: gameMode)
                        .frame(height: 24)
                        .padding(.horizontal, tabItemHorizontalPadding)
                        .padding(.vertical, tabItemVerticalPadding)
                        .id(viewModel.tabID(for: gameMode))
                        .background(content: {
                            if viewModel.activeGameMode == gameMode {
                                indicator(for: gameMode)
                            }
                        })
                        .onTapGesture {
                            withAnimation {
                                animationProgress = 1
                                viewModel.activeGameMode = gameMode
                                proxy.scrollTo(gameMode, anchor: .top)
                            }
                        }
                }
            }
            .padding(.horizontal)
        }
        .background(Color.secondaryBackground)
        .onChange(of: viewModel.activeGameMode) { newValue in
            withAnimation {
                proxy.scrollTo(viewModel.tabID(for: newValue), anchor: .center)
            }
        }
    }
    
    private func gameModeView(gameMode: Event.Map.GameMode) -> some View {
        HStack {
            KFImage(gameMode.imageUrl)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(gameMode.name)
                .foregroundColor(.white)
        }
    }
}

struct MapsView_Previews: PreviewProvider {
    static var previews: some View {
        MapsView()
            .preferredColorScheme(.dark)
    }
}
