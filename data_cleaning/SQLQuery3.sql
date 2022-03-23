/*
Data Cleaning In SQL
*/

select *
From portfolioProject.dbo.Housing



/* Formating Date  */

Select SaleDate, CONVERT(Date,SaleDate) as SaleDateConverted
From portfolioProject.dbo.Housing

Update Housing
Set SaleDateConverted = CONVERT(Date,SaleDate)


/* Populating Property Adress Data */

select *
From portfolioProject.dbo.Housing
--where PropertyAddress is null
order by ParcelID

Select a.ParcelID, b.ParcelID, a.PropertyAddress, b.PropertyAddress,isnull(a.PropertyAddress, b.PropertyAddress)
From portfolioProject.dbo.Housing a
join portfolioProject.dbo.Housing b
		on a.ParcelID=b.ParcelID
		and a.[UniqueID ]<>b.[UniqueID ]
Where a.PropertyAddress is null

Update a
set PropertyAddress = isnull(a.PropertyAddress, b.PropertyAddress)
From portfolioProject.dbo.Housing a
join portfolioProject.dbo.Housing b
		on a.ParcelID=b.ParcelID
		and a.[UniqueID ]<>b.[UniqueID ]
Where a.PropertyAddress is null

/* Breaking words to individual coloumn from rows */

Select AddressOwner
From portfolioProject.dbo.Housing 

SELECT PropertyAddress,
--SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address,
--SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address,
--SUBSTRING(PropertyAddress, 1, CHARINDEX(' ', PropertyAddress) -1) as TestAddress
--SUBSTRING(PropertyAddress, CHARINDEX(' ', PropertyAddress) , (CHARINDEX(',',PropertyAddress))) as Addressowner
From PortfolioProject.dbo.Housing

SELECT PropertyAddress,
PARSENAME(REPLACE(PropertyAddress, ',', '.') ,1)

From PortfolioProject.dbo.Housing


Alter Table portfolioProject.dbo.Housing
		Add AddressOwner Nvarchar(255);

Update portfolioProject.dbo.Housing
		SET AddressOwner = SUBSTRING(PropertyAddress, CHARINDEX(' ', PropertyAddress) , (CHARINDEX(',',PropertyAddress)))



Alter Table portfolioProject.dbo.Housing
	ADD AddressName Nvarchar(255), AddressLoc Nvarchar(255), AddressCode Nvarchar(255);

Update portfolioProject.dbo.Housing
SET AddressLoc = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))
	
Update portfolioProject.dbo.Housing
SET AddressName = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)

Update portfolioProject.dbo.Housing
SET AddressCode = SUBSTRING(PropertyAddress, 1, CHARINDEX(' ', PropertyAddress) -1)



Select OwnerAddress
From portfolioProject.dbo.Housing 


Select
--PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
--PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From portfolioProject.dbo.Housing 

Select
SUBSTRING(AddressOwner, 1,Charindex(',',AddressOwner)) As AddLine1
From PortfolioProject.dbo.Housing

Select 
PARSENAME(REPLACE(AddressOwner, ',', '.') ,2) Addline1
From portfolioProject.dbo.Housing

Alter table PortfolioProject.dbo.Housing
Add AddressLine1 Nvarchar(255)

Update PortfolioProject.dbo.Housing
	SET AddressName = PARSENAME(REPLACE(AddressOwner, ',', '.') ,2)

Select *
From portfolioProject.dbo.Housing

Update PortfolioProject.dbo.Housing
	SET AddressLine1 = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)

sp_rename'Housing.AddressLine1','AddressState', 'Column';

Select SoldAsVacant, 
	Case when SoldAsVacant = 'Y' then 'Yes'
		 When SoldAsVacant = 'N' then 'No'
		 Else SoldAsVacant
		 end
From PortfolioProject.dbo.Housing	

update Housing
set SoldAsVacant = Case when SoldAsVacant = 'Y' then 'Yes'
		 When SoldAsVacant = 'N' then 'No'
		 Else SoldAsVacant
		end

With RowNum as(
Select *,
Row_Number() over(
Partition by ParcelID,
						PropertyAddress,
						salePrice,
						SaleDate,
						LegalReference
						order by UniqueID) row_num
From PortfolioProject.dbo.Housing)

Select *
from RowNum
where row_num > 1
order by ParcelID



Select *
From PortfolioProject.dbo.Housing

Alter Table PortfolioProject.dbo.Housing
Drop column PropertyAddress


	





