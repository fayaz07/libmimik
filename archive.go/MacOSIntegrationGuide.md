# macOS Integration Guide for libmimik

## Files Generated
After running `make build-macos`, you will have:
- `build/libmimik.a` - The static library
- `build/libmimik.h` - The C header file

## Step 1: Create a New macOS Project in Xcode

1. Open Xcode
2. Create a new macOS project (App)
3. Choose SwiftUI as the interface
4. Name your project (e.g., "MimikDemo")

## Step 2: Add Library Files to Your Xcode Project

1. **Add the static library:**
   - Drag `libmimik.a` from Finder into your Xcode project
   - Choose "Copy items if needed"
   - Add to target

2. **Add the header file:**
   - Drag `libmimik.h` from Finder into your Xcode project
   - Choose "Copy items if needed"
   - Add to target

## Step 3: Create a Bridging Header

1. **Create a new header file:**
   - Right-click your project → New File → Header File
   - Name it `YourProjectName-Bridging-Header.h` (replace YourProjectName with your actual project name)

2. **Add the import to the bridging header:**
   ```c
   #import "libmimik.h"
   ```

3. **Configure the bridging header in Build Settings:**
   - Select your project target
   - Go to Build Settings
   - Search for "Objective-C Bridging Header"
   - Set the value to: `YourProjectName/YourProjectName-Bridging-Header.h`

## Step 4: Configure Library Linking

1. **Add the library to Link Binary With Libraries:**
   - Go to your target's Build Phases
   - Expand "Link Binary With Libraries"
   - Click the "+" button
   - Click "Add Other..." → "Add Files..."
   - Select your `libmimik.a`

## Step 5: Use in Swift Code

Now you can use the `Add` function directly in your Swift code!

## Important Notes

- The generated header uses `GoInt` type which maps to Swift's `Int` on 64-bit systems
- Static libraries are embedded directly in your app - no runtime dependencies
- Your app will be self-contained and easier to distribute

## Troubleshooting

### Issue: "Cannot find 'Add' in scope"
- ✅ Check bridging header path is correct
- ✅ Make sure libmimik.h is in your project
- ✅ Verify bridging header imports libmimik.h

### Issue: "Undefined symbol: _Add"
- ✅ Check libmimik.a is in "Link Binary With Libraries"
- ✅ Make sure libmimik.a was copied to project
- ✅ Clean build (⌘+Shift+K) and rebuild

## Example Swift Usage

```swift
// Simple wrapper function
func callGoAdd(_ a: Int, _ b: Int) -> Int {
    return Int(Add(Int64(a), Int64(b)))
}

// Usage
let result = callGoAdd(5, 3) // Returns 8
```