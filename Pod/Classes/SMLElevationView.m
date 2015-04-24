#import"SMLElevationView.h"
#import<CoreLocation/CoreLocation.h>

CGFloat const METERS_TO_FEET = 3.2808399;
CGFloat const METERS_TO_MILES = 0.000621371192;
CGFloat const METERS_TO_KILOMETERS = 0.001;

@interface SMLElevationView()

@property (nonatomic, readonly) CGFloat lowPoint;
@property (nonatomic, readonly) CGFloat highPoint;
@property (nonatomic, readonly) CGFloat distance;
@property (nonatomic, readonly) CGFloat elevationDelta;


@end

@implementation SMLElevationView

#pragma mark - Init

- (id)initWithCoder:(NSCoder*)aDecoder
{
    if(self  =  [super initWithCoder:aDecoder])
    {
        [self setup];
    }
    return self;
}

- (instancetype)init
{
    if(self = [super init])
    {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setup];
    }
    return self;
}

- (void)setup
{
    _strokeColor = [UIColor orangeColor];
    _fillColor = [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:0.5];
    _gridColor = [UIColor grayColor];
    _labelsColor = [UIColor whiteColor];
    _font = [UIFont systemFontOfSize:8];
    _distanceSegments = 5;
    _altitudeSegments = 4;
    _lineWidth = 2;
    _gridWidth = 1;
}

#pragma mark - Interfacebuilder

- (void)prepareForInterfaceBuilder
{
    NSDictionary *dict = @{@"results":@[@{@"elevation":@4350.96044921875,@"location":@{@"lat":@36.578581,@"lng":@-118.291994},@"resolution":@305.4064636230469},@{@"elevation":@3401.97509765625,@"location":@{@"lat":@36.56120453108409,@"lng":@-118.2148210871541},@"resolution":@305.4064636230469},@{@"elevation":@1718.481567382812,@"location":@{@"lat":@36.54377835025277,@"lng":@-118.1376829307608},@"resolution":@305.4064636230469},@{@"elevation":@1297.453491210938,@"location":@{@"lat":@36.52630251149865,@"lng":@-118.0605795922009},@"resolution":@305.4064636230469},@{@"elevation":@1083.901000976562,@"location":@{@"lat":@36.50877706890078,@"lng":@-117.9835111324712},@"resolution":@305.4064636230469},@{@"elevation":@1086.812866210938,@"location":@{@"lat":@36.49120207662418,@"lng":@-117.9064776121845},@"resolution":@305.4064636230469},@{@"elevation":@1280.449096679688,@"location":@{@"lat":@36.47357758891917,@"lng":@-117.8294790915696},@"resolution":@305.4064636230469},@{@"elevation":@2149.911865234375,@"location":@{@"lat":@36.4559036601207,@"lng":@-117.7525156304715},@"resolution":@305.4064636230469},@{@"elevation":@1629.696166992188,@"location":@{@"lat":@36.43818034464772,@"lng":@-117.6755872883518},@"resolution":@305.4064636230469},@{@"elevation":@1469.10205078125,@"location":@{@"lat":@36.42040769700269,@"lng":@-117.5986941242883},@"resolution":@305.4064636230469},@{@"elevation":@1164.840698242188,@"location":@{@"lat":@36.40258577177073,@"lng":@-117.5218361969757},@"resolution":@305.4064636230469},@{@"elevation":@486.82568359375,@"location":@{@"lat":@36.38471462361922,@"lng":@-117.4450135647253},@"resolution":@305.4064636230469},@{@"elevation":@560.2628784179688,@"location":@{@"lat":@36.36679430729701,@"lng":@-117.3682262854655},@"resolution":@305.4064636230469},@{@"elevation":@1211.659790039062,@"location":@{@"lat":@36.34882487763383,@"lng":@-117.2914744167416},@"resolution":@305.4064636230469},@{@"elevation":@1870.713256835938,@"location":@{@"lat":@36.3308063895398,@"lng":@-117.2147580157163},@"resolution":@305.4064636230469},@{@"elevation":@1731.371704101562,@"location":@{@"lat":@36.3127388980046,@"lng":@-117.13807713917},@"resolution":@305.4064636230469},@{@"elevation":@1865.640869140625,@"location":@{@"lat":@36.29462245809699,@"lng":@-117.0614318435005},@"resolution":@305.4064636230469},@{@"elevation":@934.2860717773438,@"location":@{@"lat":@36.27645712496418,@"lng":@-116.9848221847234},@"resolution":@305.4064636230469},@{@"elevation":@46.81528091430664,@"location":@{@"lat":@36.25824295383111,@"lng":@-116.9082482184725},@"resolution":@305.4064636230469},@{@"elevation":@-84.61699676513672,@"location":@{@"lat":@36.23998,@"lng":@-116.83171},@"resolution":@305.4064636230469}],@"status":@"OK"};
    
    NSMutableArray  *locations = [NSMutableArray array];
    
    for(NSDictionary * pt in dict[@"results"])
    {
        CLLocation *loc = [[CLLocation alloc] initWithCoordinate:CLLocationCoordinate2DMake([pt[@"location"][@"lat"] doubleValue], [pt[@"location"][@"lng"] doubleValue]) altitude:[pt[@"elevation"] doubleValue] horizontalAccuracy:1 verticalAccuracy:1 timestamp:[NSDate new]];
        [locations addObject:loc];
    }
    
    self.path = locations;
}

