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

# Postman-el tesztelés

Alapból a konténer csak a localhost-on hallgatózik, külső kommunikációt nem fogad.

```docker
ENV ASPNETCORE_URLS="http://0.0.0.0:80"
```

Így a 80-as porton minden network inteface-en fogad request-et, így a Docker bridge interface-en is.

Konténer indításnál a 80-as belső portra kell forward-olni.

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

# Egyéb

## Hibaüzenet amikor HTTPS endpoint volt beállítva a Dockerfile-ban

Konténer indítás után ezzel a hibával állt le:

```
Hosting failed to start
      System.InvalidOperationException: Unable to configure HTTPS endpoint. No server certificate was specified, and the default developer certificate could not be found or is out of date.
      To generate a developer certificate run 'dotnet dev-certs https'. To trust the certificate (Windows and macOS only) run 'dotnet dev-certs https --trust'.
```