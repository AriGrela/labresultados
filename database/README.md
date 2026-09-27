# Base de datos — LabResultados

Esquema relacional en **PostgreSQL** (versión 12 o superior).

| Archivo | Contenido |
| --- | --- |
| [`01_schema.sql`](01_schema.sql) | Creación de tablas, relaciones (claves foráneas), índices y vista de historial |
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

Pacientes para probar la consulta (código de orden + DNI):

| Paciente | DNI | Caso de prueba |
| --- | --- | --- |
| María González | `28456789` | 3 órdenes en un año; su glucosa sube 98 → 112 → 126 (historial) |
| Juan Pérez | `33987654` | Orden `EN_PROCESO`: todavía no ve resultados |
| Alex Romero | `40123456` | Sin obra social; DNI no binario (usa el rango general) |

## Consultas de ejemplo

Consulta del paciente (módulo *Consulta de resultados*):

```sql
SELECT estudio, analito, valor, unidad, ref_min, ref_max, fuera_de_rango
FROM vista_historial_resultados
WHERE codigo_orden = 'LR-C82NTE' AND dni = '28456789';
```

Evolución de un analito en el tiempo (módulo *Historial de resultados*):

```sql
SELECT fecha_orden, valor, unidad, fuera_de_rango
FROM vista_historial_resultados
WHERE dni = '28456789' AND analito = 'Glucosa'
ORDER BY fecha_orden;
```

Órdenes pendientes de resultados (módulo *Gestión de resultados*):

```sql
SELECT codigo, fecha_creacion
FROM orden
WHERE estado = 'EN_PROCESO'
ORDER BY fecha_creacion;
```
