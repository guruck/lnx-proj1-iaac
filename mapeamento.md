# Mapeamento do Projeto

| diretorios     | grupos                        | usuarios                    |
|----------------|-------------------------------|-----------------------------|
| /publico       |                               | todos com permissao full    |
| /adm           | GRP_ADM                       | carlos maria joao           |
| /ven           | GRP_VEN                       | debora sebastiana roberto   |
| /sec           | GRP_SEC                       | josefina amanda rogerio     |

## Observacoes
Regras do projeto:
- excluir diretorios, arquivos, grupos e usuarios criados anteriormente
- todo provisionamento deve ser feito em um arquivo do tipo bash script
- o dono de todos os diretorios criados sera o usuario root
- todos os usuarios terao permissao total dentro do diretorio 'publico'
- os usuarios de cada grupo terao permissao total dentro de seu respectivo grupo
- os usuarios nao poderam ter permissao de leitura, escrita e execucao em diretorios de departamentos que eles nao pertencem
- subir arquivo de script criado para a sua conta no GITHUB
