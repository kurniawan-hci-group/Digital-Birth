//
//  Constants.h
//  Digital-Birth
//

#import <Foundation/Foundation.h>

// These functions generate random numbers within _variance_ of the _mean_,
// distributed in a bell-shaped curve around withe _mean_.
// "variance" is not the mathematical variance (squared deviation), but rather 
// just the maximum variation, positive or negative, of the generated value
// from the _mean_.

int get_random_int_with_variance(int mean, int variance);
float get_random_float_with_variance(float mean, float variance);

// Makes a rect into a non-anti-aliased rect that will be exactly 1 pixel wide.
CGRect rectFor1PxStroke(CGRect rect);

// Do the actions share any tags?
bool actionsShareTags(NSDictionary* actionOne, NSDictionary* actionTwo);

// Is the action a position change?
bool isPosition(NSDictionary* action);
