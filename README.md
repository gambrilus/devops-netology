1   git log --oneline | grep aefea

    aefead2207ef7e2aa5dc81a34aedf0cad4c32545 Update CHANGELOG.md
    
2   git show 85024d3

    tag: v0.12.23
    
3   git show b8d720^

    В коммите указано что это merge.
    
    2 58dcac4b79 ffbcf55817
    
4   git log --oneline 85024d3...33ff1c0

    Но на требуется только между двумя тегами указать поэтому последний коммит не указывал
    
    b14b74c493 [Website] vmc provider links
    3f235065b9 Update CHANGELOG.md
    6ae64e247b registry: Fix panic when server is unreachable
    5c619ca1ba website: Remove links to the getting started guide's old location
    06275647e2 Update CHANGELOG.md
    d5f9411f51 command: Fix bug when using terraform login on Windows
    4b6d06cc5d Update CHANGELOG.md
    dd01a35078 Update CHANGELOG.md
    225466bc3e Cleanup after v0.12.23 release
    
5   git log --pretty=oneline -S "func providerSource"

    Выбираем более старый коммит
    
    git show 8c928e83589d90a031f811fae52a81be7153e82f
    
    commit 8c928e83589d90a031f811fae52a81be7153e82f
    Author: Martin Atkins <mart@degeneration.co.uk>
    Date:   Thu Apr 2 18:04:39 2020 -0700
    
6   git log --pretty=oneline -S "globalPluginDirs"

    125eb51dc40b049b38bf2ed11c32c6f594c8ef96 Remove accidentally-committed binary
    22c121df8631c4499d070329c9aa7f5b291494e1 Bump compatibility version to 1.3.0 for terraform core release (#30988)
    35a058fb3ddfae9cfee0b3893822c9a95b920f4c main: configure credentials from the CLI config file
    c0b17610965450a89598da491ce9b6b5cbd6393f prevent log output during init
    8364383c359a6b738a436d1b7745ccdce178df47 Push plugin discovery down into command package
    
7   git log --pretty=oneline -S "synchronizedWriters"

    Выбираем более старый коммит и смотрим в нем имя автора 
    
    git show 5ac311e2a91e381e2f52234668b49ba670aa0fe5

    Author: Martin Atkins <mart@degeneration.co.uk>
