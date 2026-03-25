Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC2F34104E
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 18:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774464615; cv=none; b=L4eiSms5tGbQ969j93n3h9RPp5C5ZSR5IU21pK9V81saqqwBy0deRj+M4dqC76ADOAyyPAlOmlkw0YqtpxTY6AzzxqHcNn5i8Rw9DCuuMfTnVDEgw/5z3bq+n0pYT3um31BE7L+KDBwZ371a/z6gMWyOz1vMUojFrg+FDq0NLKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774464615; c=relaxed/simple;
	bh=w1VISlujRgrRgqZxdVDhT0cMk3ovWMZc7Q2krevfdQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uCIN6q6L97PjXPIFLcQkdS2M8hGRMA17AFTn5qPNqFEaPsspRbg9ubflhxu59UCufjfnLXEMsWNFTOalNe+6Z1JJ8pL7qc8rsHRiQgqRWP1r8DjFnN7UNllWuRtkPYtDz4VrtQzgOEayoh/s/8IykdEkhwpUbDzjO6JfNd5nWYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3Dpr3+Bh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=c08EFa0n; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3Dpr3+Bh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=c08EFa0n; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3Dpr3+Bh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="c08EFa0n";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3Dpr3+Bh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="c08EFa0n"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CFE1B4D249;
	Wed, 25 Mar 2026 18:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774464610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kY4KdGkMsJWjJ5ksMVNV6iC59kNSYPkvqWwG9HHqq9o=;
	b=3Dpr3+Bh+/yfSzGDe08mC9SkKmsQfCFpGQfUsUd1dvqpgYPMQpHNfxaWzDPXsYPsY5SkX7
	Pjgvq1X0474iQumckfLCTWY2O/LvQzC1lyd5kCixXXbZreS6+wOU/tBgfqDZsZqJwz67qu
	OV1ODEIFb1v4hnLDxYvyQt+v5jsGB3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774464610;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kY4KdGkMsJWjJ5ksMVNV6iC59kNSYPkvqWwG9HHqq9o=;
	b=c08EFa0nsffs5g0ENqs0KZGNQk/pHV3AsHfVTFjJlQvzqweXwS1S/z8ht+vV/cUl3u9bzu
	LnC0GmKR2q8aYYAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774464610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kY4KdGkMsJWjJ5ksMVNV6iC59kNSYPkvqWwG9HHqq9o=;
	b=3Dpr3+Bh+/yfSzGDe08mC9SkKmsQfCFpGQfUsUd1dvqpgYPMQpHNfxaWzDPXsYPsY5SkX7
	Pjgvq1X0474iQumckfLCTWY2O/LvQzC1lyd5kCixXXbZreS6+wOU/tBgfqDZsZqJwz67qu
	OV1ODEIFb1v4hnLDxYvyQt+v5jsGB3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774464610;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kY4KdGkMsJWjJ5ksMVNV6iC59kNSYPkvqWwG9HHqq9o=;
	b=c08EFa0nsffs5g0ENqs0KZGNQk/pHV3AsHfVTFjJlQvzqweXwS1S/z8ht+vV/cUl3u9bzu
	LnC0GmKR2q8aYYAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C11794454D;
	Wed, 25 Mar 2026 18:50:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NTCLLmIuxGklVgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 25 Mar 2026 18:50:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 955CBA0B57; Wed, 25 Mar 2026 17:22:24 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Jianzhou Zhao <luckd0g@163.com>
Subject: [PATCH v2] udf: Fix race between file type conversion and writeback
Date: Wed, 25 Mar 2026 17:22:10 +0100
Message-ID: <20260325162209.29233-2-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3272; i=jack@suse.cz; h=from:subject; bh=w1VISlujRgrRgqZxdVDhT0cMk3ovWMZc7Q2krevfdQ8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpxAux9vhtZFN1N6cY0g7nvmQ5D+kWaqg8NeyUJ mhItLW+DHqJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCacQLsQAKCRCcnaoHP2RA 2RuqB/4sEUb3HH0TzLqnh38uBluxsRFJsXv8r6uLfbV3aGiMRV+gIrSJy3XGGRRfusNjRuRECNT /q1q0SlXRwLUM8fY3QBQgoJsUjmReFfflhQ0K4+A0+u/ApNXJJnrm2uH/MjcteiJL4WVDOTrtnS jMEBFMdRpNoNrIk6kJda/tFavl1pZ7wuI821xXb9Kn7sxWZVxthCJhGEIb5LAZMUuUe5o+BMxyi /NokLdetvPGk/9beiX7NaglvrHy3aG6O0F0VoxFmelYnDW0+QoZGnoqPTUNE62tUBQuCaFKgFdj JeZ6zA5Mmz5Pn1g4LzKlWQeu/CoNNCk4SQi4nFtUPRnTAjO0
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,suse.cz,163.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[163.com]
X-Spam-Flag: NO

