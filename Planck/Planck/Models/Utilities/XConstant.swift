//
//  Constant.swift
//  Planck
//
//  Created by Lei Mingyu on 10/03/15.
//  Copyright (c) 2015 Echx. All rights reserved.
//

import UIKit

struct Constant {
    static let lightSpeedBase: CGFloat = 600 //points per second
    static let audioDelay: CGFloat = 0.1
    static let angleCalculationPrecision: CGFloat = 1000 //1000 is 3 bit precision
    
    static let vectorUnitLength: CGFloat = 1
}

struct DeviceColor {
    static let mirror = UIColor.whiteColor()
    static let lens = UIColor(red: 190/255.0, green: 1, blue: 1, alpha: 1)
    static let wall = UIColor.blackColor()
    static let planck = UIColor.yellowColor()
    static let emitter = UIColor.greenColor()
}

struct StoryboardIndentifier {
    static let StoryBoardID = "Main"
    static let Home = "HomeViewController"
    static let LevelDesigner = "LevelDesignerViewController"
    static let Setting = "SettingViewController"
    static let Game = "GameViewController"
    static let LevelSelect = "LevelSelectViewController"
    static let DesignerLevelSelect = "DesignerLevelSelectViewController"
}

struct ReuseableID {
    static let LevelSelectCell = "LevelSelectCell"
    static let LevelSelectHeader = "LevelSelectHeader"
}

struct StorageDefault {
    static let levelDataType = "dat"
}

struct NSCodingKey {
    static let ColorRed = "RED"
    static let ColorGreen = "GREEN"
    static let ColorBlue = "BLUE"
    
    static let Position = "POSITION"
    static let Direction = "DIRECTION"
    static let ApperanceColor = "APPERANCE_COLOR"
    static let Medium1 = "MEDIUM1"
    static let Medium2 = "MEDIUM2"
    
    static let Focus = "FOCUS"
    static let ColorMapping = "COLOR_MAPPING"

    static let CanFire = "CAN_FIRE"
    
    static let NoteName = "NOTENAME"
    static let NoteGroup = "NOTEGRP"
    static let isPitchedNote = "ISPITCH"
}

struct ActionKey {
    static let photonActionLinear = "PHOTON_ACTION_KEY_LINEAR"
    static let nodeActionShake = "NODE_ACTION_KEY_SHAKE"
}

struct NodeName {
    static let xPhoton = "X_PHOTON"
}

struct InstrumentDefaults {
    static let direction = CGVectorMake(0, 1)
}

struct PhotonDefaults {
    static let diameter: CGFloat = 1    //measured in points
    static let illuminance: CGFloat = 1.0   //0.0 to 1.0
    static let appearanceColor = XColor()
    static let direction = CGVector.zeroVector
    static let textureImageName = "photon"
    static let textureColor = UIColor.blackColor()
}

struct EmitterDefualts {
    static let nodeName = "emitter"
    static let textureImageName = "emitter"
    static let textureColor = UIColor.blackColor()
    static let diameter: CGFloat = 50
    static let fireFrequency: Double = 10 //measured in photons/second
}

struct MirrorDefaults {
    static let flatMirrorSize = CGSizeMake(20, 100)
    static let textureColor = UIColor.blackColor()
}

struct InterfaceDefaults {
    static let thickness: CGFloat = 2
    static let length: CGFloat = 200
    static let color = UIColor.blackColor()
}

struct LensDefaults {
    static let flatLenSize = CGSizeMake(30, 80)
    static let flatLenColor = UIColor.greenColor()
    
    static let convexLenSize = CGSizeMake(20, 100)
    static let textureColor = UIColor.greenColor()
}

struct WallDefaults {
    static let wallSize = CGSizeMake(20, 500)
    static let textureColor = UIColor.blackColor()
}

struct PlanckDefaults {
    static let textureImageName = "planck-c5"
    static let planckRadius: CGFloat = 40
    static let planckPhisicsRadius: CGFloat = 30
    static let planckSize = CGSizeMake(PlanckDefaults.planckRadius * 2, PlanckDefaults.planckRadius * 2)
    static let textureColor = UIColor.blackColor()
}

