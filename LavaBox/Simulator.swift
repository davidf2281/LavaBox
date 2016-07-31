//
//  Simulator.swift
//  LavaBox
//
//  Created by David Fearon on 26/07/2016.
//  Copyright © 2016 David Fearon. All rights reserved.
//

import Cocoa

protocol SimulatorUpdateDelegate
{
    func simulatorDidUpdateSimulationWithWaterTemperature(temperature : Celsius, time : TimeInterval)
}

class Simulator
{
    private let container : Container
    private let waterBody : WaterBody
    private let heater    : Heater
 
    var delegate : SimulatorUpdateDelegate
    
    init(container : Container, waterBody : WaterBody, heater : Heater, heaterController : HeaterController)
    {
        self.container = container
        self.waterBody = waterBody
        self.heater = heater
        delegate = heaterController
    }
    
    func simulate(timeStep : TimeInterval, duration : TimeInterval, externalTemperature : Celsius) -> [TemperatureDataPoint]
    {
        var results = [TemperatureDataPoint]()
        
        self.heater.switchOn()

        var currentTime : TimeInterval = 0
        
        var temperatureAveragingAccumulator : Celsius = 0
        
        var loops : Int = 0
        
        while (currentTime < duration)
        {
            // 1: Calculate notional temperature of water for given input energy with no losses
            let heaterOutput = self.heater.currentOutputPower
            let inputEnergy = heaterOutput * timeStep
            let temperatureChangeForEnergyInput = self.waterBody.temperatureChangeForInputEnergy(inputEnergy: inputEnergy)
            
            // 2: Calculate energy lost to environment for given average temperature change for this timestep
            let averageTemperature = self.waterBody.temperature + (temperatureChangeForEnergyInput / 2)
            let powerLoss = self.container.powerLoss(internalTemperature:averageTemperature, externalTemperature: externalTemperature)
            let energyLoss = powerLoss * timeStep
            
            // 3: Set water temperature for overall net energy input
            let netInputEnergy = inputEnergy - energyLoss
            let overallTemperatureChange = self.waterBody.temperatureChangeForInputEnergy(inputEnergy: netInputEnergy)
            let finalTemperature = self.waterBody.temperature + overallTemperatureChange
            self.waterBody.temperature = finalTemperature
            
            // 4: Record our data point
            results.append(TemperatureDataPoint(time: currentTime, temperature: finalTemperature))
            
            // 5: Inform heater of current time and water temperature
            self.delegate.simulatorDidUpdateSimulationWithWaterTemperature(temperature: self.waterBody.temperature, time: currentTime)
            
            temperatureAveragingAccumulator += finalTemperature
            loops += 1
            
            currentTime = currentTime + timeStep
        }

        print("Final temperature: \(self.waterBody.temperature)")
        print("Average temperature: \(temperatureAveragingAccumulator / Double(loops))")

        
        self.heater.switchOff() // We mustn't waste energy
        
        return results
    }
}
