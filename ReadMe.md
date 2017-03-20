# UnitedCustomerFacingIphone (for watchOS, iOS)

## Version

2.1.19

## Coding Standards

### Technical Standards

#### 1.) Singleton objects SHOULD use a thread-safe pattern for creating their shared instance.

    Ex: 

        +(instancetype)sharedInstance {

            static id sharedInstance = nil;
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                sharedInstance = [[[self class] alloc] init];
            });
        return sharedInstance;
        }

### Coding Style

#### 1.) Try to make a function with in 20 lines

#### 2.) Try to make a iOS Class with in 200 lines

+ *Note*: if a file is JSON or content based, it may contain more than thousands of lines.

+ There are a couple ways to fundamentally reduce the number of lines and still be readable. You can 
make reusable code using Protocol Oriented Programming with UITableVIew and UICollectionView. If you 
are using MVC which stands for Massive View Controller you may want to find out how MVVM works.

#### 3.) Never hard type anything. Use Enums wherever it’s possible.

+ The reason we can auto-complete a lot of properties in Xcode is due to Enums.

    Ex:

        
        typedef enum{

            ChasePromoType_NONE = 0,

            ChasePromoType_50K = 1,

            ChasePromoType_70K = 2,

        } ChasePromoType;

#### 4.) Name. Be descriptive. Styling Guide

+ Yes, code is a way humans talk to computers. But, it’s also between us, developers, So it’s not what 
you say it, but how you say it.

    Ex:
        
        // Too brief & Lack of context
        
        NSString *a = "A"
        NSString *b = "B"

        // How I would do it

        NSString *capLetterA = "A"
        NSString *capLetterB = "B"

    Url:
        https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/CodingGuidelines/Articles/NamingMethods.html

#### 5.) If there are more than one if - else statement try to use Switch.

+ Switch takes O(1) time to execute, while the if ... else if ... else if ... will be O(n) where n is
the number of conditions. Doesn't make much of a difference if you only have a few cases though.

    Ex: 
        
        -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath
        *)indexPath;

+ *Note*: However if you are using some more complex conditions (maybe even including functions in the condition),
        well then you should use if statements.

#### 6.) Don’t Rely on Segues

+ Beginners tend to make too many Segues to a point when storyboards look like a spider web. Once you
go beyond a certain threshold, it becomes unmanageable and hard to track each Viewcontroller.
Therefore, use Delegate/NSNotification to send data. Use multiple storyboards instead of one.

#### 7.) If you are creating a global method which is used in other classes try to document it.

    Ex: UALImageDownloader.h

    
        /*!

        * @brief Returns Image if it's already available in cache, if not it downloads the image based on the url and caches it.

        * @param Parameters \a url - url To Download the Image, \a productName - Screen Name(i.e. example: PDE, MPSummary,..etc.)

        * @return returns a completionBlock with image or nil
        completionBlock(image) -> if image is downloaded successfully or if the image is already available in cache.
        completionBlock(nil) -> if image is failed to download or if the image is not available in cache.

        */

        - (void)getImgFromURL:(NSString*)url productIdentifier:(NSString*)productName completionBlock:(void( ^ )( UIImage* image )) completionBlock;

#### 8.) Constants are RECOMMENDED over in-line string literals or numbers.

+ Constants allow for easy reproduction of commonly used variables and can be quickly changed without 
the need for find and replace. Constants MUST be declared as static constants. Constants MAY be 
declared as #define when explicitly being used as a macro.

    Ex:
        
        static NSString * const NYTAboutViewControllerCompanyName = @"The New York Times Company";

    Not:
        
        #define CompanyName @"The New York Times Company"

#### 9.) If there is more than one import statement, statements MUST be grouped together. Groups MAY be commented or pragma marked.

    Ex:

        // Frameworks
        Or 
        # pragma mark Frameworks

        #import <UnifiedPlayerLibrary/UnifiedPlayer.h>

        // Models
        Or 
        # pragma mark Models

        #import "UALBooking20MainVM.h"
        #import "UALBooking20RecentTripVM.h"

        // Views
        Or 
        # pragma mark Views

        #import "UALBooking20CabinSelectCell.h"
        #import "UALBooking20ButtonCell.h"
        #import "UALBooking20MultiTripSelectCell.h"
