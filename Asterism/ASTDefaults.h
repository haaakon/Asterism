//
//  ASTDefaults.h
//  Asterism
//
//  Created by Robert Böhnke on 16/11/13.
//  Copyright (c) 2013 Robert Böhnke. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AsterismDefines.h"

// You should not call these methods directly.
NSDictionary *__ASTDefaults_NSDictionary(NSDictionary *dict, NSDictionary *defaults);

// Fills in missing values from another dictionary.
//
// dict     - A dictionary.
// defaults - A dictionary of default values.
//
// Returns a new dictionary that contains a union of key-value-pairs of `dict`
// and `defaults`. Key-value-pairs of `dict` will have precedence over those
// taken from `defaults`.
ASTERISM_OVERLOADABLE NSDictionary *ASTDefaults(NSDictionary *dict, NSDictionary *defaults) {
    return __ASTDefaults_NSDictionary(dict, defaults);
}
