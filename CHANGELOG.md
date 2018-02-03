CHANGELOG
=========

<details>
<summary>Note: This is in reverse chronological order, so newer entries are added to the top.</summary>

| Contents                   |
| :------------------------- |
| [Lioness 1.0](#lioness-10) |

</details>


Lioness 1.0
-----------

### 2017-05-15
* A new lexer has been implemented, removing the usage of regular expressions. This increases lexing performance up to 83x. The new lexer also supports UTF-8 characters, including emoticons, for identifier names. Example:

	```lioness
	func ∑(a, b) returns {
	    return a + b
	}
	
	😀 = ∑(2, 3) // 😀 = 5
	```
	
### 2017-01-15
* Lioness now supports structs. Example:

	```lioness
	// The Point struct is included in the stdlib
	struct Point {
	    x, y
	}
	
	p = Point(2, 3)
	foo = p
	p.x += 5.0
	
	// p = {x: 7, y: 3}
	// foo = {x: 2, y: 3}
	```
	
### 2017-01-09
* Lioness now supports non-global functions. Example:

	```lioness
	a = 0
	
	func foo() {
		
	    func bar() {
	        a += 1
	    }
		
	    do 10 times {
	        bar()
	    }
		
	}
	
	foo() // a = 10
	```

### 2016-12-18

* Lioness now supports functions with arguments. As well as functions that have a return value, with the new ```returns``` keyword. Example:

	```lioness
	func factorial(x) returns {
	
	    if x > 1 {
	        return x * factorial(x - 1)
	    }
	
	    return 1
	}
	
	a = factorial(5) // a = 120
	```
		
### 2016-12-11

* Lioness now supports functions. Example:

	```lioness
	a = 2

	do 10 times {
	    foo()
	}

	func foo() {
	    a += 1
	}

	// a = 12
	```
	
### 2016-12-10

* Lioness now supports ```break``` and ```continue``` statements in loops. 
    
### 2016-12-04

* Lioness now supports ```repeat while``` loops. Example:

	```lioness
	i = 0
	repeat {
	    // will be evaluated at least once
	    i += 1
	} while i < 10
	```
    
### 2016-11-17

* Lioness now supports ```do times``` loops. Example:

	```lioness
	do 10 times {
	    // do something
	}
	```
    
### 2016-11-13

* Lioness now supports ```for``` loops. Example:

	```lioness
	for i = 0, i < 10, i += 1 {
	    // do something
	}
	```

### 2016-10-21

* Lioness now supports ```while``` loops. Example:

	```lioness
	while true {
	    // do something
	}
	```
	
