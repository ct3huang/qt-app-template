# Deploying for macOS


## Bash profile

To build the application for macOS, cmake needs the Qt bin dir in its path and the code sign identity variable set. 
Look for your Developer ID Application certificate in _Keychain Access_. Copy its signature (including the uuid) and 
use this to set CODE_SIGN_IDENTITY for signing the app. Put the following lines in e.g. `~/.bash_profile`:

```bash
# Qt
export PATH=${HOME}/Development/lib/Qt5.12.0/5.12.0/clang_64/bin:${PATH}
export CODE_SIGN_IDENTITY="Developer ID Application: Your Name (XXXXXXXXXX)"
```


## Code signing

Code signing in the console can be done with:

```bash
codesign --deep --force --verify  --verbose  --options runtime \
   --sign ${CODE_SIGN_IDENTITY} cmake-build-debug/myApp.app
```

where `--option runtime` is for hardening runtime, required in the near future for all macOS apps. The option `--deep`
is used to sign all frameworks and libraries that are included in the app bundle.


## Troubleshooting

Below are some issues that I've seen and solved:

 - Error: "No identity found" when using codesign:
    - The certificate name is incorrect. Lookup the name in Keychain Access.
    - The certificate is expired. Create a new certificate on the Apple Developers Portal.
 