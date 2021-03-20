import Pkg
Pkg.add("CSV")
Pkg.add("DataFrames")
Pkg.add("Pandas")
Pkg.add("Plots")
Pkg.add("GR")
Pkg.add("Distributions")
Pkg.add("StatsBase")
Pkg.add("StatsPlots")
Pkg.add("PGFPlotsX")
Pkg.add("Missings")
using CSV
using DataFrames
using Plots
using Statistics
using Distributions
using StatsBase
using StatsPlots
using GR
using PGFPlotsX
using Missings


dados = DataFrame()

dados = CSV.File("C:/Users/winseven/Desktop/simpsons.csv")

dados = DataFrame(dados)

nomes = names(dados)

colnames = [ "identificador","link_imagem","avaliacao_IMDB","votos_IMDB",
             "num_temporada","num_serie","exibicao_original_data","exibicao_original_ano",
             "codigo_producao","temporada","titulo_episodio","espectadores_usa_milions",
             "link_video","visualizacoes"]

rename!(dados,colnames)
names(dados)

first(dados,5)
##
qtde = combine(nrow, groupby(dados, :temporada))
qtde

bar(qtde.temporada,
    qtde.nrow,
    label = "Temporadas",
    Title = "Episodios por temporadas",
    size = [700,500],
    color = "#FEDC03",
    border = "#FEDC03")

qtde = combine(nrow,groupby(dados,:exibicao_original_ano))
qtde

bar(qtde.exibicao_original_ano,
    qtde.nrow,
    label = "Anos",
    Title = "Episodios por temporadas",
    size = [700,500],
    color = "#FEDC03",
    border = "#FEDC03")

## Valores faltante
descricao = describe(dados)

vazios = dados[.!completecases(dados),:]

##Avaliacao do IMDB
describe(dados.avaliacao_IMDB)

dados.avaliacao_IMDB[ismissing.(dados.avaliacao_IMDB)]

mediana = Statistics.median(skipmissing(dados.avaliacao_IMDB))

replace!(dados.avaliacao_IMDB, missing => mediana)

dados.avaliacao_IMDB[ismissing.(dados.avaliacao_IMDB)]

describe(dados.avaliacao_IMDB)

boxplot(dados.avaliacao_IMDB)

StatsPlots.histogram(dados.avaliacao_IMDB)

## Espectadores
describe(dados.espectadores_usa_milions)

dados.espectadores_usa_milions[ismissing.(dados.espectadores_usa_milions)]

mediana = median(skipmissing(dados.espectadores_usa_milions))

replace!(dados.espectadores_usa_milions,missing => mediana)

describe(dados.espectadores_usa_milions)

dados.espectadores_usa_milions[ismissing.(dados.espectadores_usa_milions)]

boxplot(dados.espectadores_usa_milions)

StatsPlots.histogram(dados.espectadores_usa_milions)

## Visualizacoes

describe(dados.visualizacoes)

mediana = median(skipmissing(dados.visualizacoes))

replace!(dados.visualizacoes, missing => mediana)

dados.visualizacoes[ismissing.(dados.visualizacoes)]

boxplot(dados.visualizacoes)

StatsPlots.histogram(dados.visualizacoes)

## Votos do IMDB
describe(dados.votos_IMDB)

mediana = median(skipmissing(dados.votos_IMDB))
mediana

replace!(dados.votos_IMDB,missing => mediana)

describe(dados.votos_IMDB)

boxplot(dados.votos_IMDB)

StatsPlots.histogram(dados.votos_IMDB)

ordenado = sort(dados, :num_serie)

Plots.plot(ordenado.num_serie,
           ordenado.espectadores_usa_milions,
           title = "Espectadores por episódio",
           color = "#FEDC03",
           xlabel = "Episódios",
           ylabel = "Espectadores",
           background_color = "rgb(255, 255, 255)")

           Plots.plot(ordenado.num_serie,
                      ordenado.espectadores_usa_milions,
                      title = "Espectadores por episódio",
                      color = "#FEDC03",
                      xlabel = "Episódios",
                      ylabel = "Espectadores",
                      background_color = "rgb(255, 255, 255)")
