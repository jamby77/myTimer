//
//  WorkRestTimerModel.swift
//  MyTimer
//
//  Created by Petar Dzhambazov on 6.01.24.
//

import Foundation

class WorkRestTimerViewModel: ObservableObject {
    
    // MARK: Private properties
    private var timer = Timer()
    
    private var startDate: Date = Date.now
    
    // MARK: Public properties
    // Powers the ProgressView
    @Published var elapsedTimeInSeconds: Float = 0.0
    
    @Published var state: WorkRestState = .canceled {
        didSet {
            switch state {
            case .canceled, .finished:
                // cancel timer and reset
                timer.invalidate()
                elapsedTimeInSeconds = 0.0
                
            case .work:
                // start timer
                startTimer()
            case .rest:
                // start timer
                startTimer()
            case .paused:
                timer.invalidate()
            case .resumed:
                // Resumes the timer
                startTimer()
            }
        }
    }
    
    private func startTimer() {
        startDate = Date.now
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] _ in
            guard let self else { return }
            let diff = Float(Date.now.timeIntervalSince(startDate))
            
            self.elapsedTimeInSeconds += diff
        })
    }
}
