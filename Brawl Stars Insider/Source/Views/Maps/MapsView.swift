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
    @Namespace private var mapAnimation
    
    /// 1.0 is value if tab was tapped
    @State private var animationProgress = 0.0
    @State private var yTabOffset = 0.0
    @State private var tabBarHeight = 0.0
    @State private var selectedMap: Event.Map?
    @State private var showMapDetails = false

    var body: some View {
        NavigationStack {
            content
                .navigationTitle(showMapDetails ? selectedMap?.name ?? "" : localizations.Title.localized)
                .navigationBarTitleDisplayMode(showMapDetails ? .inline : .large)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarBackground(Color.secondaryBackground, for: .navigationBar)
                .toolbarColorScheme(.dark, for: .navigationBar)
                .toolbar(content: {
                    if showMapDetails {
                        detailsBackButton
                    }
                })
                .task {
                    try? await viewModel.fetchMaps()
                }
                .animationEnd(of: animationProgress) {
                    animationProgress = 0
                }
                .overlay {
                    if let selectedMap, showMapDetails {
                        MapDetailsView(map: selectedMap, animation: mapAnimation, show: $showMapDetails)
                    }
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
    
    private var detailsBackButton: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(
                action: {
                    withAnimation {
                        showMapDetails = false
                    }
                },
                label: {
                    Image(systemName: "chevron.left")
                }
            )
        }
    }
    
    private func section(for gameMode: Event.Map.GameMode) -> some View {
        GameModeSection(
            gameMode: gameMode,
            gameModeMaps: viewModel.mapsForGameMode[gameMode] ?? [],
            sectionTitleHeight: sectionTitleHeight,
            animation: mapAnimation,
            onMapTapped: onMapTapped
        )
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
    }

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
                    GameModeView(gameMode: gameMode)
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
                                proxy.scrollTo(viewModel.sectionID(for: gameMode), anchor: .top)
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
    
    // MARK: - Actions
    
    private func onMapTapped(map: Event.Map) {
        selectedMap = map
        
        withAnimation {
            showMapDetails = true
        }
    }
}

struct MapsView_Previews: PreviewProvider {
    static var previews: some View {
        MapsView()
            .preferredColorScheme(.dark)
    }
}
