CREATE TABLE IDN_CONFIG_TYPE (
    ID VARCHAR2(255) NOT NULL,
    NAME VARCHAR2(255) NOT NULL,
    DESCRIPTION VARCHAR2(1023) NULL,
    PRIMARY KEY (ID),
    CONSTRAINT TYPE_NAME_CONSTRAINT UNIQUE (NAME)
)
/

INSERT ALL INTO IDN_CONFIG_TYPE (ID, NAME, DESCRIPTION) VALUES
('9ab0ef95-13e9-4ed5-afaf-d29bed62f7bd', 'IDP_TEMPLATE', 'Template type to uniquely identify IDP templates')
INTO IDN_CONFIG_TYPE (ID, NAME, DESCRIPTION) VALUES
('3c4ac3d0-5903-4e3d-aaca-38df65b33bfd', 'APPLICATION_TEMPLATE', 'Template type to uniquely identify Application templates')
SELECT 1 FROM dual
/

CREATE TABLE IDN_CONFIG_RESOURCE (
    ID VARCHAR2(255) NOT NULL,
    TENANT_ID NUMBER(22,0) NOT NULL,
    NAME VARCHAR2(255) NOT NULL,
    CREATED_TIME TIMESTAMP NOT NULL,
    LAST_MODIFIED TIMESTAMP NOT NULL,
    HAS_FILE NUMBER(1,0) DEFAULT 1 NOT NULL,
    HAS_ATTRIBUTE NUMBER(1,0) DEFAULT 1 NOT NULL,
    TYPE_ID VARCHAR2(255) NOT NULL,
    PRIMARY KEY (ID),
    UNIQUE (NAME, TENANT_ID, TYPE_ID),
    CONSTRAINT TYPE_ID_FOREIGN_CONSTRAINT FOREIGN KEY (TYPE_ID) REFERENCES IDN_CONFIG_TYPE(ID) ON DELETE CASCADE
)
/

CREATE TABLE IDN_CONFIG_ATTRIBUTE (
    ID VARCHAR2(255) NOT NULL,
    RESOURCE_ID VARCHAR2(255) NOT NULL,
    ATTR_KEY VARCHAR2(255) NOT NULL,
    ATTR_VALUE VARCHAR2(1023) NULL,
    PRIMARY KEY (ID),
    UNIQUE (RESOURCE_ID, ATTR_KEY),
    CONSTRAINT RESOURCE_ID_ATTR_CONSTRAINT FOREIGN KEY (RESOURCE_ID) REFERENCES IDN_CONFIG_RESOURCE(ID) ON DELETE
    CASCADE
)
/

CREATE TABLE IDN_CONFIG_FILE (
    ID VARCHAR2(255) NOT NULL,
    VALUE BLOB NULL,
    NAME VARCHAR2(255) NOT NULL,
    RESOURCE_ID VARCHAR2(255) NULL,
    PRIMARY KEY (ID),
    CONSTRAINT RESOURCE_ID_FILE_CONSTRAINT FOREIGN KEY (RESOURCE_ID) REFERENCES IDN_CONFIG_RESOURCE(ID) ON DELETE
    CASCADE
)
/
