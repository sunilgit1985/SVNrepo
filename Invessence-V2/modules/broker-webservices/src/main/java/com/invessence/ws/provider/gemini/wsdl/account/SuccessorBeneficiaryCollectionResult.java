/**
 * SuccessorBeneficiaryCollectionResult.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.invessence.ws.provider.gemini.wsdl.account;

public class SuccessorBeneficiaryCollectionResult  implements java.io.Serializable {
    private com.invessence.ws.provider.gemini.wsdl.account.SuccessorBeneficiaryResult[] successorBeneficiary;

    private com.invessence.ws.provider.gemini.wsdl.account.Status errorStatus;

    public SuccessorBeneficiaryCollectionResult() {
    }

    public SuccessorBeneficiaryCollectionResult(
           com.invessence.ws.provider.gemini.wsdl.account.SuccessorBeneficiaryResult[] successorBeneficiary,
           com.invessence.ws.provider.gemini.wsdl.account.Status errorStatus) {
           this.successorBeneficiary = successorBeneficiary;
           this.errorStatus = errorStatus;
    }


    /**
     * Gets the successorBeneficiary value for this SuccessorBeneficiaryCollectionResult.
     * 
     * @return successorBeneficiary
     */
    public com.invessence.ws.provider.gemini.wsdl.account.SuccessorBeneficiaryResult[] getSuccessorBeneficiary() {
        return successorBeneficiary;
    }


    /**
     * Sets the successorBeneficiary value for this SuccessorBeneficiaryCollectionResult.
     * 
     * @param successorBeneficiary
     */
    public void setSuccessorBeneficiary(com.invessence.ws.provider.gemini.wsdl.account.SuccessorBeneficiaryResult[] successorBeneficiary) {
        this.successorBeneficiary = successorBeneficiary;
    }


    /**
     * Gets the errorStatus value for this SuccessorBeneficiaryCollectionResult.
     * 
     * @return errorStatus
     */
    public com.invessence.ws.provider.gemini.wsdl.account.Status getErrorStatus() {
        return errorStatus;
    }


    /**
     * Sets the errorStatus value for this SuccessorBeneficiaryCollectionResult.
     * 
     * @param errorStatus
     */
    public void setErrorStatus(com.invessence.ws.provider.gemini.wsdl.account.Status errorStatus) {
        this.errorStatus = errorStatus;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof SuccessorBeneficiaryCollectionResult)) return false;
        SuccessorBeneficiaryCollectionResult other = (SuccessorBeneficiaryCollectionResult) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.successorBeneficiary==null && other.getSuccessorBeneficiary()==null) || 
             (this.successorBeneficiary!=null &&
              java.util.Arrays.equals(this.successorBeneficiary, other.getSuccessorBeneficiary()))) &&
            ((this.errorStatus==null && other.getErrorStatus()==null) || 
             (this.errorStatus!=null &&
              this.errorStatus.equals(other.getErrorStatus())));
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
        if (getSuccessorBeneficiary() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getSuccessorBeneficiary());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getSuccessorBeneficiary(), i);
                if (obj != null &&
                    !obj.getClass().isArray()) {
                    _hashCode += obj.hashCode();
                }
            }
        }
        if (getErrorStatus() != null) {
            _hashCode += getErrorStatus().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(SuccessorBeneficiaryCollectionResult.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://enfs.com/webservices/", "SuccessorBeneficiaryCollectionResult"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("successorBeneficiary");
        elemField.setXmlName(new javax.xml.namespace.QName("http://enfs.com/webservices/", "SuccessorBeneficiary"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://enfs.com/webservices/", "SuccessorBeneficiaryResult"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        elemField.setItemQName(new javax.xml.namespace.QName("http://enfs.com/webservices/", "SuccessorBeneficiaryResult"));
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("errorStatus");
        elemField.setXmlName(new javax.xml.namespace.QName("http://enfs.com/webservices/", "ErrorStatus"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://enfs.com/webservices/", "WSCallStatus"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
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
