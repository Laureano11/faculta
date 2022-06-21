import recuerdo.*
class Persona{
	var property felicidad
	var property emocionDominante
	var property recuerdosDelDia= []
	var property pensamientoCentral= #{}
	var property procesosMentales= []
	
	method vivir(unEvento){
		const recuerdo= new Recuerdo(descripcion= unEvento, emocionDominante=self.emocionDominante())
		recuerdosDelDia.add(recuerdo)
		
	}
	method disminuirFelicidad(porcentaje){
		felicidad = felicidad*(100-porcentaje)/100
		
		if (felicidad<1){
			throw new Exception(message = "La felicidad no puede disminuir a mas de 1")
		}
		
	}
	
	method recuerdosRecientes(){
		return recuerdosDelDia.reverse().take(5)
	}
	method pensamientoCentralesDificiles(){
		return self.pensamientoCentral().filter{pensamiento => pensamiento.masDe10Palabras()}
	}
	method addPensamientoCentral(recuerdo){
		recuerdosDelDia.add(recuerdo)
	}
	
	method descansar(){
		emocionDominante.negarRecuerdos(self.recuerdosDelDia())
		procesosMentales.map{procesoMental=> }
	}
	
	method asentarRecuerdos(recuerdos){
		recuerdos.forEach{recuerdo=>recuerdo.asentarse(self)}
	}
	method asentarTodosRecuerdosDelDia(){
		recuerdosDelDia.forEach({recuerdo=> recuerdo.asentarse(self)})
	}
}


