# Templater

[![Build Status](https://travis-ci.org/czechboy0/Templater.svg?branch=master)](https://travis-ci.org/czechboy0/Templater)
![Platforms](https://img.shields.io/badge/platforms-Linux%20%7C%20OS%20X-blue.svg)
![Package Managers](https://img.shields.io/badge/package%20managers-SwiftPM-yellow.svg)

[![Blog](https://img.shields.io/badge/blog-honzadvorsky.com-green.svg)](http://honzadvorsky.com)
[![Twitter Czechboy0](https://img.shields.io/badge/twitter-czechboy0-green.svg)](http://twitter.com/czechboy0)

> Very basic Swift templating engine. macOS and Linux ready.

Templater is a very simple tool aimed at solving the simple task: in a string template, fill in a few variables with certain values. Something like [Stencil](https://github.com/kylef/Stencil) or [Mustache](http://mustache.github.io). Just a super simple version of them.

# :question: Why?
I needed to fill in a large markdown file with fresh data every day, to generate a pretty [report](https://github.com/czechboy0/swiftpm-packages-statistics).

# Features

The template string must contain one or more strings like `{{ variable_name }}`, such as `Hello, {{ name }}!`. When you render this template with the context of `name = "world"`, you'll get `Hello, world!`.

# Usage

```swift
do {
	
	//create the template
	let template = Template("Hello, {{ name }}! Today is {{ day }} and it will be {{ weather }}.")

	//have your context
	let context = [
		"name": "Tim",
		"day": "Thursday",
		"weather": "sunny"
	]

	//render the context
	let result = try template.fill(with: context)

	//result: "Hello, Tim! Today is Thursday and it will be sunny."

} catch {
	print("Template error: \(error)")
}
```

# Installation

## Swift Package Manager

```swift
.Package(url: "https://github.com/czechboy0/Templater.git", majorVersion: 0, minor: 1)
```

:blue_heart: Code of Conduct
------------
Please note that this project is released with a [Contributor Code of Conduct](./CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

:gift_heart: Contributing
------------
Please create an issue with a description of your problem or open a pull request with a fix.

:v: License
-------
MIT

:alien: Author
------
Honza Dvorsky - http://honzadvorsky.com, [@czechboy0](http://twitter.com/czechboy0)
