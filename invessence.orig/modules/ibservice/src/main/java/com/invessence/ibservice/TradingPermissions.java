
package com.invessence.ibservice;

import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * 
 * 				One or more exchange access bundles specified by country or
 * 				other grouping.
 * 			
 * 
 * <p>Java class for TradingPermissions complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="TradingPermissions">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="TradingPermission" type="{http://www.interactivebrokers.com/schemas/IBCust_import}TradingPermission" maxOccurs="unbounded"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "TradingPermissions", namespace = "http://www.interactivebrokers.com/schemas/IBCust_import", propOrder = {
    "tradingPermission"
})
public class TradingPermissions {

    @XmlElement(name = "TradingPermission", namespace = "http://www.interactivebrokers.com/schemas/IBCust_import", required = true)
    protected List<TradingPermission> tradingPermission;

    /**
     * Gets the value of the tradingPermission property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the tradingPermission property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getTradingPermission().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link TradingPermission }
     * 
     * 
     */
    public List<TradingPermission> getTradingPermission() {
        if (tradingPermission == null) {
            tradingPermission = new ArrayList<TradingPermission>();
        }
        return this.tradingPermission;
    }

}
