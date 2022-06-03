

USE Poki;
GO
ALTER PROCEDURE findAuthorsWithName
    @Name nvarchar(50)
AS
    SET NOCOUNT ON;
    SELECT Author.Id, Author.Name 
    FROM Author
    WHERE Name = @Name OR Name LIKE @Name OR Name LIKE '%@Name%';
GO