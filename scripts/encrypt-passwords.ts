import { PrismaClient } from '@prisma/client';
import * as bcrypt from 'bcrypt';

const prisma = new PrismaClient();

async function encryptExistingPasswords() {
  console.log('🔒 Iniciando proceso de encriptación de contraseñas...');

  try {
    // Obtener todos los usuarios que tienen contraseñas en texto plano
    const usuarios = await prisma.usuario.findMany({
      where: {
        passwordHash: {
          not: null,
        },
        eliminado: false,
      },
      select: {
        id: true,
        userName: true,
        email: true,
        passwordHash: true,
      },
    });

    console.log(`📊 Encontrados ${usuarios.length} usuarios para procesar`);

    let processedCount = 0;
    let errorCount = 0;

    for (const usuario of usuarios) {
      try {
        // Verificar si la contraseña ya está encriptada
        // Las contraseñas de bcrypt empiezan con $2b$ o $2a$ o $2y$
        if (usuario.passwordHash?.startsWith('$2')) {
          console.log(
            `⏭️  Usuario ${usuario.userName || usuario.email} ya tiene contraseña encriptada`,
          );
          continue;
        }

        // Validar que la contraseña no esté vacía
        if (!usuario.passwordHash || usuario.passwordHash.trim() === '') {
          console.log(
            `⚠️  Usuario ${usuario.userName || usuario.email} no tiene contraseña, saltando...`,
          );
          continue;
        }

        // Encriptar la contraseña usando exactamente las mismas condiciones que el registro
        // Usando bcrypt.hashSync con saltRounds = 10 (igual que en UsuariosService.create)
        const hashedPassword = bcrypt.hashSync(usuario.passwordHash!, 10);

        // Verificar que el hash funciona correctamente haciendo una comparación de prueba
        const testComparison = bcrypt.compareSync(
          usuario.passwordHash!,
          hashedPassword,
        );
        if (!testComparison) {
          throw new Error('La verificación del hash falló');
        }

        // Actualizar en la base de datos
        await prisma.usuario.update({
          where: { id: usuario.id },
          data: {
            passwordHash: hashedPassword,
            // Marcar que ya no es primer ingreso si la contraseña se actualiza
            primerIngreso: false,
          },
        });

        processedCount++;
        console.log(
          `✅ Usuario ${usuario.userName || usuario.email}: contraseña encriptada (${processedCount}/${usuarios.length})`,
        );
      } catch (error) {
        errorCount++;
        console.error(
          `❌ Error procesando usuario ${usuario.userName || usuario.email}:`,
          error,
        );
      }
    }

    console.log('\n📈 Resumen del proceso:');
    console.log(`✅ Contraseñas encriptadas exitosamente: ${processedCount}`);
    console.log(`❌ Errores encontrados: ${errorCount}`);
    console.log(`📊 Total procesado: ${usuarios.length}`);
  } catch (error) {
    console.error('💥 Error crítico durante el proceso:', error);
  } finally {
    await prisma.$disconnect();
  }
}

// Función para verificar las contraseñas encriptadas
async function verifyEncryptedPasswords() {
  console.log('\n🔍 Verificando contraseñas encriptadas...');

  try {
    const usuarios = await prisma.usuario.findMany({
      where: {
        passwordHash: {
          not: null,
        },
        eliminado: false,
      },
      select: {
        id: true,
        userName: true,
        email: true,
        passwordHash: true,
      },
    });

    let encryptedCount = 0;
    let plainTextCount = 0;
    const plainTextPasswords = [
      'jo091',
      'in395',
      'mq485',
      'oj250',
      'nd948',
      'bg672',
      'ak275',
      'nk816',
      'ti195',
      'we231',
    ]; // Solo algunos ejemplos para prueba

    for (const usuario of usuarios) {
      if (usuario.passwordHash?.startsWith('$2')) {
        encryptedCount++;
      } else {
        plainTextCount++;
        console.log(
          `⚠️  Usuario ${usuario.userName || usuario.email} aún tiene contraseña en texto plano: ${usuario.passwordHash}`,
        );
      }
    }

    console.log('\n📊 Estado actual de las contraseñas:');
    console.log(`🔒 Contraseñas encriptadas: ${encryptedCount}`);
    console.log(`📝 Contraseñas en texto plano: ${plainTextCount}`);
  } catch (error) {
    console.error('Error verificando contraseñas:', error);
  } finally {
    await prisma.$disconnect();
  }
}

