(define (domain desplazamientos-ext2)
    (:requirements :adl :typing :fluents)

    ;;OBJETOS: 
    (:types 
        recurso - object
        persona - recurso
        suministro - recurso
        base - object
        asentamiento - base
        almacen - base
        rover - object
    )

    (:functions
        (numPersonas ?rover - rover)        ;;Cuenta el numero de personas que hay en un rover
        (combustible ?rover - rover)               ;;Cuenta el combustible que queda en un rover
        (sumaCombustible)                   ;;Cuenta la suma de combustible total que queda entre todos los rovers
    )

    ;;PREDICADOS:
    (:predicates
        (peticion ?rec - recurso ?baseDestino - base)       ;;Peticion de un recurso a una base destino
        (posicionRecurso ?rec - recurso ?b - base)            ;;Posicion de un recurso
        (posicionRover ?rover - rover ?b - base)            ;;Posicion de un rover
        (basesAdyacentes ?b1 - base ?b2 - base)             ;;Marca si se puede ir directamente desde una base a otra
        (transportaSuministro ?rover - rover ?sum - suministro)      ;;Dice si un rover lleva un suministro
        (transportaPersona ?rover - rover ?per - persona)       ;;Dice si un rover lleva una persona
        (llevaSuministro ?rover - rover)                    ;;Dice si un rover lleva algun recurso cualquiera
        (entregado ?rec - recurso)                          ;;Dice si un recurso ya ha sido entregado en alguna base desde la que se he pedido
    ) 

    ;;ACCIONES
    ;;Mueve rover de b1 a b2
    (:action mover
        :parameters (?rover - rover ?b1 - base ?b2 - base)
        :precondition (and
                        (basesAdyacentes ?b1 ?b2)
                        (posicionRover ?rover ?b1)
                        (> (combustible ?rover) 0))
        :effect (and
            (posicionRover ?rover ?b2)
            (not (posicionRover ?rover ?b1))
            (decrease (combustible ?rover) 1)
            (decrease (sumaCombustible) 1))
    )

    ;;Coger suministro
    ;;Sube un suministro al rover
    (:action cogerSuministro
        :parameters (?rover - rover ?pos - base ?sum - suministro)
        :precondition (and
                        (posicionRover ?rover ?pos)
                        (posicionRecurso ?sum ?pos)
                        (not (entregado ?sum))
                        (not (llevaSuministro ?rover))
                        (= (numPersonas ?rover) 0))
        :effect (and
                    (llevaSuministro ?rover)
                    (transportaSuministro ?rover ?sum)
                    (not (posicionRecurso ?sum ?pos)))
    )


    ;;Coger persona
    ;;Sube a una persona al rover
    (:action cogerPersona
        :parameters (?rover - rover ?pos - base ?per - persona)
        :precondition (and
                        (posicionRover ?rover ?pos)
                        (posicionRecurso ?per ?pos)
                        (not (entregado ?per))
                        (not (llevaSuministro ?rover))
                        (<= (numPersonas ?rover) 1))
        :effect (and
                    (increase (numPersonas ?rover) 1)
                    (transportaPersona ?rover ?per)
                    (not (posicionRecurso ?per ?pos)))
    )


    ;;Dejar suministro en su destino
    ;;Deja un suministro en una destinacion que haya sido determinada por un pedido
    (:action dejarSuministro
        :parameters (?rover - rover ?pos - base ?sum - suministro)
        :precondition (and
                        (posicionRover ?rover ?pos)
                        (peticion ?sum ?pos)
                        (transportaSuministro ?rover ?sum))
        :effect (and 
                    (not (transportaSuministro ?rover ?sum))
                    (not (llevaSuministro ?rover))
                    (not (peticion ?sum ?pos))
                    (posicionRecurso ?sum ?pos)
                    (entregado ?sum))
    )


    ;;Dejar persona en su destino
    ;;Deja una persona en una destinacion que haya sido determinada por un pedido
    (:action dejarPersona
        :parameters (?rover - rover ?pos - base ?per - persona)
        :precondition (and
                        (posicionRover ?rover ?pos)
                        (peticion ?per ?pos)
                        (transportaPersona ?rover ?per)
                        (> (numPersonas ?rover) 0))
        :effect (and 
                (not (transportaPersona ?rover ?per))
                (decrease (numPersonas ?rover) 1)
                (not (peticion ?per ?pos))
                (posicionRecurso ?per ?pos)
                (entregado ?per))
    )
)