#pragma mark - Setters

- (void)setUnits:(SMLElevationViewUnits)units
{
    _units = units;
    [self setNeedsDisplay];
}

- (void)setPath:(NSArray *)points
{
    _path = points;
    
    CLLocation *firstPoint = [points firstObject];
    
    _lowPoint = firstPoint.altitude;
    _highPoint = firstPoint.altitude;
    _distance = 0;
    
    CLLocation *prevLocation = firstPoint;
    for (CLLocation *newLocation in points)
    {
        double elevation = newLocation.altitude;
        if (elevation > self.highPoint)
            _highPoint = elevation;
        if (elevation < self.lowPoint)
            _lowPoint = elevation;
        
        _distance += [newLocation distanceFromLocation:prevLocation];
        
        prevLocation = newLocation;
    }
    
    _elevationDelta = _highPoint-_lowPoint;
    
    [self setNeedsDisplay];
}

#pragma mark - Calculations

- (CGFloat)getYofPoint:(CLLocation *)point inRect:(CGRect)rect
{
    return rect.origin.y + rect.size.height - [self getNormalizedElevationOfPoint:point] * rect.size.height;
}

- (CGFloat)getNormalizedElevationOfPoint:(CLLocation *)point
{
    CGFloat result = 0;
    if (self.lowPoint < INFINITY)
    {
        if (self.elevationDelta == 0)
            result = self.lowPoint;
        else
            result = (point.altitude - self.lowPoint) / self.elevationDelta;
    }
    return result;
}

#pragma mark - Labelsconstructing

- (NSAttributedString *)makeLabelForFloat:(CGFloat)number withPrecision:(CGFloat)precision andPostfix:(NSString *)postfix
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.roundingIncrement = [NSNumber numberWithDouble:precision];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    
    NSString *labelText = [[formatter stringFromNumber:[NSNumber numberWithDouble:number]] stringByAppendingString:postfix];
    return [[NSAttributedString alloc] initWithString:labelText attributes:@{NSFontAttributeName:self.font, NSForegroundColorAttributeName:self.labelsColor}];
}

- (NSAttributedString *)makeLabelForAltitude:(CGFloat)altitude
{
    NSAttributedString *result = nil;
    
    switch (self.units)
    {
        case SMLElevationViewUnitsImperial:
            result = [self makeLabelForFloat:altitude * METERS_TO_FEET withPrecision:1 andPostfix:@"ft"];
            break;
        case SMLElevationViewUnitsMetric:
            result = [self makeLabelForFloat:altitude withPrecision:1 andPostfix:@"m"];
            break;
        default:
            break;
    }
    
    return result;
}

- (NSAttributedString *)makeLabelForDistance:(CGFloat)distance
{
    NSAttributedString *result = nil;
    
    switch (self.units)
    {
        case SMLElevationViewUnitsImperial:
            result = [self makeLabelForFloat:distance * METERS_TO_MILES withPrecision:0.1 andPostfix:@"mi"];
            break;
        case SMLElevationViewUnitsMetric:
            result = [self makeLabelForFloat:distance * METERS_TO_KILOMETERS withPrecision:0.1 andPostfix:@"km"];
            break;
        default:
            break;
    }
    
    return result;
}

