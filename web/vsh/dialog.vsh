#!/usr/bin/env -S v run

src := join_path(dir(dir(executable())),"src")

mut li := []string{}
for vue in ls(join_path(src,"dialog"))?{
	if vue.ends_with(".vue"){
		li << vue#[..-4]
	}
}

out := li.join(" ")

write_file(
	join_path(src,"config/dialog.js"),
	"export default '$out'"
)?
