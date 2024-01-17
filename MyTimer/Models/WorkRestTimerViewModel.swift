//
//  WorkRestTimerModel.swift
//  MyTimer
//
//  Created by Petar Dzhambazov on 6.01.24.
//

import SwiftUI

class WorkRestTimerViewModel: ObservableObject {
    
    // MARK: Private properties
    private var timer = Timer()
    
    private var startDate: Date = Date.now
    
    // MARK: Public properties
    // Powers the ProgressView
    @Published var elapsedTimeInMilliseconds: Int = 0
    @Published var totalRestTimeInMilliseconds: Int = 0
    
    @Published var state: WorkRestState = .canceled {
        didSet {
            switch state {
            case .canceled, .finished:
                // cancel timer and reset
                timer.invalidate()
                elapsedTimeInMilliseconds = 0
                
            case .work:
                // start work timer
                startWorkTimer()
            case .rest:
                // start rest timer
                timer.invalidate()
                startRestTimer(with: elapsedTimeInMilliseconds)
            case .pauseWork, .pauseRest:
                timer.invalidate()
            case .resumeWork:
                // Resumes work timer
                startWorkTimer(with: elapsedTimeInMilliseconds)
            case .resumeRest:
                // resume rest timer
                startRestTimer(with: totalRestTimeInMilliseconds)
            }
        }
    }
    
    
    var displayTimeInMs: Int  {
        switch state {
        case .work, .pauseWork, .resumeWork:
            elapsedTimeInMilliseconds
        case .rest, .pauseRest, .resumeRest:
            totalRestTimeInMilliseconds
        case .canceled, .finished:
            0
        }
    }
    
    var displayColor: Color  {
        switch state {
        case .work, .pauseWork, .resumeWork:
            Color.green
        case .rest, .pauseRest, .resumeRest:
            Color.orange
        case .canceled, .finished:
            Color.black
        }
    }
    
    private func startRestTimer(with restTimeInMs: Int = 0) {
        startDate = Date.now
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] _ in
            guard let self else { return }
            let diff = Date.now.timeIntervalSince(startDate)
            
//            self.secondsToCompletion -= 0.1
            self.totalRestTimeInMilliseconds = restTimeInMs - Int(diff * 1000)
            
            if self.totalRestTimeInMilliseconds < 0 {
                self.state = .finished
            }
//            print("diff: \(diff)", "time: \(totalRestTimeInMilliseconds)")
        })
    }
    
    private func startWorkTimer(with prevTimeInMs: Int = 0) {
        startDate = Date.now
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] _ in
            guard let self else { return }
            let diff = Date.now.timeIntervalSince(startDate)
            
            self.elapsedTimeInMilliseconds = prevTimeInMs + Int(diff * 1000)
//            print("diff: \(diff)", "time: \(elapsedTimeInMilliseconds)")
        })
    }
}
