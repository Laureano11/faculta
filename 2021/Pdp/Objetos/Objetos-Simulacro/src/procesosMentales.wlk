object asentamiento{
	method aplicarse(persona){
		persona.asentarTodosRecuerdosDelDia()
	}
}

object asentamientoSelectivo{
	method aplicarse(persona,palabraClave){
		const recuerdosClaves = persona.recuerdosDelDia().filter{recuerdo=> recuerdo.descripcion().contains(palabraClave)}
		persona.asentarRecuerdos(recuerdosClaves)
		
	}
}
object profundizacion{
	
}