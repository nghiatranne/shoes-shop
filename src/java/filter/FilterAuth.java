/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */
package filter;

import dao.AccountDAO;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author hoaht
 */
@WebFilter(filterName = "FilterAuth", urlPatterns = {"/*"})
public class FilterAuth implements Filter {

    private static final boolean debug = true;

    // The filter configuration object we are associated with.  If
    // this value is null, this filter instance is not currently
    // configured. 
    private FilterConfig filterConfig = null;

    public FilterAuth() {
    }

    private void doBeforeProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("FilterAuth:DoBeforeProcessing");
        }

        // Write code here to process the request and/or response before
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log items on the request object,
        // such as the parameters.
        /*
	for (Enumeration en = request.getParameterNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    String values[] = request.getParameterValues(name);
	    int n = values.length;
	    StringBuffer buf = new StringBuffer();
	    buf.append(name);
	    buf.append("=");
	    for(int i=0; i < n; i++) {
	        buf.append(values[i]);
	        if (i < n-1)
	            buf.append(",");
	    }
	    log(buf.toString());
	}
         */
    }

    private void doAfterProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("FilterAuth:DoAfterProcessing");
        }

        // Write code here to process the request and/or response after
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log the attributes on the
        // request object after the request has been processed. 
        /*
	for (Enumeration en = request.getAttributeNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    Object value = request.getAttribute(name);
	    log("attribute: " + name + "=" + value.toString());

	}
         */
        // For example, a filter might append something to the response.
        /*
	PrintWriter respOut = new PrintWriter(response.getWriter());
	respOut.println("<P><B>This has been appended by an intrusive filter.</B>");
         */
    }

    /**
     *
     * @param request The servlet request we are processing
     * @param response The servlet response we are creating
     * @param chain The filter chain we are processing
     *
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet error occurs
     */
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        AccountDAO accountDAO = new AccountDAO();

        String url = req.getRequestURI();
        String contextPath = req.getContextPath();
        String homepageUrl = contextPath + "/homepage";
        String loginUrl = contextPath + "/login";

        if (url.startsWith(contextPath + "/static/") || url.contains("/resources/")) {
            chain.doFilter(request, response);
            return;
        }
        if (url.endsWith("/")) {
            res.sendRedirect(homepageUrl);
            return;
        }

        HttpSession session = req.getSession(false);
        boolean isLoggedIn = session != null && session.getAttribute("uName") != null; // đã đăng nhập
        List<String> roles = new ArrayList<>();
        if (isLoggedIn) {
            String userEmail = (String) session.getAttribute("uName");
            roles = accountDAO.getUserRoles(userEmail);
        }

        boolean isLoginRequest = url.equals(contextPath + "/login");
        boolean isRegisterRequest = url.equals(contextPath + "/sign-up");
        boolean isResetPasswordRequest = url.equals(contextPath + "/reset-pass");
        boolean isChangePasswordRequest = url.equals(contextPath + "/profile/change-pass");
        boolean isProfileRequest = url.contains(contextPath + "/profile");
        boolean isSignOutRequest = url.equals(contextPath + "/logout");
        boolean isApiRequest = url.contains("api");
        boolean isApiUserRequst = url.contains("api-user");
        boolean isAdminLoginRequest = url.contains("/admin/login");

        boolean isHomePageRequest = url.equals(contextPath + "/homepage");
        boolean isBlogsListRequest = url.equals(contextPath + "/blog-list");
        boolean isBlogDetailsRequest = url.equals(contextPath + "/blog/post-details");
        boolean isBooksRequest = url.contains(contextPath + "/products");
        boolean isOrderRequest = url.equals(contextPath + "/orders/order-detail");
        boolean isPaymentRequest = url.equals(contextPath + "/payment");
        boolean isChooseAddressRequest = url.equals(contextPath + "/choose-address");
        boolean isInvoiceRequest = url.equals(contextPath + "/invoice");
        boolean isCheckoutRequest = url.equals(contextPath + "/cart/infor/save");
        boolean isCartComplementRequest = url.equals(contextPath + "/cart/completion");
        boolean isCartCheckoutRequest = url.equals(contextPath + "/cart/infor");
        boolean isCartRequest = url.equals(contextPath + "/cart");
        boolean isVNPayRequest = url.equals(contextPath + "/vnpay/confirmation");
        boolean isFeedbackRequest = url.equals(contextPath + "/feedback");
        boolean isCancelRequest = url.equals(contextPath + "/orders/cancel");
        boolean isUpdateRequest = url.equals(contextPath + "/update-address");
        boolean isReceiveRequest = url.equals(contextPath + "/orders/receive");
        boolean isVerifyRequest = url.equals(contextPath + "/login/verify");
        boolean isForgotPassRequest = url.equals(contextPath + "/forget-pass");
        boolean isFeedbackReq = url.equals(contextPath + "/orders/order-detail/feedback");

        boolean isMyOrdersRequest = url.equals(contextPath + "/orders");

        boolean isDashboardRequest = url.equals(contextPath + "/admin/dashboard");

        boolean isMktDashboardRequest = url.contains(contextPath + "/admin/marketer-dashboard");
        boolean isMktBookRequest = url.contains(contextPath + "/admin/books");
        boolean isMktPostsRequest = url.contains(contextPath + "/admin/posts");
        boolean isMktSlidersRequest = url.contains(contextPath + "/admin/sliders");
        boolean isMktCustomersRequest = url.contains(contextPath + "/admin/customers");
        boolean isMktFeedbacksRequest = url.contains(contextPath + "/admin/feedbacks");
        boolean isMktPaymentRequest = url.contains(contextPath + "/admin/payments");
        boolean isMktAuthorRequest = url.contains(contextPath + "/admin/authors");
        boolean isMktCategoryRequest = url.contains(contextPath + "/admin/categories");
        boolean isMktSizeRequest = url.contains(contextPath + "/admin/sizes");
        boolean isMktFormatRequest = url.contains(contextPath + "/admin/formats");
        boolean isMktPublisherRequest = url.contains(contextPath + "/admin/publishers");
        boolean isMktAddPublisherRequest = url.contains(contextPath + "/admin/publishers/save");
        boolean isMktCustomerDetaiReq = url.contains(contextPath + "/admin/customers/customer");
        boolean isMktCustomerAddRes = url.contains(contextPath + "/admin/customers/add");
        boolean isMktSliderDelReq = url.contains(contextPath + "/admin/slider/delete");
        boolean isMktBrandRequest = url.contains(contextPath + "/admin/brands");

        boolean isOrdersListRequest = url.contains(contextPath + "/admin/orders");
        boolean isAssignAccountRequest = url.contains(contextPath + "/order/assign-account");

        boolean isAddminUsersListRequest = url.contains(contextPath + "/admin/accounts");
        boolean isAddminRoleRequest = url.equals(contextPath + "/admin/roles");
        
        boolean isSaleDashboardReq = url.equals(contextPath + "/admin/sale-dashboard"); 
        boolean isProductReq = url.equals(contextPath + "/admin/products");
        boolean isProductDetailReq = url.equals(contextPath + "/admin/products/product");
        boolean isProductAddReq = url.equals(contextPath + "/admin/products/add");
        boolean isProductSaveReq = url.equals(contextPath + "/admin/products/add/save");
        boolean isProductEditReq = url.equals(contextPath + "/admin/products/edit");

