//
//  HaptiHuntRenderer.swift
//  HaptiHunt
//
//  Created by Jacob Rockland on 4/11/18.
//  Copyright © 2018 Somatic Labs. All rights reserved.
//

import SwiftyZorb

/**
 Custom renderer for adding haptic effects to Google Cardboard demo
 */
class HaptiHuntRenderer: TreasureHuntRenderer {
    
    // MARK: - Renderer Properties
    
    // Flag for if previously looking
    var wasLooking: Bool = false
    
    // Flag for whether time to update proximity info
    static var triggerHaptics: Bool = false
    static var previousTrigger: Trigger = .😄
    
    // Haptic timer
    var hapticTimer: Timer = Timer()
    var proximityTimer: Timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) {_ in
        triggerHaptics = true
    }
    
    /// Haptic timeline update interval (in seconds)
    let hapticRefreshRate = 0.1

    // MARK: - Override Methods
    
    // Override the `update` function to support writing to bluetooth
    override func update(_ headPose: GVRHeadPose!) {
        // Call super
        super.update(headPose)
        
        // Get head rotation and cube location
        let headRotation = GLKQuaternionMakeWithMatrix4(GLKMatrix4Transpose(headPose.headTransform))
        let sourceCubePosition = GLKVector3Make(cube_position_x, cube_position_y, cube_position_z)

        // Trigger haptics based on cube proximity
        var pattern: Trigger = .😬
        let sourceDirection = GLKQuaternionRotateVector3(GLKQuaternionInvert(headRotation), sourceCubePosition)
        
        // Not "focused" in the left / right axis
        if (abs(sourceDirection.v.1) >= kFocusThresholdRadians) {
            if (sourceDirection.v.1 > 0) {
                // Cube is above the viewer
                pattern = .🙌
            } else {
                // Cube is below the viewer
                pattern = .😊
            }
        }
        
        // Not "focused" in the up / down axis
        if (abs(sourceDirection.v.0) >= kFocusThresholdRadians) {
            if (sourceDirection.v.0 > 0) {
                // Cube is to the right of the viewer
                pattern = .👉
            } else {
                // Cube is to the left of the viewer
                pattern = .👈
            }
        }
        
        // Trigger pattern if time for update or trigger has changed
        // Successfully triggered pattern
        if (HaptiHuntRenderer.triggerHaptics ||
            ((pattern != HaptiHuntRenderer.previousTrigger) && (HaptiHuntRenderer.previousTrigger !=  .🎊))) {
            print(pattern.rawValue)
            
            // Flip flag
            HaptiHuntRenderer.triggerHaptics = false
            
            // Update previous trigger
            HaptiHuntRenderer.previousTrigger = pattern
            
            // Trigger pattern
            SwiftyZorb.triggerPattern(pattern) { result in
                switch result {
                case .success:
                    // Successfully triggered pattern
                    print("Triggered pattern: \(pattern.rawValue)")
                case .failure(let error):
                    // Failed to trigger pattern
                    print("Failed to trigger pattern with error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    // Override the `isLooking` function to support writing to bluetooth
    override func isLooking(atObject head_rotation: UnsafePointer<GLKQuaternion>!, sourcePosition position: UnsafeMutablePointer<GLKVector3>!) -> Bool {
        // Call super
        let looking = super.isLooking(atObject: head_rotation, sourcePosition: position)
        
        // If not looking, invalidate any queued timer
        if !looking {
            hapticTimer.invalidate()
        }
        
        // Trigger pattern if new look event
        if looking && !wasLooking {
            // Haptic timer
            hapticTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                // Flip flag
                HaptiHuntRenderer.triggerHaptics = false
                
                // Update previous trigger
                HaptiHuntRenderer.previousTrigger = .🎊
                
                // Trigger confetti pattern
                SwiftyZorb.triggerPattern(.🎊) { result in
                    switch result {
                    case .success:
                        // Successfully triggered pattern
                        print("🎊")
                        
                        // Generate the next cube.
                        self.spawnCube()
                    case .failure(let error):
                        // Failed to trigger pattern
                        print("Failed to trigger pattern with error: \(error.localizedDescription)")
                    }
                }
            }
        }
        
        // Set flag for previous looking value
        wasLooking = looking
        
        return looking
    }
    
}

