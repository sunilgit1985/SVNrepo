/**
 * AccountMessageCollectionRequest.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.invessence.ws.provider.gemini.wsdl.account;

public class AccountMessageCollectionRequest  implements java.io.Serializable {
    private com.invessence.ws.provider.gemini.wsdl.account.AccountMessageRequest[] accountMessage;

    public AccountMessageCollectionRequest() {
    }

    public AccountMessageCollectionRequest(
           com.invessence.ws.provider.gemini.wsdl.account.AccountMessageRequest[] accountMessage) {
           this.accountMessage = accountMessage;
    }


    /**
     * Gets the accountMessage value for this AccountMessageCollectionRequest.
     * 
     * @return accountMessage
     */
    public com.invessence.ws.provider.gemini.wsdl.account.AccountMessageRequest[] getAccountMessage() {
        return accountMessage;
    }


    /**
     * Sets the accountMessage value for this AccountMessageCollectionRequest.
     * 
     * @param accountMessage
     */
    public void setAccountMessage(com.invessence.ws.provider.gemini.wsdl.account.AccountMessageRequest[] accountMessage) {
        this.accountMessage = accountMessage;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof AccountMessageCollectionRequest)) return false;
        AccountMessageCollectionRequest other = (AccountMessageCollectionRequest) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.accountMessage==null && other.getAccountMessage()==null) || 
             (this.accountMessage!=null &&
              java.util.Arrays.equals(this.accountMessage, other.getAccountMessage())));
        __equalsCalc = null;
        return _equals;
    }

    private boolean __hashCodeCalc = false;
    public synchronized int hashCode() {
        if (__hashCodeCalc) {
            return 0;
        }
        __hashCodeCalc = true;
        int _hashCode = 1;
        if (getAccountMessage() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getAccountMessage());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getAccountMessage(), i);
                if (obj != null &&
                    !obj.getClass().isArray()) {
                    _hashCode += obj.hashCode();
                }
            }
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(AccountMessageCollectionRequest.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://enfs.com/webservices/", "AccountMessageCollectionRequest"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("accountMessage");
        elemField.setXmlName(new javax.xml.namespace.QName("http://enfs.com/webservices/", "AccountMessage"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://enfs.com/webservices/", "AccountMessageRequest"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        elemField.setItemQName(new javax.xml.namespace.QName("http://enfs.com/webservices/", "AccountMessageRequest"));
        typeDesc.addFieldDesc(elemField);
    }

    /**
     * Return type metadata object
     */
    public static org.apache.axis.description.TypeDesc getTypeDesc() {
        return typeDesc;
    }

    /**
     * Get Custom Serializer
     */
    public static org.apache.axis.encoding.Serializer getSerializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanSerializer(
            _javaType, _xmlType, typeDesc);
    }

    /**
     * Get Custom Deserializer
     */
    public static org.apache.axis.encoding.Deserializer getDeserializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanDeserializer(
            _javaType, _xmlType, typeDesc);
    }

}
