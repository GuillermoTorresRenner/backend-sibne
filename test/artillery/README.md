# 🔥 Tests de Stress con Artillery

Este proyecto incluye tests de stress automatizados usando Artillery v2.0.26 para evaluar el rendimiento de la API bajo diferentes cargas de trabajo.

## 🎯 Objetivos de los Tests

- **Rendimiento**: Medir tiempos de respuesta bajo carga
- **Estabilidad**: Verificar que la aplicación no falle bajo stress
- **Escalabilidad**: Determinar límites de capacidad
- **Regresión**: Detectar degradación de performance

## 📊 Fases de Testing

**⏱️ Duración Total: 3 minutos (180 segundos)**

### 1. **Warmup Phase** (30s - 5 req/s)

- Calentamiento rápido de la aplicación
- Inicialización de conexiones de BD
- Preparación del JIT compiler

### 2. **Normal Load Phase** (60s - 10 req/s)

- Carga de trabajo típica
- Medición de baseline de performance
- Validación de operaciones normales

### 3. **Stress Phase** (60s - 25 req/s)

- Carga elevada sostenida
- Identificación de cuellos de botella
- Evaluación de degradación gradual

### 4. **Peak Load Phase** (30s - 50 req/s)

- Máxima carga de prueba
- Límites de capacidad
- Comportamiento bajo presión extrema

## 🧪 Escenarios de Prueba

### 📊 **Distribución de Carga:**

- **30%** - Endpoints públicos (sin auth)
- **40%** - Flujos de autenticación
- **20%** - Tests de autorización por roles
- **10%** - Carga mixta simultánea

### 🔐 **Credenciales de Prueba:**

```yaml
Admin: pvd / BNE_MENDPEDS2024
Empresa: 00327 / jo091
```

### 🎯 **Endpoints Probados:**

- `GET /api/test/public` - Sin autenticación
- `POST /api/auth/login` - Autenticación
- `GET /api/test/protected` - Requiere auth
- `GET /api/test/admin-only` - Solo admin
- `GET /api/test/empresa-only` - Solo empresa
- `GET /api/test/user-or-admin` - Múltiples roles

## 🚀 Ejecución Local

### Prerequisitos

```bash
# Instalar Artillery v2.0.26 (o usar la versión local)
npm install -g artillery@latest

# O usar la versión local del proyecto
npm install
```

### Ejecutar Tests

```bash
# Iniciar la aplicación
npm run start:dev

# En otra terminal - Test básico
npm run test:stress

# Test con reporte HTML
npm run test:stress:report
```

### Comandos Manuales

```bash
# Test básico
artillery run test/artillery/stress-test.yml

# Con reporte JSON y HTML
artillery run --output report.json test/artillery/stress-test.yml
artillery report --output report.html report.json
```

## 📈 Métricas Generadas

### 🔢 **Métricas Básicas:**

- **RPS** (Requests per Second)
- **Response Time** (min, max, median, p95, p99)
- **HTTP Status Codes** (200, 401, 500, etc.)
- **Error Rate** (%)

### 📊 **Métricas Avanzadas:**

- **Latency Distribution** por percentiles
- **Throughput** por endpoint
- **Concurrent Users** activos
- **Memory/CPU Usage** trends

### 📋 **Reportes Generados:**

- **JSON Report** - Datos raw para análisis
- **HTML Report** - Dashboard visual interactivo
- **Console Output** - Resumen en tiempo real

## 🤖 CI/CD Integration

Los tests de stress se ejecutan automáticamente en GitHub Actions:

### 📋 **Pipeline:**

1. ✅ Unit Tests
2. 🔥 **Stress Tests** (Artillery)
3. 🐳 Docker Build
4. 🔒 Security Scan

### 📦 **Artefactos:**

- **HTML Report** - Disponible por 30 días
- **JSON Report** - Para análisis automático
- **Screenshots** - De fallos críticos

### 📥 **Descargar Reportes:**

1. Ve a la página de **Actions** del repositorio
2. Selecciona el workflow ejecutado
3. Descarga **artillery-stress-test-reports.zip**
4. Abre `artillery-report.html` en tu navegador

## 🎯 Criterios de Éxito

### ✅ **Aceptable:**

- P95 response time < 500ms
- Error rate < 1%
- No memory leaks
- Graceful degradation

### ⚠️ **Advertencia:**

- P95 response time 500-1000ms
- Error rate 1-5%
- Memory usage increasing
- Some timeout errors

### ❌ **Fallo:**

- P95 response time > 1000ms
- Error rate > 5%
- Application crashes
- Database connection errors

## 🔧 Configuración Avanzada

### Variables de Entorno

```bash
# Configurar target diferente
export ARTILLERY_TARGET=https://api-staging.sibne.com

# Aumentar duración de tests
export ARTILLERY_DURATION=300

# Configurar rate limits
export ARTILLERY_RATE=100
```

### Personalización

```yaml
# test/artillery/custom-test.yml
config:
  target: '{{ $env.ARTILLERY_TARGET }}'
  phases:
    - duration: '{{ $env.ARTILLERY_DURATION }}'
      arrivalRate: '{{ $env.ARTILLERY_RATE }}'
```

## 📚 Recursos Adicionales

- [Artillery v1.7.9 Documentation](https://artillery.io/docs/guides/getting-started/)
- [Performance Testing Best Practices](https://artillery.io/docs/guides/guides/performance-testing-best-practices.html)
- [SIBNE API Documentation](http://localhost:3000/api/docs)

## 🐞 Troubleshooting

### Problemas Comunes:

- **Connection refused**: Verificar que la app esté corriendo
- **Auth failures**: Revisar credenciales en stress-test.yml
- **Timeouts**: Aumentar timeout en configuración
- **Memory issues**: Reducir arrival rate o duration

### Logs Útiles:

```bash
# Ver logs de Artillery
artillery run --verbose test/artillery/stress-test.yml

# Logs de la aplicación durante tests
npm run start:dev | tee app-stress.log
```