udf_setsize() can race with udf_writepages() as follows:

udf_setsize()			udf_writepages()
				  if (iinfo->i_alloc_type ==
						ICBTAG_FLAG_AD_IN_ICB)
  err = udf_expand_file_adinicb(inode);
  err = udf_extend_file(inode, newsize);
				    udf_adinicb_writepages()
				      memcpy_from_file_folio() - crash
					because inode size is too big.

Fix the problem by rechecking file type under folio lock in
udf_writepages() which properly serializes with
udf_expand_file_adinicb(). Since it is quite difficult to implement this
locking with current writeback_iter() logic, let's just opencode the
logic necessary to prepare (the only) folio the inode can have for
writeback.

Reported-by: Jianzhou Zhao <luckd0g@163.com>
Link: https://lore.kernel.org/all/f622c01.67ac.19cdbdd777d.Coremail.luckd0g@163.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c | 53 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 20 deletions(-)

Changes since v1:
* opencode folio_prepare_writeback() in UDF instead of exporting it

I'll merge this fix through my tree.

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 7fae8002344a..c85b0239660c 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -181,34 +181,47 @@ static void udf_write_failed(struct address_space *mapping, loff_t to)
 	}
 }
 
-static int udf_adinicb_writepages(struct address_space *mapping,
-		      struct writeback_control *wbc)
+static int udf_writepages(struct address_space *mapping,
+			  struct writeback_control *wbc)
 {
 	struct inode *inode = mapping->host;
 	struct udf_inode_info *iinfo = UDF_I(inode);
-	struct folio *folio = NULL;
-	int error = 0;
 
-	while ((folio = writeback_iter(mapping, wbc, folio, &error))) {
-		BUG_ON(!folio_test_locked(folio));
-		BUG_ON(folio->index != 0);
+	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
+		struct folio *folio;
+		bool dirty = false;
+
+		folio = filemap_lock_folio(mapping, 0);
+		if (IS_ERR(folio))
+			return 0;
+		/*
+		 * Recheck inode type under folio lock when we are protected
+		 * against udf_expand_file_adinicb(). Bail to standard writeback
+		 * path if file got expanded.
+		 */
+		if (iinfo->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB) {
+			folio_unlock(folio);
+			goto mpage_writeback;
+		}
+		if (!folio_test_dirty(folio))
+			goto unlock_folio;
+		if (folio_test_writeback(folio)) {
+			if (wbc->sync_mode == WB_SYNC_NONE)
+				goto unlock_folio;
+			folio_wait_writeback(folio);
+		}
+		if (!folio_clear_dirty_for_io(folio))
+			goto unlock_folio;
 		memcpy_from_file_folio(iinfo->i_data + iinfo->i_lenEAttr, folio,
 				0, i_size_read(inode));
+		dirty = true;
+unlock_folio:
 		folio_unlock(folio);
+		if (dirty)
+			mark_inode_dirty(inode);
+		return 0;
 	}
-
-	mark_inode_dirty(inode);
-	return 0;
-}
-
-static int udf_writepages(struct address_space *mapping,
-			  struct writeback_control *wbc)
-{
-	struct inode *inode = mapping->host;
-	struct udf_inode_info *iinfo = UDF_I(inode);
-
-	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
-		return udf_adinicb_writepages(mapping, wbc);
+mpage_writeback:
 	return mpage_writepages(mapping, wbc, udf_get_block_wb);
 }
 
-- 
2.51.0

