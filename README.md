# Han-Schefold

This repository replicates stuff from Zonghie Han and Bertram Schefold 2006 as well as Han's dissertation.

## Usage

The calculations can be executed via `run.jl` and the results can be evaluated via `results.jl`.

## Results

For *reverse substitution of labour* we consider the change in $l_i$; the explanation with $\chi$ in the paper is unclear to me. With this approach, we obtain comparable results. 
However there are some noteworthy topics:
- There are countries where entries for the normalization factor *Total final demand* are missing. It is not clear how to handle these cases.
- A finer grid gives fully piecewise switches and qualitatively comparable results.
- A simultaneous comparison for all countries at once eliminates all perverse effects.

### Overall information

```
There are 496 pairwise comparisons.
Number of switches: 4913
Reswitching in: can1990/deu1990, r = 0.64
Number of reswitches: 1
There have been 367 instances of switches that are not piecemeal.
Capital intensity-reducing, labour-increasing: 4777 cases (97.23%)
Capital intensity-reducing, labour-reducing: 101 cases (2.06%)
Capital intensity-increasing, labour-increasing: 9 cases (0.18%)
Capital intensity-increasing, labour-reducing: 26 cases (0.53%)
```

### Overall information with finer grid
```
There are 496 pairwise comparisons.
Number of switches: 5312
Reswitching in: can1990/deu1990, r = 0.64729
Number of reswitches: 1
There have been 0 instances of switches that are not piecemeal.
Capital intensity-reducing, labour-increasing: 5158 cases (97.1%)
Capital intensity-reducing, labour-reducing: 111 cases (2.09%)
Capital intensity-increasing, labour-increasing: 11 cases (0.21%)
Capital intensity-increasing, labour-reducing: 32 cases (0.6%)
```

### Overall information for simultaneous comparisons
```
There are 1 pairwise comparisons.
Number of switches: 8
Number of reswitches: 0
There have been 0 instances of switches that are not piecemeal.
Capital intensity-reducing, labour-increasing: 8 cases (100.0%)
Capital intensity-reducing, labour-reducing: 0 cases (0.0%)
Capital intensity-increasing, labour-increasing: 0 cases (0.0%)
Capital intensity-increasing, labour-reducing: 0 cases (0.0%)
```

### can1990 vs. deu1990

