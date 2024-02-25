-- CreateIndex
CREATE INDEX "book_code_idx" ON "book"("code");

-- CreateIndex
CREATE INDEX "book_author_book_code_idx" ON "book_author"("book_code");

-- CreateIndex
CREATE INDEX "book_category_book_code_idx" ON "book_category"("book_code");

-- CreateIndex
CREATE INDEX "client_code_idx" ON "client"("code");

-- CreateIndex
CREATE INDEX "copy_code_idx" ON "copy"("code");

-- CreateIndex
CREATE INDEX "employee_code_idx" ON "employee"("code");

-- CreateIndex
CREATE INDEX "in_person_order_order_number_idx" ON "in_person_order"("order_number");

-- CreateIndex
CREATE INDEX "legal_client_client_code_idx" ON "legal_client"("client_code");

-- CreateIndex
CREATE INDEX "online_order_order_number_idx" ON "online_order"("order_number");

-- CreateIndex
CREATE INDEX "order_number_idx" ON "order"("number");

-- CreateIndex
CREATE INDEX "order_has_copy_id_idx" ON "order_has_copy"("id");

-- CreateIndex
CREATE INDEX "physical_client_client_code_idx" ON "physical_client"("client_code");

-- CreateIndex
CREATE INDEX "publisher_cnpj_idx" ON "publisher"("cnpj");

-- CreateIndex
CREATE INDEX "publisher_email_publisher_cnpj_idx" ON "publisher_email"("publisher_cnpj");

-- CreateIndex
CREATE INDEX "publisher_phone_publisher_cnpj_idx" ON "publisher_phone"("publisher_cnpj");
