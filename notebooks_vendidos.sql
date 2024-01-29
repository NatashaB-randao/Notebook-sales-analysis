use projetos
select * from Notebooks_Vendidos

-- 1. Stored Procedure para Inserir Dados
-- Esta Stored Procedure chamada InserirNotebookVendido aceita parâmetros para marca, modelo, preco_atual_real, 
-- e tipo_ram, e insere um novo registro na tabela Notebooks_Vendidos.
DELIMITER //

CREATE PROCEDURE InserirNotebookVendido(
    IN p_marca VARCHAR(255),
    IN p_modelo VARCHAR(255),
    IN p_preco_atual_real DECIMAL(10,2),
    IN p_tipo_ram VARCHAR(255)
)
BEGIN
    INSERT INTO Notebooks_Vendidos (marca, modelo, preco_atual_real, tipo_ram)
    VALUES (p_marca, p_modelo, p_preco_atual_real, p_tipo_ram);
END //

DELIMITER ;

-- 2. Trigger para Atualizar Outra Tabela Após Inserção
-- Este Trigger, chamado AfterInsertNotebookVendido, é acionado após a inserção de um novo registro na tabela Notebooks_Vendidos. 
-- Ele insere uma entrada na tabela Log_Vendas indicando que um novo notebook foi vendido.
DELIMITER //

CREATE TRIGGER AfterInsertNotebookVendido
AFTER INSERT
ON Notebooks_Vendidos
FOR EACH ROW
BEGIN
    INSERT INTO Log_Vendas (evento, descricao)
    VALUES ('NOVO_NOTEBOOK_VENDIDO', CONCAT('Notebook vendido: ', NEW.marca, ' ', NEW.modelo));
END //

DELIMITER ;
