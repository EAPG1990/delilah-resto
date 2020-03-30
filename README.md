# Delilah Restó

Pasos requeridos para inicializar el servidor:

1. Iniciar Apache y MySQL en servidor XAMPP. 
2. Copiar las queries del archivo **DB.sql** y correrlas en la consola sql. Estas querys te permite crear la base de datos, tablas, relaciones entre tablas e insertar 2 usuarios (ADMIN y NO_ADMIN) y 6 productos.
3. git clone https://github.com/eapg1990/delilah-resto.git
4. npm install
5. nodemon index.js

## Checklist

### 1. Poder registrar un nuevo usuario

Ir a postman, y realizar un post al endpoint http://127.0.0.1:3000/register con el siguiente modelo de body:
{
        "user": "usuario1",
        "fullname": "Nombre Apellido",
        "email": "usuario1@gmail.com",
        "phone": "+54 911 12345678",
        "shipping_address": "CABA, Argentina",
        "password": "1234"
 }
1. Si el usuario no esta registrado en la DB , el servidor responderá 201 con un mensaje de "Usuario Registrado".
2. Si falta algunos de los datos, el servidor responderá 404 con un mensaje de "faltan datos".
3. Si el usuario se encuentra ya registrado en la base de datos, el servidor responderá 409 con un mensaje de "user o email registrado".
4. Si el formato del email es erróneo, el servidor responderá 409 con un mensaje de "formato de email incorrecto".

### 2. Un usuario debe poder listar todos los productos disponibles

Para listar todos los productos disponibles es necesario estar logueado, de lo contrario el servidor responderá 401 con un mensaje de "Error al validar usuario"

Se puede usar la cuenta de admin o cliente generadas por defecto en la creación de la DB. Se puede loguear usando user o email.
{
        "user": "emma",
        "password": "1234"
 }

El servidor responderá un 200 con un token. En postman realizar un get al endpoint http://127.0.0.1:3000/products con el Header:

Authorization: Bearer token

El servidor responderá 200 con el listado de platos con su respectiva información.

### 3. Un usuario debe poder generar un nuevo pedido al Restaurante con un listado de platos que desea.

Copiar el token en el header del endpoint http://127.0.0.1:3000/orders  y hacer un post con el siguiente modelo de body:
{ 
	"orderProducts": [ 
			{ 
	"idProduct": 1, 
	"amount": 1 
	},
	{ 
	"idProduct": 2, 
	"amount": 2
	}, 
	{ 
	"idProduct": 3, 
	"amount": 3 
	} 
	], 
	"payment": "EFECTIVO" 
}

Donde idProduct será el id del producto, se puede probar con ids 1-6, amount es la cantidad que se desea de ese producto y payment será "EFECTIVO" o "TARJETA".

1. Si uno de los idProduct no esta en la base de dato el servidor responderá 404 con un mensaje de "uno de los platos no esta disponible".
2. Si uno de los métodos de pago no es el correcto el servidor responderá 400 con el mensaje de "método de pago invalido"

Si todos los datos están bien, el servidor responderá con 200 con el mensaje de "¡Recibimos tu pedido! ${user.fullname}, gracias por pedir a Delilah.".

### 4. El usuario con roles de administrador debe poder actualizar el estado del pedido.

Copiar el token en el header del endpoint http://127.0.0.1:3000/orders/:id  y hacer un post con el siguiente modelo de body:
{
        "newState": "CONFIRMADO"
}
newStatus puede ser : CONFIRMADO, PREPARANDO, ENVIADO, CANCELADO y ENTREGADO.

1. Si el :id no esta registrado en la DB, el servidor responderá 404 con el mensaje de "no hay pedido registrado con ese id".
2. El estado debe ser uno de los permitidos, en caso contrario el servidor responderá 400 con el mensaje "estado no valido". **Nota**: el estado Nuevo no es permitido ya que viene por defecto cuando se realiza un nuevo pedido.
3. Si el usuario **NO** es admin el servidor responderá 403 con el mensaje de "no posee privilegios".

Si todos los datos están bien, el servidor responderá con 200 con el mensaje de "Estado modificado con éxito".

### 5. Un usuario con rol de administrador debe poder realizar las acciones de creación, edición y eliminación de recursos de productos (CRUD de productos).

El usuario **NO_ADMIN** solo tendrá acceso GET products y GET products/:id. Para las demás rutas el servidor responderá 403 con el mensaje "no posee privilegios".

Loguearse con usuario **ADMIN** y colocar el token generado en el header de las siguientes rutas:

**Crear producto**: realizar un post al endpoint http://127.0.0.1:3000/products con el siguiente modelo de body:
{
  "name": "nuevo plato",
  "description": "descripcion del plato",
  "cost": 200,
  "url": "link de imagen del plato"
}

1. Si faltan los datos name y cost el servidor responderá 400 con el mensaje "faltan datos".
2. Si el name ya se encuentra registrado en la DB el servidor responderá 409 con el mensaje de "Ya se encuentra un producto registrado con este name".
3. En caso de que falten los datos de description y url, estos se definen con un valor default. Description: "no description" y URL : "link de no imagen".

Si todos los datos están bien, el servidor responderá con 200 con el mensaje de "Producto creado con éxito".

**Leer producto**: realizar un get al endpoint http://127.0.0.1:3000/products

**Leer producto por id**: realizar un get al endpoint http://127.0.0.1:3000/products/:id

Si el id no se encuentra en la DB el servidor responderá 404 con el mensaje de "no se encuentra un plato registrado con ese id". En caso contrario en servidor responderá  200 con la información del producto.

**Editar producto**: realizar un put al endpoint http://127.0.0.1:3000/products/:id y colocar en el body los datos que se quieren actualizar:
{
      "name": "Name producto",
        "description": "descripción",
        "cost": 100,
        "url": "link"
}

Si el name se encuentre registrado en la DB el servidor responderá 409 con el mensaje de "Ya se encuentra un producto registrado con este name". En caso contrario el servidor responderá 200 con el mensaje de "Producto modificado".

**Eliminar producto**: realizar un delete al endpoint http://127.0.0.1:3000/products/:id

Si el id no se encuentra en la DB el servidor responderá 404 con el mensaje de "no se encuentra un plato registrado con ese id". En caso contrario en servidor responderá  204.

### 6. Un usuario sin roles de administrador no debe poder crear, editar o eliminar un producto, ni editar o eliminar un pedido. Tampoco debe poder acceder a informaciones de otros usuarios.

**Eliminar un pedido**: realizar un delete al endpoint http://127.0.0.1:3000/orders/:id.

**Información de usuarios**: realizar un get al endpoint http://127.0.0.1:3000/customers.

Si el usuario es **ADMIN** puede acceder a la información de todos los usuarios. En caso contrario, solo podra acceder a su propia información
