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
import java.util.List;
import java.util.ArrayList;

/**
 *
 * @author hoaht
 */
@WebServlet(name = "EditProductServlet", urlPatterns = {"/admin/products/edit"})
@MultipartConfig(
        location = FileLocation.PRODUCT_IMAGE_LOCATION,
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 11
)
public class EditProductServlet extends HttpServlet {

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
        try {
            System.out.println("HELLO 1");
            int productId = Integer.parseInt(request.getParameter("product_id"));
            
            // Get product details
            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.getProductById(productId);
            
            if (product == null) {
                response.sendRedirect(request.getContextPath() + "/admin/products");
                return;
            }
            
            // Get brands for dropdown
            BrandDAO brandDAO = new BrandDAO();
            request.setAttribute("brands", brandDAO.listAllBrand());
            
            // Get categories for dropdown
            CategoryDAO categoryDAO = new CategoryDAO();
            request.setAttribute("categories", categoryDAO.listAllCategory());
            
            // Get sizes for dropdown
            SizeDAO sizeDAO = new SizeDAO();
            request.setAttribute("sizes", sizeDAO.listAllSize());
            
            // Set product for form
            request.setAttribute("product", product);
            
            request.getRequestDispatcher("/views/admin/EditProduct.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/products");
        }
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
            // Get product ID
            int productId = Integer.parseInt(request.getParameter("product_id"));
            
            // Get basic product information
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            int brandId = Integer.parseInt(request.getParameter("brandId"));
            String[] categoryIds = request.getParameterValues("categoryIds");
            
            System.out.println("HELLO");
            
            // Get product from database
            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.getProductById(productId);
            
            if (product == null) {
                response.sendRedirect(request.getContextPath() + "/admin/products");
                return;
            }
            
            // Update basic information
            product.setTitle(title);
            product.setDescription(description);
            product.setUpdateDate(new Date());
            
            // Handle main product image
            Part mainImagePart = request.getPart("mainImage");
            if (mainImagePart != null && mainImagePart.getSize() > 0) {
                String mainImageFileName = System.currentTimeMillis() + "_" + getFileName(mainImagePart);
                mainImagePart.write(mainImageFileName);
                product.setImage(mainImageFileName);
            }
            
            // Set brand
            BrandDAO brandDAO = new BrandDAO();
            Brand brand = brandDAO.getBrandById(brandId);
            product.setBrand(brand);
            
            // Update categories
            Set<Category> categories = new HashSet<>();
            CategoryDAO categoryDAO = new CategoryDAO();
            if (categoryIds != null) {
                for (String categoryId : categoryIds) {
                    Category category = categoryDAO.getCategoryById(categoryId);
                    if (category != null) {
                        categories.add(category);
                    }
                }
            }
            for (Category category : categories) {
                System.out.println(category.getName());
            }
            product.setCategories(categories);
            
            // Update product in database
            productDAO.updateProduct(product);
            
            // Handle variants
            String[] variantIds = request.getParameterValues("variantIds[]");
            String[] variantNames = request.getParameterValues("variantNames[]");
            String[] variantImportPrices = request.getParameterValues("variantImportPrices[]");
            String[] variantPrices = request.getParameterValues("variantPrices[]");
            List<Part> variantImageParts = new ArrayList<>();
            for (Part part : request.getParts()) {
                if (part.getName().equals("variantImages[]")) {
                    variantImageParts.add(part);
                }
            }
            
            // Handle sizes for each variant
            String[] sizeIds = request.getParameterValues("sizeIds[]");
            String[] sizeValues = request.getParameterValues("sizeValues[]");
            String[] quantities = request.getParameterValues("quantities[]");
            String[] holdings = request.getParameterValues("holdings[]");
            
            SizeDAO sizeDAO = new SizeDAO();
            
            // Process each variant
            if (variantNames != null) {
                for (int i = 0; i < variantNames.length; i++) {
                    final int variantIndex = i;
                    ProductVariant variant;
                    if (variantIds != null && i < variantIds.length) {
                        // Update existing variant
                        final String variantId = variantIds[i];
                        variant = product.getProductvariants().stream()
                                .filter(v -> v.getId() == Integer.parseInt(variantId))
                                .findFirst()
                                .orElse(new ProductVariant());
                    } else {
                        // Create new variant
                        variant = new ProductVariant();
                        variant.setProduct(product);
                        variant.setCreateDate(new Date());
                    }
                    
                    variant.setName(variantNames[i]);
                    variant.setImportPrice(Double.parseDouble(variantImportPrices[i]));
                    variant.setPrice(Double.parseDouble(variantPrices[i]));
                    variant.setStatus(true);
                    variant.setUpdateDate(new Date());
                    
                    // Handle variant image
                    if (i < variantImageParts.size() && variantImageParts.get(i).getSize() > 0) {
                        String variantImageFileName = System.currentTimeMillis() + "_" + getFileName(variantImageParts.get(i));
                        variantImageParts.get(i).write(variantImageFileName);
                        variant.setImage(variantImageFileName);
                    }
                    
                    // Save or update variant
                    if (variant.getId() == 0) {
                        int newVariantId = productDAO.addProductVariant(variant);
                        variant.setId(newVariantId);
                    } else {
                        productDAO.updateProductVariant(variant);
                    }
                    
                    // Process sizes for this variant
                    if (sizeValues != null) {
                        int sizeIndex = i * 3; // Assuming 3 sizes per variant
                        for (int j = 0; j < 3; j++) {
                            if (sizeIndex + j < sizeValues.length) {
                                final int currentSizeIndex = sizeIndex + j;
                                ProductVariantSize pvs;
                                if (sizeIds != null && currentSizeIndex < sizeIds.length) {
                                    // Update existing size
                                    final String sizeId = sizeIds[currentSizeIndex];
                                    pvs = variant.getProductvariantsizes().stream()
                                            .filter(s -> s.getId() == Integer.parseInt(sizeId))
                                            .findFirst()
                                            .orElse(new ProductVariantSize());
                                } else {
                                    // Create new size
                                    pvs = new ProductVariantSize();
                                    pvs.setProductVariant(variant);
                                    pvs.setCreateDate(new Date());
                                }
                                
                                Size size = sizeDAO.getSizeById(Integer.parseInt(sizeValues[currentSizeIndex]));
                                pvs.setSize(size);
                                pvs.setQuantityInStock(Integer.parseInt(quantities[currentSizeIndex]));
                                pvs.setQuantityHolding(Integer.parseInt(holdings[currentSizeIndex]));
                                pvs.setStatus(true);
                                pvs.setUpdateDate(new Date());
                                
                                // Save or update size
                                if (pvs.getId() == 0) {
                                    productDAO.addProductVariantSize(pvs);
                                } else {
                                    productDAO.updateProductVariantSize(pvs);
                                }
                            }
                        }
                    }
                }
            }
            
            response.sendRedirect(request.getContextPath() + "/admin/products");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/products/edit?product_id=" + request.getParameter("product_id") + "&error=true");
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
