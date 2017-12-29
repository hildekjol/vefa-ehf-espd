<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
        xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
        xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
        xmlns:ccv-cbc="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonBasicComponents-1"
        xmlns:cev-cbc="urn:isa:names:specification:ubl:schema:xsd:CEV-CommonBasicComponents-1"
        xmlns:cev="urn:isa:names:specification:ubl:schema:xsd:CEV-CommonAggregateComponents-1"
        xmlns:espd-response="urn:grow:names:specification:ubl:schema:xsd:ESPDResponse-1"
        xmlns:espd-request="urn:grow:names:specification:ubl:schema:xsd:ESPDRequest-1"
        xmlns:ext="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"
        xmlns:espd-cbc="urn:grow:names:specification:ubl:schema:xsd:ESPD-CommonBasicComponents-1"
        xmlns:ccv="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonAggregateComponents-1"
        xmlns:espd-cac="urn:grow:names:specification:ubl:schema:xsd:ESPD-CommonAggregateComponents-1">

    <title>EHF ESPD</title>

    <ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"/>
    <ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"/>
    <ns prefix="ccv-cbc" uri="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonBasicComponents-1"/>
    <ns prefix="cev-cbc" uri="urn:isa:names:specification:ubl:schema:xsd:CEV-CommonBasicComponents-1"/>
    <ns prefix="cev" uri="urn:isa:names:specification:ubl:schema:xsd:CEV-CommonAggregateComponents-1"/>
    <ns prefix="espd-res" uri="urn:grow:names:specification:ubl:schema:xsd:ESPDResponse-1"/>
    <ns prefix="espd-req" uri="urn:grow:names:specification:ubl:schema:xsd:ESPDRequest-1"/>
    <ns prefix="ext" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"/>
    <ns prefix="espd-cbc" uri="urn:grow:names:specification:ubl:schema:xsd:ESPD-CommonBasicComponents-1"/>
    <ns prefix="ccv" uri="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonAggregateComponents-1"/>
    <ns prefix="espd-cac" uri="urn:grow:names:specification:ubl:schema:xsd:ESPD-CommonAggregateComponents-1"/>>

    <!-- <include href="parts/syntax.xml"/> -->
    <include href="../../target/generated/EHF-ESPD-RESPONSE-BASIC.sch"/>

</schema>