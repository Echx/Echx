//
//  XEmitter.swift
//  Planck
//
//  Created by NULL on 11/04/15.
//  Copyright (c) 2015年 Echx. All rights reserved.
//

import UIKit

class XEmitter: XNode {
    init(emitter: GOEmitterRep) {
        super.init(physicsBody: emitter)
        self.strokeColor = DeviceColor.emitter
        self.instrument = NodeDefaults.instrumentNil
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let body = aDecoder.decodeObjectForKey("phyBody") as GOEmitterRep
        let isFixed = aDecoder.decodeBoolForKey("isFixed")
        let normalNote = aDecoder.decodeObjectForKey("normalNote") as XNote
        let planckNote = aDecoder.decodeObjectForKey("planckNote") as XNote
        
        self.init(emitter: body)
        self.isFixed = isFixed
        self.normalNote = normalNote
        self.planckNote = planckNote
    }
    
    override func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.physicsBody, forKey: "phyBody")
        aCoder.encodeBool(self.isFixed, forKey: "isFixed")
        aCoder.encodeObject(self.normalNote, forKey: "normalNote")
        aCoder.encodeObject(self.planckNote, forKey: "planckNote")
    }
}
