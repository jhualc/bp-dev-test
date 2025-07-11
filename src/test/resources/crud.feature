Feature: Escenarios CRUD de Character (con username en la ruta)

Background:
  # URL base definida en karate-config.js
  * url baseUrl
  # Username de prueba
  * def username = 'hjaimesr'
  # Prefijamos el path general una sola vez
  * path username, 'api', 'characters'
  * def uniq = java.util.UUID.randomUUID() + ''
  * configure headers = { Content-Type: 'application/json' }
  * def newChar =
     """
     {
       "name": "Spider-Man29",
       "alterego": "Peter Parker",
       "description": "Friendly neighbourhood hero",
       "powers": ["wall-crawling", "spider-sense"]
     }
     """

Scenario:  Crear personaje (POST)

  Given request newChar
  When method post
  Then status 201
  And match response.name == newChar.name
  * print 'POST RESPONSE =', response
  * def idTemp = response.id
  * eval karate.set('id', idTemp)
  * print 'ID grabado =', id

Scenario: Crear personaje duplicado – debe fallar con 400

  Given request newChar
  When method post
  Then status 400
  And match response.error == 'Character name already exists'



Scenario: Listar todos (GET /api/characters)
  When method get
  Then status 200
  * print 'ID guardado =', id
  And match response[*].id contains, id

Scenario: Obtener por id (GET /11)
  # Sobre el path ya existente añadimos el id
  Given path 11
  When method get
  Then status 200
  * print 'GET BY ID RESPONSE =', response
  And match response.id == 11
  And match response.name == 'Spider-Man 2099'

Scenario: Actualizar (PUT /11)
  * def upd =
    """
    {
      "name": "Spider-Man 2099",
      "alterego": "Miguel O'Hara",
      "description": "Future hero",
      "powers": ["accelerated vision","enhanced strength"]
    }
    """
  Given path 11
  And request upd
  When method put
  Then status 200
  And match response.name == upd.name

Scenario: Borrar (DELETE /id)
  Given path 14
  When method delete
  Then status 204


