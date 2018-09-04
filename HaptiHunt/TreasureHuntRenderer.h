// This file is from a Google Cardboard demo provided by Google: https://github.com/googlevr/gvr-ios-sdk/tree/master/Samples/TreasureHunt

#import "GVRAudioEngine.h"
#import "GVRKit/GVRRenderer.h"

// Sample sound file names.
static const NSString *kObjectSoundFile = @"cube_sound.wav";
static const NSString *kSuccessSoundFile = @"success.wav";

// Cube focus angle threshold in radians.
static const float kFocusThresholdRadians = 0.5f;

/** TreasureHunt renderer. */
@interface TreasureHuntRenderer : GVRRenderer

    @property (strong, nonatomic) GVRAudioEngine* gvr_audio_engine;

    @property (nonatomic) GLfloat cube_position_x;

    @property (nonatomic) GLfloat cube_position_y;

    @property (nonatomic) GLfloat cube_position_z;

    - (bool)handleTrigger;

    - (void)update:(GVRHeadPose *)headPose;

    - (bool)isLookingAtObject:(const GLKQuaternion *)head_rotation
               sourcePosition:(GLKVector3 *)position;

    - (void)spawnCube;

@end

