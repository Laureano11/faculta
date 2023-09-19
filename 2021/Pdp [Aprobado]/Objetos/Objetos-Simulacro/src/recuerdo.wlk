import emociones.*
class Recuerdo {
	const property descripcion
	const property emocionDominante
	
	
	method asentarse(unaPersona){
		emocionDominante.asentarRecuerdo(self,unaPersona)
		
	}
	method masDe10Palabras(){
		return descripcion.words().size()>10
	}
}
