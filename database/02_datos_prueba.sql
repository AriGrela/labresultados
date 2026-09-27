-- =====================================================================
-- LabResultados — Datos de prueba (PostgreSQL)
-- Trabajo Final Integrador · Grupo 111 · UTN
--
-- Carga un conjunto chico de datos para probar el esquema y los módulos.
-- Ejecutar DESPUÉS de 01_schema.sql.
--
-- ⚠ Solo para desarrollo: los datos son ficticios y los usuarios
--   comparten una contraseña de prueba conocida. No usar en producción.
--
-- Los valores de referencia son orientativos, a modo de ejemplo:
-- cada laboratorio define los suyos.
-- =====================================================================

-- ---------------------------------------------------------------------
-- Roles y usuarios internos
-- Contraseña de prueba de los tres usuarios: LabDemo2026!
-- (guardada como hash BCrypt, compatible con Spring Security)
-- ---------------------------------------------------------------------
INSERT INTO rol (nombre) VALUES
    ('ADMINISTRADOR'),
    ('RECEPCION'),
    ('BIOQUIMICO');

INSERT INTO usuario (rol_id, nombre, apellido, email, password_hash)
SELECT r.id, v.nombre, v.apellido, v.email,
       '$2b$10$nnaso/paa2x32O0Wyx6N6ekadJmn3FKnEpBnhyhmcM08/s7Cogrri'
FROM (VALUES
    ('ADMINISTRADOR', 'Laura', 'Méndez',  'admin@labresultados.test'),
    ('RECEPCION',     'Sofía', 'Ramírez', 'recepcion@labresultados.test'),
    ('BIOQUIMICO',    'Carla', 'Benítez', 'bioquimica@labresultados.test')
) AS v(rol, nombre, apellido, email)
JOIN rol r ON r.nombre = v.rol;

-- ---------------------------------------------------------------------
-- Obras sociales y pacientes
-- ---------------------------------------------------------------------
INSERT INTO obra_social (nombre) VALUES
    ('OSDE'), ('Swiss Medical'), ('IOMA'), ('PAMI'), ('Galeno');

-- María cambió de OSDE a Swiss Medical este año: su cobertura ACTUAL es
-- Swiss Medical, pero sus órdenes viejas conservan OSDE (ver órdenes).
-- Alex no tiene cobertura (particular).
INSERT INTO paciente (obra_social_id, dni, nombre, apellido, fecha_nacimiento,
                      sexo, email, telefono, nro_afiliado)
SELECT os.id, v.dni, v.nombre, v.apellido, v.nacimiento::date,
       v.sexo, v.email, v.telefono, v.afiliado
FROM (VALUES
    ('Swiss Medical', '28456789', 'María', 'González', '1980-03-14', 'F', 'maria.gonzalez@example.com', '11 4567-8901',  'SM-552310'),
    ('IOMA',          '33987654', 'Juan',  'Pérez',    '1988-11-02', 'M', 'juan.perez@example.com',     '221 456-7890', 'IO-8831204'),
    (NULL,            '40123456', 'Alex',  'Romero',   '1997-07-21', 'X', 'alex.romero@example.com',    NULL,           NULL)
) AS v(obra_social, dni, nombre, apellido, nacimiento, sexo, email, telefono, afiliado)
LEFT JOIN obra_social os ON os.nombre = v.obra_social;

-- ---------------------------------------------------------------------
-- Catálogo: estudios, analitos y rangos de referencia
-- ---------------------------------------------------------------------
INSERT INTO estudio (nombre, descripcion) VALUES
    ('Glucemia',        'Glucosa en sangre en ayunas'),
    ('Hemograma',       'Recuento y características de las células de la sangre'),
    ('Perfil lipídico', 'Colesterol y triglicéridos'),
    ('Función renal',   'Urea y creatinina'),
    ('Perfil tiroideo', 'Hormona estimulante de la tiroides');