#pragma mark - Drawing

- (void)drawHorisontalLineWithRatio:(CGFloat)ratio inRect:(CGRect)rect andLabel:(BOOL)drawLabel
{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    [path moveToPoint:CGPointMake(rect.origin.x, rect.origin.y + rect.size.height * ratio)];
    [path addLineToPoint:CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height * ratio)];
    
    [self.gridColor setStroke];
    [path setLineWidth:self.gridWidth];
    [path stroke];
    
    if (drawLabel)
    {
        NSAttributedString *label = [self makeLabelForAltitude:self.highPoint - self.elevationDelta * ratio];
        [label drawAtPoint:CGPointMake(rect.origin.x - label.size.width - 2, rect.origin.y + rect.size.height * ratio - label.size.height / 2)];
    }
}

- (void)drawVerticalLineWithRatio:(CGFloat)ratio inRect:(CGRect)rect andLabel:(BOOL)drawLabel
{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    [path moveToPoint:CGPointMake(rect.origin.x + rect.size.width * ratio, rect.origin.y)];
    [path addLineToPoint:CGPointMake(rect.origin.x + rect.size.width * ratio, rect.origin.y + rect.size.height)];
    
    [self.gridColor setStroke];
    [path setLineWidth:self.gridWidth];
    [path stroke];
    
    if (drawLabel)
    {
        NSAttributedString *label = [self makeLabelForDistance:self.distance * ratio];
        [label drawAtPoint:CGPointMake(rect.origin.x + rect.size.width * ratio - label.size.width / 2, rect.origin.y + rect.size.height)];
    }
}

- (void)drawNetInRect:(CGRect)rect
{
    
    for (CGFloat i = 0; i <= 1; i += 1.0 / self.altitudeSegments)
        [self drawHorisontalLineWithRatio:i inRect:rect andLabel:YES];
    for (CGFloat i = 0; i <= 1; i += 1.0 / self.distanceSegments)
        [self drawVerticalLineWithRatio:i inRect:rect andLabel:(i > 0)];
}

- (void)drawGraphicInRect:(CGRect)rect
{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    double x = rect.origin.x;
    
    CLLocation *prevLocation = [self.path firstObject];
    
    CGPoint currentPoint = CGPointMake(x, [self getYofPoint:prevLocation inRect:rect]);
    [path moveToPoint:currentPoint];
    
    for(CLLocation *newLocation in self.path)
    {
        x += [newLocation distanceFromLocation:prevLocation] / _distance * rect.size.width;
        currentPoint = CGPointMake(x, [self getYofPoint:newLocation inRect:rect]);
        [path addLineToPoint:currentPoint];
        prevLocation = newLocation;
    }
    [self.strokeColor setStroke];
    [self.fillColor setFill];
    
    [path setLineWidth:self.lineWidth];
    [path setLineJoinStyle:kCGLineJoinRound];
    [path setLineCapStyle:kCGLineCapRound];
    [path stroke];
    
    currentPoint = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
    [path addLineToPoint:currentPoint];
    currentPoint = CGPointMake(rect.origin.x, rect.origin.y + rect.size.height);
    [path addLineToPoint:currentPoint];
    [path fill];
}

- (void)drawRect:(CGRect)rect
{
    NSAttributedString *altitudeLabel = [self makeLabelForAltitude:self.highPoint];
    NSAttributedString *distanceLabel = [self makeLabelForDistance:self.distance];
    CGFloat altitudeLabelWidthWithInsets = altitudeLabel.size.width + 4;
    CGFloat halfLabelHeight = altitudeLabel.size.height * 0.5;
    CGRect graphicRect = CGRectMake(rect.origin.x + altitudeLabelWidthWithInsets,
                                    rect.origin.y + halfLabelHeight,
                                    rect.size.width - altitudeLabelWidthWithInsets - distanceLabel.size.width * 0.5 - 2,
                                    rect.size.height - halfLabelHeight * 3);
    [self drawNetInRect:graphicRect];
    [self drawGraphicInRect:graphicRect];
}

@end
