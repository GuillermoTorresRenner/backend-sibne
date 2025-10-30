---
applyTo: '**'
---
Integraremos la clave única como método de autenticación en tu aplicación. Sigue estos pasos para completar la integración:


1. Implementación de Autenticación ClaveÚnica en NestJS (TypeScript)
El proceso de autenticación de ClaveÚnica se basa en el flujo "Authorization Code Flow" de OpenID Connect/OAuth 2.0. Todos los servicios deben utilizar HTTPS con TLS 1.2 o superior.
Requisitos y Configuración Inicial
Es fundamental no almacenar las credenciales (client_secret) directamente en el código fuente; deben gestionarse a través de variables de entorno (por ejemplo, usando el módulo ConfigService de NestJS).
Variables de Entorno Requeridas:
Variable
Uso
CLAVEUNICA_CLIENT_ID
Identificador de la integración.
CLAVEUNICA_CLIENT_SECRET
Secreto asociado a la integración.
CLAVEUNICA_REDIRECT_URI
La URI de callback registrada, por ejemplo: https://miweb.cl/claveunica/callback.
Endpoints de ClaveÚnica (a usar en el código):
Funcionalidad
Método
URL Base
Referencia
Autorización (Login)
GET
https://accounts.claveunica.gob.cl/openid/authorize/
Token (Backend)
POST
https://accounts.claveunica.gob.cl/openid/token/
Información Usuario (Backend)
POST
https://accounts.claveunica.gob.cl/openid/userinfo/
Cierre de Sesión
GET
https://accounts.claveunica.gob.cl/api/v1/accounts/app/logout
Estructura Conceptual del Código en NestJS (TypeScript)
Paso 1: Crear Token de estado anti-falsificación (state)
En NestJS, esto se implementaría en un servicio de autenticación o en la función que maneja la solicitud de login. El token debe ser único por sesión (una cadena aleatoria de 30 o más caracteres o un hash) y almacenarse temporalmente (por ejemplo, en la sesión HTTP o en una caché temporal asociada a la solicitud).
auth.service.ts (Conceptual)
import { Injectable } from '@nestjs/common';
import { randomBytes } from 'crypto';

@Injectable()
export class AuthService {
  // Función que genera y almacena el state para la sesión actual
  generateStateToken(req: any): string {
    const state = randomBytes(16).toString('hex');
    // **NOTA:** Aquí se debe almacenar 'state' en la sesión del usuario para validación posterior (Paso 3)
    // Por ejemplo: req.session.cu_state = state;
    return state;
  }
}
Paso 2: Enviar una solicitud de autenticación
Esto se maneja en un controlador de NestJS que intercepta la solicitud /login y redirige al usuario al endpoint de autorización de ClaveÚnica.
auth.controller.ts
import { Controller, Get, Redirect, Req } from '@nestjs/common';
import { AuthService } from './auth.service';
import { ConfigService } from '@nestjs/config';

@Controller('claveunica')
export class AuthController {
  constructor(
    private readonly authService: AuthService,
    private readonly configService: ConfigService,
  ) {}

  @Get('login')
  @Redirect()
  login(@Req() req) {
    // 1. Crear Token de estado anti-falsificación (Paso 1)
    const state = this.authService.generateStateToken(req); 
    
    // 2. Parámetros requeridos para la solicitud GET [8, 10]
    const client_id = this.configService.get('CLAVEUNICA_CLIENT_ID');
    const redirect_uri = this.configService.get('CLAVEUNICA_REDIRECT_URI');
    
    // El 'scope' debe ser 'openid run name' [8]
    const params = new URLSearchParams({
      client_id: client_id,
      response_type: 'code', // Siempre 'code' [8]
      scope: 'openid run name', 
      redirect_uri: redirect_uri, // Debe estar codificada en formato URL [10]
      state: state,
    });
    
    const urlAutorizacion = `https://accounts.claveunica.gob.cl/openid/authorize/?${params.toString()}`;
    
    return { url: urlAutorizacion, statusCode: 302 }; // Redirige al navegador
  }
}
Paso 3 y Paso 4: Confirmar state y Cambiar code por access_token
El callback es la ruta registrada que recibe la respuesta de ClaveÚnica. Este endpoint recibe el code y state como parámetros de consulta. El Paso 4 es una llamada POST server-to-server.
auth.controller.ts (Continuación)
// Requiere la inyección del HttpService de NestJS (Module: @nestjs/axios)

