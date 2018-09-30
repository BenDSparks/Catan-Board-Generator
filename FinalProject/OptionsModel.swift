//
//  OptionsModel.swift
//  FinalProject
//
//  Created by Ben Sparks on 12/11/17.
//  Copyright © 2017 UMSL. All rights reserved.
//

import Foundation


class OptionsModel {
    
    var randomNumbersToggle: Bool
    var randomTilesToggle: Bool
    let session: ApplicationSession
    
    
    init(session: ApplicationSession) {
        
        self.session = session
        
        if let options = self.session.optionsPersistence.getOptions() {
            print("retrived options from core data")
            randomTilesToggle = options.randomTiles
            randomNumbersToggle = options.randomNumbers
            session.getOptionsFromCoreData()
        }
        else {
            randomNumbersToggle = false
            randomTilesToggle = true
            
            //create and save options for first time.
            print("creating options in core data")
            
            let options = OptionsData(randomNumbers: randomNumbersToggle, randomTiles: randomTilesToggle)
            
            let semaphore = DispatchSemaphore(value: 0)
            session.optionsPersistence.setOptions(optionsData: options) {
                semaphore.signal()
            }
            if semaphore.wait(timeout: .now() + 3) == .timedOut {
                print("semaphore timeout after setOptions call in OptionsModel")
            }
            
            session.getOptionsFromCoreData()
            
        }
        
        

    }
    
    func toggleRandomNumbers(){
        if randomNumbersToggle {
            randomNumbersToggle = false
        }
        else {
            randomNumbersToggle = true
        }
        
        let options = OptionsData(randomNumbers: randomNumbersToggle, randomTiles: randomTilesToggle)
        
        session.optionsPersistence.setOptions(optionsData: options) {
        }
        
    }
    
    func toggleTilesNumbers(){
        if randomTilesToggle {
            randomTilesToggle = false
        }
        else {
            randomTilesToggle = true
        }
        
        let options = OptionsData(randomNumbers: randomNumbersToggle, randomTiles: randomTilesToggle)
        
        session.optionsPersistence.setOptions(optionsData: options) {
        }
        
    }
    
    
}
