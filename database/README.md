# Base de datos — LabResultados

Esquema relacional en **PostgreSQL** (versión 12 o superior).

| Archivo | Contenido |
| --- | --- |
| [`01_schema.sql`](01_schema.sql) | Creación de las 13 tablas, sus 15 relaciones (claves foráneas), índices y vista de historial |
| [`02_datos_prueba.sql`](02_datos_prueba.sql) | Datos ficticios para probar el esquema y los módulos |
| [`diagrama-er.md`](diagrama-er.md) | Diagrama entidad-relación, relaciones explicadas y decisiones de diseño |

## Cómo ejecutarlo

Sobre una base vacía, en este orden:

```bash
psql -d labresultados -f 01_schema.sql
psql -d labresultados -f 02_datos_prueba.sql
```

También se pueden pegar en el editor SQL de Supabase. El script `01_schema.sql` empieza borrando las tablas si ya existen, así que se puede volver a correr desde cero (**solo en desarrollo**).

## Datos de prueba

Usuarios internos (contraseña de prueba: `LabDemo2026!`, solo desarrollo):

| Email | Rol |
| --- | --- |
| `admin@labresultados.test` | Administrador |
| `recepcion@labresultados.test` | Recepción |
| `bioquimica@labresultados.test` | Bioquímico |

Pacientes y casos de prueba:

| Paciente | DNI | Caso de prueba |
| --- | --- | --- |
| María González | `28456789` | 3 órdenes en un año; su glucosa sube 98 → 112 → 126 (historial). Cambió de OSDE a Swiss Medical (cada orden guarda su cobertura). Una hemoglobina corregida de 11.2 a 11.4 (auditoría). Una orden entregada por portal y otra por mostrador |
| Juan Pérez | `33987654` | Orden `EN_PROCESO`: todavía no ve resultados. Pidió un enlace de acceso que venció sin usarse |
| Alex Romero | `40123456` | Particular (sin obra social); DNI no binario (usa el rango general). Su aviso por email salió en el segundo intento |

## Consultas de ejemplo

Consulta del paciente (módulo *Consulta de resultados*). El paciente ya entró con su enlace de acceso, así que el backend conoce su `paciente_id` por la sesión y solo filtra por él:

```sql
SELECT estudio, analito, valor, unidad, ref_min, ref_max, fuera_de_rango
FROM vista_historial_resultados
WHERE paciente_id = 1                -- paciente de la sesión (María)
  AND codigo_orden = 'LR-C82NTE';
```

Evolución de un analito en el tiempo (módulo *Historial de resultados*):

```sql
SELECT fecha_orden, valor, unidad, fuera_de_rango
FROM vista_historial_resultados
WHERE paciente_id = 1 AND analito = 'Glucosa'
ORDER BY fecha_orden;
```

Validar un enlace de acceso (módulo *Gestión de usuarios y acceso*). Solo funciona una vez y dentro de los 15 minutos; el backend recibe el token del enlace y lo compara por su hash:

```sql
UPDATE token_acceso
SET fecha_uso = now()
WHERE token_hash = encode(sha256(convert_to('<token del enlace>', 'UTF8')), 'hex')
  AND fecha_uso IS NULL
  AND now() < fecha_expiracion
RETURNING paciente_id;
```

Notificaciones que tiene que procesar la tarea de envío (módulo *Notificaciones*):

```sql
SELECT id, orden_id, email_destino, intentos
FROM notificacion
WHERE estado = 'PENDIENTE'
ORDER BY fecha_creacion;
```

Órdenes pendientes de resultados (módulo *Gestión de resultados*):

```sql
SELECT codigo, fecha_creacion
FROM orden
WHERE estado = 'EN_PROCESO'
ORDER BY fecha_creacion;
```
