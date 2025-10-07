// Este enum se mantiene para compatibilidad con decoradores
// pero los roles reales vendrán de la base de datos
export enum Roles {
  ADMIN = 'ADMIN',
  USER = 'USER',
  SUPER_ADMIN = 'SUPER_ADMIN',
  MODERATOR = 'MODERATOR',
}

// Función helper para validar roles dinámicos
export function isValidRole(role: string): boolean {
  return (
    Object.values(Roles).includes(role as Roles) ||
    (typeof role === 'string' && role.length > 0)
  );
}
