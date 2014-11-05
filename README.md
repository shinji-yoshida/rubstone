# Rubstone

This is library manager for Unity3d.

## Installation

To avoid problem, it is better to use rvm to manage this gem.
Please see [here](http://rvm.io/).

To install rubstone, add this line to your application's Gemfile:

    gem 'rubstone', github: "shinji-yoshida/rubstone", branch: "v0.0.1"

And then execute:

    $ bundle install

## Usage

### Library Installation

1. Put Rubfile to your project root. Rubfile is written in yaml. For example:

```yaml
config:
  cache_root: "vendor/.rubstone" # root directory where all libraies are cloned into.
  lib_root: "Assets/Libs" # root directory where all cloned libraies are copied into.
libs:
- name: gotanda
  repository: "https://github.com/shinji-yoshida/gotanda.git"
  ref: "v0.0.1" # branch, tag or hash
  lib_root: "gotanda" # directory in the library to copy
```

2. Execute:

```
rubstone install
```

### Library Update

Execute:

    rubstone install

### Library Development

You can import modifications in copied library into cloned repository.
For example, when you are developing *gotanda*, execute:

    rubstone dev_import gotanda

Then all modifications in `Assets/Libs/gotanda` are copied into `vendor/.rubstone/gotanda`.
Then you can commit and push the modifications within `vendor/.rubstone/gotanda`.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
