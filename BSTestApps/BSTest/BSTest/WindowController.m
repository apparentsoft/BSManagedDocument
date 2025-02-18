//
//  WindowController.m
//  BSTest
//
//  Created by Abizer Nasir on 19/12/2012.
//  Copyright (c) 2012 Jungle Candy Software. All rights reserved.
//

#import "WindowController.h"
#import "Document.h"
#import "Ebook.h"

@interface WindowController ()

@end

@implementation WindowController

- (id)init {
    if (!(self = [super initWithWindowNibName:@"Document"])) {
        return nil; //
    }

    return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
    self.contentView.wantsLayer = YES;
    self.contentView.layer.backgroundColor = NSColor.greenColor.CGColor;
}

- (IBAction)addAFile:(id)sender {
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    openPanel.allowedFileTypes = @[@"public.plain-text"];
    openPanel.allowsMultipleSelection = NO;

    [openPanel beginWithCompletionHandler:^(NSModalResponse result) {
        if (result == NSModalResponseCancel) {
            return;
        }

        NSURL *fileUrl = openPanel.URL;
        NSString *fileName = fileUrl.path.lastPathComponent;
        NSError *error;

        NSData *fileData = [NSData dataWithContentsOfURL:fileUrl options:NSDataReadingUncached error:&error];

        if (!fileData) {
            [self presentError:error];
            return;
        }

        Document *document = self.document;

        Ebook *ebook = [NSEntityDescription insertNewObjectForEntityForName:@"Ebook" inManagedObjectContext:document.managedObjectContext];
        ebook.contents = fileData;
        ebook.title = fileName;
    }];
    
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    
}
@end
