-- AlterTable
ALTER TABLE "LegalClient" ALTER COLUMN "client_code" DROP DEFAULT;
DROP SEQUENCE "legalclient_client_code_seq";

-- AlterTable
ALTER TABLE "PhysicalClient" ALTER COLUMN "client_code" DROP DEFAULT;
DROP SEQUENCE "physicalclient_client_code_seq";
