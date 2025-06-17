/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin.ProductFeatures;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import constants.FileLocation;
import dao.ProductDAO;
import dao.BrandDAO;
import dao.CategoryDAO;
import dao.SizeDAO;
import model.Product;
import model.ProductVariant;
import model.ProductVariantSize;
import model.Brand;
import model.Category;
import model.Size;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 *
 * @author hoaht
 */
@WebServlet(name = "SaveProductServlet", urlPatterns = {"/admin/products/add/save"})
@MultipartConfig(
        location = FileLocation.PRODUCT_IMAGE_LOCATION,
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 11
)
public class SaveProductServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SaveProductServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SaveProductServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get basic product information
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            int brandId = Integer.parseInt(request.getParameter("brandId"));
            String[] categoryIds = request.getParameterValues("categoryIds");
            
            // Handle main product image
            Part mainImagePart = request.getPart("mainImage");
            String mainImageFileName = System.currentTimeMillis() + "_" + getFileName(mainImagePart);
            mainImagePart.write(mainImageFileName);

            // Create product object
            Product product = new Product();
            product.setTitle(title);
            product.setDescription(description);
            product.setImage(mainImageFileName);
            product.setCreateDate(new Date());
            product.setUpdateDate(new Date());
            product.setStatus(true);

            // Set brand
            BrandDAO brandDAO = new BrandDAO();
            Brand brand = brandDAO.getBrandById(brandId);
            product.setBrand(brand);

            // Set categories
            Set<Category> categories = new HashSet<>();
            CategoryDAO categoryDAO = new CategoryDAO();
            for (String categoryId : categoryIds) {
                Category category = categoryDAO.getCategoryById(categoryId);
                categories.add(category);
            }
            product.setCategories(categories);

            // Save product to get its ID
            ProductDAO productDAO = new ProductDAO();
            int productId = productDAO.addNewProduct(product);
            product.setId(productId);

            // Handle variants
            String[] variantNames = request.getParameterValues("variantNames[]");
            String[] variantImportPrices = request.getParameterValues("variantImportPrices[]");
            String[] variantPrices = request.getParameterValues("variantPrices[]");
            Part[] variantImages = request.getParts().stream()
                    .filter(part -> part.getName().equals("variantImages[]"))
                    .toArray(Part[]::new);

            // Handle sizes for each variant
            String[] sizeValues = request.getParameterValues("sizeValues[]");
            String[] quantities = request.getParameterValues("quantities[]");
            String[] holdings = request.getParameterValues("holdings[]");

            SizeDAO sizeDAO = new SizeDAO();

            // Process each variant
            for (int i = 0; i < variantNames.length; i++) {
                ProductVariant variant = new ProductVariant();
                variant.setName(variantNames[i]);
                variant.setImportPrice(Double.parseDouble(variantImportPrices[i]));
                variant.setPrice(Double.parseDouble(variantPrices[i]));
                variant.setProduct(product);
                variant.setStatus(true);
                variant.setCreateDate(new Date());
                variant.setUpdateDate(new Date());

                // Handle variant image
                Part variantImagePart = variantImages[i];
                String variantImageFileName = System.currentTimeMillis() + "_" + getFileName(variantImagePart);
                variantImagePart.write(variantImageFileName);
                variant.setImage(variantImageFileName);

                // Save variant to get its ID
                int variantId = productDAO.addProductVariant(variant);
                variant.setId(variantId);

                // Process sizes for this variant
                int sizeIndex = i * 3; // Assuming 3 sizes per variant
                for (int j = 0; j < 3; j++) {
                    if (sizeIndex + j < sizeValues.length) {
                        ProductVariantSize pvs = new ProductVariantSize();
                        pvs.setProductVariant(variant);
                        
                        Size size = sizeDAO.getSizeById(Integer.parseInt(sizeValues[sizeIndex + j]));
                        pvs.setSize(size);
                        
                        pvs.setQuantityInStock(Integer.parseInt(quantities[sizeIndex + j]));
                        pvs.setQuantityHolding(Integer.parseInt(holdings[sizeIndex + j]));
                        pvs.setStatus(true);
                        pvs.setCreateDate(new Date());
                        pvs.setUpdateDate(new Date());

                        productDAO.addProductVariantSize(pvs);
                    }
                }
            }

            response.sendRedirect(request.getContextPath() + "/admin/products");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/products/add?error=true");
        }
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
