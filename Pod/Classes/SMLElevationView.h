#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SMLElevationViewUnitsMetric,
    SMLElevationViewUnitsImperial
} SMLElevationViewUnits;

IB_DESIGNABLE

/**
 View that displays elevation profile of path.
 */
@interface SMLElevationView : UIView

/**
 Color of elevation profile line
 */
@property (strong, nonatomic) IBInspectable UIColor *strokeColor;

/**
 Color of fill under elevation profile
 */
@property (strong, nonatomic) IBInspectable UIColor *fillColor;

/**
 Color of grid lines
 */
@property (strong, nonatomic) IBInspectable UIColor *gridColor;

/**
 Color of labels under grid lines
 */
@property (strong, nonatomic) IBInspectable UIColor *labelsColor;

/**
 Font of labels
 */
@property (strong, nonatomic) UIFont *font;

/**
 Count of horisontal grid segments
 */
@property (nonatomic) IBInspectable NSUInteger distanceSegments;

/**
 Count of vertical grid segments
 */
@property (nonatomic) IBInspectable NSUInteger altitudeSegments;

/**
 Width of elevation profile line
 */
@property (nonatomic) IBInspectable NSUInteger lineWidth;

/**
 Width of grid lines
 */
@property (nonatomic) IBInspectable NSUInteger gridWidth;

/**
 Array of CLLocations that represent path
 */
@property (strong, nonatomic) NSArray *path;

/**
 Units of measurement
 */
@property (nonatomic) SMLElevationViewUnits units;

@end
