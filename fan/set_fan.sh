#!/usr/bin/expect -f

set script_dir [file dirname [file normalize [info script]]]

# Get the commands to run, one per line
set f [open "${script_dir}/fan_cmd"]
set commands [split [read $f] "\n"]
close $f

set timeout 180
spawn ssh $env(ILO_SSH_ADDRESS)

foreach cmd $commands {
	if { $cmd == "" || [string match "#*" $cmd] } {
		continue
	}
	expect "</>hpiLO->"
	send "$cmd\r"
}
