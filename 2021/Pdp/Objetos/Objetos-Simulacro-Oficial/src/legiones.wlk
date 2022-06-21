import ninos.*
class Legion {
	
	var property integrantes=[]
	
	method capacidadDeSusto(){
		return integrantes.map{nino=>nino.capacidadDeSusto()}.sum()
	}
	method cantidadCaramelos(){
		return integrantes.map{nino=>nino.cantidadCaramelos()}.sum()
	}
	method asustar(adulto){
		adulto.asustarse(self)
	}
	method recibirCaramelos(cantidad){
		self.lider().recibirCaramelos(cantidad)
	}
	method lider(){
		return integrantes.sortedBy{integrante1, integrante2=> integrante1.capacidadDeSusto()>integrante2.capacidadDeSusto()}.first()
	}
}
