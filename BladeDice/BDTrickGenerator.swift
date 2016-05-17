//
//  BDTrickGenerator.swift
//  BladeDice
//
//  Created by Juho Pispa on 17.5.2016.
//  Copyright © 2016 Juho Pispa. All rights reserved.
//

import Foundation

class TrickGenerator {
    static let soulTricks = ["Soul",
                      "Acid",
                      "Makio",
                      "Mizou",
                      "Pornstar",
                      "X-Grind"]
    
    static let hBlockTricks = ["Unity",
                        "Savannah",
                        "Nugen",
                        "Torque",
                        "Royale",
                        "Backslide"]
    
    static let randomTricks = ["Fastslide",
                        "Pudslide",
                        "BynSoul",
                        "Cowboy",
                        "Bullshit"]
    
    static let soulSpins = ["AlleyOop",
                     "TrueSpin",
                     "Inspin",
                     "Outspin",
                     "Zerospin"]
    
    static let hBlockSpins = ["270",
                       "Fakie 270"]
    
    
    static func generateRandomTrick() -> [String:String]{
        let random = Int(arc4random_uniform(2))
        
        var trickDict = [String:String]()
        
        if(random == 0) {
            trickDict = generateTrick(true, spins: soulSpins, trickNames: soulTricks)
        }
        else {
            trickDict = generateTrick(false, spins: hBlockSpins, trickNames: hBlockTricks)
        }
        
        return trickDict
    }
    
    
    static func generateTrick(soulTrick: Bool, spins: [String], trickNames: [String]) -> [String:String] {
        var trickDict = [String:String]()
        let randomSide = Int(arc4random_uniform(2))
        var side = "-"
        if(soulTrick && randomSide == 1) {
            side = "Topside"
        }
        else if(!soulTrick) {
            side = "Frontside"
            if(randomSide == 1) {
                side = "Backside"
            }
        }
        
        let randomSpinIndex = Int(arc4random_uniform(UInt32(spins.count)))
        trickDict[Constants.spinKey] = spins[randomSpinIndex]
        
        trickDict[Constants.sideKey] = side
        
        let randomTrickIndex = Int(arc4random_uniform(UInt32(trickNames.count)))
        trickDict[Constants.trickNameKey] = trickNames[randomTrickIndex]
        
        return trickDict
    }
    
    //    func generateHBlockTrick() -> [String:String] {
    //        var trickDict = [String:String]()
    //        let randomSpinIndex = Int(arc4random_uniform(UInt32(hBlockSpins.count)))
    //        trickDict["spin"] = hBlockSpins[randomSpinIndex]
    //
    //        let randomSide = Int(arc4random_uniform(2))
    //        var side = "Frontside"
    //        if(randomSide == 1) {
    //            side = "Backside"
    //        }
    //        trickDict["side"] = side
    //
    //        let randomTrickIndex = Int(arc4random_uniform(UInt32(hBlockTricks.count)))
    //        trickDict["trickName"] = hBlockTricks[randomTrickIndex]
    //
    //        return trickDict
    //    }
    //
    //    func generateSoulTrick() -> [String:String] {
    //        var trickDict = [String:String]()
    //        let randomSpinIndex = Int(arc4random_uniform(UInt32(soulSpins.count)))
    //        trickDict["spin"] = soulSpins[randomSpinIndex]
    //
    //        let randomSide = Int(arc4random_uniform(2))
    //        var side = "Topside"
    //
    //        if(randomSide == 1) {
    //            side = "-"
    //        }
    //        trickDict["side"] = side
    //
    //        let randomTrickIndex = Int(arc4random_uniform(UInt32(soulTricks.count)))
    //        trickDict["trickName"] = soulTricks[randomTrickIndex]
    //        
    //        return trickDict
    //    }

}





