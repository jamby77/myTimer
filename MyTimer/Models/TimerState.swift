//
//  TimerState.swift
//  MyTimer
//
//  Created by Petar Dzhambazov on 6.01.24.
//

import Foundation

enum TimerState {
    case active
    case paused
    case resumed
    case canceled
    case finished
}


enum StopwatchState {
    case active
    case paused
    case resumed
    case canceled
    case finished
}

enum WorkRestState {
    case work
    case rest
    case pauseWork
    case pauseRest
    case resumeWork
    case resumeRest
    case canceled
    case finished
}
