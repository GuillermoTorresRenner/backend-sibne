/**
 * Enum con los roles de autenticación del sistema
 * Estos valores deben coincidir exactamente con los nombres en la base de datos
 */
export enum AuthRoles {
  ADMINISTRADOR = 'Administrador',
  USUARIO = 'Usuario',
  USUARIO_EMPRESA = 'Usuario Empresa',
}

/**
 * Array con todos los valores de roles disponibles
 * Útil para validaciones y operaciones que requieren todos los roles
 */
export const ALL_AUTH_ROLES = Object.values(AuthRoles);

/**
 * Función helper para validar si un rol es válido
 * @param role - El rol a validar
 * @returns true si el rol es válido, false en caso contrario
 */
export function isValidRole(role: string): boolean {
  return ALL_AUTH_ROLES.includes(role as AuthRoles);
}
