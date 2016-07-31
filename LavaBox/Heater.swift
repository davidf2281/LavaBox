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
    var maxOutputPower : Watts
    
    var on : Bool = false
    
    init(maxOutputPower : Watts)
    {
        self.maxOutputPower = maxOutputPower
    }
    
    func switchOn()
    {
        self.on = true
    }
    
    func switchOff()
    {
        self.on = false
    }
    
    func currentOuputPower() -> Watts
    {
        return self.on ? self.maxOutputPower : 0
    }
}
