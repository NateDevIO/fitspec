-- ============================================================================
-- FitSpec Stored Procedures
-- Core data-access layer for the FitSpec vehicle-fitment platform.
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 1. sp_GetVehicleCascade
--    Cascading vehicle selector.
--      No params          -> all makes
--      @MakeId only       -> models for that make
--      @MakeId + @ModelId -> years/trims for that make+model
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE sp_GetVehicleCascade
    @MakeId INT = NULL,
    @ModelId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- No params: return all makes
    IF @MakeId IS NULL AND @ModelId IS NULL
    BEGIN
        SELECT Id, Name, Slug, LogoUrl
        FROM Makes
        ORDER BY Name;
        RETURN;
    END

    -- MakeId only: return models for that make
    IF @MakeId IS NOT NULL AND @ModelId IS NULL
    BEGIN
        SELECT DISTINCT m.Id, m.Name, m.Slug
        FROM Models m
        INNER JOIN Vehicles v ON v.ModelId = m.Id
        WHERE m.MakeId = @MakeId
        ORDER BY m.Name;
        RETURN;
    END

    -- Both params: return years/trims for that make+model
    IF @MakeId IS NOT NULL AND @ModelId IS NOT NULL
    BEGIN
        SELECT v.Id AS VehicleId, v.Year, v.Trim, v.BodyStyle
        FROM Vehicles v
        WHERE v.MakeId = @MakeId AND v.ModelId = @ModelId
        ORDER BY v.Year DESC, v.Trim;
        RETURN;
    END
END
GO

-- ----------------------------------------------------------------------------
-- 2. sp_GetCompatibleProducts
--    Full product search with filters, pagination, and sorting.
--    Returns a paged result set plus @TotalCount via OUTPUT parameter.
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE sp_GetCompatibleProducts
    @VehicleId INT,
    @CategoryId INT = NULL,
    @Brand NVARCHAR(100) = NULL,
    @MinPrice DECIMAL(10,2) = NULL,
    @MaxPrice DECIMAL(10,2) = NULL,
    @MaxDifficulty INT = NULL,
    @VerifiedOnly BIT = NULL,
    @SortBy NVARCHAR(20) = 'name',
    @PageNumber INT = 1,
    @PageSize INT = 12,
    @TotalCount INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    -- Get total count
    SELECT @TotalCount = COUNT(*)
    FROM Products p
    INNER JOIN FitmentMappings fm ON fm.ProductId = p.Id
    INNER JOIN Categories c ON p.CategoryId = c.Id
    WHERE fm.VehicleId = @VehicleId
        AND (@CategoryId IS NULL OR p.CategoryId = @CategoryId OR c.ParentCategoryId = @CategoryId)
        AND (@Brand IS NULL OR p.Brand = @Brand)
        AND (@MinPrice IS NULL OR p.Price >= @MinPrice)
        AND (@MaxPrice IS NULL OR p.Price <= @MaxPrice)
        AND (@MaxDifficulty IS NULL OR fm.InstallDifficulty <= @MaxDifficulty)
        AND (@VerifiedOnly IS NULL OR @VerifiedOnly = 0 OR fm.IsVerified = 1);

    -- Get paged results
    SELECT
        p.Id,
        p.SKU,
        p.Name,
        p.Brand,
        p.Price,
        p.ImageUrl,
        c.Name AS CategoryName,
        fm.InstallDifficulty,
        fm.IsVerified,
        CAST(NULL AS FLOAT) AS AverageRating
    FROM Products p
    INNER JOIN FitmentMappings fm ON fm.ProductId = p.Id
    INNER JOIN Categories c ON p.CategoryId = c.Id
    WHERE fm.VehicleId = @VehicleId
        AND (@CategoryId IS NULL OR p.CategoryId = @CategoryId OR c.ParentCategoryId = @CategoryId)
        AND (@Brand IS NULL OR p.Brand = @Brand)
        AND (@MinPrice IS NULL OR p.Price >= @MinPrice)
        AND (@MaxPrice IS NULL OR p.Price <= @MaxPrice)
        AND (@MaxDifficulty IS NULL OR fm.InstallDifficulty <= @MaxDifficulty)
        AND (@VerifiedOnly IS NULL OR @VerifiedOnly = 0 OR fm.IsVerified = 1)
    ORDER BY
        CASE WHEN @SortBy = 'name' THEN p.Name END ASC,
        CASE WHEN @SortBy = 'price_asc' THEN p.Price END ASC,
        CASE WHEN @SortBy = 'price_desc' THEN p.Price END DESC,
        CASE WHEN @SortBy = 'difficulty' THEN fm.InstallDifficulty END ASC,
        CASE WHEN @SortBy = 'brand' THEN p.Brand END ASC
    OFFSET (@PageNumber - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;
END
GO

-- ----------------------------------------------------------------------------
-- 3. sp_GetCategoryBreakdown
--    Returns category names and product counts for a given vehicle.
--    Only includes leaf categories (those with a ParentCategoryId).
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE sp_GetCategoryBreakdown
    @VehicleId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        c.Id AS CategoryId,
        c.Name,
        c.Slug,
        c.Icon,
        COUNT(DISTINCT p.Id) AS ProductCount
    FROM Categories c
    INNER JOIN Products p ON p.CategoryId = c.Id
    INNER JOIN FitmentMappings fm ON fm.ProductId = p.Id
    WHERE fm.VehicleId = @VehicleId
        AND c.ParentCategoryId IS NOT NULL
    GROUP BY c.Id, c.Name, c.Slug, c.Icon
    HAVING COUNT(DISTINCT p.Id) > 0
    ORDER BY c.Name;
END
GO

-- ----------------------------------------------------------------------------
-- 4. sp_GetProductCoOccurrence
--    Co-purchase data used for ML recommendation training.
--      @ProductId = NULL -> all co-occurrence pairs (bulk export)
--      @ProductId set    -> top co-occurring products for that product
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE sp_GetProductCoOccurrence
    @ProductId INT = NULL,
    @TopN INT = 100
AS
BEGIN
    SET NOCOUNT ON;

    IF @ProductId IS NULL
    BEGIN
        -- Return all co-occurrence pairs for ML training
        SELECT TOP (@TopN * 100)
            oi1.ProductId AS ProductId1,
            oi2.ProductId AS ProductId2,
            COUNT(*) AS CoOccurrenceCount
        FROM OrderItems oi1
        INNER JOIN OrderItems oi2 ON oi1.OrderId = oi2.OrderId
            AND oi1.ProductId < oi2.ProductId
        GROUP BY oi1.ProductId, oi2.ProductId
        HAVING COUNT(*) >= 2
        ORDER BY COUNT(*) DESC;
    END
    ELSE
    BEGIN
        -- Return top co-occurring products for a specific product
        SELECT TOP (@TopN)
            oi2.ProductId AS ProductId2,
            COUNT(*) AS CoOccurrenceCount
        FROM OrderItems oi1
        INNER JOIN OrderItems oi2 ON oi1.OrderId = oi2.OrderId
            AND oi1.ProductId != oi2.ProductId
        WHERE oi1.ProductId = @ProductId
        GROUP BY oi2.ProductId
        ORDER BY COUNT(*) DESC;
    END
END
GO
