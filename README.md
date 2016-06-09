[travis]: https://travis-ci.org/dry-cr/dry-monads

# dry-monads

[![Build Status](https://travis-ci.org/dry-cr/dry-monads.svg?branch=master)](travis)

This is a port of the Ruby gem **dry-monads** by [dry-rb](http://dry-rb.org/).

For usage examples read the Ruby **dry-monads** [documentation](http://dry-rb.org/gems/dry-monads/).

**CAUTION:** This project in still under active development. Use at your own risk.

### TODOs

- [x] Dry::Monads::Either::Right
- [x] Dry::Monads::Either::Left
- [x] Dry::Monads::Maybe::Some
- [x] Dry::Monads::Maybe::None
- [ ] Either#to_maybe
- [ ] Maybe#to_either
- [ ] Dry::Monads::Try
- [ ] integration specs for Either
- [ ] integrations specs for Maybe

## Installation


Add this to your application's `shard.yml`:

```yaml
dependencies:
  dry-monads:
    github: dry-cr/dry-monads
```
Then run `crystal deps` to install dependencies.

## Usage

```crystal
require "dry-monads"
```


TODO: Write usage instructions here

## Development

TODO: Write development instructions here

## Contributing

1. Fork it ( https://github.com/dry-cr/dry-monads/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [ttdonovan](https://github.com/ttdonovan) Tanner Donovan - creator, maintainer
