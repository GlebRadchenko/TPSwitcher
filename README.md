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
switcher.addTarget(self,
                   action: #selector(self.switcherValueChanged(sender:)),
                   for: .valueChanged)
                   
func switcherValueChanged(sender: AnyObject?) {
    guard let switcher = sender as? TPSwitcher else {
        return
    }
    switch switcher.selectedIndex {
    case 0:
        switcher.backgroundColor = .blue
        switcher.selectedTextColor = .blue
        break
    case 1:
        switcher.backgroundColor = .gray
        switcher.selectedTextColor = .gray
        break
    default:
        switcher.backgroundColor = .red
        switcher.selectedTextColor = .red
        break
    }
}
```

##Result:
![image] (https://github.com/GlebRadchenko/TPSwitcher/blob/master/example.png?raw=true)
![gif] (https://github.com/GlebRadchenko/TPSwitcher/blob/master/example.gif)
