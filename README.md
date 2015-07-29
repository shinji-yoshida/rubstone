# Rubstone

This is library manager for Unity3d.

## Installation

Add this line to your application's Gemfile:

    gem 'rubstone', github: "shinji-yoshida/rubstone", branch: "v0.2.0"

And then execute:

    $ bundle install

## Usage

### Library Installation

1. Put Rubfile to your project root. Rubfile is written in yaml. For example:

```yaml
config:
  cache_root: "vendor/rubstone" # root directory where all libraies are cloned into.
  directories:
    plugins: "Assets/Plugins/Rubstone" # tag directory as "plugins"
    plugins_editor: "Assets/Plugins/Editor/Rubstone" # tag directory as "plugins_editor"
libs:
- name: Lockables
  repository: "https://github.com/shinji-yoshida/Lockables.git"
  ref: master # branch, tag or hash
  directories:
    plugins: # put the tag which is defined in [config:directories].
      path: src/Lockables # directory to be copied to plugins("Assets/Plugins/Rubstone")
      exclusions:
        - "*.prefab" # file or directory to be ignored
```

2. Execute:

```
rubstone install
```

### Library Update

Execute:

    rubstone update <library name>

### Library Development

You can import modifications in copied library into cloned repository.
For example, when you are developing *Lockables*, execute:

    rubstone dev_import Lockables

Then all modifications in `Assets/Plugins/Rubstone/Lockables` is copied into `vendor/rubstone/Lockables`.
Then you can commit and push the modifications within `vendor/rubstone/Lockables`.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
