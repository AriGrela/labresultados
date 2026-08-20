# Propuesta de Proyecto — LabResultados

**Trabajo Final Integrador — Tecnicatura Universitaria en Programación (UTN)**
**Grupo 111:** Grela, Ariel · Higa, Matías
**Tutor:** Fonzo, Santiago
**Repositorio único:** https://github.com/AriGrela/labresultados
**1.ª Entrega — Fecha máxima:** 30/08

---

## 1. Contexto y problema

**Contexto.** Un laboratorio de análisis clínicos chico/mediano (de barrio) atiende entre 20 y 25 pacientes por día. La toma de muestra es por orden de llegada (no se usan turnos) y los resultados se procesan a lo largo de uno o varios días.

**Problema.** El paciente **no tiene forma de saber si sus estudios ya están listos**. Para averiguarlo llama por teléfono o se acerca al laboratorio sin necesidad, lo que satura a la recepción con consultas repetitivas (*"¿ya están mis análisis?"*). Además, la entrega de resultados es manual: se imprimen en papel o se envían como PDF por WhatsApp/email uno por uno.

**Impacto medible (relevamiento en un laboratorio real):**
- **6 a 10 consultas por día** preguntando por resultados (promedio: **8**).
- **2 a 3 minutos** por consulta → **16 a 24 minutos diarios** de recepción dedicados a esto (promedio: **20 min/día**).
- **10 % a 15 % de los pacientes** concurren antes de que sus resultados estén disponibles → con 20–25 pacientes/día, unos **2 a 3 pacientes diarios** que viajan al pedo.

Estas cifras muestran un costo de tiempo concreto y recurrente, tanto para la recepción como para el paciente, que una solución de software puede reducir.

---

## 2. Elicitación de Requisitos

### 2.1 Actores involucrados
| Actor | Rol | Necesidad principal |
|---|---|---|
| Paciente | Consulta estado y accede a sus resultados e historial | Saber si están listos y ver/descargar resultados sin llamar |
| Administrativo / Recepción | Registra la orden del paciente | Cargar rápido la orden y sus estudios |
| Profesional (Bioquímico/técnico) | Carga resultados y cambia el estado de la orden | Cargar valores de forma ágil y sin errores |
| Administrador del laboratorio | Configura estudios, analitos y rangos de referencia | Mantener el catálogo del laboratorio |
| Externo — Obra social | Se registra en la orden como dato del paciente | Identificar la cobertura (solo dato, sin facturación) |

### 2.2 Flujo actual
1. El paciente llega y se realiza la extracción por orden de llegada.
2. La recepción registra la orden (paciente, estudios) en papel o en una planilla.
3. El laboratorio procesa las muestras; los resultados quedan listos en uno o varios días.
4. El paciente, sin visibilidad del avance, llama o se acerca para preguntar → **8 consultas/día** promedio, **~20 min/día** de recepción, y **2–3 pacientes/día** que vienen antes de tiempo.
5. Cuando están listos, se entregan en papel en el mostrador o por PDF a mano por WhatsApp/email.

---

## 3. Propuesta de solución

Un portal web donde:
- La recepción **registra la orden** del paciente y sus estudios, generando un **código de orden**.
- El bioquímico **carga los resultados** (valores por analito con su rango de referencia) y actualiza el **estado** de la orden.
- El paciente **consulta por código de orden / DNI** el estado y, cuando están listos, los resultados con **valores fuera de rango resaltados** y su **historial**.
- El sistema **avisa por email** al pasar a "listo".

### 3.1 Stack tecnológico
| Capa | Elección | Justificación |
|---|---|---|
| Backend | Java + Spring Boot + JPA/Hibernate (Lombok, DTOs, API REST) | Es el stack que el equipo ya cursa (Programación III). Cero curva de aprendizaje. |
| Frontend | HTML + CSS + JavaScript (TypeScript opcional) | También del plan de estudios; sin framework SPA para no sumar costo de aprendizaje. |
| Base de datos | PostgreSQL (relacional / SQL) | Datos estructurados con relaciones fuertes e integridad (ACID); integra nativo con JPA. |
| Despliegue | Docker Compose (desarrollo) + nube (Render/Railway + Supabase/Aiven) | Docker iguala entornos entre los dos integrantes; la nube cumple el requisito de tener un componente online. |

> **Nota de equipo:** el README inicial de Matías listaba MySQL / Node / Python como opciones. Quedó definido usar **PostgreSQL** (el modelo es fuertemente relacional y ambos motores sirven con JPA) y **Java/Spring Boot** como único backend. A confirmar entre ambos antes de la entrega.

