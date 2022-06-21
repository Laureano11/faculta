import persona.*

class Emociones {
	
	method asentarRecuerdo(recuerdo,unaPersona){
		
	}
	method negarRecuerdo(recuerdos){
		return recuerdos
	}
}

object alegre inherits Emociones{
	override method asentarRecuerdo(recuerdo,unaPersona){
		if (unaPersona.felicidad()>500){
			unaPersona.addPensamientoCentral(recuerdo)
		}
		}
	override method negarRecuerdo(recuerdos){
		return recuerdos.filter{recuerdo=>recuerdo.emocionDominante()!= alegre}
	}
	}

object triste inherits Emociones{
	override method asentarRecuerdo(recuerdo,unaPersona){
		unaPersona.addPensamientoCentral(recuerdo)
		unaPersona.disminuirFelicidad(10)
	}
	override method negarRecuerdo(recuerdos){
		return recuerdos.filter{recuerdo=>recuerdo.emocionDominante()== alegre}
	}
	
}

object disgusto inherits Emociones{}
object temeroso inherits Emociones{}
object furioso inherits Emociones{}