# TPSwitcher
Custom implementation of Apple UISegmentedControl

##Requirements: 
  - IOS 9.0+
  - XCode 8.0+ 
  - Swift 3.0
  
##Usage: 

``` swift
let switcher = TPSwitcher(titles: ["First", "Second", "Third"])
switcher.borderColor = .white
switcher.borderWidth = 1.0
switcher.sliderMargin = 2.0
switcher.backgroundColor = .blue
switcher.selectedColor = .white
switcher.selectedTextColor = .blue
switcher.textColor = .white
switcher.setSelected(0, animated: false)
```

##Result:
![image] (https://github.com/GlebRadchenko/TPSwitcher/blob/master/example.png?raw=true)
![gif] (https://github.com/GlebRadchenko/TPSwitcher/blob/master/example.gif)
