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
                wallThickness : Metres
    
    private let thermalConductivity : Double
    
    /*
     The thermal conduction equation: Q/t = kA(T1 - T2)/d relies on what is effectively the
     constant kA/d (a constant for any given container). Nudge factor is a coefficient that
     nudges the value of kA/d to match empirically derived values, 
     set via the calibrateForMeasuredEnergyLoss() function.
     */
    private var nudgeFactor : Double = 1
    
    private var kAByD : Double
    {
        return self.thermalConductivity * self.surfaceArea / self.wallThickness
    }
    
    private var volume : CubicMetres
    {
        return externalLength * externalWidth * externalHeight
    }

    private var surfaceArea : SquareMetres
    {
        return (externalLength * externalWidth * 2) + (externalLength * externalHeight * 2) + (externalWidth * externalHeight * 2)
    }
    
    init(externalLength : Metres, externalWidth : Metres, externalHeight : Metres, wallThickness : Metres, thermalConductivity : Double)
    {
        self.externalLength = externalLength
        self.externalWidth =  externalWidth
        self.externalHeight = externalHeight
        self.wallThickness =  wallThickness
        self.thermalConductivity = thermalConductivity
    }
    
    func calibrateForMeasuredEnergyLoss(energyLoss : Joules, time : TimeInterval, externalTemperature : Celsius, internalTemperature : Celsius)
    {
        let empiricalPowerLoss = energyLoss / time;
        
        let calculatedPowerLoss = self.powerLoss(internalTemperature: internalTemperature, externalTemperature: externalTemperature)
        
        let nudgeFactor = empiricalPowerLoss / calculatedPowerLoss
        
        self.nudgeFactor = nudgeFactor
    }
    
    func powerLoss(internalTemperature : Celsius, externalTemperature : Celsius) -> Watts
    {
        // Return Q/t = kA(T1 - T2)/d = kA / d * (T1 - T2), compensated for by empirical nudge factor
        return self.kAByD * (internalTemperature - externalTemperature) * self.nudgeFactor
    }
}
