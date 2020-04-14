package com.vasquezhouse.pokemondeckwizard

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
class PokemonDeckWizardApplication

fun main(args: Array<String>) {
	runApplication<PokemonDeckWizardApplication>(*args)
}

// todo: replace dockerfile with a buildpack
// todo: image version matching app version
// todo: image version is hardcoded at 0.1.${build-num}
