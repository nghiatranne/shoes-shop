package model;
import java.util.Date;

public class FeedbackDto {
    private String accountName;
    private String content;
    private int ratedStar;
    private boolean status;
    private String image;
    private Date createDate;
    private Date updateDate;
    private String productVariantName;

    // Getter & Setter
    public String getAccountName() { return accountName; }
    public void setAccountName(String accountName) { this.accountName = accountName; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public int getRatedStar() { return ratedStar; }
    public void setRatedStar(int ratedStar) { this.ratedStar = ratedStar; }
    public boolean isStatus() { return status; }
    public void setStatus(boolean status) { this.status = status; }
    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
    public Date getCreateDate() { return createDate; }
    public void setCreateDate(Date createDate) { this.createDate = createDate; }
    public Date getUpdateDate() { return updateDate; }
    public void setUpdateDate(Date updateDate) { this.updateDate = updateDate; }
    public String getProductVariantName() { return productVariantName; }
    public void setProductVariantName(String productVariantName) { this.productVariantName = productVariantName; }
} 