struct PhysicsCategory {
    static let none: UInt32 = 0
    static let all: UInt32 = 0x1 << 31
    static let photon: UInt32 = 0x1 << 0
    static let flatMirror: UInt32 = 0x1 << 1
    static let planck: UInt32 = 0x1 << 2
    static let wall: UInt32 = 0x1 << 3
    static let interface: UInt32 = 0x1 << 4
    static let flatLen: UInt32 = 0x1 << 5
    static let convexLen: UInt32 = 0x1 << 6
}

struct MediumDescription {
    static let vacuumDescription: String = "Vacuum is space that is devoid of matter."
    static let airDesciption: String = "Air is a layer of gases surrounding the planet Earth that is retained by Earth's gravity."
    static let waterDescription: String = "Water is a transparent fluid which forms the world's streams, lakes, oceans and rain."
    static let oliveOilDescription: String = "Olive oil is a fat obtained from the the fruit of Olea europaea, a traditional tree crop of the Mediterranean Basin."
    static let crownGlassDescription: String = "Crown glass is a type of optical glass used in lenses and other optical components. It has relatively low refractive index (≈1.52) and low dispersion (with Abbe numbers around 60). Crown glass is produced from alkali-lime (RCH) silicates containing approximately 10% potassium oxide and is one of the earliest low dispersion glasses."
    static let flintGlassDescription: String = "Flint glass is optical glass that has relatively high refractive index and low Abbe number (high dispersion). Flint glasses are arbitrarily defined as having an Abbe number of 50 to 55 or less. The currently known flint glasses have refractive indices ranging between 1.45 and 2.00."
}

struct LevelDesignerDefaults {
    static let selectorButtonClicked: Selector = "buttonDidClicked:"
    static let selectorFunctionalButtonClicked: Selector = "functionalButtonDidClicked:"
    
    static let buttonHeight: CGFloat = 60;
    static let buttonBackgroundColor: UIColor = UIColor.darkGrayColor()
    static let buttonLabelColor: UIColor = UIColor.lightGrayColor()
    
    static let interButtonSpace: CGFloat = 5;
    
    static let buttonNames = ["flat mirror", "emitter", "wall", "planck", "interface", "eraser", "clear", "save", "load"]
    static let buttonNameFlatMirror = LevelDesignerDefaults.buttonNames[0]
    static let buttonNameEmitter = LevelDesignerDefaults.buttonNames[1]
    static let buttonNameWall = LevelDesignerDefaults.buttonNames[2]
    static let buttonNamePlanck = LevelDesignerDefaults.buttonNames[3]
    static let buttonNameInterface = LevelDesignerDefaults.buttonNames[4]
    static let buttonNameEraser = LevelDesignerDefaults.buttonNames[5]
    static let buttonNameClear = LevelDesignerDefaults.buttonNames[6]
    static let buttonNameSave = LevelDesignerDefaults.buttonNames[7]
    static let buttonNameLoad = LevelDesignerDefaults.buttonNames[8]

    
    static let functionalButtonNames = ["add item"]
    static let functionalButtonNameAddItem = LevelDesignerDefaults.functionalButtonNames[0]
    
    static let eraserSize: CGFloat = 20;
    static let selectionAreaSize: CGFloat = 20;
}

struct SoundFiles {
    static let snareDrumSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("snare-drum", ofType: "m4a")!)
    static let bassDrumSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bass-drum", ofType: "m4a")!)
    static let cymbalSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cymbal", ofType: "m4a")!)
}

struct PlanckControllPanel {
    static let instrumentPickerTag = 0
    static let notePickerTag = 1
    static let accidentalPickerTag = 2
    static let groupPickerTag = 3
    
    static let instrumentPickerTitle = ["inherit", "nil", "piano", "guitar"]
    static let notePickerTitle = ["A", "B", "C", "D", "E", "F", "G"]
//    static let accidentalPickerTitle = ["♮", "♯", "♭", "𝄪", "𝄫"]
    static let accidentalPickerTitle = ["♮", "♯", "♭", "x", "♭♭"]
    static let groupPickerTitle = ["0", "1", "2", "3", "4", "5", "6", "7"]
}