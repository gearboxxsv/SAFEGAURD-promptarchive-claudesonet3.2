seriously... what happened!  redo it, one script file not 3, stop halting the work until is done, spend the time, work harder, complete the job in one request... there are issues with the react codebase, many of the includes are missing the libraries.  I need to make sure there is a setup shell script to build a react app that includes all the items for the AR/VR webXR meta and haptics toolsets.  create a script to build a meteor react application from bash, also make sure that the following directory includes from the solution in /client/simulator* files you created have libraries resolved by creating the code now or using the bash script to import sources from the web: colaboration
neural
collaborative
physics
controls
ui
data
visualization
environment
xr... errors in the script, redo it with the following in mind: 'Currently using ecmascript with version constraint 0.16.13.
The version constraint will be removed.

                                                           ecmascript: Compiler plugin that supports ES2015+ in all .js files
                                                                                                         
                                                           check: Check whether a value matches a pattern
                                                            => Errors while parsing arguments:           
                                                                                                         
                                                           While adding package simpl-schema:
                                                           error: no such package
                                                           
                                                           Currently using reactive-var with version constraint 1.0.13.
                                                           The version constraint will be removed.       ', 'Installing WebXR & 3D dependencies...
                                                                                                             npm error code ERESOLVE
                                                                                                             npm error ERESOLVE unable to resolve dependency tree
                                                                                                             npm error
                                                                                                             npm error While resolving: xr-simulation-platform@undefined
                                                                                                             npm error Found: react@17.0.2
                                                                                                             npm error node_modules/react
                                                                                                             npm error   react@"^17.0.2" from the root project
                                                                                                             npm error   peer react@"*" from expo@54.0.8
                                                                                                             npm error   node_modules/expo
                                                                                                             npm error     peerOptional expo@">=43.0" from @react-three/fiber@8.13.5
                                                                                                             npm error     node_modules/@react-three/fiber
                                                                                                             npm error       @react-three/fiber@"8.13.5" from the root project
                                                                                                             npm error     peer expo@"*" from @expo/dom-webview@0.2.7
                                                                                                             npm error     node_modules/@expo/dom-webview
                                                                                                             npm error       peerOptional @expo/dom-webview@"*" from expo@54.0.8
                                                                                                             npm error     3 more (@expo/metro-runtime, expo-asset, expo-gl)
                                                                                                             npm error   8 more (@expo/dom-webview, @expo/metro-runtime, react-dom, ...)
                                                                                                             npm error
                                                                                                             npm error Could not resolve dependency:
                                                                                                             npm error peer react@">=18.0" from @react-three/fiber@8.13.5
                                                                                                             npm error node_modules/@react-three/fiber
                                                                                                             npm error   @react-three/fiber@"8.13.5" from the root project
                                                                                                             npm error
                                                                                                             npm error Fix the upstream dependency conflict, or retry
                                                                                                             npm error this command with --force or --legacy-peer-deps
                                                                                                             npm error to accept an incorrect (and potentially broken) dependency resolution.
                                                                                                             npm error
                                                                                                             npm error
                                                                                                             npm error For a full report see:
                                                                                                             npm error /Users/gdeeds/.npm/_logs/2025-09-17T02_09_55_371Z-eresolve-report.txt
                                                                                                             npm error A complete log of this run can be found in: /Users/gdeeds/.npm/_logs/2025-09-17T02_09_55_371Z-debug-0.log
                                                                                                             Installing haptics and tracking dependencies...
                                                                                                             npm error code E404
                                                                                                             npm error 404 Not Found - GET https://registry.npmjs.org/webxr-layers - Not found
                                                                                                             npm error 404
                                                                                                             npm error 404  'webxr-layers@1.0.0' is not in this registry.
                                                                                                             npm error 404
                                                                                                             npm error 404 Note that you can also install from a
                                                                                                             npm error 404 tarball, folder, http url, or git url.
                                                                                                             npm error A complete log of this run can be found in: /Users/gdeeds/.npm/_logs/2025-09-17T02_09_59_057Z-debug-0.log
                                                                                                             Installing data visualization and neural dependencies...
                                                                                                             npm error code ERESOLVE
                                                                                                             npm error ERESOLVE could not resolve
                                                                                                             npm error
                                                                                                             npm error While resolving: xr-simulation-platform@undefined
                                                                                                             npm error Found: @tensorflow/tfjs-core@4.10.0
                                                                                                             npm error node_modules/@tensorflow/tfjs-core
                                                                                                             npm error   @tensorflow/tfjs-core@"4.10.0" from @tensorflow/tfjs@4.10.0
                                                                                                             npm error   node_modules/@tensorflow/tfjs
                                                                                                             npm error     @tensorflow/tfjs@"4.10.0" from the root project
                                                                                                             npm error   peer @tensorflow/tfjs-core@"4.10.0" from @tensorflow/tfjs-backend-webgl@4.10.0
                                                                                                             npm error   node_modules/@tensorflow/tfjs-backend-webgl
                                                                                                             npm error     @tensorflow/tfjs-backend-webgl@"4.10.0" from the root project
                                                                                                             npm error     @tensorflow/tfjs-backend-webgl@"4.10.0" from @tensorflow/tfjs@4.10.0
                                                                                                             npm error     node_modules/@tensorflow/tfjs
                                                                                                             npm error       @tensorflow/tfjs@"4.10.0" from the root project
                                                                                                             npm error
                                                                                                             npm error Could not resolve dependency:
                                                                                                             npm error ml5@"0.12.2" from the root project
                                                                                                             npm error
                                                                                                             npm error Conflicting peer dependency: @tensorflow/tfjs-core@1.7.4
                                                                                                             npm error node_modules/@tensorflow/tfjs-core
                                                                                                             npm error   peer @tensorflow/tfjs-core@"^1.2.9" from ml5@0.12.2
                                                                                                             npm error   node_modules/ml5
                                                                                                             npm error     ml5@"0.12.2" from the root project
                                                                                                             npm error
                                                                                                             npm error Fix the upstream dependency conflict, or retry
                                                                                                             npm error this command with --force or --legacy-peer-deps
                                                                                                             npm error to accept an incorrect (and potentially broken) dependency resolution.
                                                                                                             npm error
                                                                                                             npm error
                                                                                                             npm error For a full report see:
                                                                                                             npm error /Users/gdeeds/.npm/_logs/2025-09-17T02_10_00_462Z-eresolve-report.txt
                                                                                                             npm error A complete log of this run can be found in: /Users/gdeeds/.npm/_logs/2025-09-17T02_10_00_462Z-debug-0.log
                                                                                                             Installing UI and controls dependencies...
                                                                                                             npm error code ERESOLVE
                                                                                                             npm error ERESOLVE could not resolve
                                                                                                             npm error
                                                                                                             npm error While resolving: framer-motion@10.16.1
                                                                                                             npm error Found: react@17.0.2
                                                                                                             npm error node_modules/react
                                                                                                             npm error   peer react@"17.0.2" from react-dom@17.0.2
                                                                                                             npm error   node_modules/react-dom
                                                                                                             npm error     react-dom@"^17.0.2" from the root project
                                                                                                             npm error     peer react-dom@"^17.0.0 || ^18.0.0" from @mui/material@5.14.5
                                                                                                             npm error     node_modules/@mui/material
                                                                                                             npm error       @mui/material@"5.14.5" from the root project
                                                                                                             npm error       1 more (@mui/icons-material)
                                                                                                             npm error     5 more (react-joystick-component, react-router-dom, ...)
                                                                                                             npm error   react@"^17.0.2" from the root project
                                                                                                             npm error   17 more (@emotion/react, @emotion/styled, @mui/icons-material, ...)
                                                                                                             npm error
                                                                                                             npm error Could not resolve dependency:
                                                                                                             npm error peerOptional react@"^18.0.0" from framer-motion@10.16.1
                                                                                                             npm error node_modules/framer-motion
                                                                                                             npm error   framer-motion@"10.16.1" from the root project
                                                                                                             npm error
                                                                                                             npm error Conflicting peer dependency: react@18.3.1
                                                                                                             npm error node_modules/react
                                                                                                             npm error   peerOptional react@"^18.0.0" from framer-motion@10.16.1
                                                                                                             npm error   node_modules/framer-motion
                                                                                                             npm error     framer-motion@"10.16.1" from the root project
                                                                                                             npm error
                                                                                                             npm error Fix the upstream dependency conflict, or retry
                                                                                                             npm error this command with --force or --legacy-peer-deps
                                                                                                             npm error to accept an incorrect (and potentially broken) dependency resolution.
                                                                                                             npm error
                                                                                                             npm error
                                                                                                             npm error For a full report see:
                                                                                                             npm error /Users/gdeeds/.npm/_logs/2025-09-17T02_10_05_299Z-eresolve-report.txt
                                                                                                             npm error A complete log of this run can be found in: /Users/gdeeds/.npm/_logs/2025-09-17T02_10_05_299Z-debug-0.log
                                                                                                             Installing physics and environment dependencies...
                                                                                                             npm error code ETARGET
                                                                                                             npm error notarget No matching version found for oimo@1.0.10.
                                                                                                             npm error notarget In most cases you or one of your dependencies are requesting
                                                                                                             npm error notarget a package version that doesn't exist.
                                                                                                             npm error A complete log of this run can be found in: /Users/gdeeds/.npm/_logs/2025-09-17T02_10_11_858Z-debug-0.log
                                                                                                             Installing collaboration dependencies...
                                                                                                             npm error code E404
                                                                                                             npm error 404 Not Found - GET https://registry.npmjs.org/shared-state-manager - Not found
                                                                                                             npm error 404
                                                                                                             npm error 404  'shared-state-manager@1.0.0' is not in this registry.
                                                                                                             npm error 404
                                                                                                             npm error 404 Note that you can also install from a
                                                                                                             npm error 404 tarball, folder, http url, or git url.
                                                                                                             npm error A complete log of this run can be found in: /Users/gdeeds/.npm/_logs/2025-09-17T02_10_14_501Z-debug-0.log
                                                                                                             Installing dev dependencies...
                                                                                                             npm error code ERESOLVE
                                                                                                             npm error ERESOLVE unable to resolve dependency tree
                                                                                                             npm error
                                                                                                             npm error While resolving: xr-simulation-platform@undefined
                                                                                                             npm error Found: react@17.0.2
                                                                                                             npm error node_modules/react
                                                                                                             npm error   react@"^17.0.2" from the root project
                                                                                                             npm error
                                                                                                             npm error Could not resolve dependency:
                                                                                                             npm error peer react@"^18.0.0" from @testing-library/react@14.0.0
                                                                                                             npm error node_modules/@testing-library/react
                                                                                                             npm error   dev @testing-library/react@"14.0.0" from the root project
                                                                                                             npm error
                                                                                                             npm error Fix the upstream dependency conflict, or retry
                                                                                                             npm error this command with --force or --legacy-peer-deps
                                                                                                             npm error to accept an incorrect (and potentially broken) dependency resolution.
                                                                                                             npm error
                                                                                                             npm error'