//
//  TimerView.swift
//  MyTimer
//
//  Created by Petar Dzhambazov on 18.12.23.
//

import SwiftUI


struct TimerView: View {
    @StateObject private var timerManager = TimerManager()
    
    var body: some View {
        VStack {
            Text("\(timerManager.timeRemaining, specifier: "%.2f")")
                .font(.largeTitle)
                .padding()
            
            Button(action: {
                timerManager.isTimerRunning.toggle()
                if timerManager.isTimerRunning {
                    timerManager.startTimer()
                } else {
                    timerManager.stopTimer()
                }
            }) {
                Text(timerManager.isTimerRunning ? "Pause" : "Start")
                    .font(.title)
                    .padding()
            }
            .disabled(timerManager.timeRemaining == 0)
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}

import Combine

class TimerManager: ObservableObject {
    @Published var timeRemaining = 6.0 // Initial time in seconds
    private var timer: Timer?
    @Published var isTimerRunning = false
    
    func startTimer() {
        guard timer == nil else { return }
        
//        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in `[weak self] _ in
//            guard let self = self else { return }
//            
//            if self.timeRemaining > 0 && self.isTimerRunning {
//                self.timeRemaining -= 0.01
//            } else {
//                self.stopTimer()
//            }
//        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

