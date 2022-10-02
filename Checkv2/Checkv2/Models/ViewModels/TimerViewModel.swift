//
//  TimerViewModel.swift
//  Checkv2
//
//  Created by Payten O'Driscoll on 10/1/22.
//

import Foundation

extension ListView {
    final class TimerViewModel: ObservableObject {
        
        
        @Published var timerLabel = "Next Break In:"
        @Published var isActive = false
        @Published var showingTakeBreakAlert = false
        @Published var showingBackToWorkAlert = false
        @Published var showingCongratsAlert = false
        @Published var workTime: Int = 2
        @Published var breakTime: Int = 1
        @Published var time: String = "0:00"
        @Published var initialMinutes: Int = 0
        @Published var minutes: Int = 0 {
            didSet {
                self.time = "\(minutes):00"
            }
        }
        private var initialTime = 0
        private var endDate = Date()
        
        func start(minutes: Int) {
            self.initialMinutes = minutes
            self.initialTime = minutes
            self.endDate = Date()
            self.isActive = true
            self.endDate = Calendar.current.date(byAdding: .minute, value: minutes, to: endDate)!
        }
        
        func reset() {
            self.initialMinutes = initialTime
            self.minutes = initialTime
            self.isActive = false
            self.time = "\(minutes):00"
        }
        
        func updateCountdown() {
            guard isActive else {return}
            
            let now = Date()
            let diff = endDate.timeIntervalSince1970 - now.timeIntervalSince1970
            
            if diff <= 0 && initialMinutes == workTime {
                self.isActive = false
                self.time = "0:00"
                self.showingTakeBreakAlert = true
                return
            } else if diff <= 0 && initialMinutes == breakTime {
                self.isActive = false
                self.time = "0:00"
                self.showingBackToWorkAlert = true
            }
            
            let date = Date(timeIntervalSince1970: diff)
            let calendar = Calendar.current
            let minutes = calendar.component(.minute, from: date)
            let seconds = calendar.component(.second, from: date)
            
            self.minutes = minutes
            self.time = String(format: "%d:%02d", minutes, seconds )

        }
    }
}
