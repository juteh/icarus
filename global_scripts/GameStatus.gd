extends Node

const ATTEMPTS = 5

var projectileExist = false
var hasJumped = false
var isShooted = false
var isLanded = false

var landedProjectiles = []

func reset():
	projectileExist = false
	hasJumped = false
	isShooted = false
	isLanded = false
