//
//  ViewController.m
//  AR-beta
//
//  Created by moi on 2018/05/18.
//  Copyright © 2018 moi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <ARSCNViewDelegate>

@property (nonatomic, strong) IBOutlet ARSCNView *sceneView;

@end

    
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Set the view's delegate
    self.sceneView.delegate = self;
    // Show statistics such as fps and timing information
    self.sceneView.showsStatistics = YES;
    // Create a new scene
    SCNScene *scene = [SCNScene sceneNamed:@"art.scnassets/ship.scn"];
    // Set the scene to the view
    self.sceneView.scene = scene;
    
    // Debug feature points and world origin
    self.sceneView.debugOptions = ARSCNDebugOptionShowFeaturePoints | ARSCNDebugOptionShowWorldOrigin;
    
    // Initialize tracking_status_label
    tracking_status_label = [[UILabel alloc] init];
    tracking_status_label.textColor = [UIColor redColor];
    tracking_status_label.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
}

- (void)session:(ARSession *)session cameraDidChangeTrackingState:(ARCamera *)camera;{
    // 0:normal, 1:limited(initialization in progress), 2:limited(excessive motion), 3:limited(lack of feature points), 4:limited(relocalization in prpgress)
    switch (camera.trackingStateReason) {
        case 0:
            tracking_status_label.text = @"Normal";
            break;
        case 1:
            tracking_status_label.text = @"Limited (initialization in progress)";
            break;
        case 2:
            tracking_status_label.text = @"Limited (excessive motion)";
            break;
        case 3:
            tracking_status_label.text = @"Limited (lack of features)";
            break;
        default:
            tracking_status_label.text = @"Limited (relocalization in progress)";
            break;
    }
    // Print on screen
    [tracking_status_label sizeToFit];
    tracking_status_label.center = self.view.center;
    [self.view addSubview:tracking_status_label];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Create a session configuration
    ARWorldTrackingConfiguration *configuration = [ARWorldTrackingConfiguration new];

    // Run the view's session
    [self.sceneView.session runWithConfiguration:configuration];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Pause the view's session
    [self.sceneView.session pause];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - ARSCNViewDelegate

/*
// Override to create and configure nodes for anchors added to the view's session.
- (SCNNode *)renderer:(id<SCNSceneRenderer>)renderer nodeForAnchor:(ARAnchor *)anchor {
    SCNNode *node = [SCNNode new];
 
    // Add geometry to the node...
 
    return node;
}
*/

- (void)session:(ARSession *)session didFailWithError:(NSError *)error {
    // Present an error message to the user
    
}

- (void)sessionWasInterrupted:(ARSession *)session {
    // Inform the user that the session has been interrupted, for example, by presenting an overlay
    
}

- (void)sessionInterruptionEnded:(ARSession *)session {
    // Reset tracking and/or remove existing anchors if consistent tracking is required
    
}

@end
