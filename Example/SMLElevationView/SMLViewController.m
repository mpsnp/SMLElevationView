//
//  SMLViewController.m
//  SMLElevationView
//
//  Created by George Kiriy on 04/24/2015.
//  Copyright (c) 2014 George Kiriy. All rights reserved.
//

#import "SMLViewController.h"
#import "SMLElevationView.h"
#import <CoreLocation/CoreLocation.h>

@interface SMLViewController ()
@property (weak, nonatomic) IBOutlet SMLElevationView *elevationView;
@end

@implementation SMLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.elevationView.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[@"http://maps.googleapis.com/maps/api/elevation/json?path=36.578581,-118.291994|36.23998,-116.83171&samples=200&sensor=true_or_false" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSError *error;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if (!error)
        {
            NSMutableArray  *locations = [NSMutableArray array];
            
            for(NSDictionary * pt in dict[@"results"])
            {
                CLLocation *loc = [[CLLocation alloc] initWithCoordinate:CLLocationCoordinate2DMake([pt[@"location"][@"lat"] doubleValue], [pt[@"location"][@"lng"] doubleValue]) altitude:[pt[@"elevation"] doubleValue] horizontalAccuracy:1 verticalAccuracy:1 timestamp:[NSDate new]];
                [locations addObject:loc];
            }
            
            self.elevationView.path = locations;
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
