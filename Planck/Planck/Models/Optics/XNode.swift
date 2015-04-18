//
//  XNode.swift
//  Planck
//
//  Created by Wang Jinghan on 10/04/15.
//  Copyright (c) 2015 Echx. All rights reserved.
//

import UIKit

class XNode: NSObject, NSCoding {
    var physicsBody: GOOpticRep
    var instrument: Int = NodeDefaults.instrumentInherit
    
    var isPlanck: Bool {
        get {
            if (self.instrument == NodeDefaults.instrumentInherit) || (self.instrument == NodeDefaults.instrumentNil) {
                return false
            } else {
                return true
            }
        }
    }
    var shouldPlaySound: Bool {
        get {
            if self.instrument == NodeDefaults.instrumentNil {
                return false
            } else {
                return true
            }
        }
    }
    
    var strokeColor = UIColor.whiteColor()
    var normalNote: XNote?
    var planckNote: XNote?
    var isFixed = true
    
    var id: String {
        get {
            return self.physicsBody.id
        }
    }
    
    init(physicsBody: GOOpticRep) {
        self.physicsBody = physicsBody
        super.init()
    }
    
    func getSound() -> NSURL? {
        if !self.shouldPlaySound {
            return nil
        } else {
            return self.getNote()?.getAudioFile()
        }
    }
    
    func getNote() -> XNote? {
        if !self.shouldPlaySound {
            return nil
        } else if self.isPlanck {
            return self.planckNote
        } else {
            return self.normalNote
        }
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let body = aDecoder.decodeObjectForKey(NSCodingKey.XNodeBody) as GOOpticRep
        let isFixed = aDecoder.decodeBoolForKey(NSCodingKey.XNodeFixed)
        let planckNote = aDecoder.decodeObjectForKey(NSCodingKey.XNodePlanck) as XNote?
        let instrument = aDecoder.decodeObjectForKey(NSCodingKey.XNodeInstrument) as Int

        self.init(physicsBody: body)
        self.isFixed = isFixed
        self.instrument = instrument
        self.planckNote = planckNote
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.physicsBody, forKey: NSCodingKey.XNodeBody)
        aCoder.encodeBool(self.isFixed, forKey: NSCodingKey.XNodeFixed)
        aCoder.encodeObject(self.instrument, forKey: NSCodingKey.XNodeInstrument)
        if self.planckNote != nil {
            aCoder.encodeObject(self.planckNote, forKey: NSCodingKey.XNodePlanck)
        }
    }
}
