(define (domain desplazamientos-basico)
    (:requirements :adl :typing)

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

    ;;PREDICADOS:
    (:predicates
        (peticion ?rec - recurso ?baseDestino - base)      ;;Peticion de un recurso a una base destino
        (posicionRecurso ?rec - recurso ?b - base)             ;;Posicion de un recurso
        (posicionRover ?rover - rover ?b - base)               ;;Posicion de un rover
        (basesAdyacentes ?b1 - base ?b2 - base)                ;;Marca si se puede ir directamente desde una base a otra
        (transporta ?rover - rover ?rec - recurso)             ;;Dice si un rover lleva un recurso
        (entregado ?rec - recurso)                             ;;Dice si un recurso ya ha sido entregado en una base desde la que se ha pedido
    ) 

    ;;ACCIONES
    ;;Mueve rover de b1 a b2 y deja todos los recursos que lleve cuya destinacion sea b2
    (:action mover
        :parameters (?rover - rover ?b1 - base ?b2 - base)
        :precondition (and
                        (basesAdyacentes ?b1 ?b2)
                        (posicionRover ?rover ?b1))
        :effect (and
                    (posicionRover ?rover ?b2)
                    ;;DEJAR RECURSOS
                    (forall (?rec - recurso)
                        (when (and
                            (transporta ?rover ?rec)
                            (peticion ?rec ?b2))
                        (and
                            (not (transporta ?rover ?rec))
                            (entregado ?rec)
                            (not (peticion ?rec ?b2))))))
    )

    ;;Coger recurso
    ;;Añade un recurso a la carga del rover
    (:action coger
        :parameters (?rover - rover ?base - base ?rec - recurso)
        :precondition (and
                        (posicionRecurso ?rec ?base)
                        (posicionRover ?rover ?base)
                        (not (entregado ?rec)))
        :effect (and
                (not (posicionRecurso ?rec ?base))
                (transporta ?rover ?rec))
    )
)
