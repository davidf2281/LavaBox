//
//  TemperatureDataPoint.swift
//  LavaBox
//
//  Created by David Fearon on 31/07/2016.
//  Copyright © 2016 David Fearon. All rights reserved.
//

import Cocoa

class TemperatureDataPoint : Equatable
{
    var time : TimeInterval
    var temperature : Celsius
    
    init(time: TimeInterval, temperature : Celsius)
    {
        self.time = time
        self.temperature = temperature
    }
}

func ==(lhs: TemperatureDataPoint, rhs: TemperatureDataPoint) -> Bool {
    return lhs === rhs
}
