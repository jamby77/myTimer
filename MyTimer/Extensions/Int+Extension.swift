//
//  Int+Extension.swift
//  MyTimer
//
//  Created by Petar Dzhambazov on 17.01.24.
//

import Foundation

extension Int {
    var asTimestamp: String {
        let timeInMs = self
        
        let hour = (timeInMs/1000) / 3600
        let minute = (timeInMs/1000) / 60 % 60
        let second = (timeInMs/1000) % 60
        let ms = timeInMs % 1000 / 10
        
//        print(self, "total: ", timeInMs, "hour: ", hour, "min: ", minute, "sec: ", second, "ms: ", ms)
        if hour > 0 {
            return String(format: "%02d:%02d:%02d", hour, minute, second)
        }
        return String(format: "%02d:%02d,%02d", minute, second, ms)
    }
}
