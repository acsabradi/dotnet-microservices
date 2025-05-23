[.NET Microservices – Full Course](https://www.youtube.com/watch?v=DgVjEo3OGBI&ab_channel=LesJackson)

# `dotnet` parancsok

- `dotnet new webapi -n PlatformService`
    - Ez a parancs minimal API projektet hoz létre. Helyette:
        - `dotnet new webapi --use-controllers -o PlatformService`
        - [Create a Web API project](https://learn.microsoft.com/en-us/aspnet/core/tutorials/first-web-api?view=aspnetcore-9.0&tabs=visual-studio-code#create-a-web-api-project)
- `dotnet add package Automapper.Extensions.Microsoft.DependencyInjection`
- `dotnet add package Microsoft.EntityFrameworkCore`
- `dotnet add package Microsoft.EntityFrameworkCore.Design`
- `dotnet add package Microsoft.EntityFrameworkCore.InMemory`
- `dotnet add package Microsoft.EntityFrameworkCore.SqlServer`

# Docker parancsok

- `docker --version`
- `docker build -t atcs0/platformservice .`
- `docker run -p 8080:80 -d atcs0/platformservice`
    - mindig új konténert indít el
- `docker ps`
- `docker stop <container ID>`
- `docker start <container ID>`
- `docker push atcs0/platformservice`

# Kubernetes parancsok

- `kubectl apply -f .\platforms-depl.yaml`
- `kubectl get deployments`
- `kubectl get pods`
- `kubectl rollout restart deployment platforms-depl`
    - kikényszeríti a legfrissebb image letöltését
- `kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.12.1/deploy/static/provider/cloud/deploy.yaml`
    - [Ingress Nginx](https://kubernetes.github.io/ingress-nginx/deploy/)
- `kubectl get storageclass`
    - Default: hostpath
- `kubectl get pvc`
    - Storageclass: hostpath
- `kubectl create secret generic mssql --from-literal=SA_PASSWORD="pa55w0rd!"`

# Postman-el tesztelés

Alapból a konténer csak a localhost-on hallgatózik, külső kommunikációt nem fogad.

```docker
ENV ASPNETCORE_URLS="http://0.0.0.0:80"
```

Így a 80-as porton minden network inteface-en fogad request-et, így a Docker bridge interface-en is.

Konténer indításnál a 80-as belső portra kell forward-olni.

# SQL Server Management Studio

## Login

![ssms-login](Images/2025-05-20%2023_31_10-Microsoft%20SQL%20Server%20Management%20Studio.png)

## Persistent volume claim tesztelése

1. Login az szerverbe
2. Egy új adatbázist létrehozunk
3. Lekapcsolódunk a szerverről
4. Töröljük az SQL pod-ot -> mivel `replicas: 1`, ezért a k8s azonnal elindít egy új SQL pod-ot
5. Login a szerverba -> látható a létrehozott adatbázis

# ToDo

- Minimal API legyen MVC helyett
- AutoMapper helyett LINQ
- PlatformService-nél HTTP-t használunk HTTPS helyett
    - dockerfile-ban és a launchSettings-ben (process-ként futtatva) is
- API endpoint authorizáció
- Az endpoint függvények miért nem async?
- központi logolás console.write helyett
    - konténerbe logolás
- Podman Docker helyett
- health check
- k2s a docker desktop-ba beépített k8s helyett
- kustomization
- Helm
- http fájlok postman helyett
    - https://httpyac.github.io/
    - https://marketplace.visualstudio.com/items?itemName=humao.rest-client
    - https://learn.microsoft.com/en-us/aspnet/core/test/http-files?view=aspnetcore-9.0
- openapi
- certificate
- build pipeline ([bullseye](https://github.com/adamralph/bullseye) vagy [cake](https://cakebuild.net/))

# Egyéb

## Hibaüzenet amikor HTTPS endpoint volt beállítva a Dockerfile-ban

Konténer indítás után ezzel a hibával állt le:

```
Hosting failed to start
      System.InvalidOperationException: Unable to configure HTTPS endpoint. No server certificate was specified, and the default developer certificate could not be found or is out of date.
      To generate a developer certificate run 'dotnet dev-certs https'. To trust the certificate (Windows and macOS only) run 'dotnet dev-certs https --trust'.
```

## `vmmemwsl`

WSL kezelésért felel. Docker Desktop leállítás után nem áll le magától, ki kell adni a `wsl --shutdown` parancsot.

## `hosts`

Ingress fellövése után módosítani kell a `hosts` fájlt. 

Helye:
- Win: `C:\Windows\System32\drivers\etc\hosts`
- Linux: `/etc/hosts`

Ezt kell hozzáadni: `127.0.0.1 acme.com`. Mindegy a sorrend. 