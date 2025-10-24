---
applyTo: '**'
---

# instrucciones Generales
- Trabajkaremos en la refactorizacioń del login de usuarios.
- El flujo básico del login se encuentra ya establecido en el módulo Auth.
- El módulo Auth se encuentra en la carpeta `src/modules/auth`.
- Se encontraba establecido par la entidad Usuarios la cual ya no existe en la base de datos, aunque su modulo de nest sigue estando yu debe sser la base para esta refactorización del login.
- La nueva entidad que se usará para el login es Contacto.
- La entidad Contacto se encuentra en la carpeta `src/modules/contactos`.
- El login debe permitir a los usuarios autenticarse usando su email y contraseña.
- Se debe implementar la generación y validación de tokens JWT para la autenticación tal cual se hacía en el flujo que usaba Usuarios.
- Se debe asegurar que las contraseñas se manejen de manera segura, utilizando hashing y salting.
- Se debe seguir  teniendo en cuenta la generaciópn también de los tokens de refresco.
-Cuando un usuario inicie sesión correctamente, se debe registrar un log en la tabla de Contacto login, po lo que hay que crear esa entidad también y su respectivo módulo en nest.
Se cuando se registre inicio de sesión se debe establecer por defecto que se haga con el LoginProvider   EMAIL_Y_PASSWORD, el cual se encuentra declarado como un enum en la entidad ContactoLogin.
