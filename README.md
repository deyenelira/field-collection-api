
## A API simula o fluxo de um sistema de coleta em campo.

* Ruby version: 2.4.10
* Rails version: 5.2.6
* Postgresql

## Execução dos testes:
- Antes da execução de cada teste, é necessário executar o seguinte comando: 
    - bundle exec rake db:reset RAILS_ENV=test
- Requests:
    - rspec ./spec/models/(nomedoarquivo)_spec.rb
- Models:
    - rspec ./spec/requests/(nomedoarquivo)_spec.rb