@Get('callback')
async callback(@Req() req, @Query('code') code: string, @Query('state') state: string) {
    // 1. Confirmar el Token de estado anti-falsificación (Paso 3)
    // **NOTA:** Asumiendo que el 'state' original se guardó en la sesión:
    // const originalState = req.session.cu_state;
    // if (state !== originalState) {
    //    throw new Error('CSRF/State mismatch error'); // FALLA DE SEGURIDAD
    // }

    // 2. Cambiar el código de autorización por el token de acceso (Paso 4)
    // Esta lógica se encapsula en el servicio.
    try {
        const tokenData = await this.authService.getTokens(code, state);
        
        // El tokenData contiene el access_token y expires_in [17].
        const access_token = tokenData.access_token;

        // Continuar con el Paso 5/6: Obtener información del ciudadano
        const userInfo = await this.authService.getUserInfo(access_token);
        
        // **3. Autenticar localmente:**
        // Usar la información (RUN) de userInfo para crear una sesión local para el usuario.
        // const run = userInfo.RolUnico.numero; [18]
        // ... Lógica de sesión local ...
        
        return { message: 'Autenticación exitosa', user: userInfo };
        
    } catch (error) {
        // Manejo de errores (código expirado, credenciales incorrectas, etc.) [11]
        console.error('Error durante el intercambio de tokens:', error);
        return { message: 'Fallo en la autenticación' };
    }
}
auth.service.ts (Implementación del Paso 4 y 6)
El servicio gestiona las llamadas POST server-to-server, asegurando que el client_secret nunca se exponga.
import { HttpService } from '@nestjs/axios';
import { ConfigService } from '@nestjs/config';
import { lastValueFrom } from 'rxjs';

// Interfaz conceptual para la respuesta de /userinfo [18, 19]
interface UserInfo {
    sub: string;
    RolUnico: { DV: string; numero: number; tipo: string };
    name: { apellidos: string[]; nombres: string[] };
}

@Injectable()
export class AuthService {
    constructor(
        private readonly httpService: HttpService,
        private readonly configService: ConfigService,
    ) {}

    // Paso 4: Cambiar código por token de acceso
    async getTokens(code: string, state: string): Promise<any> {
        const client_id = this.configService.get('CLAVEUNICA_CLIENT_ID');
        const client_secret = this.configService.get('CLAVEUNICA_CLIENT_SECRET');
        const redirect_uri = this.configService.get('CLAVEUNICA_REDIRECT_URI');

        // Los parámetros se envían en el cuerpo (Body) del POST como x-www-form-urlencoded [9]
        const body = {
            client_id,
            client_secret,
            redirect_uri,
            grant_type: 'authorization_code', // Siempre 'authorization_code' [20]
            code,
            state,
        };

        const tokenUrl = 'https://accounts.claveunica.gob.cl/openid/token/'; // [11]

        // Ejecución de la solicitud POST
        const response$ = this.httpService.post(
            tokenUrl, 
            new URLSearchParams(body).toString(), // Formato application/x-www-form-urlencoded [21]
            {
                headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' }, // [22]
            },
        );

        const response = await lastValueFrom(response$);
        return response.data; // Contiene access_token, token_type, expires_in, id_token [17]
    }

    // Paso 6: Obtener información de ciudadano
    async getUserInfo(accessToken: string): Promise<UserInfo> {
        const userinfoUrl = 'https://accounts.claveunica.gob.cl/openid/userinfo/'; // [12]

        // El Token de Acceso se envía en el header 'Authorization' [12]
        const response$ = this.httpService.post(userinfoUrl, {}, {
            headers: {
                Authorization: `Bearer ${accessToken}`, // [12]
            },
        });

        const response = await lastValueFrom(response$);
        
        // NOTA: El identificador de la persona es el RUN (RolUnico.numero) [18]
        return response.data; 
    }
}
Paso 7: Cierre de Sesión
El cierre de sesión debe ser explícito (si el usuario presiona un botón) y se realiza llamando al endpoint de logout de ClaveÚnica.
auth.controller.ts (Continuación)
@Get('logout')
@Redirect()
logout(@Req() req) {
    // 1. Cierre de sesión local (borrar cookies/sesión de NestJS)
    // req.session.destroy(); 
    // ... Lógica de cierre de sesión local ...

    // 2. Redirigir al endpoint de cierre de ClaveÚnica (Paso 7)
    const logoutUri = this.configService.get('CLAVEUNICA_LOGOUT_URI_APLICACION'); 
    
    // Método 1: con redirección inmediata [13]
    const cuLogoutUrl = `https://accounts.claveunica.gob.cl/api/v1/accounts/app/logout?redirect=${logoutUri}`;
    
    return { url: cuLogoutUrl, statusCode: 302 }; 
    // NOTA: La aplicación debe tener un endpoint '/logout' (coincidiendo con logout_uri)
    // para manejar la respuesta final tras el cierre en CU.
}