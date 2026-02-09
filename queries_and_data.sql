USE ecommerce_dio;

-- Seed Data
INSERT INTO Clients (Fname, Minit, Lname, Address) VALUES
('Gus', 'D', 'Silva', 'Rua Tech, 100'),
('Maria', 'A', 'Souza', 'Av. Dados, 50'),
('TechSolutions', '', '', 'Rua Inovação, 200');

INSERT INTO Client_PF (idClient, CPF) VALUES (1, '12345678901'), (2, '98765432100');
INSERT INTO Client_PJ (idClient, CNPJ, SocialName) VALUES (3, '00011122233344', 'TechSolutions Ltda');

INSERT INTO Product (Pname, Category, Price) VALUES
('Notebook Gamer', 'Eletrônico', 5000),
('Mouse Ergonômico', 'Periférico', 150),
('Monitor 27', 'Eletrônico', 1200);

INSERT INTO Orders (idClient, OrderStatus, Freight) VALUES
(1, 'Confirmado', 20),
(1, 'Em processamento', 15),
(2, 'Confirmado', 30),
(3, 'Confirmado', 50);

INSERT INTO ProductOrder (idPOproduct, idPOorder, PoQuantity, PoStatus) VALUES
(1, 1, 1, 'Disponível'),
(2, 1, 2, 'Disponível'),
(3, 3, 1, 'Disponível');

INSERT INTO Delivery (idOrder, TrackingCode, Status) VALUES
(1, 'TRK123456BR', 'Enviado'),
(3, 'TRK987654BR', 'Entregue');

-- 1. Recuperar Clientes e Status de Pedidos (PF e PJ)
SELECT 
    c.idClient, 
    COALESCE(pf.CPF, pj.CNPJ) AS Doc_ID, 
    o.idOrder, 
    o.OrderStatus 
FROM Clients c
LEFT JOIN Client_PF pf ON c.idClient = pf.idClient
LEFT JOIN Client_PJ pj ON c.idClient = pj.idClient
INNER JOIN Orders o ON c.idClient = o.idClient;

-- 2. Ticket Médio por Pedido (com frete)
SELECT 
    o.idOrder,
    SUM(p.Price * po.PoQuantity) + o.Freight AS Total_Value
FROM Orders o
INNER JOIN ProductOrder po ON o.idOrder = po.idPOorder
INNER JOIN Product p ON po.idPOproduct = p.idProduct
GROUP BY o.idOrder;

-- 3. Clientes com mais de 1 pedido (HAVING)
SELECT 
    c.Fname, 
    COUNT(o.idOrder) as Orders_Count 
FROM Clients c
JOIN Orders o ON c.idClient = o.idClient
GROUP BY c.idClient
HAVING Orders_Count > 1;
