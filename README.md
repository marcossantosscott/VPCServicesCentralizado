Terraform Infrastructure as Code (IaC) - Multi-VPC Setup

Este repositório contém os arquivos Terraform para provisionar uma infraestrutura de nuvem multi-VPC. A infraestrutura inclui três VPCs, sendo uma delas centralizada, com serviços de endpoint de VPC e um NAT Gateway centralizado.

As outras 2 são VPCs de Clientes/Consumidores dos serviços

Pré-requisitos
Antes de começar, certifique-se de ter o Terraform instalado. Se ainda não o fez, você pode baixá-lo em https://developer.hashicorp.com/terraform/install

Como Usar
Clonar o Repositório:



bash
Copy code
git clone https://github.com/seu-usuario/seu-repositorio.git
cd seu-repositorio
Configurar suas Credenciais AWS:

Certifique-se de ter suas credenciais AWS configuradas. Você pode fazer isso criando um arquivo ~/.aws/credentials ou configurando as variáveis de ambiente.

Editar as Variáveis do Terraform:

Abra o arquivo terraform.tfvars e ajuste as variáveis conforme necessário. Certifique-se de fornecer informações específicas, como nomes de VPC, regiões, etc.

Iniciar e Aplicar o Terraform:

bash
Copy code
terraform init
terraform apply
Siga as instruções para confirmar e aplicar as alterações.

Limpar a Infraestrutura:

Quando você terminar de usar a infraestrutura, é recomendável destruí-la para evitar custos desnecessários.

bash
Copy code
terraform destroy
Estrutura do Projeto
main.tf: Contém a configuração principal do Terraform, incluindo definições de recursos e módulos.
variables.tf: Define as variáveis utilizadas no projeto.
outputs.tf: Define as saídas exportadas pelo Terraform após a aplicação.
terraform.tfvars: Arquivo para preenchimento das variáveis com valores específicos.
Contribuições
Contribuições são bem-vindas! Sinta-se à vontade para abrir problemas (issues) ou enviar pull requests.

Licença
Este projeto está licenciado sob a MIT License - veja o arquivo LICENSE para detalhes.