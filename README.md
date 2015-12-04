Purpose:
=======

I wanted a way to base64 encode videos and photos from the CameraRoll in react-native. So I came up with this solution.

How to use:
-----------

1. Open up your project and drag the Base64Asset.h and Base64Asset.m classes into your project.
2. Run the project
3. Use the module by using:

const {NativeModules} = React

NativeModules.Base64Asset.read(assetUri, (base64EncodedFile) => {
console.log(base64EncodedFile)
})

4. That's it!
