//
//  GO2DRepresentation.swift
//  GridOptic
//
//  Created by Wang Jinghan on 30/03/15.
//  Copyright (c) 2015 Echx. All rights reserved.
//

import UIKit

class GOSegment : NSObject, NSCoding {
    //if both are true, only take refract (ignore the reflect ray)
    var willRefract: Bool = false
    var willReflect: Bool = false
    var center: CGPoint = CGPointZero
    var tag: NSInteger = 0
    var bezierPath: UIBezierPath {
        get {
            fatalError("Property bezierPath need to be overriden by child classes")
        }
    }
    var parent: String = ""
    
    //angle should be within [0, 2PI) from
    var direction: CGVector = CGVector(dx: 0, dy: 1)
    var normalDirection: CGVector {
        set {
            self.direction = CGVectorMake(-newValue.dy, newValue.dx)
        }
        get {
            return CGVectorMake(self.direction.dy, -self.direction.dx)
        }
    }
    var startPoint: CGPoint {
        get {
            fatalError("startPoint needed by overriden by child classes")
        }
    }
    
    var endPoint: CGPoint {
        get {
            fatalError("endPoint needed by overriden by child classes")
        }
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let willRefract = aDecoder.decodeBoolForKey(GOCodingKey.segment_willRef)
        let willReflect = aDecoder.decodeBoolForKey(GOCodingKey.segment_willRel)
        
        let center = aDecoder.decodeCGPointForKey(GOCodingKey.segment_center)
        let tag = aDecoder.decodeObjectForKey(GOCodingKey.segment_tag) as NSInteger
        
        let parent = aDecoder.decodeObjectForKey(GOCodingKey.segment_parent) as String
        
        let direction = aDecoder.decodeCGVectorForKey(GOCodingKey.segment_direction)
        
        self.init()
        self.willReflect = willReflect
        self.willRefract = willRefract
        self.center = center
        self.tag = tag
        self.parent = parent
        self.direction = direction
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeBool(willRefract, forKey: GOCodingKey.segment_willRef)
        aCoder.encodeBool(willReflect, forKey: GOCodingKey.segment_willRel)
        aCoder.encodeCGPoint(center, forKey: GOCodingKey.segment_center)
        aCoder.encodeCGVector(direction, forKey: GOCodingKey.segment_direction)
        aCoder.encodeObject(tag, forKey: GOCodingKey.segment_tag)
        aCoder.encodeObject(parent, forKey: GOCodingKey.segment_parent)
    }
    
    func getIntersectionPoint(ray: GORay) -> CGPoint? {
        fatalError("getIntersectionPoint must by overriden")
    }
    
    func isIntersectedWithRay(ray: GORay) -> Bool {
        return self.getIntersectionPoint(ray) != nil
    }
    
    func getOutcomeRay(#rayIn: GORay, indexIn: CGFloat, indexOut: CGFloat) -> GORay? {
        if self.willRefract {
            return self.getRefractionRay(rayIn: rayIn, indexIn: indexIn, indexOut: indexOut)
        } else if self.willReflect {
            return self.getReflectionRay(rayIn: rayIn)
        } else {
            return nil
        }
    }
    
    func getRefractionRay(#rayIn: GORay, indexIn: CGFloat, indexOut: CGFloat) -> GORay? {
        return nil
    }
    
    func getReflectionRay(#rayIn: GORay) -> GORay? {
        return nil
    }
}
