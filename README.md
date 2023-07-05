# app_cuida_pet

A new Flutter project.

## Iniciando backend
- [Download aqui](https://github.com/JBSilvaDev/backend-cuida-pet)

Abrir pasta do backend no terminal e executar comando dart para startar o servidor
```
cuidapet_api git:(main) dart bin/server.dart
Server iniciado na porta 8080
Para acessar usar um dos endereços abaixo: 
http://0.0.0.0:8080
http://localhost:8080
http://<seu-ip>:8080
```

## Login rede social
- Google
  -  Funcional e ativo
-  Facebook
   -  Desabilidado devido a problemas na implementação e registro do aplicativo na API do facebook
      -  Case seja resolvido, criar arquivo strings.xml em /Users/jbsilva/Documents/cuidapet/android/app/src/main/res/values/strings.xml
          com o seguinte conteudo:
          ```xml
          <?xml version="1.0" encoding="utf-8"?>
          <resources>
              <string name="facebook_app_id">950682336210153</string>
              <string name="app_name">app_cuida_pet</string>
              <string name="facebook_client_token">8378fc4ba08a6c98e7b49f44f6382aae</string>
              <string name="fb_login_protocol_scheme">fb950682336210153</string>
          </resources>
          ```

