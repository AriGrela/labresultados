# LabResultados

**Portal de resultados y seguimiento de órdenes para un laboratorio de análisis clínicos chico/mediano.**

Trabajo Final Integrador — Tecnicatura Universitaria en Programación (UTN).

---

## Descripción

LabResultados es un sistema web que permite a los pacientes de un laboratorio de análisis clínicos **consultar el estado de sus estudios y acceder a sus resultados online**, y al personal del laboratorio **registrar órdenes y cargar resultados** de forma centralizada.

El paciente ingresa con su código de orden / DNI y ve en qué estado están sus estudios y, cuando están listos, los resultados **con los valores fuera de rango resaltados** y su **historial** a lo largo del tiempo.

## Problema que resuelve

En los laboratorios de barrio chicos/medianos, el paciente no tiene forma de saber si sus estudios están listos: llama por teléfono o va al laboratorio sin necesidad, y la recepción se satura atendiendo consultas del tipo *"¿ya están mis análisis?"*. Además, la entrega de resultados suele ser en papel o por PDF enviado a mano por WhatsApp. Los portales existentes son de los laboratorios grandes; el segmento chico no tiene una solución accesible.

## Actores

| Actor | Rol |
|---|---|
| Paciente | Consulta el estado y accede a sus resultados e historial |
| Recepcionista / administrativo | Registra la orden del paciente |
| Bioquímico / técnico | Carga los resultados y actualiza el estado de la orden |
| Administrador del laboratorio | Configura estudios, analitos y rangos de referencia |

## Alcance (MVP)

- Registro de órdenes (paciente, estudios pedidos).
- Carga de resultados estructurados (analito, valor, unidad, rango de referencia).
- Estados de la orden (en proceso → listo → entregado).
- Consulta del paciente por código de orden / DNI.
- Resaltado automático de valores fuera de rango.
- Historial de resultados por paciente.
- Aviso por email cuando los resultados están listos.

## Fuera de alcance

- Integración con equipos / analizadores del laboratorio.
- Facturación y pasarela de pagos.
- Firma digital y validación regulatoria del bioquímico.
- Aplicación móvil nativa.

## Stack tecnológico

| Capa | Tecnología |
|---|---|
| Backend | Java + Spring Boot + JPA/Hibernate (Lombok, DTOs, API REST) |
| Frontend | HTML + CSS + JavaScript (TypeScript opcional) |
| Base de datos | PostgreSQL (relacional) |
| Despliegue | Docker Compose (desarrollo) · Nube para el MVP (Render/Railway + Supabase/Aiven) |

> La elección del stack se justifica en que es el que el equipo **ya domina** según el plan de estudios de la carrera (Java/Spring Boot/JPA en Programación III), y en que el dominio del problema es fuertemente relacional (paciente → orden → estudios → resultados), lo que hace natural una base de datos SQL.

## Estructura del repositorio

```
labresultados/
├── backend/     # API REST (Spring Boot)
├── frontend/    # Interfaz web (HTML/CSS/JS)
├── database/    # Scripts DDL/DML, esquema y migraciones
├── docs/        # Propuesta, informes y documentación de avances
└── README.md
```

## Instalación

> ⏳ Próximamente. Se documentará al iniciar el desarrollo del backend y el frontend (Entrega 2 en adelante).

## Integrantes

- Ariel Grela
- Matías Higa

## Estado del proyecto

En etapa de **propuesta (1.ª Entrega)**. Ver la propuesta completa en [`docs/propuesta-entrega-1.md`](docs/propuesta-entrega-1.md).
