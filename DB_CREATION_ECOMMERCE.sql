CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE produto(
	idproduct INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(20) NOT NULL,
    category VARCHAR (15) NOT NULL,
    class FLOAT DEFAULT 0,
    status ENUM('Ativo','Desativado')
    
);

CREATE TABLE pedido(
	idorder INT AUTO_INCREMENT PRIMARY KEY,
    order_status ENUM('Faturado', 'Pendente', 'Cancelado'),
    id_client_order INT,
    order_observation VARCHAR (300),
    shipping_status ENUM('Pendente','Em separação','Em rota','Entregue'),
    order_value FLOAT,
    payment ENUM('mastercard','visa','elo','pix'),
    order_id_product INT,
    CONSTRAINT fk_order_client FOREIGN KEY(id_client_order) REFERENCES cliente(idclient),
    CONSTRAINT fk_order_id_product FOREIGN KEY(order_id_product) REFERENCES produto(idproduct)
    
);
	
CREATE TABLE cliente(
	idclient INT AUTO_INCREMENT PRIMARY KEY,
    fname VARCHAR(10) NOT NULL,
    minit char(3),
    lname VARCHAR(20),
    CPF CHAR(11) NOT NULL,
    address VARCHAR(50),
    CONSTRAINT unique_cpf_client UNIQUE(CPF)
    
);

CREATE TABLE estoque(
	id_storage INT AUTO_INCREMENT PRIMARY KEY,
    storage_name VARCHAR(15) DEFAULT 'CD Principal' NOT NULL,
    localization VARCHAR(300) NOT NULL
    
);

CREATE TABLE produto_em_estoque(
	id_produto_pe INT NOT NULL, 
    id_estoque_pe INT NOT NULL,
    quantity INT DEFAULT 0
);


CREATE TABLE fornecedor(
	idsupplier INT AUTO_INCREMENT PRIMARY KEY,
    nome_fantasia VARCHAR(200),
    razao_social VARCHAR (200) NOT NULL,
    CPNJ CHAR(15) NOT NULL,
    contato CHAR(11),
    CONSTRAINT unique_cnpj UNIQUE(CNPJ)
);

CREATE TABLE produto_pedido (
	id_pedido INT,
    id_produto INT,
    quantity INT,
    CONSTRAINT PRIMARY KEY(id_pedido, id_produto),
    CONSTRAINT fk_prodped_order FOREIGN KEY (id_pedido) REFERENCES pedido(idorder),
    CONSTRAINT fk_prodprod_product FOREIGN KEY (id_produto) REFERENCES produto(idproduct)
);


