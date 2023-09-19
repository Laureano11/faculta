import adultos.*
import estadosSalud.*

class Nino {
	
	var traje
	var maquillaje /*Se entiende que tanto el maquillaje como el traje son 1 solo */
	var property actitud
	var property cantidadCaramelos
	var property estadoSalud
	
	method capacidadDeSusto(){
		return (traje.susto()+maquillaje.susto())*self.actitud()
	}
	method asustar(adulto){
		adulto.asustarse(self)
	}
	method recibirCaramelos(cantidad){
		cantidadCaramelos+= cantidad
	}
	method elementos(){
		return [traje,maquillaje]
	}
	method comerCaramelos(cantidad){
		if (cantidad<=self.cantidadCaramelos() && self.estadoSalud() != enCama){
			cantidadCaramelos-=cantidad
			if (cantidad>10){
				estadoSalud.afectar(self)	
			}	
		}
		else{
			throw new Exception (message="No podes comer caramelos")
		}
	}
	method empacharse(){
		self.estadoSalud(empachado)
		self.actitudALaMitad()
	}
	method irACama(){
		self.estadoSalud(enCama)
		self.bajaSuActitud()
	}

	method bajaSuActitud(){
		actitud=0
	}
	method actitudALaMitad(){
		actitud= actitud/2
	}
}





class Traje{
	var property susto
}
class Maquillaje{
	var property susto=3 
}

const tenebroso= new Maquillaje()
const winniePoh= new Traje(susto=2)
const sullivan= new Traje(susto=2)
const jason= new Traje(susto=5)
const georgebush= new Traje(susto=5)