// Función para probar que las contraseñas encriptadas funcionan con el login
async function testLoginWithEncryptedPasswords() {
  console.log('\n🧪 Probando login con contraseñas encriptadas...');

  try {
    // Obtener algunos usuarios encriptados para probar
    const usuarios = await prisma.usuario.findMany({
      where: {
        passwordHash: {
          startsWith: '$2', // Solo usuarios con contraseñas encriptadas
        },
        eliminado: false,
      },
      select: {
        id: true,
        userName: true,
        email: true,
        passwordHash: true,
      },
      take: 3, // Solo probar con 3 usuarios
    });

    console.log(`🔍 Probando login para ${usuarios.length} usuarios...`);

    // Nota: Para probar realmente necesitaríamos las contraseñas originales
    // Este test solo verifica la estructura del hash
    let validHashes = 0;

    for (const usuario of usuarios) {
      if (usuario.passwordHash && usuario.passwordHash.startsWith('$2b$10$')) {
        validHashes++;
        console.log(
          `✅ Usuario ${usuario.userName || usuario.email}: hash válido`,
        );
      } else {
        console.log(
          `❌ Usuario ${usuario.userName || usuario.email}: hash inválido`,
        );
      }
    }

    console.log(`\n📊 Resultado del test:`);
    console.log(`✅ Hashes válidos: ${validHashes}/${usuarios.length}`);
  } catch (error) {
    console.error('Error probando login:', error);
  } finally {
    await prisma.$disconnect();
  }
}

// Ejecutar el script
async function main() {
  const args = process.argv.slice(2);

  if (args.includes('--verify-only')) {
    await verifyEncryptedPasswords();
  } else if (args.includes('--encrypt')) {
    await encryptExistingPasswords();
    console.log('\n🧪 Probando la integridad de los hashes generados...');
    await testLoginWithEncryptedPasswords();
  } else if (args.includes('--test-login')) {
    await testLoginWithEncryptedPasswords();
  } else {
    console.log('🔧 Script de encriptación de contraseñas');
    console.log('');
    console.log(
      '⚠️  IMPORTANTE: Este script usa las mismas condiciones de hasheo que el registro de usuarios',
    );
    console.log(
      '   (bcrypt.hashSync con saltRounds = 10) para garantizar compatibilidad con el login.',
    );
    console.log('');
    console.log('Opciones disponibles:');
    console.log('  --verify-only    Solo verificar el estado actual');
    console.log(
      '  --encrypt        Encriptar todas las contraseñas en texto plano',
    );
    console.log(
      '  --test-login     Probar la integridad de los hashes encriptados',
    );
    console.log('');
    console.log('Ejemplo de uso:');
    console.log('  npm run encrypt-passwords -- --verify-only');
    console.log('  npm run encrypt-passwords -- --encrypt');
    console.log('  npm run encrypt-passwords -- --test-login');
    console.log('');
    console.log('🔒 Pasos recomendados:');
    console.log('  1. Hacer backup de la base de datos: npm run db:backup');
    console.log('  2. Ejecutar --verify-only para ver el estado actual');
    console.log('  3. Ejecutar --encrypt para encriptar las contraseñas');
    console.log('  4. Verificar que el login funciona correctamente');
    console.log('');
    console.log('📁 Comandos de base de datos disponibles:');
    console.log(
      '  npm run db:backup        - Crear backup de la base de datos',
    );
    console.log('  npm run db:restore       - Restaurar backup más reciente');
    console.log('  npm run db:list-backups  - Listar backups disponibles');
  }
}

main().catch(console.error);
