CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE produto(
	id_product INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(20) NOT NULL,
    category VARCHAR (15) NOT NULL,
    class FLOAT DEFAULT 0,
    status_product ENUM('Ativo','Desativado'),
    id_supplier_product INT,
    CONSTRAINT fk_id_supplier FOREIGN KEY(id_supplier_product) REFERENCES fornecedor(id_supplier)
);

INSERT INTO produto(product_name, category, class, status_product, id_supplier_product) 
						VALUES('Fone de ouvido','Eletrônico','4','Ativo',1),
                              ('Barbie Elsa','Brinquedos','3','Ativo',1),
                              ('Body Carters','Vestimenta','5','Ativo',3),
                              ('Microfone Vedo - Youtuber','Eletrônico','4','Ativo',2),
                              ('Sofá retrátil','Móveis','3','Ativo',3),
                              ('Farinha de arroz','Alimentos','2','Ativo',2),
                              ('Fire Stick Amazon','Eletrônico','3','Ativo',3);


CREATE TABLE pedido(
	id_order INT AUTO_INCREMENT PRIMARY KEY,
    order_status ENUM('Faturado', 'Pendente', 'Cancelado'),
    id_client_order INT,
    order_observation VARCHAR (300),
    shipping_status ENUM('Pendente','Em separação','Em rota','Entregue'),
    order_value FLOAT,
    payment ENUM('mastercard','visa','elo','pix'),
    order_id_product INT,
    CONSTRAINT fk_order_client FOREIGN KEY(id_client_order) REFERENCES cliente(id_client),
    CONSTRAINT fk_order_id_product FOREIGN KEY(order_id_product) REFERENCES produto(id_product)
);

INSERT INTO pedido(order_status, id_client_order, order_observation, shipping_status, order_value, payment, order_id_product) 
	VALUES ('Pendente',1,'Deliver on the frontyard','Pendente',150,'visa',2),
		   ('Faturado',2,'thank you','Entregue',100,'visa',3),
           ('Faturado',2,'please deliver on day 4','Entregue',120,'visa',1);

CREATE TABLE cliente(
	id_client INT AUTO_INCREMENT PRIMARY KEY,
    f_name VARCHAR(10) NOT NULL,
    minit char(3),
    l_name VARCHAR(20),
    CPF CHAR(11) NOT NULL,
    address VARCHAR(50),
    CONSTRAINT unique_cpf_client UNIQUE(CPF)
);

INSERT INTO cliente(f_name, init, l_name , CPF, address)
VALUES ('Maria','M','Silva', 12346789, 'rua silva de prata 29, Carangola - Cidade das flores'),
		     ('Matheus','O','Pimentel', 987654321,'rua alemeda 289, Centro - Cidade das flores'),
			 ('Ricardo','F','Silva', 45678913,'avenida alemeda vinha 1009, Centro - Cidade das flores'),
			 ('Julia','S','França', 789123456,'rua lareijras 861, Centro - Cidade das flores'),
			 ('Roberta','G','Assis', 98745631,'avenidade koller 19, Centro - Cidade das flores'),
			 ('Isabela','M','Cruz', 654789123,'rua alemeda das flores 28, Centro - Cidade das flores');

CREATE TABLE estoque(
	id_storage INT AUTO_INCREMENT PRIMARY KEY,
    storage_name VARCHAR(15) DEFAULT 'CD Principal' NOT NULL,
    location VARCHAR(300) NOT NULL
);

INSERT INTO estoque(storage_name, location) VALUES ('Main CD','Rio de Janeiro'),
                            ('Cross Docking','Rio de Janeiro'),
                            ('Main SP','São Paulo'),
                            ('Cross Docking SP','São Paulo'),
                            ('Picking Point SP','São Paulo'),
                            ('Main CD BR','Brasília');

CREATE TABLE produto_em_estoque(
	id_produto_pe INT NOT NULL, 
    id_estoque_pe INT NOT NULL,
    quantity INT DEFAULT 0,
    CONSTRAINT PRIMARY KEY(id_produto_pe, id_estoque_pe),
    CONSTRAINT fk_idproduto_pe_produto FOREIGN KEY (id_produto_pe) REFERENCES produto(id_product),
    CONSTRAINT fk_idestoque_pe_estoque FOREIGN KEY (id_estoque_pe) REFERENCES estoque(id_storage)
);


CREATE TABLE fornecedor(
	id_supplier INT AUTO_INCREMENT PRIMARY KEY,
    nome_fantasia VARCHAR(200),
    razao_social VARCHAR (200) NOT NULL,
    CPNJ CHAR(15) NOT NULL,
    contato CHAR(11),
    CONSTRAINT unique_cnpj UNIQUE(CNPJ)
);

INSERT INTO fornecedor VALUES (1,'Almeida e filhos', 'EMPRESA DE ELETRONICOS ALMEIDA',123456789123456,'21985474'),
                            (2,'Eletrônicos Silva','ELETROTECNICA SILVA & ASSOCIADOS',854519649143457,'21985484'),
                            (3,'Eletrônicos Valma', 'VALMA PRODUTOS ELETRONICOS',934567893934695,'21975474');

CREATE TABLE produto_pedido (
	id_pedido INT,
    id_produto INT,
    quantity INT,
    CONSTRAINT PRIMARY KEY(id_pedido, id_produto),
    CONSTRAINT fk_idpedido_pp_order FOREIGN KEY (id_pedido) REFERENCES pedido(id_order),
    CONSTRAINT fk_idproduto_pp_product FOREIGN KEY (id_produto) REFERENCES produto(id_product)
);


