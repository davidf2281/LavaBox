//
//  HeaterController.swift
//  LavaBox
//
//  Created by David Fearon on 31/07/2016.
//  Copyright © 2016 David Fearon. All rights reserved.
//

import Cocoa

class HeaterController : SimulatorUpdateDelegate
{
    let heater : Heater
    
    var temperatureTarget : Celsius
    
    init(heater : Heater, temperatureTarget : Celsius)
    {
        self.heater = heater
        self.temperatureTarget = temperatureTarget
    }
    
    func simulatorDidUpdateSimulationWithWaterTemperature(temperature: Watts, time: TimeInterval)
    {
        if temperature > self.temperatureTarget + 0.5
        {
            self.heater.switchOff()
        }
        else if temperature < self.temperatureTarget - 0.5
        {
            self.heater.switchOn()
        }
    }
}