// Common feature accessible by all logged in users
        if (isLoginRequest || isRegisterRequest || isResetPasswordRequest || isChangePasswordRequest || isSignOutRequest || isForgotPassRequest || isAdminLoginRequest) {
            chain.doFilter(request, response);
            return;
        }
        if (isHomePageRequest || isBlogsListRequest || isBlogDetailsRequest || isBooksRequest || isApiRequest || isApiUserRequst || isVerifyRequest || isResetPasswordRequest || isForgotPassRequest || isProfileRequest || isAdminLoginRequest) {
            chain.doFilter(request, response);
            return;
        }
        if (isMyOrdersRequest || isHomePageRequest || isBlogsListRequest || isCancelRequest || isBlogDetailsRequest
                || isBooksRequest || isCartRequest || isFeedbackRequest || isApiRequest || isApiUserRequst || isProfileRequest
                || isOrderRequest || isPaymentRequest || isVNPayRequest || isChooseAddressRequest || isCheckoutRequest
                || isInvoiceRequest || isCartCheckoutRequest || isCartComplementRequest || isUpdateRequest || isReceiveRequest || isFeedbackReq) {
            if (roles.contains("CUSTOMER")) {
                chain.doFilter(request, response);
                return;
            } else {
                res.sendRedirect(loginUrl);
                return;
            }
        }
        if (isDashboardRequest) {
            if (roles.contains("MARKETER") || roles.contains("SALE") || roles.contains("SALE MANAGER") || roles.contains("ADMIN") || roles.contains("WAREHOUSE")) {
                chain.doFilter(request, response);
                return;
            } else {
                res.sendRedirect(homepageUrl);
                return;
            }
        }
        
        
        if (isMktBookRequest && roles.contains("WAREHOUSE")) {
            chain.doFilter(request, response);
            return;
        }
        
        if (isMktBookRequest || isMktPostsRequest || isMktSlidersRequest || isMktCustomersRequest || isMktAuthorRequest
                || isMktFeedbacksRequest || isMktPaymentRequest || isMyOrdersRequest || isMktCategoryRequest
                || isMktFormatRequest || isMktPublisherRequest || isProfileRequest
                || isHomePageRequest || isBlogsListRequest || isCancelRequest || isBlogDetailsRequest
                || isBooksRequest || isCartRequest || isFeedbackRequest || isApiRequest || isApiUserRequst
                || isOrderRequest || isPaymentRequest || isVNPayRequest || isChooseAddressRequest || isCheckoutRequest
                || isInvoiceRequest || isCartCheckoutRequest || isCartComplementRequest || isMktDashboardRequest || isMktAddPublisherRequest || isMktCustomerDetaiReq || isMktCustomerAddRes
                || isMktSliderDelReq || isMktSizeRequest || isMktBrandRequest || isMktPaymentRequest || isProductReq || isProductDetailReq
                || isProductAddReq || isProductSaveReq || isProductEditReq) {
            if (roles.contains("MARKETER") || roles.contains("SALE") || roles.contains("SALE MANAGER")) {
                chain.doFilter(request, response);
                return;
            } else {
                res.sendRedirect(homepageUrl);
                return;
            }
        }
        
        if (isOrdersListRequest || isMyOrdersRequest || isProfileRequest || isAssignAccountRequest
                || isHomePageRequest || isBlogsListRequest || isCancelRequest || isBlogDetailsRequest
                || isBooksRequest || isCartRequest || isFeedbackRequest || isApiRequest || isApiUserRequst
                || isOrderRequest || isPaymentRequest || isVNPayRequest || isChooseAddressRequest || isCheckoutRequest
                || isInvoiceRequest || isCartCheckoutRequest || isCartComplementRequest || isSaleDashboardReq) {
            if (roles.contains("SALE") || roles.contains("SALE MANAGER") || roles.contains("WAREHOUSE")) {
                chain.doFilter(request, response);
                return;
            } else {
                res.sendRedirect(homepageUrl);
                return;
            }
        }
        if (isApiRequest || isApiUserRequst || isAddminUsersListRequest || isAddminRoleRequest || isMyOrdersRequest
                || isHomePageRequest || isBlogsListRequest || isCancelRequest || isBlogDetailsRequest
                || isBooksRequest || isCartRequest || isFeedbackRequest || isApiRequest || isApiUserRequst
                || isOrderRequest || isPaymentRequest || isVNPayRequest || isChooseAddressRequest || isCheckoutRequest
                || isInvoiceRequest || isCartCheckoutRequest || isCartComplementRequest || isProfileRequest) {
            if (roles.contains("ADMIN")) {
                chain.doFilter(request, response);
                return;
            } else {
                res.sendRedirect(homepageUrl);
                return;
            }
        }

        res.sendRedirect(homepageUrl);
    }

    /**
     * Return the filter configuration object for this filter.
     */
    public FilterConfig getFilterConfig() {
        return (this.filterConfig);
    }

    /**
     * Set the filter configuration object for this filter.
     *
     * @param filterConfig The filter configuration object
     */
    public void setFilterConfig(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    /**
     * Destroy method for this filter
     */
    public void destroy() {
    }

    /**
     * Init method for this filter
     */
    public void init(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
        if (filterConfig != null) {
            if (debug) {
                log("FilterAuth:Initializing filter");
            }
        }
    }

    /**
     * Return a String representation of this object.
     */
    @Override
    public String toString() {
        if (filterConfig == null) {
            return ("FilterAuth()");
        }
        StringBuffer sb = new StringBuffer("FilterAuth(");
        sb.append(filterConfig);
        sb.append(")");
        return (sb.toString());
    }

    private void sendProcessingError(Throwable t, ServletResponse response) {
        String stackTrace = getStackTrace(t);

        if (stackTrace != null && !stackTrace.equals("")) {
            try {
                response.setContentType("text/html");
                PrintStream ps = new PrintStream(response.getOutputStream());
                PrintWriter pw = new PrintWriter(ps);
                pw.print("<html>\n<head>\n<title>Error</title>\n</head>\n<body>\n"); //NOI18N

                // PENDING! Localize this for next official release
                pw.print("<h1>The resource did not process correctly</h1>\n<pre>\n");
                pw.print(stackTrace);
                pw.print("</pre></body>\n</html>"); //NOI18N
                pw.close();
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        } else {
            try {
                PrintStream ps = new PrintStream(response.getOutputStream());
                t.printStackTrace(ps);
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        }
    }

    public static String getStackTrace(Throwable t) {
        String stackTrace = null;
        try {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            t.printStackTrace(pw);
            pw.close();
            sw.close();
            stackTrace = sw.getBuffer().toString();
        } catch (Exception ex) {
        }
        return stackTrace;
    }

    public void log(String msg) {
        filterConfig.getServletContext().log(msg);
    }
}
