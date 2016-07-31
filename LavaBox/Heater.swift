//
//  Heater.swift
//  LavaBox
//
//  Created by David Fearon on 26/07/2016.
//  Copyright © 2016 David Fearon. All rights reserved.
//

import Cocoa

class Heater
{
    let maxOutputPower : Watts
    
    var outputPowerSetPoint : Watts
    
    var currentOutputPower : Watts
    {
        return self.on ? self.outputPowerSetPoint : 0
    }
    
    var on : Bool = false
    
    init(maxOutputPower : Watts)
    {
        self.maxOutputPower = maxOutputPower
        self.outputPowerSetPoint = maxOutputPower
    }
    
    func switchOn()
    {
        self.on = true
    }
    
    func switchOff()
    {
        self.on = false
    }
    
    func setOutputPowerSetPoint(power: Watts)
    {
        self.outputPowerSetPoint = (power > self.maxOutputPower) ? self.maxOutputPower : (power < 0) ? 0 : power
    }
}
