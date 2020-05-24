class_name Attack
extends State

func enter():
    Game.Animator.animate(owner, "idle")

func _on_Weapon_attack_finished():
    emit_signal("finished", Constants.STATES.PREVIOUS)
