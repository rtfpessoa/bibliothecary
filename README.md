# Bibliothecary

Dependency manifest parsing library for https://libraries.io

[![Build Status](https://travis-ci.org/librariesio/bibliothecary.svg?branch=master)](https://travis-ci.org/librariesio/bibliothecary)
[![Code Climate](https://img.shields.io/codeclimate/github/librariesio/bibliothecary.svg?style=flat)](https://codeclimate.com/github/librariesio/bibliothecary)
[![Test Coverage](https://img.shields.io/codeclimate/coverage/github/librariesio/bibliothecary.svg?style=flat)](https://codeclimate.com/github/librariesio/bibliothecary)
[![Code Climate](https://img.shields.io/codeclimate/issues/github/librariesio/bibliothecary.svg)](https://codeclimate.com/github/librariesio/bibliothecary/issues)
[![license](https://img.shields.io/github/license/librariesio/bibliothecary.svg)](https://github.com/librariesio/bibliothecary/blob/master/LICENSE.txt)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bibliothecary'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bibliothecary

## Usage

Identify package manager manifests from a list of files:

```ruby
Bibliothecary.identify_manifests(['package.json', 'README.md', 'index.js']) #=> 'package.json'
```

Parse a manifest file for it's dependencies:

```ruby
Bibliothecary.analyse_file 'bower.json', File.open('bower.json').read
```

Search a directory for manifest files and parse the contents:

```ruby
Bibliothecary.analyse('./')
```

## Supported package manager file formats

- npm
  - package.json
  - npm-shrinkwrap.json
  - yarn.lock
- Maven
  - pom.xml
  - ivy.xml
  - build.gradle
- RubyGems
  - Gemfile
  - Gemfile.lock
  - gems.rb
  - gems.locked
  - *.gemspec
- Packagist
  - composer.json
  - composer.lock
- PyPi
  - setup.py
  - req*.txt
  - req*.pip
  - requirements/*.txt
  - requirements/*.pip
  - Pipfile
  - Pipfile.lock
- Nuget
  - packages.config
  - Project.json
  - Project.lock.json
  - *.nuspec
  - paket.lock
- Bower
  - bower.json
- CPAN
  - META.json
  - META.yml
- CocoaPods
  - Podfile
  - Podfile.lock
  - *.podspec
- Clojars
  - project.clj
- Meteor
  - versions.json
- CRAN
  - DESCRIPTION
- Cargo
  - Cargo.toml
  - Cargo.lock
- Hex
  - mix.exs
  - mix.lock
- Swift
  - Package.swift
- Pub
  - pubspec.yaml
  - pubspec.lock
- Carthage
  - Cartfile
  - Cartfile.private
  - Cartfile.resolved
- Dub
  - dub.json
  - dub.sdl
- Julia
  - REQUIRE
- Shards
  - shard.yml
  - shard.lock
- Go
  - glide.yaml
  - glide.lock
  - Godeps
  - Godeps/Godeps.json
  - vendor/manifest
  - vendor/vendor.json
- Elm
  - elm-package.json
  - elm_dependencies.json
  - elm-stuff/exact-dependencies.json

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/librariesio/bibliothecary. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.
