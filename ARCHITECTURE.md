# Arquitetura do Projeto Rick and Morty Info

Este documento descreve a arquitetura do projeto Rick and Morty Info.

## Visão Geral

O projeto segue uma arquitetura baseada em **MVVM (Model-View-ViewModel)** com organização estrutural em camadas, baseada na **arquitetura hexagonal**. Além disso conta no com o auxílio da biblioteca **Signals** para gerenciamento de estado reativo. A estrutura é dividida em camadas para promover a separação de responsabilidades, testabilidade e manutenibilidade.

## Camadas da Arquitetura

O projeto é organizado nas seguintes camadas principais:

1.  **application (UI Layer):**
    *   Responsável pela interface do usuário (Widgets Flutter).
    *   Observa os `ViewModels` para atualizar a UI quando os dados mudam.
    *   Encaminha as interações do usuário para os `ViewModels`.
    *   **Componentes:**
        *   **Views (Widgets):** Telas e componentes visuais.
        *   **ViewModels:** Contêm a lógica de apresentação e o estado da UI. Eles expõem dados para as Views através de `Signals` e manipulam as ações do usuário. Exemplo: `HomeViewModel`.

2.  **core:**
    *   Contém utilitários, classes base, e abstrações que são usadas em múltiplas camadas.
    *   Contém a lógica de negócios central da aplicação.
    *   Independente de qualquer framework de UI ou detalhes de implementação de acesso a dados.
    *   **Componentes:**
        *   **Models/Entities:** Representam os objetos de domínio. Exemplo: `Character`.
        *   **Use Cases (Casos de Uso):** Encapsulam a lógica de negócios específica. Eles orquestram o fluxo de dados entre a camada de apresentação e a camada de dados. Exemplo: `GetAllCharacters`.
        *   **Repositories (Interfaces):** Abstrações para as fontes de dados. A camada de domínio define as interfaces dos repositórios, e a camada de dados fornece as implementações.
        *   **Error Handling:** Classes para representar e manipular erros (ex: `RequestFailure`).
        *   **Network Utilities:** (Se aplicável) Helpers para requisições de rede.
        *   **Dependency Injection Setup:** Configuração da injeção de dependência (ex: usando `get_it`).

3.  **external (Data Layer):**
    *   Responsável por obter e armazenar dados de diferentes fontes (API remota, banco de dados local, etc.).
    *   Implementa as interfaces de repositório definidas na camada de domínio.
    *   **Componentes:**
        *   **Repositories (Implementações):** Implementam as interfaces de repositório, coordenando o acesso aos `DataSources`.
        *   **DataSources:** Responsáveis pela comunicação direta com as fontes de dados (ex: chamadas HTTP para uma API, queries em um banco de dados, cache local, etc).
        *   **Mappers:** Convertem dados entre diferentes formatos (ex: DTOs da API para Models de domínio).

## Fluxo de Dados (Exemplo: Carregar Personagens)

1.  A **View** (ex: `HomePage`) inicia a ação de carregar personagens, chamando um método no `HomeViewModel` (ex: `fetchCharacters()`).
2.  O `HomeViewModel` atualiza seu estado de `isLoading` para `true` (usando `Signal`).
3.  O `HomeViewModel` chama o `execute()` do `GetAllCharacters` (Use Case).
4.  O `GetAllCharacters` (Use Case) chama o método apropriado no `CharacterRepository` (Interface da Camada de Domínio).
5.  A implementação do `CharacterRepository` (na Camada de Dados) decide de qual `DataSource` buscar os dados (ex: `RemoteCharacterDataSource`).
6.  O `RemoteCharacterDataSource` faz uma requisição HTTP para a API do Rick and Morty.
7.  A resposta da API é recebida e, se necessário, mapeada de DTOs para os `Character` Models (Domínio).
8.  O `CharacterRepository` retorna o resultado (uma lista de `Character` ou um `RequestFailure`) para o `GetAllCharacters` (Use Case).
9.  O `GetAllCharacters` (Use Case) retorna o resultado para o `HomeViewModel`.
10. O `HomeViewModel` atualiza seus `Signals` (`characters` ou `error`) com base na resposta.
11. A **View**, que está observando os `Signals` do `HomeViewModel`, se reconstrói automaticamente para exibir a lista de personagens ou uma mensagem de erro.
12. O `HomeViewModel` atualiza seu estado de `isLoading` para `false`.

## Gerenciamento de Estado

O projeto utiliza a biblioteca **Signals** (`signals_flutter`) para gerenciamento de estado reativo.

*   `Signal<T>`: É um container observável para um valor. Quando o valor de um `Signal` muda, qualquer widget ou componente que o esteja "escutando" é notificado e pode se reconstruir/atualizar.
*   `Computed<T>`: Um `Signal` cujo valor é derivado de outros `Signals`. Ele é recalculado automaticamente quando qualquer uma de suas dependências muda.
*   `Effect`: Permite executar código com efeitos colaterais em resposta a mudanças em `Signals`.

Os `ViewModels` expõem os dados e o estado da UI através de `Signals`, que são observados pelas Views. Isso cria um fluxo de dados unidirecional e reativo.

## Injeção de Dependência

A injeção de dependência (ID) é usada para fornecer as dependências necessárias para as classes (ex: injetar `GetAllCharacters` no `HomeViewModel`). Isso melhora a testabilidade e o desacoplamento. (Especifique aqui qual ferramenta de ID está sendo usada, por exemplo, `get_it`, `provider`, ou injeção manual via construtor como no exemplo fornecido).

No exemplo do `HomeViewModel`:

