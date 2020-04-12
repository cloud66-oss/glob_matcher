<img src="http://cdn2-cloud66-com.s3.amazonaws.com/images/oss-sponsorship.png" width=150/>

![build_status](https://app.codeship.com/projects/eac78290-5ef1-0138-f343-1aecfe2393a1/status?branch=master)

# GlobMatcher

GlobMatcher is a string matcher for Ruby. You can use it to check for matches using wildcards. It supports multiple patterns as well as negative patterns.

GlobMatcher is used in [Cloud 66 Skycap](https://www.cloud66.com/containers/skycap/) to filter git branches before deployment.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'glob_matcher'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install glob_matcher

## Usage

GlobMatcher checks strings against a pattern. A pattern is a space delimited list of single patterns to check against. Here are some patterns:

```
abc -> Matches abc
a* -> Matches ab, abc, azyz, ...
foo*bar -> Matches fooxbar, fooxxxxbar, ...
!abc -> Matches any value except for abc
!ab* -> Matches any value except for anything that matches ab*
foo{abc,xyz}bar -> Matches fooabcbar and fooxyzbar
```

You can use multiple patterns:

```
abc xyz -> Matches abc or xyz (OR)
!abc !xyz -> Matches anything expcet abc and xyz (AND)
foo bar !fuzz !buzz -> Matches foo or bar but not fuzz and buzz
```

```ruby
matcher = ::GlobMatcher::Matcher.new('hel*')
matcher.is_match? 'hello' # true

matcher = ::GlobMatcher::Matcher.new('fo* !bar')
matcher.is_match? 'foo' # true
matcher.is_match? 'bar' # false
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/cloud66-oss/glob_matcher.
