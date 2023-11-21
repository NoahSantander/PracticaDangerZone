import Empleados.*

class Mision {
	const habilidadesRequeridas
	const peligrosidad
	
	method cumpleHabilidades(empleado) =  habilidadesRequeridas.
											all({ habilidad => empleado.puedeUsar(habilidad) })

	method cumplirMision(empleado) {
		if(self.cumpleHabilidades(empleado))
			empleado.recibirDano(peligrosidad)
	}
}