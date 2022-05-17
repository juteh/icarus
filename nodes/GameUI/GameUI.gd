extends CanvasLayer

var distanceLabelX: Label = null
var distanceLabelY: Label = null
var angleLabel: Label = null
var scoreLabel: Label = null
var roundLabel: Label = null

func _ready():
	distanceLabelX = $DistanceLabelX
	distanceLabelY = $DistanceLabelY
	angleLabel = $AngleLabel
	scoreLabel = $ScoreLabel
	roundLabel = $RoundLabel
	scoreLabel.visible = false;

func _process(_delta):
	roundLabel.text = "Round " + str(GameStatus.landedProjectiles.size() + 1)
	if (GameStatus.projectileInstance):
		distanceLabelX.text = "Distance X: " + str(GameStatus.projectileInstance.position.x)
		distanceLabelY.text = "Distance Y: " + str(GameStatus.projectileInstance.position.y)
		angleLabel.text = "Angle: " + str(GameStatus.projectileInstance.rotation)
	if (GameStatus.isLanded):
		scoreLabel.text = "Es ist " + str(stepify(GameStatus.projectileInstance.position.x / 100, 0.01)) + "m geflogen!"
		scoreLabel.visible = true
