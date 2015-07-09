# Terranous - SpriteKit Swift
![Terranous Icon](http://imgur.com/kJ4mYbb.gif "Terranous Icon")

**Terranous - SpriteKit Swift** is a complete space themed endless runner game using SpriteKit written in Swift created as a *prototype* for my upcoming book on making games for iOS devices. 

## Features
- Game Center login and Leader Boards
- iAd Integration, hide iAd banner when player is in game.
- Shader effects applied to sprites. When the player loses the game, all sprites in the gameNode layer are pixelated with a shader.
- "Pixel Perfect" collision using CGMutablePathRefs. 
- Player can pause the game. 
- Player can enable/disable music with a simple button tap in the Menu and GameOver scenes. 

## Source Code
This project was built using Xcode 6.4 and Swift 1.2, and known to compile clean on the iPhone 5/iPad 2 and newer devices running a minimum versionof iOS 8. 

How this project will perform using Swift 2.0, Xcode 7 and devices running iOS 9 is unknown at this time.

## Performance
This game is very light considering how many particles are in the scene. You might experience as much as 60 FPS on the Simulator, but I still advise developing games on a real device when possible. 

GameCenter logins on the Simulator can be painfully slow. If you must use the Simulator you may want to comment out GameCenter
login sections of code in GameViewController.swift.

## Game Description
*Pilot your intrepid ship, the Terranous through an endless field of meteors and collect stars to increase your score.*

*Every 5 stars you pick up without getting hit increases your bonus by 250 points up to a maximum of 5000 points per star.*

*Oh, and you only get to destroy your ship three times; think of it as a bonus of two extra chances. Do you have the elite piloting skills to rack up some serious points in this fast paced endless runner?* 

*Good luck, Captain, you'll need it!*

## Animated Gif Demo
This demo is recorded to gif at a very low FPS to keep the image size down.

![Terranous - SpriteKit Swift](http://imgur.com/I4k6f4A.gif "Terranous Demo")

## Game Assets
**Terranous - SpriteKit Swift** uses 100% Open Source game art, sounds and fonts from http://opengameart.org and http://dafont.com

## Credits
Ship, Stars, Meteors, Explosions - **Kenny** - http://opengameart.org/users/kenney

Music - **SketchyLogic** - http://opengameart.org/users/sketchylogic

Player Sound Effects - **Michel Baradari** - http://opengameart.org/content/15-monster-gruntpaindeath-sounds

Sound Effects and Jingles - **Little Robot Sound Factory** - http://opengameart.org/content/8-bit-sound-effects-library

SKTUtils Library - **The Awesome Ray Wenderlich Tutorial Team** - https://github.com/raywenderlich/SKTUtils

Font - **&AElig;nigma** - http://www.dafont.com/edit-undo.font
