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
    
    private(set) var on : Bool
    
    var outputPowerSetPoint: Watts
    {
        didSet {
            outputPowerSetPoint = (outputPowerSetPoint > self.maxOutputPower) ?
                maxOutputPower :
                (outputPowerSetPoint < 0) ? 0 : outputPowerSetPoint
        }
    }
    
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
}
