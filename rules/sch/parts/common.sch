<?xml version="1.0" encoding="UTF-8"?>
<pattern xmlns="http://purl.oclc.org/dsdl/schematron">
    <rule context="/*">
        <assert id="EHF-ESPD-R003"
                test="not(@*:schemaLocation)"
                flag="fatal">Document MUST not contain schema location.</assert>
    </rule>
</pattern>