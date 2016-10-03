# WinRM::Multi

WinRM::Multi is a library for working with multiple winrm shells using a single interface. Its ideal for invoking a single set of commands on multiple remote Windows machines.

This library is inspired by [Jamis Buck's](https://github.com/jamis) [net-ssh-multi](https://github.com/jamis/net-ssh-multi)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'winrm-multi'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install winrm-multi

## Usage

Using WinRM::Multi is nearly identical to the usage of the WinRM gem. The key difference being that `WinRM::Multi::Connection.new` takes an array of connection hashes, each representing a connection to an individual remote machine.

```
require 'winrm-multi'
conn1 = { 
  endpoint: 'http://myhost:5985/wsman',
  user: 'administrator',
  password: 'Pass@word1'
}
conn2 = { 
  endpoint: 'http://myotherhost:5985/wsman',
  user: 'vagrant',
  password: 'vagrant'
}

multi_conn = WinRM::Multi::Connection.new([conn1, conn2])
```

You create a shell from the `Connection` just as you normally would. Executing commands using `run` will invoke the command on all hosts and yield, in addition to stdout and stderr, a endpoint representing the maching sending the data.

```
multi_conn.shell(:powershell) do |shell|
  output = shell.run('$PSVersionTable') do |endpoint, stdout, stderr|
    STDOUT.print "#{endpoint}: #{stdout}"
    STDERR.print "#{endpoint}: #{stderr}"
  end
end
```

Finally the `WinRM::Multi::Output` returned from `run` is a hash of `WinRM::Output` instances keyed by endpoint.

```
puts "#{conn1[:endpoint]} exited with #{output[conn1[:endpoint]].exitcode}"
```

## Contributing

1. Fork it.
2. Create a branch (git checkout -b my_feature_branch)
3. Run the unit and integration tests (bundle exec rake integration)
4. Commit your changes (git commit -am "Added a sweet feature")
5. Push to the branch (git push origin my_feature_branch)
6. Create a pull requst from your branch into master (Please be sure to provide enough detail for us to cipher what this change is doing)

### Running the tests

We use Bundler to manage dependencies during development.

```
$ bundle install
```

Once you have the dependencies, you can run the unit tests with `rake`:

```
$ bundle exec rake spec
```

To run the integration tests you will need a Windows box with the WinRM service properly configured. Its easiest to use the Vagrant Windows box in the Vagrantilfe of this repo.

1. Create a Windows VM with WinRM configured (see above).
2. Copy the config-example.yml to config.yml - edit this file with your WinRM connection details.
3. Run `bundle exec rake integration`

## WinRM-multi Author
* Matt Wrock (https://github.com/mwrock)

[Contributors](https://github.com/WinRb/winrm-elevated/graphs/contributors)
