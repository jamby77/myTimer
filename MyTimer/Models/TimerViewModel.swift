//
//  TimerViewModel.swift
//  MyTimer
//
//  Created by Petar Dzhambazov on 19.12.23.
//

import Foundation

enum TimerState {
    case active
    case paused
    case resumed
    case canceled
    case finished
}

class TimerViewModel: ObservableObject {
    @Published var selectedHoursAmount = 0
    @Published var selectedMinutesAmount = 1
    @Published var selectedSecondsAmount = 0
    
    let hoursRange = 0...23
    let minutesRange = 0...59
    let secondsRange = 0...59
    
    // MARK: Private properties
    private var timer = Timer()
    private var totalTimeForCurrentSelection: Int {
        (selectedHoursAmount * 3600) + (selectedMinutesAmount * 60) + selectedSecondsAmount
    }
    
    // MARK: Public properties
    
    // Powers the ProgressView
    @Published var secondsToCompletion: Float = 0.1
    @Published var progress: Float = 0.0
    @Published var completionDate = Date.now
    
    @Published var state: TimerState = .canceled {
        didSet {
            switch state {
            case .canceled:
                fallthrough
            case .finished:
                // cancel timer and reset
                timer.invalidate()
                secondsToCompletion = 0
                progress = 0
                
            case .active:
                // start timer and set progress props
                startTimer()
                secondsToCompletion = Float(totalTimeForCurrentSelection)
                progress = 1.0
                
                updateCompletionDate()
            case .paused:
                // We want to pause the timer, but we
                // don't want to change the state of our progress
                // properties (secondsToCompletion and progress)
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
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] _ in
            guard let self else { return }
            
            self.secondsToCompletion -= 0.1
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
