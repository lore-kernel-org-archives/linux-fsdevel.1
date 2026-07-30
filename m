Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DCD3FE671
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 10:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785408168; cv=none; b=Ahl7lehotjaa4sAQ9cE4n3fupCsuUKOvaTFRw8cgyf+KLa9CeiXf29dd23iarEYwYA0k/BOk0JFrGbs40u/KezEyflRmgVoVBm8YHB90V1wc1Za2SaETPY3SK5wnJalsxPN/1GHMD4LDzpFBy1j7SQuxYFGG3mcF1Eeh+/AzE1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785408168; c=relaxed/simple;
	bh=lJSrsGEJYjjjAvP5RTKSpaaoaVLLtdq5ko31t+8WxI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4Pr6zWI8+NtkSEPo19AaEd+BQLjWF3t9NE8uupd/mGbUPejfvfz6i1MJNEPG5t2mVYtKpCrHoTQ6K013iv9A7rR3s4X5HRs4/prRLHRbUNlriTN1c2tSeBcsD261i0rY22dXTtMhnMJIBGX/DKH4Bd7Z/lJvC/QReoNBWYKs/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ao27TkDt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xDVBBRbh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ao27TkDt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xDVBBRbh"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7AA183FE2;
	Thu, 30 Jul 2026 10:42:40 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785408160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JS9+PRVTac1pta7BqlEAix0JeafaRSTYKVEn7OklDKA=;
	b=Ao27TkDt0iqEY8sMHQtSL2sAdjdejzQDHRBQX2SavyBzI8sk49u/AWYB8vvFDw7AzBlC2L
	pVHhAAZ1A/Y83wMReYHvaNRTkgVqWV73t7xGxZt2auxdlZrAaH4EVShP+P5kIEpjUr6I+w
	5xCNQgirXqxUnR8V8DU0Dz7z76pu5Jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785408160;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JS9+PRVTac1pta7BqlEAix0JeafaRSTYKVEn7OklDKA=;
	b=xDVBBRbhHUTATcchj2q8oDhcucsdTrR9LfBKF4X75Rvy9DFNIKVwuxkEnI7faRGykIolYg
	3+bwOzC3liefX/Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72A81779CD;
	Thu, 30 Jul 2026 10:42:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t0/9G6Aqa2p+PgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 30 Jul 2026 10:42:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0602AA07A0; Thu, 30 Jul 2026 12:42:36 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] udf: Move udf_map_block() up
Date: Thu, 30 Jul 2026 12:42:28 +0200
Message-ID: <20260730104232.4086759-3-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260730104040.18150-1-jack@suse.cz>
References: <20260730104040.18150-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4344; i=jack@suse.cz; h=from:subject; bh=lJSrsGEJYjjjAvP5RTKSpaaoaVLLtdq5ko31t+8WxI4=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBqayqZQhvfoaoR/CCnBSQtwhTbqX0ZkhbChqYUX 4MbuAog5fqJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCamsqmQAKCRCcnaoHP2RA 2QI0CACEHzxjrLrfhoEQGISNH6uYom34cUUT5+PfrHsoSaBy9e1DGDV6GwBHBfXN+lK2i1NliA3 bYOlosVGTIJ4KKGBXJOuYk9tvguq+TZMtsjgGNM+V01x7tJnh7fl+ly866y0z0HdQtlbwrWtH0+ IgpiK45UWUu4RzT8khwL23rJ//nMdSpwxjnjhsxFv6VRudsDx9qMGV9hyROFJeUFtrWJSmxTVdQ 1F4i4EgUehSLkCwlQQ4L1PEwlV2zEfK4IdppD3FbIdkjW49xtN6K0dGwqxB1FVTx8SS3N5Clkj1 SgrRwO7M4d3wFr9L7KM/Z4A17jaCS6/68YmWLMh3U+oQsbfL
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 7AA183FE2
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

Move udf_map_block() in the file to avoid forward declarations.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c | 118 ++++++++++++++++++++++++-------------------------
 1 file changed, 59 insertions(+), 59 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 67bcf83758c8..b8b9b7132115 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -336,65 +336,6 @@ const struct address_space_operations udf_aops = {
 	.migrate_folio	= buffer_migrate_folio,
 };
 
