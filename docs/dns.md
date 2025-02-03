# Documentación de la Configuración del Servidor DNS

## Instalación de BIND

En el servidor Fedora (`Fedora41`):

1. Se instaló el paquete BIND utilizando el gestor de paquetes correspondiente:
   ```bash
   sudo dnf install bind bind-utils
   ```
2. Se habilitó y se inició el servicio BIND:
   ```bash
   sudo systemctl enable named
   sudo systemctl start named
   ```

*Captura de pantalla 1: Instalación de BIND*

## Configuración de BIND

### Archivo de configuración principal (`/etc/named.conf`)

El archivo principal se configuró con las siguientes opciones:
- Se habilitó la escucha en las interfaces requeridas.
- Se definieron las zonas primarias y secundarias.

```bash
options {
    listen-on port 53 { any; };
    directory "/var/named";
    allow-query { any; };
};

zone "sudohero.es" IN {
    type master;
    file "/var/named/named.sudohero.es";
};
```

*Captura de pantalla 2: Contenido del archivo `/etc/named.conf`*

### Archivo de la Zona Primaria (`/var/named/named.sudohero.es`)

Este archivo contiene los registros DNS de la zona primaria `sudohero.es`.

```bash
$TTL 86400
@   IN  SOA ns1.sudohero.es. admin.sudohero.es. (
        2025010101 ; Serial
        3600       ; Refresh
        1800       ; Retry
        1209600    ; Expire
        86400      ; Minimum TTL
    )

    IN  NS  ns1.sudohero.es.
ns1 IN  A   192.168.1.10
www IN  A   192.168.1.20
```

*Captura de pantalla 3: Contenido del archivo `/var/named/named.sudohero.es`*

### Configuración de Zona Secundaria

En el servidor Ubuntu (`Ubuntu24`), se configuró la zona secundaria para replicar los registros de `sudohero.es`.

1. Instalación de BIND:
   ```bash
   sudo apt install bind9
   ```
2. Configuración del archivo `/etc/bind/named.conf.local`:
   ```bash
   zone "sudohero.es" IN {
       type slave;
       masters { 192.168.1.10; };
       file "/var/cache/bind/sudohero.es";
   };
   ```
3. Se reinició el servicio:
   ```bash
   sudo systemctl restart bind9
   ```

*Captura de pantalla 4: Configuración de zona secundaria*

## Verificación de la Configuración

1. Comprobación de que el servicio está escuchando en el puerto 53:
   ```bash
   sudo netstat -tulnp | grep :53
   ```

*Captura de pantalla 5: Resultado del comando anterior*

2. Resolución de nombres para confirmar que los registros funcionan correctamente:
   ```bash
   dig @192.168.1.10 www.sudohero.es
   ```

*Captura de pantalla 6: Salida del comando `dig`*

---

Este documento puede ser ampliado con más detalles o correcciones según sea necesario. Las capturas de pantalla mencionadas deben insertarse en los lugares correspondientes.