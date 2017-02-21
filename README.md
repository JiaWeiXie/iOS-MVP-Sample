# iOS-MVP-Sample

### Xcode Project Setting

> BridgeHeader.h

````
#ifndef BridgeHeader_h
#define BridgeHeader_h

#endif /* BridgeHeader_h */

#include "sqlite3.h"
#import <CommonCrypto/CommonDigest.h>
````
>> TARGETS > <ProjectName> > Build Settings > Objective-C Bridging Header

```
<ProjectName>/BridgeHeader_h
```
