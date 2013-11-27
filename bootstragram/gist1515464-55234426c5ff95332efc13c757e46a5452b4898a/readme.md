Original Reference:  
http://www.merriampark.com/ldobjc.htm

__Store & Sort Matches Based on Search String__

		NSMutableArray *results = [NSMutableArray array];
		
		for (id item in theItemList) {
			// note the modified weighting, this ends up working similiar to Alfred / TextMate searching method
			// TextMate takes into account camelcase while matching and is a little smarter, but you get the idea
			NSInteger score = [_searchString compareWithWord:[item searchOnString] matchGain:10 missingCost:1];
			
			[results addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:score], @"score", list, @"item", nil]];
		}
		
		// sort list
		results = [results sortedArrayUsingComparator: (NSComparator)^(id obj1, id obj2) {
			return [[obj1 valueForKey:@"score"] compare:[obj2 valueForKey:@"score"]];
		}];g

__Note:__  

 * The `compareWithString:` has not been tested extensively.
 * 64bit compatible
 * There are a couple more modifications / tweaks from the original, look at revision history for details