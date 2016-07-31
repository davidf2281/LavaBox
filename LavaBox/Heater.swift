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
    private let maxOutputPower : Watts
    
    private var outputPowerSetPoint : Watts
    
    private var on : Bool

    var currentOutputPower : Watts
    {
        return self.on ? self.outputPowerSetPoint : 0
    }
    
    init(maxOutputPower : Watts)
    {
        self.maxOutputPower = maxOutputPower
        self.outputPowerSetPoint = maxOutputPower
        self.on = false
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