INSERT INTO analito (estudio_id, nombre, unidad)
SELECT e.id, v.analito, v.unidad
FROM (VALUES
    ('Glucemia',        'Glucosa',          'mg/dL'),
    ('Hemograma',       'Hemoglobina',      'g/dL'),
    ('Hemograma',       'Hematocrito',      '%'),
    ('Hemograma',       'Leucocitos',       '/mm³'),
    ('Perfil lipídico', 'Colesterol total', 'mg/dL'),
    ('Perfil lipídico', 'Colesterol HDL',   'mg/dL'),
    ('Perfil lipídico', 'Colesterol LDL',   'mg/dL'),
    ('Perfil lipídico', 'Triglicéridos',    'mg/dL'),
    ('Función renal',   'Urea',             'mg/dL'),
    ('Función renal',   'Creatinina',       'mg/dL'),
    ('Perfil tiroideo', 'TSH',              'µUI/mL')
) AS v(estudio, analito, unidad)
JOIN estudio e ON e.nombre = v.estudio;

-- sexo NULL = aplica a todos · mínimo/máximo NULL = sin límite de ese lado
INSERT INTO rango_referencia (analito_id, sexo, valor_min, valor_max)
SELECT a.id, v.sexo, v.minimo, v.maximo
FROM (VALUES
    ('Glucosa',          NULL, 70,    110),
    ('Hemoglobina',      'F',  12.0,  16.0),
    ('Hemoglobina',      'M',  13.5,  17.5),
    ('Hematocrito',      'F',  36,    48),
    ('Hematocrito',      'M',  40,    54),
    ('Leucocitos',       NULL, 4000,  10000),
    ('Colesterol total', NULL, NULL,  200),
    ('Colesterol HDL',   'F',  50,    NULL),
    ('Colesterol HDL',   'M',  40,    NULL),
    ('Colesterol LDL',   NULL, NULL,  130),
    ('Triglicéridos',    NULL, NULL,  150),
    ('Urea',             NULL, 10,    50),
    ('Creatinina',       'F',  0.6,   1.1),
    ('Creatinina',       'M',  0.7,   1.3),
    ('TSH',              NULL, 0.4,   4.0)
) AS v(analito, sexo, minimo, maximo)
JOIN analito a ON a.nombre = v.analito;

-- ---------------------------------------------------------------------
-- Órdenes y estudios pedidos
-- Los códigos son aleatorios (no correlativos) para que no se puedan
-- adivinar: el paciente accede con código + DNI (protección de datos).
-- ---------------------------------------------------------------------
INSERT INTO orden (codigo, paciente_id, obra_social_id, creada_por, estado,
                   fecha_creacion, fecha_listo, fecha_entrega)
SELECT v.codigo, p.id, os.id, u.id, v.estado,
       v.creada::timestamptz, v.listo::timestamptz, v.entregada::timestamptz
FROM (VALUES
    -- María: tres órdenes a lo largo de un año (sirven para ver su historial)
    ('LR-4F7K2Q', '28456789', 'OSDE',          'ENTREGADO',  '2025-09-15 08:10-03', '2025-09-16 17:30-03', '2025-09-18 10:05-03'),
    ('LR-9XH3MB', '28456789', 'OSDE',          'ENTREGADO',  '2026-03-10 07:45-03', '2026-03-11 16:20-03', '2026-03-12 09:40-03'),
    ('LR-C82NTE', '28456789', 'Swiss Medical', 'LISTO',      '2026-09-22 08:05-03', '2026-09-23 18:00-03', NULL),
    -- Juan: orden del día, todavía en proceso (el paciente aún no ve resultados)
    ('LR-P5WQ7D', '33987654', 'IOMA',          'EN_PROCESO', '2026-09-25 07:30-03', NULL,                  NULL),
    -- Alex: particular, sin obra social
    ('LR-M2Z8RA', '40123456', NULL,            'ENTREGADO',  '2026-09-18 08:20-03', '2026-09-19 15:10-03', '2026-09-21 11:00-03')
) AS v(codigo, dni, obra_social, estado, creada, listo, entregada)
JOIN paciente p          ON p.dni = v.dni
LEFT JOIN obra_social os ON os.nombre = v.obra_social
JOIN usuario u           ON u.email = 'recepcion@labresultados.test';

INSERT INTO orden_estudio (orden_id, estudio_id)
SELECT o.id, e.id
FROM (VALUES
    ('LR-4F7K2Q', 'Glucemia'),
    ('LR-4F7K2Q', 'Perfil lipídico'),
    ('LR-9XH3MB', 'Glucemia'),
    ('LR-C82NTE', 'Glucemia'),
    ('LR-C82NTE', 'Hemograma'),
    ('LR-P5WQ7D', 'Función renal'),
    ('LR-M2Z8RA', 'Perfil tiroideo')
) AS v(codigo, estudio)
JOIN orden o   ON o.codigo = v.codigo
JOIN estudio e ON e.nombre = v.estudio;

