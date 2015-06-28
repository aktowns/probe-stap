# probe-stap

Emit Systemtap probes from your crystal application for debugging and performance tracing.

## Installation

Add it to `Projectfile`

```crystal
deps do
  github "aktowns/probe-stap"
end
```

## Usage

```crystal
require "probe-stap"

probe_stap_emit(myprobe, "Hello", "World")
```

then you can monitor using a SystemTap script like the following:
```
probe process.mark("myprobe") {
	printf("%s %s (%p,%p) \n", user_string($arg1), user_string($arg2), $arg1, $arg2);
}
```
```
$ stap -c "myapp" script_file.stp
Hello World (0x40c34c,0x40c36c)
```

## Development

Learning crystal as I go, advice/hints welcome!

## Contributing

1. Fork it ( https://github.com/aktowns/probe-stap/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [aktowns](https://github.com/aktowns) Ashley Towns - creator, maintainer
