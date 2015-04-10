//
//  GameViewController.swift
//  Planck
//
//  Created by Wang Jinghan on 07/04/15.
//  Copyright (c) 2015 Echx. All rights reserved.
//

import UIKit

class GameViewController: XViewController {

    @IBOutlet var shootSwitch: UISwitch!
    
    var gameLevel: GameLevel = GameLevel()
    private var rayLayers = [String: [CAShapeLayer]]()
    private var rays = [String: [CGPoint]]()
    private var audioPlayerList = [AVAudioPlayer]()
    
    private var grid: GOGrid {
        get {
            return gameLevel.grid
        }
    }
    private var xNodes : [String: XNode] {
        get {
            return gameLevel.xNodes
        }
    }
    
    private var deviceViews = [String: UIView]()
    
    class func getInstance(gameLevel: GameLevel) -> GameViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let identifier = StoryboardIndentifier.Game
        let viewController = storyboard.instantiateViewControllerWithIdentifier(identifier) as GameViewController
        viewController.gameLevel = gameLevel
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpGrid()
        self.grid.delegate = self
    }
    
    @IBAction func switchValueDidChange(sender: UISwitch) {
        if sender.on {
            self.shootRay()
        } else {
            self.clearRay()
        }
    }
    
    private func setUpGrid() {
        for (key, node) in self.grid.instruments {
            self.addNode(node, strokeColor: self.xNodes[node.id]!.strokeColor)
        }
    }
    
    private func shootRay() {
        self.clearRay()
        for (name, item) in self.grid.instruments {
            if let item = item as? GOEmitterRep {
                self.addRay(item.getRay())
            }
            
        }
    }
    
    private func addRay(ray: GORay) {
        var newTag = String.generateRandomString(20)
        self.rays[newTag] = [CGPoint]()
        self.rayLayers[newTag] = [CAShapeLayer]()
        
        self.grid.startCriticalPointsCalculationWithRay(ray, withTag: newTag)
    }
    
    private func clearRay() {
        self.grid.stopSubsequentCalculation()
        for (key, layers) in self.rayLayers {
            for layer in layers {
                layer.removeFromSuperlayer()
            }
        }
        self.audioPlayerList.removeAll(keepCapacity: false)
        self.rayLayers = [String: [CAShapeLayer]]()
        self.rays = [String: [CGPoint]]()
    }
    
    private func drawRay(tag: String, currentIndex: Int) {
        dispatch_async(dispatch_get_main_queue()) {
            if self.rays.count == 0 {
                return
            }
            
            if currentIndex < self.rays[tag]?.count {
                let layer = CAShapeLayer()
                layer.strokeEnd = 1.0
                layer.strokeColor = UIColor.whiteColor().CGColor
                layer.fillColor = UIColor.clearColor().CGColor
                layer.lineWidth = 2.0
                
                self.rayLayers[tag]?.append(layer)
                
                var path = UIBezierPath()
                let rayPath = self.rays[tag]!
                let prevPoint = rayPath[currentIndex - 1]
                let currentPoint = rayPath[currentIndex]
                path.moveToPoint(prevPoint)
                path.addLineToPoint(currentPoint)
                let distance = prevPoint.getDistanceToPoint(currentPoint)
                layer.path = path.CGPath
                self.view.layer.addSublayer(layer)
                
                let delay = distance / Constant.lightSpeedBase
                
                let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
                pathAnimation.fromValue = 0.0;
                pathAnimation.toValue = 1.0;
                pathAnimation.duration = CFTimeInterval(delay);
                pathAnimation.repeatCount = 1.0
                pathAnimation.fillMode = kCAFillModeForwards
                pathAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
                
                layer.addAnimation(pathAnimation, forKey: "strokeEnd")
                if currentIndex > 1 {
                    self.processPoint(prevPoint)
                }
                
                let delayInNanoSeconds = 0.9 * delay * CGFloat(NSEC_PER_SEC);
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delayInNanoSeconds)), dispatch_get_main_queue()) {
                    self.drawRay(tag, currentIndex: currentIndex + 1)
                }
            }
        }
    }
    
    private func processPoints(points: [CGPoint]) {
        if points.count > 2 {
            var prevPoint = points[0]
            var distance: CGFloat = 0
            for i in 1...points.count - 1 {
                distance += points[i].getDistanceToPoint(prevPoint)
                prevPoint = points[i]
                if let physicsBody = self.grid.getInstrumentAtPoint(points[i]) {
                    if let device = xNodes[physicsBody.id] {
                        if let sound = device.getSound() {
                            let audioPlayer = AVAudioPlayer(contentsOfURL: sound, error: nil)
                            self.audioPlayerList.append(audioPlayer)
                            audioPlayer.prepareToPlay()
                            let wait = NSTimeInterval(distance / Constant.lightSpeedBase + Constant.audioDelay)
                            audioPlayer.playAtTime(wait + audioPlayer.deviceCurrentTime)
                        }
                    } else {
                        fatalError("The node for the physics body not existed")
                    }
                }
            }
        }
    }
    
    private func processPoint(currPoint: CGPoint) {
        if let physicsBody = self.grid.getInstrumentAtPoint(currPoint) {
            if let device = xNodes[physicsBody.id] {
                if let sound = device.getSound() {
                    let audioPlayer = AVAudioPlayer(contentsOfURL: sound, error: nil)
                    self.audioPlayerList.append(audioPlayer)
                    audioPlayer.prepareToPlay()
                    audioPlayer.play()
                }
            } else {
                fatalError("The node for the physics body not existed")
            }
        }
    }
    

    
    private func addNode(node: GOOpticRep, strokeColor: UIColor) -> Bool{
        var coordinateBackup = node.center
        node.setCenter(GOCoordinate(x: self.grid.width/2, y: self.grid.height/2))
        
        self.grid.addInstrument(node)
        let layer = CAShapeLayer()
        layer.strokeEnd = 1.0
        layer.strokeColor = strokeColor.CGColor
        layer.fillColor = UIColor.clearColor().CGColor
        layer.lineWidth = 2.0
        layer.path = self.grid.getInstrumentDisplayPathForID(node.id)?.CGPath
        
        let view = UIView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        view.backgroundColor = UIColor.clearColor()
        view.layer.addSublayer(layer)
        self.deviceViews[node.id] = view
        self.view.insertSubview(view, atIndex: 0)
        
        var offsetX = CGFloat(coordinateBackup.x - node.center.x) * self.grid.unitLength
        var offsetY = CGFloat(coordinateBackup.y - node.center.y) * self.grid.unitLength
        var offset = CGPointMake(offsetX, offsetY)
        
        if !self.moveNode(node, from: self.view.center, offset: offset) {
            view.removeFromSuperview()
            self.grid.removeInstrumentForID(node.id)
            return false
        }
        
        return true
    }

    private func moveNode(node: GOOpticRep, from: CGPoint,offset: CGPoint) -> Bool{
        let offsetX = offset.x
        let offsetY = offset.y
        
        let originalDisplayPoint = self.grid.getCenterForGridCell(node.center)
        let effectDisplayPoint = CGPointMake(originalDisplayPoint.x + offsetX, originalDisplayPoint.y + offsetY)
        
        let centerBackup = node.center
        
        //check whether the node will overlap with other nodes with the new center
        node.setCenter(self.grid.getGridCoordinateForPoint(effectDisplayPoint))
        if self.grid.isInstrumentOverlappedWidthOthers(node) {
            //overlapped recover the center and view
            node.setCenter(centerBackup)
            //recover the view
            let view = self.deviceViews[node.id]!
            view.center = originalDisplayPoint
            return false
        } else{
            //not overlap, move the view to the new position
            let view = self.deviceViews[node.id]!
            let finalDisplayPoint = self.grid.getCenterForGridCell(node.center)
            let finalX = finalDisplayPoint.x - originalDisplayPoint.x + from.x
            let finalY = finalDisplayPoint.y - originalDisplayPoint.y + from.y
            
            view.center = CGPointMake(finalX, finalY)
            return true
        }
    }
    
    private func moveNode(node: GOOpticRep, to: GOCoordinate) -> Bool{
        let originalCenter = self.grid.getCenterForGridCell(node.center)
        let finalCenter = self.grid.getCenterForGridCell(to)
        let offsetX = finalCenter.x - originalCenter.x
        let offsetY = finalCenter.y - originalCenter.y
        let offset = CGPointMake(offsetX, offsetY)
        return self.moveNode(node, from: originalCenter, offset: offset)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension GameViewController: GOGridDelegate {
    func grid(grid: GOGrid, didProduceNewCriticalPoint point: CGPoint, forRayWithTag tag: String) {
        if self.rays.count == 0 {
            // waiting for thread to complete
            return
        }
        
        self.rays[tag]?.append(point)
        if self.rays[tag]?.count == 2 {
            // when there are 2 points, start drawing
            drawRay(tag, currentIndex: 1)
        }
    }
    
    func gridDidFinishCalculation(grid: GOGrid, forRayWithTag tag: String) {
        //        self.processPoints(self.rays[tag])
    }
}