-/*
- * Expand file stored in ICB to a normal one-block-file
- *
- * This function requires i_mutex held
- */
-int udf_expand_file_adinicb(struct inode *inode)
-{
-	struct folio *folio;
-	struct udf_inode_info *iinfo = UDF_I(inode);
-	int err;
-
-	WARN_ON_ONCE(!inode_is_locked(inode));
-	if (!iinfo->i_lenAlloc) {
-		down_write(&iinfo->i_data_sem);
-		if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_USE_SHORT_AD))
-			iinfo->i_alloc_type = ICBTAG_FLAG_AD_SHORT;
-		else
-			iinfo->i_alloc_type = ICBTAG_FLAG_AD_LONG;
-		up_write(&iinfo->i_data_sem);
-		mark_inode_dirty(inode);
-		return 0;
-	}
-
-	folio = __filemap_get_folio(inode->i_mapping, 0,
-			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, GFP_KERNEL);
-	if (IS_ERR(folio))
-		return PTR_ERR(folio);
-
-	if (!folio_test_uptodate(folio))
-		udf_adinicb_read_folio(folio);
-	down_write(&iinfo->i_data_sem);
-	memset(iinfo->i_data + iinfo->i_lenEAttr, 0x00,
-	       iinfo->i_lenAlloc);
-	iinfo->i_lenAlloc = 0;
-	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_USE_SHORT_AD))
-		iinfo->i_alloc_type = ICBTAG_FLAG_AD_SHORT;
-	else
-		iinfo->i_alloc_type = ICBTAG_FLAG_AD_LONG;
-	folio_mark_dirty(folio);
-	folio_unlock(folio);
-	up_write(&iinfo->i_data_sem);
-	err = filemap_fdatawrite(inode->i_mapping);
-	if (err) {
-		/* Restore everything back so that we don't lose data... */
-		folio_lock(folio);
-		down_write(&iinfo->i_data_sem);
-		memcpy_from_folio(iinfo->i_data + iinfo->i_lenEAttr,
-				folio, 0, inode->i_size);
-		folio_unlock(folio);
-		iinfo->i_alloc_type = ICBTAG_FLAG_AD_IN_ICB;
-		iinfo->i_lenAlloc = inode->i_size;
-		up_write(&iinfo->i_data_sem);
-	}
-	folio_put(folio);
-	mark_inode_dirty(inode);
-
-	return err;
-}
-
 #define UDF_MAP_CREATE		0x01	/* Mapping can allocate new blocks */
 #define UDF_MAP_NOPREALLOC	0x02	/* Do not preallocate blocks */
 
@@ -455,6 +396,65 @@ static int udf_map_block(struct inode *inode, struct udf_map_rq *map)
 	return ret;
 }
 
+/*
+ * Expand file stored in ICB to a normal one-block-file
+ *
+ * This function requires i_mutex held
+ */
+int udf_expand_file_adinicb(struct inode *inode)
+{
+	struct folio *folio;
+	struct udf_inode_info *iinfo = UDF_I(inode);
+	int err;
+
+	WARN_ON_ONCE(!inode_is_locked(inode));
+	if (!iinfo->i_lenAlloc) {
+		down_write(&iinfo->i_data_sem);
+		if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_USE_SHORT_AD))
+			iinfo->i_alloc_type = ICBTAG_FLAG_AD_SHORT;
+		else
+			iinfo->i_alloc_type = ICBTAG_FLAG_AD_LONG;
+		up_write(&iinfo->i_data_sem);
+		mark_inode_dirty(inode);
+		return 0;
+	}
+
+	folio = __filemap_get_folio(inode->i_mapping, 0,
+			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, GFP_KERNEL);
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
+
+	if (!folio_test_uptodate(folio))
+		udf_adinicb_read_folio(folio);
+	down_write(&iinfo->i_data_sem);
+	memset(iinfo->i_data + iinfo->i_lenEAttr, 0x00,
+	       iinfo->i_lenAlloc);
+	iinfo->i_lenAlloc = 0;
+	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_USE_SHORT_AD))
+		iinfo->i_alloc_type = ICBTAG_FLAG_AD_SHORT;
+	else
+		iinfo->i_alloc_type = ICBTAG_FLAG_AD_LONG;
+	folio_mark_dirty(folio);
+	folio_unlock(folio);
+	up_write(&iinfo->i_data_sem);
+	err = filemap_fdatawrite(inode->i_mapping);
+	if (err) {
+		/* Restore everything back so that we don't lose data... */
+		folio_lock(folio);
+		down_write(&iinfo->i_data_sem);
+		memcpy_from_folio(iinfo->i_data + iinfo->i_lenEAttr,
+				folio, 0, inode->i_size);
+		folio_unlock(folio);
+		iinfo->i_alloc_type = ICBTAG_FLAG_AD_IN_ICB;
+		iinfo->i_lenAlloc = inode->i_size;
+		up_write(&iinfo->i_data_sem);
+	}
+	folio_put(folio);
+	mark_inode_dirty(inode);
+
+	return err;
+}
+
 static int __udf_get_block(struct inode *inode, sector_t block,
 			   struct buffer_head *bh_result, int flags)
 {
-- 
2.51.0