-- ---------------------------------------------------------------------
-- Resultados
-- El rango se elige igual que lo hará el backend: el que coincide con
-- el sexo del paciente (o el rango sin sexo) y con su edad a la fecha
-- de la orden. Se guarda una copia del rango en el resultado y la
-- columna fuera_de_rango se calcula sola.
-- La glucosa de María sube orden a orden: 98 → 112 → 126.
-- ---------------------------------------------------------------------
INSERT INTO resultado (orden_estudio_id, analito_id, cargado_por, valor,
                       unidad, ref_min, ref_max, fecha_carga)
SELECT oe.id, a.id, u.id, v.valor,
       a.unidad, rr.valor_min, rr.valor_max,
       v.cargado::timestamptz
FROM (VALUES
    ('LR-4F7K2Q', 'Glucosa',            98, '2025-09-16 11:00-03'),
    ('LR-4F7K2Q', 'Colesterol total',  215, '2025-09-16 11:00-03'),
    ('LR-4F7K2Q', 'Colesterol HDL',     52, '2025-09-16 11:00-03'),
    ('LR-4F7K2Q', 'Colesterol LDL',    138, '2025-09-16 11:00-03'),
    ('LR-4F7K2Q', 'Triglicéridos',     140, '2025-09-16 11:00-03'),
    ('LR-9XH3MB', 'Glucosa',           112, '2026-03-11 10:30-03'),
    ('LR-C82NTE', 'Glucosa',           126, '2026-09-23 12:15-03'),
    ('LR-C82NTE', 'Hemoglobina',      11.4, '2026-09-23 12:15-03'),
    ('LR-C82NTE', 'Hematocrito',        37, '2026-09-23 12:15-03'),
    ('LR-C82NTE', 'Leucocitos',       7200, '2026-09-23 12:15-03'),
    ('LR-P5WQ7D', 'Creatinina',        1.1, '2026-09-26 09:40-03'),  -- falta la urea: sigue EN_PROCESO
    ('LR-M2Z8RA', 'TSH',               2.1, '2026-09-19 13:00-03')
) AS v(codigo, analito, valor, cargado)
JOIN orden o          ON o.codigo = v.codigo
JOIN paciente p       ON p.id = o.paciente_id
JOIN analito a        ON a.nombre = v.analito
JOIN orden_estudio oe ON oe.orden_id = o.id AND oe.estudio_id = a.estudio_id
JOIN usuario u        ON u.email = 'bioquimica@labresultados.test'
LEFT JOIN rango_referencia rr
       ON rr.analito_id = a.id
      AND (rr.sexo IS NULL OR rr.sexo = p.sexo)
      AND (rr.edad_min IS NULL OR extract(year FROM age(o.fecha_creacion, p.fecha_nacimiento)) >= rr.edad_min)
      AND (rr.edad_max IS NULL OR extract(year FROM age(o.fecha_creacion, p.fecha_nacimiento)) <= rr.edad_max);

-- ---------------------------------------------------------------------
-- Notificaciones (una orden puede tener varios intentos de aviso)
-- ---------------------------------------------------------------------
INSERT INTO notificacion (orden_id, email_destino, estado, fecha_creacion, fecha_envio, detalle)
SELECT o.id, p.email, v.estado, v.creada::timestamptz, v.enviada::timestamptz, v.detalle
FROM (VALUES
    ('LR-4F7K2Q', 'ENVIADA', '2025-09-16 17:30-03', '2025-09-16 17:31-03', NULL),
    ('LR-9XH3MB', 'ENVIADA', '2026-03-11 16:20-03', '2026-03-11 16:21-03', NULL),
    ('LR-C82NTE', 'ENVIADA', '2026-09-23 18:00-03', '2026-09-23 18:01-03', NULL),
    ('LR-M2Z8RA', 'FALLIDA', '2026-09-19 15:10-03', NULL,                  'Buzón del destinatario lleno'),
    ('LR-M2Z8RA', 'ENVIADA', '2026-09-19 18:10-03', '2026-09-19 18:11-03', 'Reintento')
) AS v(codigo, estado, creada, enviada, detalle)
JOIN orden o    ON o.codigo = v.codigo
JOIN paciente p ON p.id = o.paciente_id;
