// Roles reales de la base de datos
export enum Roles {
  ADMINISTRADOR = 'ADMINISTRADOR',
  USUARIO = 'USUARIO',
  USUARIO_EMPRESA = 'USUARIO EMPRESA',
}

// Función helper para validar roles dinámicos
export function isValidRole(role: string): boolean {
  return (
    Object.values(Roles).includes(role as Roles) ||
    (typeof role === 'string' && role.length > 0)
  );
}
