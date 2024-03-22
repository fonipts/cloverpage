# Clover page
![Cloverpage version][ruby-image]

## Introduction
The intention of this tool is to scan the code, API traffic and performance of the Web. To have a synchronization tool across different language and platform, that easily maintain by enthusiast at heart.

`Cloverpage` provide a continues code inspection for quality code, api performance in your application

## Usage
First you need to create config file in your project directory `cloverrc.yaml` and copy what we had in this repository.


Then run this command at your terminal
```bash
cloverpage lint
```

## Available command you can use at your terminal
The commands must in this format  `cloverpage <Command type>` 
|Command type | Description| Example |
|------------- | ------------- | ------------- |
|format | Format your project | `cloverpage format`|
|lint | Lint your project | `cloverpage lint`|
|help | See available command for cloverpage | `cloverpage help` |


[ruby-image]: https://img.shields.io/badge/cloverpage-0.0.1-brightgreen
