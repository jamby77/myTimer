//
//  Int+Extension.swift
//  TimerDemo
//
//  Created by Aryaman Sharda on 2/20/23.
//

import Foundation

extension Float {
    var asTimestamp: String {
        let timeInMs = Int(self * 1000)
        
        let hour = (timeInMs/1000) / 3600
        let minute = (timeInMs/1000) / 60 % 60
        let second = (timeInMs/1000) % 60
        let ms = timeInMs % 1000
        
        print(self, timeInMs, hour, minute, second, ms)

        return String(format: "%02i:%02i:%02i,%02i", hour, minute, second, ms)
    }
}
