//
//  Simulator.swift
//  LavaBox
//
//  Created by David Fearon on 26/07/2016.
//  Copyright © 2016 David Fearon. All rights reserved.
//

import Cocoa

class Simulator
{
    private let container : Container
    private let waterBody : WaterBody
    private let heater    : Heater
    
    init(container : Container, waterBody : WaterBody, heater : Heater)
    {
        self.container = container
        self.waterBody = waterBody
        self.heater = heater
    }
    
    func simulate(timeStep : TimeInterval, duration : TimeInterval, externalTemperature : Celsius) -> [TemperatureDataPoint]
    {
        var results = [TemperatureDataPoint]()
        
        self.heater.switchOn()

        var currentTime : TimeInterval = 0
        
        while (currentTime < duration)
        {
            // 1: Calculate notional temperature of water for given input energy with no losses
            let heaterOutput = self.heater.currentOuputPower()
            let inputEnergy = heaterOutput * timeStep
            let temperatureChangeForEnergyInput = self.waterBody.temperatureChangeForInputEnergy(inputEnergy: inputEnergy)
            
            // 2: Calculate energy lost to environment for given average temperature change for this timestep
            let averageTemperature = self.waterBody.temperature + (temperatureChangeForEnergyInput / 2)
            let powerLoss = self.container.powerLoss(internalTemperature:averageTemperature, externalTemperature: externalTemperature)
            let energyLoss = powerLoss * timeStep
            
            // 3: Set water temperature for overall net energy input
            let netInputEnergy = inputEnergy - energyLoss
            let overallTemperatureChange = self.waterBody.temperatureChangeForInputEnergy(inputEnergy: netInputEnergy)
            self.waterBody.temperature = self.waterBody.temperature + overallTemperatureChange
            
            // 4: Record our data point
            results.append(TemperatureDataPoint(time: currentTime, temperature: self.waterBody.temperature))
            
            // 5: Inform heater of current time and water temperature
            // TODO:
            
            // print("inputEnergy : \(inputEnergy), temperatureChangeForEnergyInput: \(temperatureChangeForEnergyInput), averageTemperature:\(averageTemperature), energyLoss:\(energyLoss)")
            
            currentTime = currentTime + timeStep
        }

        print("Final temperature: \(self.waterBody.temperature)")
        
        self.heater.switchOff() // We mustn't waste energy
        
        return results
    }
}
