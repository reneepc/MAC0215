# Utilização

Para realizar a simulação é necessário utilizar SUMO, OpenStreet Map e ns-3.

Não instalar sumo com apt, uma vez que deste modo não é possível estender o SUMO com módulos. Para que a simulação possa
ser feita é necessário clonar o repositório e compilar o código fonte.

O mesmo será feito com o ns-3 e com OSM (Open Street Map - osmWebWizard.py). Dentro do SUMO há a pasta tools, onde será
encontrado o arquivo osmWebWizard.py o qual será responsável por modelar as ruas e estradas.

Quando executado o osmWebWizard gerará um mapa no browser, o qual pode permitir a utilização da localização do usuário.
É possível utilizar a ferramenta select area para restringir a área do mapa em que o cenário será gerado, bem como
escolher quais veículos serão utilizados, contando com carros, caminhões, ônibus, motos, bicicletas, trens, barcos e
mesmo pedestres.

Após escolher a área de simulação e os parâmetros, o cenário poderá ser gerado, abrindo a GUI do SUMO ou diretamente
para um arquivo de configuração.

Para que o ns-3 consiga interpretar os dados do SUMO será necessário criar um aquivo .tcl. Para isso, primeiramente
utiliza-se o comando:

sumo -c osm.sumocfg --fcd-output trace.xml

Isso gerará um arquivo trace.xml com um grande número de linhas. Este arquivo será utilizado pelo script
traceExporter.py no diretório tools do SUMO o qual possui a opção --ns2mobility-output, o qual gerará um arquivo próprio
para o ns-3.

O comando executado será:

python traceExporter.py -i <diretório-da-simulação>/trace.xml --ns2mobility-output=<diretório-da-simulação>/mobility.tcl

Esse arquivo mobility.tcl será utilizado pelo ns2-mobility-trace para obter a posição dos veículos e pedestres. O
comando para utilizá-lo está especificado no ns2-mobility-trace.cc nos exemplos do módulo de mobilidade do ns-3. 

./waf --run "ns2-mobility-trace" --traceFile=<caminho>/mobility.tcl nodeNum=<número de nós> --duration=<segundos>
--logFile=ns2-mob.log

Depois de gerar o arquivo utiliza-se o módulo netanim (#include "ns3/netanim-module.h") para realizar uma animação da
movimentação dos veículos e pedestres.

Antes do comando Simulator::Run(), adiciona-se o comando AnimationInterface anim("vehicularmobility.xml");
