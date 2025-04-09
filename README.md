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

# ToDo

- Minimal API legyen MVC helyett
- AutoMapper helyett LINQ
- PlatformService-nél HTTP-t használunk HTTPS helyett
- API endpoint authorizáció