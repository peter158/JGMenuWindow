//
//  StatusItemAppDelegate.m
//  StatusItem
//
//  Created by Joshua Garnham on 07/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StatusItemAppDelegate.h"

@implementation StatusItemAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	menuController = [[[JGMenuWindowController alloc] initWithWindowNibName:@"JGMenuWindow"] retain];
	[menuController setHeaderView:customView];
}

- (void)applicationDidResignActive:(NSNotification *)aNotification {
	[menuController closeWindow];
}

#pragma mark Showing and Hiding Table

- (void)showTableView {
	NSMutableArray *items = [[NSMutableArray alloc] init];
	for (int i = 0; i < 6; i++) {
		if (i==3)
			[items addObject:[JGMenuItem seperatorItem]];
		JGMenuItem *menuItem = [[JGMenuItem alloc] initWithTitle:[NSString stringWithFormat:@"Result %i", i] target:self action:@selector(itemSelected)];
		[items addObject:menuItem];
	} 
	[menuController setMenuItems:items];
	[menuController highlightMenuItemAtIndex:0];
}

- (void)hideTableView {
	[menuController setMenuItems:nil];
}

- (void)itemSelected {
	NSLog(@"item selected");
}

#pragma mark NSControlTextEditingDelegate

- (BOOL)control:(NSControl *)control textShouldBeginEditing:(NSText *)fieldEditor {
	if (![searchField.stringValue isEqualToString:@""]) {
		[self showTableView];
	}
	return YES;
}

- (void)controlTextDidChange:(NSNotification *)obj {
	if (![searchField.stringValue isEqualToString:@""]) {
		[self showTableView];
	} else {
		[self hideTableView];
	}
}

@end
