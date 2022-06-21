import ninos.*
class Adultos{
	var property ninosQueIntentaronAsustar= []
	
	
	method asustarse(nino){	
	}
	method tolerancia(){
		return 10 * self.ninosConMasDe15Caramelos()
	}
	method ninosConMasDe15Caramelos(){
		return ninosQueIntentaronAsustar.filter{nino=>nino.cantidadCaramelos()>15}.size()
	} 
	
}



object adultosComunes inherits Adultos{
	override method asustarse(nino){
		if (self.tolerancia()<nino.capacidadDeSusto()){
			nino.recibirCaramelos(self.tolerancia()/2)
		}
		ninosQueIntentaronAsustar.add(nino)	
	}
}

object adultosNecios inherits Adultos{
	override method asustarse(nino){		
	}
}

object abuelos inherits Adultos{
	override method asustarse(nino){
		nino.recibirCaramelos(self.tolerancia()/4)
		ninosQueIntentaronAsustar.add(nino)
	}
	
}

