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
            randomTilesToggle = options.randomTiles
            randomNumbersToggle = options.randomNumbers
        }
        else {
            randomNumbersToggle = false
            randomTilesToggle = true
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