### 3.2 Arquitectura
Aplicación web en 3 capas: un **frontend** (HTML/CSS/JS) que consume una **API REST** en Spring Boot, la cual persiste en **PostgreSQL** vía JPA/Hibernate. Autenticación por roles (recepción, bioquímico, admin) para el personal, y acceso del paciente por código de orden / DNI. Todo empaquetado con Docker Compose para desarrollo.

---

## 4. Alcance
La primera versión (MVP) cubre el circuito completo *registro de orden → carga de resultados → consulta del paciente*, sin integrarse con los equipos del laboratorio ni con sistemas de facturación.

---

## 5. Funcionalidades

### 5.1 MVP
- Registro de órdenes (paciente + estudios pedidos + obra social como dato).
- Carga de resultados estructurados (analito, valor, unidad, rango de referencia).
- Estados de la orden: en proceso → listo → entregado.
- Consulta del paciente por código de orden / DNI.
- Resaltado automático de valores fuera de rango.
- Historial de resultados por paciente.
- Aviso por email cuando los resultados pasan a "listo".
- Gestión de usuarios y roles del personal (recepción, bioquímico, admin).

### 5.2 Nice to have (si sobra tiempo)
- Gráfico de evolución/tendencia de un analito en el tiempo.
- Descarga del resultado en PDF.
- Notificación por WhatsApp además del email.
- Panel con métricas para el laboratorio.

### 5.3 Fuera de alcance
- Integración con equipos / analizadores del laboratorio.
- Facturación y pasarela de pagos.
- Firma digital y validación regulatoria del bioquímico.
- Aplicación móvil nativa.

---

## 6. Plan de trabajo

**Objetivo general.** Desarrollar un MVP funcional de portal de resultados y seguimiento de órdenes, desplegado online.

**Objetivos específicos (medibles).**
- Permitir al paciente consultar el estado de su orden por código/DNI.
- Permitir la carga de resultados estructurados con rangos de referencia.
- Resaltar automáticamente los valores fuera de rango.
- Enviar aviso por email al pasar a "listo".

**Entregables por etapa.**
| Etapa | Fecha máxima | Entregable |
|---|---|---|
| 1.ª Entrega | 30/08 | Propuesta + plan de trabajo + URL del repositorio |
| 2.ª Entrega | 27/09 | Esquema de base de datos + listado de módulos (Condición de Regular) |
| Entrega Final | 14/11 (cursado hasta 21/11) | Repo completo, despliegue online, informe y video (preferentemente en inglés) |

**Riesgos y mitigaciones.**
- Alcance mayor al tiempo disponible → priorizar el MVP y respetar el No-Alcance.
- Curva del despliegue en la nube → probar el deploy temprano con un "hola mundo".
- Coordinación entre dos personas → Trello + repositorio único + Docker.

**Criterios de éxito del MVP.**
- Un paciente puede consultar estado y resultados sin llamar al laboratorio.
- El laboratorio puede cargar una orden y sus resultados de punta a punta.
- Los valores fuera de rango se resaltan correctamente.

---

## 7. Viabilidad

### 7.1 Técnica
Viable con el stack conocido (Java/Spring Boot/JPA + PostgreSQL). Única dependencia externa: envío de email (SMTP), no crítica y postergable. Sin dependencia de integración con equipos.

### 7.2 Temporal
El alcance del MVP entra en el cronograma de la cátedra (30/08, 27/09, 21/11). Las funcionalidades "nice to have" quedan como colchón descartable.

### 7.3 Conocimientos
El equipo cursa Java, Spring Boot, JPA, DTOs y APIs REST (Programación III), y HTML/CSS/JS. La elección se apoya en lo que ya se domina, tal como recomienda la guía de stack de la materia.

---

## 8. Análisis de competencia y diferenciación

- **Competidores directos:** portales de resultados de laboratorios grandes (cadenas). Robustos, pero pensados para su propia operación; no son un producto accesible para el laboratorio chico.
- **Competidores indirectos:** entrega por WhatsApp/email manual, retiro de papel en el mostrador, consulta telefónica.
- **Diferenciadores de LabResultados:** foco en el laboratorio chico/mediano, bajo costo, simple, sin depender de integración con equipos, y con **resaltado de valores fuera de rango e historial** —algo que un PDF suelto no ofrece—.

---

## 9. Uso crítico de IA

Se utiliza IA como asistente (por ejemplo para refinar la propuesta, generar código repetitivo, y apoyar en pruebas unitarias y refactorización), tal como fomenta la cátedra. Sin embargo, **el criterio arquitectónico y la defensa de la lógica de negocio son responsabilidad del equipo**: cada decisión (stack, modelo de datos, alcance) fue revisada y validada por los integrantes, y debe poder sostenerse en la defensa oral.
