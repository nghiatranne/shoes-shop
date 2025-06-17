/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import model.Brand;
import model.Category;
import model.Product;
import model.ProductVariant;
import model.Publisher;

/**
 *
 * @author admin
 */
public class ProductDAO extends DBContext{
    public List<Product> listAll() {
        BrandDAO brandDAO = new BrandDAO();
        CategoryDAO categoryDAO = new CategoryDAO();

        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM Product";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("ID"));
                product.setTitle(rs.getString("Title"));
                product.setImage(rs.getString("Image"));
                product.setDescription(rs.getString("Description")); 
                product.setCreateDate(rs.getDate("CreateDate"));
                product.setUpdateDate(rs.getDate("UpdateDate"));
                product.setStatus(rs.getInt("Status") == 1);
                product.setBrand(brandDAO.getBrandById(rs.getInt("BrandID")));

                product.setCategories(categoryDAO.listAll(product.getId()));
                // Bạn có thể set thêm productvariants nếu có DAO tương ứng

                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    public List<Product> listNewProducts() {
        BrandDAO brandDAO = new BrandDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        ProductVariantDAO productVariantDAO = new ProductVariantDAO();

        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM Product ORDER BY CreateDate DESC";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("ID"));
                product.setTitle(rs.getString("Title"));
                product.setImage(rs.getString("Image"));
                product.setDescription(rs.getString("Description")); // hoặc "DescDetail" nếu bạn muốn
                product.setCreateDate(rs.getDate("CreateDate"));
                product.setUpdateDate(rs.getDate("UpdateDate"));
                product.setStatus(rs.getInt("Status") == 1);
                product.setBrand(brandDAO.getBrandById(rs.getInt("BrandID")));

                product.setCategories(categoryDAO.listAll(product.getId()));
                // Nếu có DAO cho ProductVariant thì thêm ở đây:
                product.setProductvariants(productVariantDAO.getProductVariantsByProductId(product.getId()));

                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    public List<Product> listBestSellers() {
        BrandDAO brandDAO = new BrandDAO();
        CategoryDAO categoryDAO = new CategoryDAO();

        ProductVariantDAO productVariantDAO = new ProductVariantDAO();
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, SUM(od.Quantity) AS TotalSold "
                   + "FROM Product p "
                   + "JOIN ProductVariant pv ON p.ID = pv.ProductID "
                   + "JOIN ProductVariantSize pvs ON pv.ID = pvs.ProductVariantID "
                   + "JOIN OrderDetail od ON pvs.ID = od.ProductVariantSizeID "
                   + "GROUP BY p.ID, p.Title, p.Image, p.Description, p.CreateDate, p.UpdateDate, p.Status, p.PublisherID "
                   + "HAVING SUM(od.Quantity) > 5 "
                   + "ORDER BY TotalSold DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("ID"));
                product.setTitle(rs.getString("Title"));
                product.setImage(rs.getString("Image"));
                product.setDescription(rs.getString("Description"));
                product.setCreateDate(rs.getDate("CreateDate"));
                product.setUpdateDate(rs.getDate("UpdateDate"));
                product.setStatus(rs.getBoolean("Status"));
                product.setBrand(brandDAO.getBrandById(rs.getInt("BrandID")));
                product.setCategories(categoryDAO.listAll(product.getId()));

                // Nếu cần, có thể load thêm productVariants ở đây
                product.setProductvariants(productVariantDAO.getProductVariantsByProductId(product.getId()));
                products.add(product);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }
    public List<Product> listRandomProducts() {
        BrandDAO brandDAO = new BrandDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        List<Product> products = new ArrayList<>();
        ProductVariantDAO productVariantDAO = new ProductVariantDAO();

        String sql = "SELECT * FROM Product WHERE Status = 1 ORDER BY NEWID()";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("ID"));
                product.setTitle(rs.getString("Title"));
                product.setImage(rs.getString("Image"));
                product.setDescription(rs.getString("Description"));
                product.setCreateDate(rs.getDate("CreateDate"));
                product.setUpdateDate(rs.getDate("UpdateDate"));
                product.setStatus(rs.getBoolean("Status"));
                product.setBrand(brandDAO.getBrandById(rs.getInt("BrandID")));
                product.setCategories(categoryDAO.listAll(product.getId()));
                product.setProductvariants(productVariantDAO.getProductVariantsByProductId(product.getId()));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    public Product getProductById(int id) {
        String sql = "SELECT * FROM Product WHERE ID = ? AND Status = 1";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("ID"));
                p.setTitle(rs.getString("Title"));
                p.setImage(rs.getString("Image"));
                p.setDescription(rs.getString("Description"));
                p.setCreateDate(rs.getDate("CreateDate"));
                p.setUpdateDate(rs.getDate("UpdateDate"));
                p.setStatus(rs.getBoolean("Status"));
                
                // Get publisher
                BrandDAO brandDAO = new BrandDAO();
                Brand brand = brandDAO.getBrandById(rs.getInt("BrandID"));
                p.setBrand(brand);
                
                // Get categories
                CategoryDAO categoryDAO = new CategoryDAO();
                Set<Category> categories = categoryDAO.listAll(id);
                p.setCategories(categories);
                
                // Get product variants
                ProductVariantDAO productVariantDAO = new ProductVariantDAO();
                List<ProductVariant> variants = productVariantDAO.getProductVariantsByProductId(id);
                p.setProductvariants(variants);
                
                return p;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<Product> listAllActiveProducts() {
        BrandDAO brandDAO = new BrandDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        ProductVariantDAO productVariantDAO = new ProductVariantDAO();
        List<Product> products = new ArrayList<>();

        String sql = "SELECT * FROM Product WHERE Status = 1";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("ID"));
                product.setTitle(rs.getString("Title"));
                product.setImage(rs.getString("Image"));
                product.setDescription(rs.getString("Description")); 
                product.setCreateDate(rs.getDate("CreateDate"));
                product.setUpdateDate(rs.getDate("UpdateDate"));
                product.setStatus(rs.getInt("Status") == 1);
                product.setBrand(brandDAO.getBrandById(rs.getInt("BrandID")));
                product.setCategories(categoryDAO.listAll(product.getId()));
                product.setProductvariants(productVariantDAO.getProductVariantsByProductId(product.getId()));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Product> searchProducts(String keyword) {
        BrandDAO brandDAO = new BrandDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        ProductVariantDAO productVariantDAO = new ProductVariantDAO();
        List<Product> products = new ArrayList<>();

        String sql = "SELECT * FROM Product WHERE Status = 1 AND (Title LIKE ? OR Description LIKE ?)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("ID"));
                product.setTitle(rs.getString("Title"));
                product.setImage(rs.getString("Image"));
                product.setDescription(rs.getString("Description")); 
                product.setCreateDate(rs.getDate("CreateDate"));
                product.setUpdateDate(rs.getDate("UpdateDate"));
                product.setStatus(rs.getInt("Status") == 1);
                product.setBrand(brandDAO.getBrandById(rs.getInt("BrandID")));
                product.setCategories(categoryDAO.listAll(product.getId()));
                product.setProductvariants(productVariantDAO.getProductVariantsByProductId(product.getId()));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Product> listProductsByCategory(int categoryId) {
        BrandDAO brandDAO = new BrandDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        ProductVariantDAO productVariantDAO = new ProductVariantDAO();
        List<Product> products = new ArrayList<>();

        String sql = "SELECT DISTINCT p.* FROM Product p " +
                    "INNER JOIN ProductCategory pc ON p.ID = pc.ProductID " +
                    "WHERE p.Status = 1 AND pc.CategoryID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("ID"));
                product.setTitle(rs.getString("Title"));
                product.setImage(rs.getString("Image"));
                product.setDescription(rs.getString("Description")); 
                product.setCreateDate(rs.getDate("CreateDate"));
                product.setUpdateDate(rs.getDate("UpdateDate"));
                product.setStatus(rs.getInt("Status") == 1);
                product.setBrand(brandDAO.getBrandById(rs.getInt("BrandID")));
                product.setCategories(categoryDAO.listAll(product.getId()));
                product.setProductvariants(productVariantDAO.getProductVariantsByProductId(product.getId()));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

//
//    public int addNewBook(Book book) {
//        SimpleDateFormat sf = new SimpleDateFormat("MM-dd-yyyy");
//        String sql = "insert into Book(ISBN, Title, Image, [Desc], DescDetail, PublishDate, Language, Price, Pages, Width, Height, Thickness, Weight, QuantityInStock, Available, FormatId, PublisherID) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
//        try {
//            PreparedStatement ps = connection.prepareStatement(sql);
//            ps.setString(1, book.getIsbn());
//            ps.setString(2, book.getTitle());
//            ps.setString(3, book.getImage());
//            ps.setString(4, book.getDesc());
//            ps.setString(5, book.getDescDetail());
//            ps.setString(6, sf.format(book.getPublishDate()));
//            ps.setString(7, book.getLanguage());
//            ps.setFloat(8, book.getPrice());
//            ps.setInt(9, book.getPages());
//            ps.setFloat(10, book.getWidth());
//            ps.setFloat(11, book.getHeight());
//            ps.setFloat(12, book.getThickness());
//            ps.setFloat(13, book.getWeight());
//            ps.setInt(14, book.getQuantityInStock());
//            ps.setBoolean(15, book.isAvailable());
//            ps.setInt(16, book.getFormat().getId());
//            ps.setInt(17, book.getPublisher().getId());
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                return rs.getInt(1);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return -1;
//    }
//
//    public void addBookAuthor(String[] authors_id, int book_id) {
//        String sql = "insert into BookAuthor(AuthorID, BookID) values (?, ?)";
//        try {
//            PreparedStatement ps = connection.prepareStatement(sql);
//            for (String id : authors_id) {
//                ps.setInt(1, Integer.parseInt(id));
//                ps.setInt(2, book_id);
//                ps.executeUpdate();
//            }
//        } catch (NumberFormatException | SQLException e) {
//            e.printStackTrace();
//        }
//    }
//
//    public void deleteBookAuthor(Set<Author> authors, int book_id) {
//        String sql = "delete from BookAuthor where AuthorID = ? and BookID = ?";
//        try {
//            PreparedStatement ps = connection.prepareStatement(sql);
//            for (Author a : authors) {
//                ps.setInt(1, a.getId());
//                ps.setInt(2, book_id);
//                ps.executeUpdate();
//            }
//        } catch (NumberFormatException | SQLException e) {
//            e.printStackTrace();
//        }
//    }
//
//    public void deleteBookCategory(Set<Category> categories, int book_id) {
//        String sql = "delete from BookCategory where CategoryID = ? and BookID = ?";
//        try {
//            PreparedStatement ps = connection.prepareStatement(sql);
//            for (Category c : categories) {
//                ps.setInt(1, Integer.parseInt(c.getId()));
//                ps.setInt(2, book_id);
//                ps.executeUpdate();
//            }
//        } catch (NumberFormatException | SQLException e) {
//            e.printStackTrace();
//        }
//    }
//
//    public void addBookCategory(String[] category_id, int book_id) {
//        String sql = "insert into BookCategory(CategoryID, BookID) values (?, ?)";
//        try {
//            PreparedStatement ps = connection.prepareStatement(sql);
//            for (String id : category_id) {
//                ps.setInt(1, Integer.parseInt(id));
//                ps.setInt(2, book_id);
//                ps.executeUpdate();
//            }
//        } catch (NumberFormatException | SQLException e) {
//            e.printStackTrace();
//        }
//    }
//
//    public Book getBook(int b_id) {
//        AuthorDAO authorDAO = new AuthorDAO();
//        PublisherDAO publisherDAO = new PublisherDAO();
//        CategoryDAO categoryDAO = new CategoryDAO();
//        FormatDAO formatDAO = new FormatDAO();
//
//        String sql = "Select * from Book where id = ?";
//        try {
//            PreparedStatement ps = connection.prepareStatement(sql);
//            ps.setInt(1, b_id);
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                Book book = new Book();
//                book.setId(rs.getInt("ID"));
//                book.setIsbn(rs.getString("ISBN"));
//                book.setTitle(rs.getString("Title"));
//                book.setImage(rs.getString("Image"));
//                book.setDesc(rs.getString("Desc"));
//                book.setDescDetail(rs.getString("DescDetail"));
//                book.setPublishDate(rs.getDate("PublishDate"));
//                book.setLanguage(rs.getString("Language"));
//                book.setPrice(rs.getFloat("Price"));
//                book.setPages(rs.getInt("Pages"));
//                book.setWidth(rs.getFloat("Width"));
//                book.setHeight(rs.getFloat("Height"));
//                book.setThickness(rs.getFloat("Thickness"));
//                book.setWeight(rs.getFloat("Weight"));
//                book.setQuantityInStock(rs.getInt("QuantityInStock"));
//                book.setCreateDate(rs.getDate("CreateDate"));
//                book.setUpdateDate(rs.getDate("UpdateDate"));
//                book.setStatus(rs.getInt("Status") == 1);
//                book.setAvailable(rs.getBoolean("Available"));
//                book.setPublisher(publisherDAO.getPublisher(rs.getInt("PublisherID")));
//                book.setFormat(formatDAO.getFormat(rs.getInt("FormatId")));
//                book.setAuthors(authorDAO.listAll(book.getId()));
//                book.setCategories(categoryDAO.listAll(book.getId()));
//                book.setHold(rs.getInt("Hold"));
//                book.setImportPrice(rs.getFloat("ImportPrice"));
//                return book;
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return null;
//    }
//
//    public Book getBook(String isbn) {
//        AuthorDAO authorDAO = new AuthorDAO();
//        PublisherDAO publisherDAO = new PublisherDAO();
//        CategoryDAO categoryDAO = new CategoryDAO();
//        FormatDAO formatDAO = new FormatDAO();
//
//        String sql = "Select * from Book where ISBN = ?";
//        try {
//            PreparedStatement ps = connection.prepareStatement(sql);
//            ps.setString(1, isbn);
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                Book book = new Book();
//                book.setId(rs.getInt("ID"));
//                book.setIsbn(rs.getString("ISBN"));
//                book.setTitle(rs.getString("Title"));
//                book.setImage(rs.getString("Image"));
//                book.setDesc(rs.getString("Desc"));
//                book.setDescDetail(rs.getString("DescDetail"));
//                book.setPublishDate(rs.getDate("PublishDate"));
//                book.setLanguage(rs.getString("Language"));
//                book.setPrice(rs.getFloat("Price"));
//                book.setPages(rs.getInt("Pages"));
//                book.setWidth(rs.getFloat("Width"));
//                book.setHeight(rs.getFloat("Height"));
//                book.setThickness(rs.getFloat("Thickness"));
//                book.setWeight(rs.getFloat("Weight"));
//                book.setQuantityInStock(rs.getInt("QuantityInStock"));
//                book.setCreateDate(rs.getDate("CreateDate"));
//                book.setUpdateDate(rs.getDate("UpdateDate"));
//                book.setStatus(rs.getInt("Status") == 1);
//                book.setAvailable(rs.getBoolean("Available"));
//                book.setPublisher(publisherDAO.getPublisher(rs.getInt("PublisherID")));
//                book.setFormat(formatDAO.getFormat(rs.getInt("FormatId")));
//                book.setAuthors(authorDAO.listAll(book.getId()));
//                book.setCategories(categoryDAO.listAll(book.getId()));
//                book.setHold(rs.getInt("Hold"));
//                book.setImportPrice(rs.getFloat("ImportPrice"));
//                return book;
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return null;
//    }
//
//    public void updateStatusBook(String isbn, boolean status) {
//        String sql = "UPDATE Book SET Status = ? WHERE ISBN = ?";
//        try {
//            PreparedStatement ps = connection.prepareStatement(sql);
//            ps.setBoolean(1, status);
//            ps.setString(2, isbn);
//            ps.executeUpdate();
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//    }
//
//    public List<Book> listAll(String key) {
//        AuthorDAO authorDAO = new AuthorDAO();
//        PublisherDAO publisherDAO = new PublisherDAO();
//        CategoryDAO categoryDAO = new CategoryDAO();
//        FormatDAO formatDAO = new FormatDAO();
//
//        List<Book> books = new ArrayList<>();
//        String sql = "Select * from Book where Title + ' ' + ISBN like '%" + key + "%'";
//        try {
//            PreparedStatement ps = connection.prepareStatement(sql);
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                Book book = new Book();
//                book.setId(rs.getInt("ID"));
//                book.setIsbn(rs.getString("ISBN"));
//                book.setTitle(rs.getString("Title"));
//                book.setImage(rs.getString("Image"));
//                book.setDesc(rs.getString("Desc"));
//                book.setDescDetail(rs.getString("DescDetail"));
//                book.setPublishDate(rs.getDate("PublishDate"));
//                book.setLanguage(rs.getString("Language"));
//                book.setPrice(rs.getFloat("Price"));
//                book.setPages(rs.getInt("Pages"));
//                book.setWidth(rs.getFloat("Width"));
//                book.setHeight(rs.getFloat("Height"));
//                book.setThickness(rs.getFloat("Thickness"));
//                book.setWeight(rs.getFloat("Weight"));
//                book.setQuantityInStock(rs.getInt("QuantityInStock"));
//                book.setCreateDate(rs.getDate("CreateDate"));
//                book.setUpdateDate(rs.getDate("UpdateDate"));
//                book.setStatus(rs.getInt("Status") == 1);
//                book.setAvailable(rs.getBoolean("Available"));
//                book.setPublisher(publisherDAO.getPublisher(rs.getInt("PublisherID")));
//                book.setFormat(formatDAO.getFormat(rs.getInt("FormatId")));
//                book.setAuthors(authorDAO.listAll(book.getId()));
//                book.setCategories(categoryDAO.listAll(book.getId()));
//
//                books.add(book);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return books;
//    }
//
//    public int updateBook(Book b, String book_isbn) {
//        String sql = "UPDATE Book SET ISBN = ?, Title = ?, Image = ?, [Desc] = ?, DescDetail = ?, PublishDate = ?, Language = ?, Price = ?, Pages = ?, Width = ?, Height = ?, Thickness = ?, Weight = ?, QuantityInStock = ?, UpdateDate = ?, FormatId = ?, PublisherID = ? WHERE ISBN = ?";
//        try {
//            PreparedStatement ps = connection.prepareStatement(sql);
//
//            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//
//            ps.setString(1, b.getIsbn());
//            ps.setString(2, b.getTitle());
//            ps.setString(3, b.getImage());
//            ps.setString(4, b.getDesc());
//            ps.setString(5, b.getDescDetail());
//            ps.setString(6, sdf.format(b.getPublishDate()));
//            ps.setString(7, b.getLanguage());
//            ps.setFloat(8, b.getPrice());
//            ps.setInt(9, b.getPages());
//            ps.setFloat(10, b.getWidth());
//            ps.setFloat(11, b.getHeight());
//            ps.setFloat(12, b.getThickness());
//            ps.setFloat(13, b.getWeight());
//            ps.setInt(14, b.getQuantityInStock());
//            ps.setString(15, sdf.format(new Date()));
//            ps.setInt(16, b.getFormat().getId());
//            ps.setInt(17, b.getPublisher().getId());
//            ps.setString(18, book_isbn);
//
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                return rs.getInt(1);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return -1;
//    }
//
//    public List<Book> listBookByCid(int cid) {
//        PublisherDAO publisherDAO = new PublisherDAO();
//        CategoryDAO categoryDAO = new CategoryDAO();
//        FormatDAO formatDAO = new FormatDAO();
//        AuthorDAO authorDAO = new AuthorDAO();
//        List<Book> books = new ArrayList<>();
//
//        String sql = "SELECT b.*, c.Name AS CategoryName "
//                + "FROM Book b "
//                + "JOIN BookCategory bc ON b.ID = bc.BookID "
//                + "JOIN Category c ON bc.CategoryID = c.ID "
//                + "WHERE c.ID = ?";
//        try {
//            PreparedStatement ps = connection.prepareStatement(sql);
//            ps.setInt(1, cid);
//            ResultSet rs = ps.executeQuery();
//
//            Map<Integer, Book> bookMap = new HashMap<>();
//
//            while (rs.next()) {
//                int bookId = rs.getInt("ID");
//                Book book = bookMap.get(bookId);
//                if (book == null) {
//                    book = new Book();
//                    book.setId(bookId);
//                    book.setIsbn(rs.getString("ISBN"));
//                    book.setTitle(rs.getString("Title"));
//                    book.setImage(rs.getString("Image"));
//                    book.setDesc(rs.getString("Desc"));
//                    book.setDescDetail(rs.getString("DescDetail"));
//                    book.setPublishDate(rs.getDate("PublishDate"));
//                    book.setLanguage(rs.getString("Language"));
//                    book.setPrice(rs.getFloat("Price"));
//                    book.setPages(rs.getInt("Pages"));
//                    book.setWidth(rs.getFloat("Width"));
//                    book.setHeight(rs.getFloat("Height"));
//                    book.setThickness(rs.getFloat("Thickness"));
//                    book.setWeight(rs.getFloat("Weight"));
//                    book.setQuantityInStock(rs.getInt("QuantityInStock"));
//                    book.setCreateDate(rs.getDate("CreateDate"));
//                    book.setUpdateDate(rs.getDate("UpdateDate"));
//                    book.setStatus(rs.getInt("Status") == 1);
//                    book.setAvailable(rs.getBoolean("Available"));
//                    book.setPublisher(publisherDAO.getPublisher(rs.getInt("PublisherID")));
//                    book.setFormat(formatDAO.getFormat(rs.getInt("FormatId")));
//                    book.setCategories(categoryDAO.listAll(book.getId()));
//
//                    // Fetch authors for the current book using AuthorDAO
//                    Set<Author> authors = authorDAO.listAll(book.getId());
//                    book.setAuthors(authors);
//
//                    bookMap.put(bookId, book);
//                    books.add(book);
//                }
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return books;
//    }
//
    public List<Product> listBookRelated(int bookID) {
        BrandDAO brandDAO = new BrandDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        ProductVariantDAO productVariantDAO = new ProductVariantDAO();

        List<Product> books = new ArrayList<>();

        String sql = "select * from Product where ID in ( "
                + "	select distinct b.ID from Product b left join ProductCategory bc on b.ID = bc.ProductID where bc.CategoryID in ( "
                + "		select c.ID from Category c left join ProductCategory bc on c.ID = bc.CategoryID where bc.ProductID = ? "
                + "	) and b.ID != ? "
                + ")";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, bookID);
            ps.setInt(2, bookID);
            ResultSet rs = ps.executeQuery();

            Map<Integer, Product> bookMap = new HashMap<>();

            while (rs.next()) {
                int bookId = rs.getInt("ID");
                Product book = bookMap.get(bookId);
                if (book == null) {
                    Product product = new Product();
                product.setId(rs.getInt("ID"));
                product.setTitle(rs.getString("Title"));
                product.setImage(rs.getString("Image"));
                product.setDescription(rs.getString("Description")); // hoặc "DescDetail" nếu bạn muốn
                product.setCreateDate(rs.getDate("CreateDate"));
                product.setUpdateDate(rs.getDate("UpdateDate"));
                product.setStatus(rs.getInt("Status") == 1);
                product.setBrand(brandDAO.getBrandById(rs.getInt("BrandID")));

                product.setCategories(categoryDAO.listAll(product.getId()));
                // Nếu có DAO cho ProductVariant thì thêm ở đây:
                product.setProductvariants(productVariantDAO.getProductVariantsByProductId(product.getId()));

                    bookMap.put(bookId, book);
                    books.add(book);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }
//
//    public Book getBookByIsbn(String isbn) {
//        PublisherDAO publisherDAO = new PublisherDAO();
//        CategoryDAO categoryDAO = new CategoryDAO();
//        FormatDAO formatDAO = new FormatDAO();
//        AuthorDAO authorDAO = new AuthorDAO();
//        Book book = null;
//
//        String sql = "SELECT b.*, c.Name AS CategoryName "
//                + "FROM Book b "
//                + "JOIN BookCategory bc ON b.ID = bc.BookID "
//                + "JOIN Category c ON bc.CategoryID = c.ID "
//                + "WHERE b.ISBN = ?";
//        try {
//            PreparedStatement ps = connection.prepareStatement(sql);
//            ps.setString(1, isbn);
//            ResultSet rs = ps.executeQuery();
//
//            if (rs.next()) {
//                book = new Book();
//                book.setId(rs.getInt("ID"));
//                book.setIsbn(rs.getString("ISBN"));
//                book.setTitle(rs.getString("Title"));
//                book.setImage(rs.getString("Image"));
//                book.setDesc(rs.getString("Desc"));
//                book.setDescDetail(rs.getString("DescDetail"));
//                book.setPublishDate(rs.getDate("PublishDate"));
//                book.setLanguage(rs.getString("Language"));
//                book.setPrice(rs.getFloat("Price"));
//                book.setPages(rs.getInt("Pages"));
//                book.setWidth(rs.getFloat("Width"));
//                book.setHeight(rs.getFloat("Height"));
//                book.setThickness(rs.getFloat("Thickness"));
//                book.setWeight(rs.getFloat("Weight"));
//                book.setQuantityInStock(rs.getInt("QuantityInStock"));
//                book.setCreateDate(rs.getDate("CreateDate"));
//                book.setUpdateDate(rs.getDate("UpdateDate"));
//                book.setStatus(rs.getInt("Status") == 1);
//                book.setAvailable(rs.getBoolean("Available"));
//                book.setPublisher(publisherDAO.getPublisher(rs.getInt("PublisherID")));
//                book.setFormat(formatDAO.getFormat(rs.getInt("FormatId")));
//                book.setCategories(categoryDAO.listAll(book.getId()));
//
//                // Fetch authors for the current book using AuthorDAO
//                Set<Author> authors = authorDAO.listAll(book.getId());
//                book.setAuthors(authors);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return book;
//    }
//
//    public int getSoldQuantityByIsbn(String isbn) {
//        int soldQuantity = 0;
//
//        String sql = "SELECT SUM(od.Quantity) AS SoldQuantity "
//                + "FROM [Order] o "
//                + "JOIN OrderDetail od ON o.ID = od.OrderID "
//                + "WHERE od.ISBN = ? AND o.Status = 3";
//
//        try {
//            PreparedStatement ps = connection.prepareStatement(sql);
//            ps.setString(1, isbn);
//            ResultSet rs = ps.executeQuery();
//
//            if (rs.next()) {
//                soldQuantity = rs.getInt("SoldQuantity");
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//
//        return soldQuantity;
//    }
//
//    public List<Book> getNewBooks() {
//        List<Book> newBooks = new ArrayList<>();
//
//        // Get current date and date 7 days ago
//        java.util.Date currentDate = new java.util.Date();
//        java.util.Date sevenDaysAgo = new java.util.Date(currentDate.getTime() - (7 * 24 * 60 * 60 * 1000));
//
//        // Convert dates to SQL Date format
//        java.sql.Date sqlCurrentDate = new java.sql.Date(currentDate.getTime());
//        java.sql.Date sqlSevenDaysAgo = new java.sql.Date(sevenDaysAgo.getTime());
//
//        // SQL query to retrieve books published within the last 7 days
//        String sql = "SELECT * FROM Book WHERE PublishDate BETWEEN ? AND ?";
//
//        try {
//            PreparedStatement ps = connection.prepareStatement(sql);
//
//            ps.setDate(1, sqlSevenDaysAgo);
//            ps.setDate(2, sqlCurrentDate);
//
//            ResultSet rs = ps.executeQuery();
//
//            while (rs.next()) {
//                Book book = new Book();
//
//                book.setId(rs.getInt("ID"));
//                book.setIsbn(rs.getString("ISBN"));
//                book.setTitle(rs.getString("Title"));
//                book.setImage(rs.getString("Image"));
//                book.setDesc(rs.getString("Desc"));
//                book.setDescDetail(rs.getString("DescDetail"));
//                book.setPublishDate(rs.getDate("PublishDate"));
//                book.setLanguage(rs.getString("Language"));
//                book.setPrice(rs.getFloat("Price"));
//                book.setPages(rs.getInt("Pages"));
//                book.setWidth(rs.getFloat("Width"));
//                book.setHeight(rs.getFloat("Height"));
//                book.setThickness(rs.getFloat("Thickness"));
//                book.setWeight(rs.getFloat("Weight"));
//                book.setQuantityInStock(rs.getInt("QuantityInStock"));
//                book.setCreateDate(rs.getDate("CreateDate"));
//                book.setUpdateDate(rs.getDate("UpdateDate"));
//                book.setStatus(rs.getInt("Status") == 1);
//                book.setAvailable(rs.getBoolean("Available"));
//
//                newBooks.add(book);
//            }
//
//            connection.close();
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//
//        return newBooks;
//    }
//
//    public Book getDetailBookByBookIsbn(String book_isbn_key) {
//        CategoryDAO categoryDAO = new CategoryDAO();
//
//        String sql = "SELECT *\n"
//                + "FROM Book b\n"
//                + "LEFT JOIN BookAuthor ba ON b.ID = ba.BookID\n"
//                + "LEFT JOIN Author a ON ba.AuthorID = a.ID\n"
//                + "LEFT JOIN BookPublisher bp ON b.ID = bp.BookID\n"
//                + "LEFT JOIN Publisher p ON bp.PublisherID = p.ID\n"
//                + "WHERE b.ISBN = ?";
//        try {
//            PreparedStatement ps = connection.prepareStatement(sql);
//            ps.setString(1, book_isbn_key);
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                Book book = new Book();
//                book.setId(rs.getInt("id"));
//                book.setIsbn(rs.getString("isbn"));
//                book.setTitle(rs.getString("title"));
//                book.setImage(rs.getString("image"));
//                book.setDesc(rs.getString("desc"));
//                book.setDescDetail(rs.getString("descDetail"));
//                book.setPublishDate(rs.getDate("publishDate"));
//                book.setLanguage(rs.getString("language"));
//                book.setPrice(rs.getFloat("price"));
//                book.setPages(rs.getInt("pages"));
//                book.setWidth(rs.getFloat("width"));
//                book.setHeight(rs.getFloat("height"));
//                book.setThickness(rs.getFloat("thickness"));
//                book.setWeight(rs.getFloat("weight"));
//                book.setQuantityInStock(rs.getInt("quantityInStock"));
//                book.setCreateDate(rs.getDate("createDate"));
//                book.setUpdateDate(rs.getDate("updateDate"));
//                book.setStatus(rs.getBoolean("status"));
//                book.setAvailable(rs.getBoolean("available"));
//
//                Author author = new Author();
//                author.setId(rs.getInt("AuthorID"));
//                author.setFullName(rs.getString("AuthorFullName"));
//                author.setDesc(rs.getString("AuthorDesc"));
//                author.setUpdateDate(rs.getDate("AuthorUpdateDate"));
//
//                Publisher publisher = new Publisher();
//                publisher.setId(rs.getInt("PublisherID"));
//                publisher.setName(rs.getString("PublisherName"));
//
//                book.setPublisher(publisher);
//                book.setAuthors(new HashSet<>(Arrays.asList(author)));
//
//                return book;
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return null;
//    }
//
//    public List<Book> searchBooks(String keyword) {
//        AuthorDAO authorDAO = new AuthorDAO();
//        PublisherDAO publisherDAO = new PublisherDAO();
//        CategoryDAO categoryDAO = new CategoryDAO();
//        FormatDAO formatDAO = new FormatDAO();
//
//        List<Book> books = new ArrayList<>();
//        String sql = "SELECT DISTINCT b.* "
//                + "FROM Book b "
//                + "LEFT JOIN BookAuthor ba ON b.ID = ba.BookID "
//                + "LEFT JOIN Author a ON ba.AuthorID = a.ID "
//                + "WHERE b.Title LIKE ? OR a.FullName LIKE ?";
//        try (PreparedStatement ps = connection.prepareStatement(sql)) {
//            String queryParam = "%" + keyword + "%";
//            ps.setString(1, queryParam);
//            ps.setString(2, queryParam);
//            try (ResultSet rs = ps.executeQuery()) {
//                while (rs.next()) {
//                    Book book = new Book();
//                    book.setId(rs.getInt("ID"));
//                    book.setIsbn(rs.getString("ISBN"));
//                    book.setTitle(rs.getString("Title"));
//                    book.setImage(rs.getString("Image"));
//                    book.setDesc(rs.getString("Desc"));
//                    book.setDescDetail(rs.getString("DescDetail"));
//                    book.setPublishDate(rs.getDate("PublishDate"));
//                    book.setLanguage(rs.getString("Language"));
//                    book.setPrice(rs.getFloat("Price"));
//                    book.setPages(rs.getInt("Pages"));
//                    book.setWidth(rs.getFloat("Width"));
//                    book.setHeight(rs.getFloat("Height"));
//                    book.setThickness(rs.getFloat("Thickness"));
//                    book.setWeight(rs.getFloat("Weight"));
//                    book.setQuantityInStock(rs.getInt("QuantityInStock"));
//                    book.setCreateDate(rs.getDate("CreateDate"));
//                    book.setUpdateDate(rs.getDate("UpdateDate"));
//                    book.setStatus(rs.getInt("Status") == 1);
//                    book.setAvailable(rs.getBoolean("Available"));
//                    book.setPublisher(publisherDAO.getPublisher(rs.getInt("PublisherID")));
//                    book.setFormat(formatDAO.getFormat(rs.getInt("FormatId")));
//                    book.setAuthors(authorDAO.listAll(book.getId()));
//                    book.setCategories(categoryDAO.listAll(book.getId()));
//
//                    books.add(book);
//                }
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return books;
//    }
//
//    public void updateQuantity(int bookId, int quantity) {
//        String sql = "update Book set QuantityInStock = ? where ID = ?";
//        try {
//            PreparedStatement ps = connection.prepareStatement(sql);
//            ps.setInt(1, quantity);
//            ps.setInt(2, bookId);
//            ps.executeQuery();
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//    }
//    
//    public void updateHold(int bookId, int quantity) {
//        String sql = "update Book set Hold = ? where ID = ?";
//        try {
//            PreparedStatement ps = connection.prepareStatement(sql);
//            ps.setInt(1, quantity);
//            ps.setInt(2, bookId);
//            ps.executeQuery();
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//    }
//
//    public void updateAvailableOfBook() {
//        String sql = "update Book set Available = 1 where PublishDate <= GETDATE()";
//        try {
//            PreparedStatement ps = connection.prepareStatement(sql);
//            ps.executeQuery();
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//    }
//
//    public int getTotalBookCreateToday() {
//        String sql = "select COUNT(*) from Book where CreateDate = CAST(GETDATE() AS DATE)";
//        try {
//            PreparedStatement ps = connection.prepareStatement(sql);
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                return rs.getInt(1);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return 0;
//    }
//
//    public int getTotalBook() {
//        String sql = "select COUNT(*) from Book";
//        try {
//            PreparedStatement ps = connection.prepareStatement(sql);
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                return rs.getInt(1);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return 0;
//    }
//
//    public List<BookRAW> listAllBookWithTotalSaveToCart() {
//        PublisherDAO publisherDAO = new PublisherDAO();
//        AuthorDAO authorDAO = new AuthorDAO();
//        CategoryDAO categoryDAO = new CategoryDAO();
//        
//        List<BookRAW> books = new ArrayList<>();
//        
//        String sql = "select b.ID, b.ISBN, b.Image, b.Title, b.Price, b.PublisherID, b.Status, b.CreateDate, count(AccountID) [totalAccountSaveToCart] from Cart c "
//                + "left join Book b on b.ID = BookID "
//                + "where c.status = 0 and c.CreateAt <= GETDATE() and c.CreateAt >= DATEADD(day, -7, GETDATE()) "
//                + "group by b.ID, b.ISBN, b.Image, b.Title, b.Price, b.PublisherID, b.Status, b.CreateDate "
//                + "order by [totalAccountSaveToCart] desc , Price desc";
//        try {
//            PreparedStatement ps = connection.prepareStatement(sql);
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                Book book = new Book();
//                book.setId(rs.getInt("ID"));
//                book.setIsbn(rs.getString("ISBN"));
//                book.setTitle(rs.getString("Title"));
//                book.setImage(rs.getString("Image"));
//                book.setPrice(rs.getFloat("Price"));
//                book.setCreateDate(rs.getDate("CreateDate"));
//                book.setStatus(rs.getInt("Status") == 1);
//                book.setPublisher(publisherDAO.getPublisher(rs.getInt("PublisherID")));
//                book.setAuthors(authorDAO.listAll(book.getId()));
//                book.setCategories(categoryDAO.listAll(book.getId()));
//                
//                BookRAW bookRAW = new BookRAW(book, rs.getInt("totalAccountSaveToCart"));
//                
//                books.add(bookRAW);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return books;
//    }
//    
//    public List<BookRAW> listAllBookWithTotalSaveToCart(Date from, Date to) {
//        SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
//        PublisherDAO publisherDAO = new PublisherDAO();
//        AuthorDAO authorDAO = new AuthorDAO();
//        CategoryDAO categoryDAO = new CategoryDAO();
//        
//        List<BookRAW> books = new ArrayList<>();
//        
//        String sql = "select b.ID, b.ISBN, b.Image, b.Title, b.Price, b.PublisherID, b.Status, b.CreateDate, count(AccountID) [totalAccountSaveToCart] from Cart c "
//                + "left join Book b on b.ID = BookID "
//                + "where c.status = 0 and c.CreateAt <= ? and c.CreateAt >= ? "
//                + "group by b.ID, b.ISBN, b.Image, b.Title, b.Price, b.PublisherID, b.Status, b.CreateDate "
//                + "order by [totalAccountSaveToCart] desc , Price desc";
//        try {
//            PreparedStatement ps = connection.prepareStatement(sql);
//            ps.setString(1, sf.format(to));
//            ps.setString(2, sf.format(from));
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                Book book = new Book();
//                book.setId(rs.getInt("ID"));
//                book.setIsbn(rs.getString("ISBN"));
//                book.setTitle(rs.getString("Title"));
//                book.setImage(rs.getString("Image"));
//                book.setPrice(rs.getFloat("Price"));
//                book.setCreateDate(rs.getDate("CreateDate"));
//                book.setStatus(rs.getInt("Status") == 1);
//                book.setPublisher(publisherDAO.getPublisher(rs.getInt("PublisherID")));
//                book.setAuthors(authorDAO.listAll(book.getId()));
//                book.setCategories(categoryDAO.listAll(book.getId()));
//                
//                BookRAW bookRAW = new BookRAW(book, rs.getInt("totalAccountSaveToCart"));
//                
//                books.add(bookRAW);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return books;
//    }
//    
//    public BookForWarehouse getBookForUpdateStock(String b_isbn) {
//        String sql = "Select ID, ISBN, Title, QuantityInStock, Price, ImportPrice from Book where isbn = ?";
//        try {
//            PreparedStatement ps = connection.prepareStatement(sql);
//            ps.setString(1, b_isbn);
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                Book book = new Book();
//                book.setId(rs.getInt("ID"));
//                book.setIsbn(rs.getString("ISBN"));
//                book.setTitle(rs.getString("Title"));
//                book.setPrice(rs.getFloat("Price"));
//                book.setQuantityInStock(rs.getInt("QuantityInStock"));
//                
//                BookForWarehouse bookForWarehouse = new BookForWarehouse();
//                bookForWarehouse.setBook(book);
//                bookForWarehouse.setHold(0);
//                bookForWarehouse.setImportPrice(rs.getFloat("ImportPrice"));
//                
//                return bookForWarehouse;
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return null;
//    }
//    
//    public void updateStockOfBook(int book_id, float importPrice, int quantityInStock) {
//        String sql = "update Book set ImportPrice = ?, QuantityInStock = ? where ID = ?";
//        try {
//            PreparedStatement ps = connection.prepareStatement(sql);
//            ps.setFloat(1, importPrice);
//            ps.setInt(2, quantityInStock);
//            ps.setInt(3, book_id);
//            ps.executeUpdate();
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//    }
}
