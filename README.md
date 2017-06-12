<img src="https://s3-us-west-1.amazonaws.com/udacity-content/degrees/catalog-images/nd003.png" alt="iOS Developer Nanodegree logo" height="70" >

# GifMaker (Swift)

![Platform iOS](https://img.shields.io/badge/nanodegree-iOS-blue.svg)

This repository contains the GifMaker (Swift) project which I ported to Swift from Objective-C.

## Overview

GifMaker is an app that lets users create simple GIF animations from their iOS device. The template was forked from Udacity's repository & provided the storyboard, launch screen, info.plist, and gif creation code were provided.  The remaining features I ported from Objective-C or created on my own.

## Navigation

### Welcome Screen (Only visible the first time app launches)

* Tap button to bring up video options: Select Record a video to enable the camera, Select Use existing video to go to photo album 

## My Collection Screen

* Tap button to bring up video options: Select Record a video to enable the camera, Select Use existing video to go to photo album 
* Tap a gif to see the Detail View

### Detail View

* Tap DELETE button to remove gif from collection and return to My Collection Screen
* Tap SHARE button to see options for sharing, Tap cancel to return to detail view or share & be returned to My Collection Screen
* Tap the X to cancel and return to My Collection Screen
 
### Record a Video

* Tap button to begin recording and the button will change shape to a rounded=edged square
* Tap rounded-edged square to end recording
* Tap Retake to discard video & record another
* Tap play button to preview the video
* Slide < mark at video strip along top of screen to change starting point of video, slide > to change end point, press play to preview
* Tap use video to go to the Add Caption Screen

## Add Caption

* If desired tap bottom of screen where Add Cation placeholder shows to bring up keyboard.  Enter caption and press return to dismiss keyboard.  Tap caption again to change.
* When satisfied with caption or if no caption is desired press Next to go to the Preview Screen

### Preview Screen
* To add gif to collection tap CREATE AND SAVE button to see the new gif in the collection.  Note - do this before sharing as no option to save is available from Share screen
* To share without saving tap Share button.



