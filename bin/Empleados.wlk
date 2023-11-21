import Misiones.*

class Empleado {
	var tipo
	var salud
	const habilidades
	method tipo(nuevoTipo) {
		tipo = nuevoTipo
	}
	
	method aprenderHabilidad(habilidad) {
		habilidades.add(habilidad)
	}
	method aprenderHabilidades(habilidadesNuevas) = habilidadesNuevas.forEach({ habilidad => self.aprenderHabilidad(habilidad) })
	
	method saludCritica() = tipo.saludCritica()
	method estaIncapacitado() = salud < self.saludCritica()
	method restarSalud(dano) {
		salud -= dano
	}
	
	method sobrevivio() = salud > 0
	
	method tieneHabilidad(habilidad) = habilidades.contains(habilidad)
	method puedeUsarHabilidad(habilidad) =  !self.estaIncapacitado() && self.tieneHabilidad(habilidad)
	
	method recibirDano(dano) {
		self.restarSalud(dano)
		if(self.sobrevivio())
			tipo.completarMision(self)
	}
}

class Espia {
	method saludCritica() = 15
	
	method completarMision(empleado, habilidades) {
		empleado.aprenderHabilidades(habilidades)
	}
}

class Oficinista {
	var cantEstrellas
	method sumarEstrella(empleado) {
		cantEstrellas += 1
		if(cantEstrellas == 3)
			empleado.tipo(new Espia()) 
	}
	
	method saludCritica() = 40 - 5 * cantEstrellas 
	
	method completarMision(empleado, _) {
		self.sumarEstrella(empleado)
	}
}

class Jefe inherits Empleado {
	const subordinados
	
	method algunoLaPuedeUsar(habilidad) = subordinados.any({ subordinado => subordinado.puedeUsarHabilidad(habilidad) })
	
	override method tieneHabilidad(habilidad) = super(habilidad) || self.algunoLaPuedeUsar(habilidad)
	override method puedeUsarHabilidad(habilidad) = !self.estaIncapacitado() && self.tieneHabilidad(habilidad)
}
