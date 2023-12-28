Terraform Infrastructure as Code (IaC) - Multi-VPC Setup

Este repositório contém os arquivos Terraform para provisionar uma infraestrutura de nuvem multi-VPC. A infraestrutura inclui três VPCs, sendo uma delas centralizada, com serviços de endpoint de VPC e um NAT Gateway centralizado.

As outras 2 são VPCs de Clientes/Consumidores dos serviços.

Pré-requisitos
Antes de começar, certifique-se de ter o Terraform instalado. Se ainda não o fez, você pode baixá-lo em https://developer.hashicorp.com/terraform/install

Como Usar
Clonar o Repositório: 
https://github.com/marcossantosscott/VPCServicesCentralizado.git

Configurar suas Credenciais AWS:

Certifique-se de ter suas credenciais AWS configuradas. Você pode fazer isso criando um arquivo ~/.aws/credentials ou configurando as variáveis de ambiente.

Editar as Variáveis do Terraform:

Abra o arquivo variables.tf e ajuste as variáveis conforme necessário. Certifique-se de fornecer informações específicas, como nomes de VPC, regiões, etc.

Iniciar e Aplicar o Terraform:

terraform init
terraform plan
terraform apply

Siga as instruções para confirmar e aplicar as alterações.

Limpar a Infraestrutura:

Quando você terminar de usar a infraestrutura, é recomendável destruí-la para evitar custos desnecessários.

terraform destroy -auto-approve

Tive que usar o TransitGateway como um módulo pois estava encontrando erros quando criava as rotas privadas das vpcs que apotavam para o TGW, informando que o recuros não existia.

Estrutura do Projeto

modules/transit_gateway/tgw.tf: Responsável pela criação do TGW e export do id do recurso.

ec2.tf: Contém a configuração das instâncias que vão ser criadas para cada VPC. Para simplificar, deixei todas com as mesmas configurações.

endpoints.tf: Criação do VPC endpoint. No meu caso específico, criei o de SQS para testar o envio de mensagens para a fila.

provider.tf: Arquivo com a configuração do provider e a região.

route53_hostedzone.tf: Criação da zona privada, associação com as três VPCs e criação do record que aponta para o endpoint do SQS.

sg.tf: Arquivo destinado à criação dos Security Groups (SGs) e regras, para uso nas EC2 e no endpoint do SQS.

sqs.tf: Arquivo que cria a fila do SQS

tgw.tf: Criação do Transit Gateway e associação com as VPCs.

tgw_attach.tf: Attachment do Transit Gateway com as VPCs.

variables.tf: Define as variáveis utilizadas no projeto.

vpc-services.tf: Criação da VPC de Services, que é a VPC centralizada na arquitetura, e seus recursos relacionados.

vpcs-consumers.tf: Criação das VPCs de Consumers, que são as VPCs centralizadas na arquitetura, e seus recursos relacionados.