| **Country**<br>`String` | **Sector**<br>`String`                | **0.62**<br>`Float64` | **0.63**<br>`Float64` | **0.64**<br>`Float64` | **0.65**<br>`Float64` | **0.66**<br>`Float64` | **0.67**<br>`Float64` | **0.68**<br>`Float64` | **0.69**<br>`Float64` | **0.7**<br>`Float64` |
|------------------------:|--------------------------------------:|----------------------:|----------------------:|----------------------:|----------------------:|----------------------:|----------------------:|----------------------:|----------------------:|---------------------:|
| can1990                 | Agriculture, forestry & fishing       | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                  |
| can1990                 | Mining & quarrying                    | 5.24509               | 5.39361               | 5.54884               | 5.65897               | 5.25469               | 5.39367               | 5.53837               | 5.68916               | 5.87125              |
| can1990                 | Food, beverages & tobacco             | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                  |
| can1990                 | Textiles, apparel & leather           | 3.80872               | 3.87086               | 3.93537               | 3.94522               | 3.87852               | 3.93933               | 4.00228               | 4.0675                | 4.18627              |
| can1990                 | Wood products & furniture             | 1.77076               | 1.80172               | 1.83408               | 1.86594               | 1.69777               | 1.72378               | 1.75084               | 1.779                 | 1.80034              |
| can1990                 | Paper, paper products & printing      | 3.83267               | 3.93809               | 4.04832               | 4.08632               | 2.83965               | 2.90682               | 2.97673               | 3.04955               | 3.13653              |
| can1990                 | Industrial chemicals                  | 6.57183               | 6.76076               | 6.95836               | 6.77067               | 6.51228               | 6.68996               | 6.87517               | 7.06838               | 7.64027              |
| can1990                 | Drugs & medicines                     | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                  |
| can1990                 | Petroleum & coal products             | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                  |
| can1990                 | Rubber & plastic products             | 2.20653               | 2.25129               | 2.29794               | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 2.22887              |
| can1990                 | Non-metallic mineral products         | 1.27261               | 1.30139               | 1.33144               | 1.38911               | 1.31235               | 1.3404                | 1.36958               | 1.39996               | 1.40012              |
| can1990                 | Iron & steel                          | 2.07866               | 2.12978               | 2.18303               | 2.25077               | 2.08236               | 2.12994               | 2.17931               | 2.23057               | 2.25995              |
| can1990                 | Non-ferrous metals                    | 2.84099               | 2.89821               | 2.95773               | 3.03219               | 2.88632               | 2.94111               | 2.9979                | 3.0568                | 3.09454              |
| can1990                 | Metal products                        | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                  |
| can1990                 | Non-electrical machinery              | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                  |
| can1990                 | Office & computing machinery          | 4.94302               | 5.00178               | 5.06226               | 5.13735               | 5.03602               | 5.09403               | 5.15358               | 5.21475               | 5.25596              |
| can1990                 | Electrical apparatus, nec             | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                  |
| can1990                 | Radio, TV & communication equipment   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                  |
| can1990                 | Shipbuilding & repairing              | 1.05515               | 1.05705               | 1.05902               | 1.06051               | 1.04389               | 1.04522               | 1.0466                | 1.04804               | 1.04918              |
| can1990                 | Other transport                       | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                  |
| can1990                 | Motor vehicles                        | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                  |
| can1990                 | Aircraft                              | 2.28816               | 2.30976               | 2.33207               | 2.35816               | 2.30395               | 2.32362               | 2.34383               | 2.36461               | 2.37919              |
| can1990                 | Professional goods                    | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                  |
| can1990                 | Other manufacturing                   | 1.8927                | 1.91221               | 1.93251               | 1.9883                | 1.87643               | 1.89401               | 1.91223               | 1.93113               | 1.90998              |
| can1990                 | Electricity, gas & water              | 3.27232               | 3.35915               | 3.44992               | 3.54485               | 3.33377               | 3.41631               | 3.50226               | 3.59182               | 3.67084              |
| can1990                 | Construction                          | 3.10348               | 3.17632               | 3.25254               | 3.338                 | 2.94248               | 3.00564               | 3.07149               | 3.14018               | 3.18306              |
| can1990                 | Wholesale & retail trade              | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                  |
| can1990                 | Restaurants & hotels                  | 1.82492               | 1.85578               | 1.88804               | 1.92559               | 1.47105               | 1.48917               | 1.50803               | 1.52766               | 1.52076              |
| can1990                 | Transport & storage                   | 4.87675               | 5.0155                | 5.16062               | 5.25491               | 2.89605               | 2.96438               | 3.03552               | 3.10964               | 3.12361              |
| can1990                 | Communication                         | 1.70547               | 1.73902               | 1.77404               | 1.79949               | 1.68615               | 1.7164                | 1.74785               | 1.78057               | 1.81823              |
| can1990                 | Finance & insurance                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                  |
| can1990                 | Real estate & business services       | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                  |
| can1990                 | Community, social & personal services | 2.47613               | 2.52685               | 2.57988               | 2.61522               | 2.1626                | 2.20042               | 2.2398                | 2.28084               | 2.31869              |
| can1990                 | Producers of government services      | 1.38766               | 1.41781               | 1.44938               | 1.47459               | 1.4111                | 1.44022               | 1.4706                | 1.50233               | 1.5388               |
| can1990                 | Other producers                       | 6.12434               | 6.27837               | 6.43923               | 6.29197               | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                  |
| can1990                 | Statistical discrepancy               | 0.564626              | 0.579983              | 0.596046              | 0.642281              | 0.665992              | 0.683445              | 0.701632              | 0.720597              | 0.711423             |
| deu1990                 | Agriculture, forestry & fishing       | 3.51125               | 3.60158               | 3.69602               | 3.81063               | 3.70438               | 3.79522               | 3.88984               | 3.98849               | 4.06609              |
| deu1990                 | Mining & quarrying                    | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                  |
| deu1990                 | Food, beverages & tobacco             | 3.4112                | 3.48649               | 3.56519               | 3.63307               | 3.70899               | 3.78896               | 3.87227               | 3.95913               | 4.06418              |
| deu1990                 | Textiles, apparel & leather           | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                  |
| deu1990                 | Wood products & furniture             | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                  |
| deu1990                 | Paper, paper products & printing      | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                  |
| deu1990                 | Industrial chemicals                  | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                  |
| deu1990                 | Drugs & medicines                     | 0.554215              | 0.55541               | 0.556657              | 0.5553                | 0.546193              | 0.547076              | 0.547994              | 0.548949              | 0.552075             |
| deu1990                 | Petroleum & coal products             | 3.15861               | 3.23987               | 3.32494               | 3.37198               | 2.9816                | 3.05109               | 3.12357               | 3.1992                | 3.29765              |
| deu1990                 | Rubber & plastic products             | 0.0                   | 0.0                   | 0.0                   | 2.46127               | 2.18629               | 2.22678               | 2.26878               | 2.3124                | 0.0                  |
| deu1990                 | Non-metallic mineral products         | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                  |
| deu1990                 | Iron & steel                          | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                  |
| deu1990                 | Non-ferrous metals                    | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                  |
| deu1990                 | Metal products                        | 3.07642               | 3.14446               | 3.21535               | 3.25355               | 2.89333               | 2.95122               | 3.01128               | 3.07363               | 3.15123              |
| deu1990                 | Non-electrical machinery              | 3.18476               | 3.23453               | 3.2863                | 3.42273               | 3.11379               | 3.15756               | 3.20289               | 3.24989               | 3.19874              |
| deu1990                 | Office & computing machinery          | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                  |
| deu1990                 | Electrical apparatus, nec             | 3.15808               | 3.21319               | 3.27048               | 3.37532               | 3.13937               | 3.18994               | 3.24231               | 3.29658               | 3.29229              |
| deu1990                 | Radio, TV & communication equipment   | 2.05855               | 2.08434               | 2.1109                | 2.1361                | 2.03363               | 2.05696               | 2.08088               | 2.10542               | 2.1261               |
| deu1990                 | Shipbuilding & repairing              | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                  |
| deu1990                 | Other transport                       | 0.551174              | 0.552475              | 0.553837              | 0.55418               | 0.541444              | 0.542317              | 0.543226              | 0.544173              | 0.545542             |
| deu1990                 | Motor vehicles                        | 2.33173               | 2.36026               | 2.38992               | 2.46319               | 2.28779               | 2.31261               | 2.3383                | 2.36491               | 2.34005              |
| deu1990                 | Aircraft                              | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                  |
| deu1990                 | Professional goods                    | 1.56448               | 1.57414               | 1.58417               | 1.59528               | 1.54113               | 1.5494                | 1.55793               | 1.56675               | 1.57192              |
| deu1990                 | Other manufacturing                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                  |
| deu1990                 | Electricity, gas & water              | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                  |
| deu1990                 | Construction                          | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                  |
| deu1990                 | Wholesale & retail trade              | 6.20089               | 6.35448               | 6.5148                | 6.65796               | 5.73878               | 5.86737               | 6.00103               | 6.14006               | 6.25604              |
| deu1990                 | Restaurants & hotels                  | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                  |
| deu1990                 | Transport & storage                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                  |
| deu1990                 | Communication                         | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                  |
| deu1990                 | Finance & insurance                   | 5.3183                | 5.46324               | 5.61469               | 5.77225               | 5.2552                | 5.3882                | 5.52663               | 5.67081               | 5.78799              |
| deu1990                 | Real estate & business services       | 9.93254               | 10.2231               | 10.5267               | 11.1521               | 10.8711               | 11.1695               | 11.4802               | 11.8039               | 11.8061              |
| deu1990                 | Community, social & personal services | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                  |
| deu1990                 | Producers of government services      | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                  |
| deu1990                 | Other producers                       | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 5.63173               | 5.76069               | 5.89484               | 6.03448               | 6.45072              |
| deu1990                 | Statistical discrepancy               | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                   | 0.0                  |


