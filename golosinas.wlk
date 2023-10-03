/*
 * Los sabores
 */
object frutilla { }
object chocolate { }
object vainilla { }
object naranja { }
object limon { }


/*
 * Golosinas
 */
 
class Golosina {
	var peso = 0
	method peso() = peso
	
}
class Bombon inherits Golosina{
	
	method precio() { return 5 }
	method mordisco() { peso = peso * 0.8 - 1 }
	method sabor() { return frutilla }
	method libreGluten() { return true }
}

class BombonDuro inherits Bombon {
	override method mordisco() { peso -= 1 }
	method dureza() = if(peso >= 12) { 3 } else if (peso >= 8 ) { 2 } else { 1 }
}

/*
var bombon = new Bombon() 
bombon.mordisco() self
bombon.peso()  self
bombon = new BombonDuro() 
bombon.mordisco() self
bombon.peso() clase Bombon 
 
 */

class Alfajor inherits Golosina{
	
	method precio() { return 12 }
	method mordisco() { peso = 0.max(peso - 1) }
	method sabor() { return chocolate }
	method libreGluten() { return false }
}

class Caramelo inherits Golosina{
	var sabor

	method precio() { return 12 }
	method mordisco() { peso = peso - 1 }
	method sabor() { return sabor }
	method libreGluten() { return true }
}

class CarameloRelleno inherits Caramelo {
	override method mordisco(){ 
		peso = peso - 1
		sabor = chocolate
	}
	override method precio() { return 13 }
}

class Chupetin inherits Golosina{
	
	method precio() { return 2 }
	method mordisco() { 
		if (peso >= 2) {
			peso = peso * 0.9
		}
	}
	method sabor() { return naranja }
	method libreGluten() { return true }
}

class Oblea inherits Golosina{
	
	method precio() { return 5 }
	method mordisco() {
		if (peso >= 70) {
			// el peso pasa a ser la mitad
			peso = peso * 0.5
		} else { 
			// pierde el 25% del peso
			peso = peso - (peso * 0.25)
		} 
		peso = peso - self.pesoConCondicion()
	}	
	method pesoConCondicion() = 0
	method sabor() { return vainilla }
	method libreGluten() { return false }
}

class ObleaCrujiente inherits Oblea {
	var mordidas = 0
	override method pesoConCondicion(){ 
		if(mordidas < 3){  
			mordidas += 1
			return 3
		}
		return 0
	}
	
	method estaDebil() = mordidas > 3
	
}

class Chocolatin inherits Golosina{
	// hay que acordarse de *dos* cosas, el peso inicial y el peso actual
	// el precio se calcula a partir del precio inicial
	// el mordisco afecta al peso actual
	var comido = 0
	
	method pesoInicial(unPeso) { peso = unPeso }
	method precio() { return peso * 0.50 }
	override method peso() { return (peso - comido).max(0) }
	method mordisco() { comido = comido + 2 }
	method sabor() { return chocolate }
	method libreGluten() { return false }

}

class ChocolatinVip inherits Chocolatin {
	var coeficienteHumedad = 0.randomUpTo(1)
	method calculoHumedad() = 1 + coeficienteHumedad
	override method peso() { return (peso - comido) * self.calculoHumedad()}
}

class ChocolatinPremium inherits ChocolatinVip {
	override method calculoHumedad() = 1 + (coeficienteHumedad / 2)
}

class GolosinaBaniada inherits Golosina{
	var golosinaInterior
	var pesoBanio = 4
	
	method golosinaInterior(unaGolosina) { golosinaInterior = unaGolosina }
	method precio() { return golosinaInterior.precio() + 2 }
	override method peso() { return golosinaInterior.peso() + pesoBanio }
	method mordisco() {
		golosinaInterior.mordisco()
		pesoBanio = (pesoBanio - 2).max(0) 
	}	
	method sabor() { return golosinaInterior.sabor() }
	method libreGluten() { return golosinaInterior.libreGluten() }	
}


class Tuttifrutti inherits Golosina {
	var libreDeGluten
	var sabores = [frutilla, chocolate, naranja]
	var saborActual = 0

	
	method mordisco() { saborActual += 1 }	
	method sabor() { return sabores.get(saborActual % 3) }	
	method precio() { return (if(self.libreGluten()) 7 else 10) }
	override method peso() { return 5 }
	method libreGluten() { return libreDeGluten }	
	method libreGluten(valor) { libreDeGluten = valor }
}
