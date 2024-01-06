//
//  TimerViewModel.swift
//  MyTimer
//
//  Created by Petar Dzhambazov on 19.12.23.
//

import Foundation

class TimerViewModel: ObservableObject {
    
    // MARK: Private properties
    private var timer = Timer()
    private var totalTimeForCurrentSelection: Int {
        (selectedHoursAmount * 3600) + (selectedMinutesAmount * 60) + selectedSecondsAmount
    }
    private var startDate: Date = Date.now
    private var totalTime: Float = 0.0
    
    // MARK: Public properties
    
    @Published var selectedHoursAmount = 0
    @Published var selectedMinutesAmount = 1
    @Published var selectedSecondsAmount = 0
    // Powers the ProgressView
    @Published var secondsToCompletion: Float = 0.1
    @Published var progress: Float = 0.0
    @Published var completionDate = Date.now
    
    
    @Published var state: TimerState = .canceled {
        didSet {
            switch state {
            case .canceled, .finished:
                // cancel timer and reset
                timer.invalidate()
                secondsToCompletion = 0
                progress = 0
                
            case .active:
                // start timer and set progress props
                secondsToCompletion = Float(totalTimeForCurrentSelection)
                totalTime = Float(totalTimeForCurrentSelection)
                startTimer()
                progress = 1.0
                
                updateCompletionDate()
            case .paused:
                // We want to pause the timer, but we
                // don't want to change the state of our progress
                // properties (secondsToCompletion and progress)
                totalTime = secondsToCompletion
                timer.invalidate()
            case .resumed:
                // Resumes the timer
                startTimer()
                
                // update ETA
                updateCompletionDate()
            }
        }
    }
    
    private func startTimer() {
        startDate = Date.now
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] _ in
            guard let self else { return }
            let diff = Float(Date.now.timeIntervalSince(startDate))
            
//            self.secondsToCompletion -= 0.1
            self.secondsToCompletion = self.totalTime - diff
            self.progress = self.secondsToCompletion / Float(self.totalTimeForCurrentSelection)
            
            if self.secondsToCompletion < 0 {
                self.state = .finished
            }
        })
    }
    
    private func updateCompletionDate() {
        completionDate = Date.now.addingTimeInterval(Double(secondsToCompletion))
    }
}