### can1981 vs. can1990
| **lq, r=0.52**<br>`Any` | **pA, r=0.52**<br>`Any` | **pA, r=0.53**<br>`Any` | **lq, r=0.53**<br>`Any` | **p, r=0.52**<br>`Any` | **q, r=0.52**<br>`Any` | **q, r=0.53**<br>`Any` |
|------------------------:|------------------------:|------------------------:|------------------------:|-----------------------:|-----------------------:|-----------------------:|
| 17.7341                 | 0.463538                | 0.463538                | 17.7367                 | 0.866203               | 2.53804                | 2.53829                |
| pAq/lq, r=0.52          | 0.221846                | 0.221846                | pAq/lq, r=0.53          | 0.521617               | 4.39199                | 4.38324                |
| 1.64654                 | 0.573122                | 0.573122                | 1.64674                 | 1.13741                | 1.8427                 | 1.84231                |
| missing                 | 0.65472                 | 0.65472                 | missing                 | 1.34244                | 1.87076                | 1.86622                |
| missing                 | 0.556026                | 0.556026                | missing                 | 1.2293                 | 1.48898                | 1.48838                |
| missing                 | 0.474364                | 0.474364                | missing                 | 1.10823                | 2.25965                | 2.26111                |
| missing                 | 0.523058                | 0.523058                | missing                 | 1.06172                | 3.17278                | 3.17021                |
| missing                 | 0.289014                | 0.289014                | missing                 | 0.793236               | 1.20416                | 1.20431                |
| missing                 | 0.527441                | 0.527441                | missing                 | 0.860071               | 1.95687                | 1.94666                |
| missing                 | 0.534566                | 0.534566                | missing                 | 1.18784                | 1.69516                | 1.69472                |
| missing                 | 0.376685                | 0.376685                | missing                 | 0.979429               | 1.48492                | 1.48479                |
| missing                 | 0.507252                | 0.507252                | missing                 | 1.13088                | 2.60692                | 2.60644                |
| missing                 | 0.543752                | 0.543752                | missing                 | 1.07602                | 2.30011                | 2.29881                |
| missing                 | 0.561186                | 0.561186                | missing                 | 1.21751                | 2.0835                 | 2.08253                |
| missing                 | 0.598902                | 0.598902                | missing                 | 1.27147                | 1.7579                 | 1.75776                |
| missing                 | 0.718948                | 0.718948                | missing                 | 1.45371                | 1.6078                 | 1.60793                |
| missing                 | 0.554667                | 0.554667                | missing                 | 1.18637                | 1.61292                | 1.61261                |
| missing                 | 0.467208                | 0.467208                | missing                 | 1.08821                | 1.68538                | 1.68841                |
| missing                 | 0.528998                | 0.528998                | missing                 | 1.3049                 | 1.09556                | 1.09547                |
| missing                 | 0.693579                | 0.693579                | missing                 | 1.37009                | 1.26082                | 1.26079                |
| missing                 | 1.19017                 | 1.19017                 | missing                 | 2.00485                | 2.22108                | 2.22072                |
| missing                 | 0.416229                | 0.416229                | missing                 | 1.05381                | 1.291                  | 1.29096                |
| missing                 | 0.521579                | 0.521579                | missing                 | 1.20385                | 1.25732                | 1.25195                |
| missing                 | 0.511533                | 0.511533                | missing                 | 1.17774                | 1.20207                | 1.19862                |
| missing                 | 0.139035                | 0.139035                | missing                 | 0.457826               | 1.98039                | 1.98117                |
| missing                 | 0.500424                | 0.500424                | missing                 | 1.11904                | 1.90263                | 1.90243                |
| missing                 | 0.190661                | 0.190661                | missing                 | 0.884048               | 2.98185                | 2.98707                |
| missing                 | 0.360108                | 0.360108                | missing                 | 1.00015                | 1.22288                | 1.22268                |
| missing                 | 0.406005                | 0.406005                | missing                 | 1.01479                | 2.61905                | 2.61756                |
| missing                 | 0.159917                | 0.159917                | missing                 | 0.655267               | 1.58654                | 1.58568                |
| missing                 | 0.224671                | 0.224671                | missing                 | 0.760304               | 2.91425                | 2.92971                |
| missing                 | 0.138772                | 0.138772                | missing                 | 0.813559               | 2.31064                | 2.32459                |
| missing                 | 0.187                   | 0.197224                | missing                 | 0.756973               | 1.58152                | 1.5959                 |
