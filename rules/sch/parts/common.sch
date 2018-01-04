<?xml version="1.0" encoding="UTF-8"?>
<pattern xmlns="http://purl.oclc.org/dsdl/schematron">
    <rule context="/*">
        <assert id="EHF-ESPD-R003"
                test="not(@*:schemaLocation)"
                flag="fatal">Document MUST not contain schema location.</assert>
    </rule>

    <rule context="ccv:Requirement">
        <assert id="EHF-ESPD-R100"
                test="(/espd:ESPDResponse and ccv:Response) or (/espd-req:ESPDRequest and not(ccv:Response))"
                flag="fatal">Response MUST be provided in ESPD Response and MUST NOT be provided in ESPD Request.</assert>
    </rule>

    <rule context="ccv:Response">

    </rule>
</pattern>