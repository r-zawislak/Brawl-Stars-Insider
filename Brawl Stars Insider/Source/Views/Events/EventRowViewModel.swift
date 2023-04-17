//
//  EventRowViewModel.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 17/02/2023.
//
import Combine
import Foundation

final class EventRowViewModel: ObservableObject {
    
    @Published var recommended: [Event.Map.Stat] = []
    @Published var eventEndsInString = ""
    
    private let recommendedStatsCount = 5
    private let event: Event
    private var timeToEndEvent: TimeInterval
    
    private let dateComponentsFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.maximumUnitCount = 1
        return formatter
    }()
    
    init(event: Event) {
        self.event = event
        timeToEndEvent = event.endTime.timeIntervalSince(.now)
        
        updateRecommendedBrawlers()
        updateEventEndsInString()
    }
    
    private func updateEventEndsInString() {
        let dateString = dateComponentsFormatter.string(from: timeToEndEvent) ?? ""
        eventEndsInString = Localizations.Events.Row.EndsIn.localized(p0: dateString)
    }
    
    private func updateRecommendedBrawlers() {
        recommended = StatsSorter().sortedStats(event.map.stats ?? [], maxCount: recommendedStatsCount)
    }
}
