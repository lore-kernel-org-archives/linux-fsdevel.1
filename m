Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC08B34AAF6
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 14:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774534019; cv=none; b=XeSLJ3gZcxI5gl0ERpOO8Q9jmkDwC9rOxL2hd0UdQj/3dfu/Y8iw4yvis2qXSanWXnXgG+eBFUWLmE1DVACjkcC1gS7fEvu6mjRQARy2p3duQO4znkuid5vF1fHS42YEYwmXbcCfiYXb4RXKhkaXrs7EDGLbVsUKWCCxdc72RGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774534019; c=relaxed/simple;
	bh=5URDOT1jUOeb01OM+wHhdYPyB6xwH29HnTVJX85lzag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JuMIShpd/dLHLBf3SMItt95EeLD9BFagofOxyggwllUaXh5Tb79KCLyqMQtjiDV51MzQd5V2I5Iyd6IeMMpfyNQFo1fzdMfivC1Umt8FCYYP6acu3IMRE8VXOvrraInOG+F6ZWFVY+PV0pZM8Sbm1KG34oJoHcOs7Ki5SmOFk+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AHyw0B94; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rhdlaIC+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AHyw0B94; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rhdlaIC+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AHyw0B94";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rhdlaIC+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AHyw0B94";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rhdlaIC+"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B3BBE5BD1D;
	Thu, 26 Mar 2026 14:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774534010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sqswnKWDD6RtMYHDdLpy72OrQo5OgSUZjB3BLH9Bkos=;
	b=AHyw0B94JKglXUsLiGXNIl3Tan+mceG70peZgoyWghnALmUzgDrS1b93JcAVFP9URzxRFI
	C0WaEg7CCsTgKXC218H91JBYatHW6A3pzjcamhBTvYYJaH7ovHPeepBF4BCa0/CsCfIJq1
	BK4X9G8YDW5oicC91qXxN1cdr/VKzJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774534010;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sqswnKWDD6RtMYHDdLpy72OrQo5OgSUZjB3BLH9Bkos=;
	b=rhdlaIC+bM7znHQQ2xaZABxeAerm7U5VZ0d+mILqV/P6sL5MUirp8OXXjjp+sykzRd3mT+
	ftOz9Eac+Gz7YiBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774534010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sqswnKWDD6RtMYHDdLpy72OrQo5OgSUZjB3BLH9Bkos=;
	b=AHyw0B94JKglXUsLiGXNIl3Tan+mceG70peZgoyWghnALmUzgDrS1b93JcAVFP9URzxRFI
	C0WaEg7CCsTgKXC218H91JBYatHW6A3pzjcamhBTvYYJaH7ovHPeepBF4BCa0/CsCfIJq1
	BK4X9G8YDW5oicC91qXxN1cdr/VKzJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774534010;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sqswnKWDD6RtMYHDdLpy72OrQo5OgSUZjB3BLH9Bkos=;
	b=rhdlaIC+bM7znHQQ2xaZABxeAerm7U5VZ0d+mILqV/P6sL5MUirp8OXXjjp+sykzRd3mT+
	ftOz9Eac+Gz7YiBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A807E4A0A6;
	Thu, 26 Mar 2026 14:06:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fNr+KHo9xWnBDgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 26 Mar 2026 14:06:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5E02FA0B57; Thu, 26 Mar 2026 15:06:42 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Jianzhou Zhao <luckd0g@163.com>
Subject: [PATCH v3 2/2] udf: Fix race between file type conversion and writeback
Date: Thu, 26 Mar 2026 15:06:32 +0100
Message-ID: <20260326140635.15895-4-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260326140257.15908-1-jack@suse.cz>
References: <20260326140257.15908-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2897; i=jack@suse.cz; h=from:subject; bh=5URDOT1jUOeb01OM+wHhdYPyB6xwH29HnTVJX85lzag=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpxT1s6z7ZxY33P6rrNmotZpfs3a66QX8fCWiNU pWOZjOfh7SJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCacU9bAAKCRCcnaoHP2RA 2bHJCADYy6xi3KAOo5AkTBqgG2NUe0GuHEpf+iEudwzHpmjrVGcIMfH0wtCWJwICEPKPa5KvpB3 IW/UHjTMGYxc13pjq5byaYuLrSTQyteUpz1V0fIvBkvIibxnC8WBffMcQoUSAqAQKyrhxhA4HnE +57wefDE3HbRV7VvEZIdq3v8CYNlCIV/sxkRRd+7J+YrxaDnSYzL6IOYnFyPSYEuJaiL3ogOmIB l6wOyJFBSfvs7cniDWomHg8MeDvPEj/LA1pNrXd+IEIU4SUtuF2UqzHqkhBf4AeHm0pfQ3GumsA 3XOL7wm+iMVqg49DEdeGnVlujaF+14D2ilFQIRtvZOyxxmn2
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.989];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,suse.cz,163.com];
	FREEMAIL_ENVRCPT(0.00)[163.com]
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 

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
 fs/udf/inode.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 7fae8002344a..23e894092dab 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -181,22 +181,23 @@ static void udf_write_failed(struct address_space *mapping, loff_t to)
 	}
 }
 
-static int udf_adinicb_writepages(struct address_space *mapping,
-		      struct writeback_control *wbc)
+static int udf_handle_page_wb(struct folio *folio,
+			      struct writeback_control *wbc)
 {
-	struct inode *inode = mapping->host;
+	struct inode *inode = folio->mapping->host;
 	struct udf_inode_info *iinfo = UDF_I(inode);
-	struct folio *folio = NULL;
-	int error = 0;
 
-	while ((folio = writeback_iter(mapping, wbc, folio, &error))) {
-		BUG_ON(!folio_test_locked(folio));
-		BUG_ON(folio->index != 0);
-		memcpy_from_file_folio(iinfo->i_data + iinfo->i_lenEAttr, folio,
-				0, i_size_read(inode));
-		folio_unlock(folio);
-	}
+	/*
+	 * Inodes in the normal format are handled by the generic code. This
+	 * check is race-free as the folio lock protects us from inode type
+	 * conversion.
+	 */
+	if (iinfo->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB)
+		return 1;
 
+	memcpy_from_file_folio(iinfo->i_data + iinfo->i_lenEAttr, folio,
+				0, i_size_read(inode));
+	folio_unlock(folio);
 	mark_inode_dirty(inode);
 	return 0;
 }
@@ -204,12 +205,8 @@ static int udf_adinicb_writepages(struct address_space *mapping,
 static int udf_writepages(struct address_space *mapping,
 			  struct writeback_control *wbc)
 {
-	struct inode *inode = mapping->host;
-	struct udf_inode_info *iinfo = UDF_I(inode);
-
-	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
-		return udf_adinicb_writepages(mapping, wbc);
-	return mpage_writepages(mapping, wbc, udf_get_block_wb);
+	return __mpage_writepages(mapping, wbc, udf_get_block_wb,
+				  udf_handle_page_wb);
 }
 
 static void udf_adinicb_read_folio(struct folio *folio)
-- 
2.51.0

