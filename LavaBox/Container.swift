//
//  Container.swift
//  LavaBox
//
//  Created by David Fearon on 30/07/2016.
//  Copyright © 2016 David Fearon. All rights reserved.
//

import Cocoa

class Container
{
    private let externalLength,
                externalWidth,
                externalHeight,
                wallThickness,
                thermalConductivity : Float
    
    /*
     The thermal conduction equation: Q/t = kA(T1 - T2)/d relies on what is effectively the
     constant kA/d (a constant for any given container). Fudge factor is a coefficient that 
     nudges the value of kA/d to match empirically derived values, 
     set via the calibrateForMeasuredEnergyLoss() function.
     */
    private var fudgeFactor : Float = 1
    
    private var kAByD : Float
    {
        return self.thermalConductivity * self.surfaceArea / self.wallThickness
    }
    
    private var volume : Float
    {
        return externalLength * externalWidth * externalHeight
    }

    internal var surfaceArea : Float
    {
        return (externalLength * externalWidth * 2) + (externalLength * externalHeight * 2) + (externalWidth * externalHeight * 2)
    }
    
    init(externalLength : Float, externalWidth : Float, externalHeight : Float, wallThickness : Float, thermalConductivity : Float)
    {
        self.externalLength = externalLength
        self.externalWidth =  externalWidth
        self.externalHeight = externalHeight
        self.wallThickness =  wallThickness
        self.thermalConductivity = thermalConductivity
    }
    
    func calibrateForMeasuredEnergyLoss(energyLoss : Float, time : TimeInterval, externalTemperature : Float, internalTemperature : Float)
    {
        let empiricalPowerLoss = energyLoss / Float(time);
        
        let calculatedPowerLoss = self.powerLoss(internalTemperature: internalTemperature, externalTemperature: externalTemperature)
        
        let fudgeFactor = empiricalPowerLoss / calculatedPowerLoss
        
        self.fudgeFactor = fudgeFactor
    }
    
    func powerLoss(internalTemperature : Float, externalTemperature : Float) -> Float
    {
        // Return Q/t = kA(T1 - T2)/d = kA / d * (T1 - T2), compensated for by empirical fudge factor
        return self.kAByD * (internalTemperature - externalTemperature) * self.fudgeFactor
    }
}
