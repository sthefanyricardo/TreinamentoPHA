*** Settings ***
Documentation       Este é um conjunto de testes, referente aos desafios da 2 semana do treinamento PHA Edição 6

Library             DateTime
Library             Collections


*** Variables ***
&{DADOS_DICIONARIO}
...    nome=Sthefany
...    idade=24
...    rua=Rua dos Exemplos
...    numero=0
...    bairro=Vila do Exemplo
...    cep=00000-000
...    cidade=São Paulo
...    estado=SP

@{DADOS_LISTA}    
...    Maça
...    Abacaxi
...    Laranja
...    Morango
...    Banana
...    Uva
...    Melão

@{LISTA_DE_LETRAS_E_NUMEROS}    "A"    1    "B"    2    "C"    3

@{LISTA_DE_NUMEROS}


*** Test Cases ***
CT01 - Exercício Dicionário
    [Documentation]    Exibir as informações do usuário no console a partir de um dicionário
    [Tags]    ct01

    Exibir Informações do Usuário a partir de um Dicionário

CT02 - Exercício Argumentos e Retornos + IF Simples
    [Documentation]    A partir da idade informada calcula e retorna o ano de nascimento,
    ...    se o ano for menor que 2000, exibi uma mensagem informando que a pessoa nasceu no século passado
    [Tags]    ct02

    ${ANO_NASCIMENTO_RETORNADO}    Calcular e Retornar o Ano de Nascimento    IDADE=24

    Verificar se a pessoa nasceu no século passado    ${ANO_NASCIMENTO_RETORNADO}

CT03 - Exercício For Simples + Lista
    [Documentation]    Exibir o nome de todas as frutas contidas em uma lista usando um FOR Simples
    [Tags]    ct03

    Exibir o nome de todas as frutas contidas em uma lista

CT04 - Exercício IF Inline + For in Range
    [Documentation]    Verificar a quantidade de numeros pares existentes entre 0 e 10 usando um For in Range e um IF Inline
    [Tags]    ct04

    Verificar a quantidade de numeros pares existentes entre 0 e 10

CT05 - Atividade Extra
    [Documentation]    A partir de uma lista que contém numeros e letras verificar somente os numeros e adicioná-los em uma nova lista,
    ...    tratar os caracteres como exceção e exibir a nova lista a cada iteração usando Finally.
    [Tags]    ct05

    Extrair e Exibir Somente os Numeros em uma Nova Lista


*** Keywords ***
Exibir Informações do Usuário a partir de um Dicionário
    Log To Console    \n

    FOR    ${CHAVE}    ${VALOR}    IN    &{DADOS_DICIONARIO}
        Log To Console    ${chave}: ${valor}
    END

    Log To Console    \n

Calcular e Retornar o Ano de Nascimento
    [Arguments]    ${IDADE}

    ${ANO_ATUAL}    Get Current Date    result_format=%Y

    ${ANO_NASCIMENTO}    Evaluate    ${ANO_ATUAL} - ${IDADE}

    RETURN    ${ANO_NASCIMENTO}

Verificar se a pessoa nasceu no século passado
    [Arguments]    ${ANO_NASCIMENTO}

    IF    ${ANO_NASCIMENTO} < 2000
        Log To Console    \n
        Log To Console    Nasceu no século passado.\n
    ELSE
        Log To Console    \n
        Log To Console    O ano de nascimento é: ${ANO_NASCIMENTO}\n
    END

Exibir o nome de todas as frutas contidas em uma lista
    Log To Console    \n

    FOR    ${INDEX}    IN    @{DADOS_LISTA}
        Log To Console    ${INDEX}
    END

    Log To Console    \n

Verificar a quantidade de numeros pares existentes entre 0 e 10
    ${CONTADOR}    Set Variable    0

    FOR    ${INDEX}    IN RANGE    0    11
        ${CONTADOR}=    IF    ${INDEX} % 2 == 0    Evaluate    ${CONTADOR} + 1    ELSE    Set Variable    ${CONTADOR}
    END
    
    # Outra forma de fazer  
    # FOR    ${INDEX}    IN RANGE    0    11
    #     ${CONTADOR}=    IF    ${INDEX} % 2 == 0    Evaluate    ${CONTADOR} + 1    ELSE    Continue For Loop
    # END

    # Outra forma de fazer
    # FOR    ${INDEX}    IN RANGE    0    11
    #    IF    ${INDEX} % 2 == 0    Incrementar contador    ${CONTADOR}
    # END

    Log To Console    \n

    Log To Console    O total de números pares é: ${CONTADOR}\n

Incrementar contador
    [Arguments]    ${CONTADOR}

    ${CONTADOR_AUXILIAR}    Evaluate    ${CONTADOR} + 1

    Set Test Variable    ${CONTADOR}    ${CONTADOR_AUXILIAR}

Extrair e Exibir Somente os Numeros em uma Nova Lista
    Log To Console    \n

    FOR    ${ITEM}    IN    @{LISTA_DE_LETRAS_E_NUMEROS}
        TRY
            IF    "${ITEM}".isnumeric() or "${ITEM}".isdigit()
                Append To List    ${LISTA_DE_NUMEROS}    ${ITEM}
                Log To Console    O caracter é um número:
            END
        EXCEPT
            Log To Console    O caracter não é um número:
        FINALLY
            Log To Console    Nova Lista: @{LISTA_DE_NUMEROS}
        END
    END

    Log To Console    \n
