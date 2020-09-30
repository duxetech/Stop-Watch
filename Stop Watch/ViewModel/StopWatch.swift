//
//  TimeEngine.swift
//  Stop Watch
//
//  Created by Karthik on 9/25/20.
//  Copyright © 2020 Karthik. All rights reserved.
//

import Foundation

class StopWatch {
   
    var timer : Timer?
    var laps : [String] = []

    var currentTime : Time!
    var totalTime = 0
    
    var notStarted = true
    var timeString = "00:00.00"
    
    var lastLapTime = 0
    var currentLapTime = 0
    var interval : Double = 1/60
    
    init(currentTime:Time) {
        self.currentTime=currentTime
    }
  

    func updateTimer() {
        totalTime += 1
        currentTime = convertTime(time: totalTime)
    }
    
    func convertTime(time : Int)->Time {
         
        let min = time /  3600
        let s = time % 3600
        let sec = s / 60
        let micro = s % 60
        return Time(micro: micro, second: sec, minute: min)
        
    }
    
    func formatTime(time:Time)->String{
        let t = time.micro > 9 ? "\(time.micro)" : "0\(time.micro)"
        let m = time.minute > 9 ? "\(time.minute)" : "0\(time.minute)"
        let s = time.second > 9 ? "\(time.second)" : "0\(time.second)"
        
        return  m+":"+s+"."+t

    }
    
    func resetTime(){
        totalTime = 0
        lastLapTime = 0
        currentLapTime = 0
        currentTime = convertTime(time:0)
        laps.removeAll()
    }
    


}
