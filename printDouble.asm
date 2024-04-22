.data
	myDouble: .double 3.1415

.text
	li  $v0,  3
	l.d $f12, myDouble
	syscall