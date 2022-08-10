extends CanvasLayer

onready var distanceLabelX: Label = $DistanceLabelX
onready var distanceLabelY: Label = $DistanceLabelY
onready var angleLabel: Label = $AngleLabel
onready var scoreLabel: Label = $ScoreLabel
onready var roundLabel: Label = $RoundLabel
onready var maxFlapsLabel: Label = $MaxFlapsLabel
onready var maxFlapsProgressBar: TextureProgress = $MaxFlapsProgressBar

func _ready():
	scoreLabel.visible = false
	maxFlapsLabel.visible = false

func _process(_delta):
	roundLabel.text = "Round " + str(GameStatus.projectileResults.size() + 1)
	if (GameStatus.projectileInstance):
		maxFlapsLabel.visible = true
		distanceLabelX.text = "Distance X: " + str(GameStatus.projectileInstance.position.x)
		distanceLabelY.text = "Distance Y: " + str(GameStatus.projectileInstance.position.y)
		angleLabel.text = "Angle: " + str(GameStatus.projectileInstance.rotation)
		maxFlapsLabel.text = "Boost: " + str(GameStatus.projectileInstance.impulseAttempts)
		maxFlapsProgressBar.value = GameStatus.projectileInstance.impulseAttempts
	if (GameStatus.isLanded):
		scoreLabel.text = str(stepify(GameStatus.projectileInstance.position.x / 100, 0.01)) + "m!"
		scoreLabel.visible = true
		maxFlapsLabel.visible = false
	else:
		scoreLabel.visible = false
