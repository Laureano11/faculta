import ninos.*
class Barrios {
	var property habitantes= []
	
	method tresMejoresNinos(){
		return habitantes.sortedBy{habitante1, habitante2 => habitante1.cantidadCaramelos()>habitante2.cantidadCaramelos()}.take(3)
	}
	method elementosUsados(){
		return self.ninosCon10Caramelos().map{ninos=>ninos.elementos()}.asSet()
	}
	method ninosCon10Caramelos(){
		return habitantes.filter{habitante => habitante.cantidadCaramelos()>10}
	}
}
