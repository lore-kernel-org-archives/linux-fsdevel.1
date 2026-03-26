Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA67345741
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 14:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774534013; cv=none; b=FzE+/+o3AHmWwwZVsFDy+kq38Uo+CYvMcNv/VWcDXZjs+4+bnz0/k6OPtyT6z5/iuzY1aJhFaNJL5zP7s5MvISsaVDA/hf4TdvfN2eNMOIb+X/DngjHcbV//fpmfbg8p2vizweDQakjwGY9zdiaR00Rd32MGonGE5DiO8463EFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774534013; c=relaxed/simple;
	bh=JhMy/iHlwlyRYT1YUHqsIg1XlqHaZnQlQ+7hIwhi2HU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpzCWKTOec1IPAzne1WrJ5/KEgKkQkvSxiNlNHI+a3juA9AliEqAw7e54pyTH4cpaw9CG8dRjRGYktLV9BNfWRk2nvHEIkBTQ5pYpQbCihAuttANW9MsJLGOZ7lcJIyzPqXVw6rrtHdvw0WBzGQM9BQlY9SgHnCo3lkUhpixseI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jM7ol5R/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XI16ux8c; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jM7ol5R/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XI16ux8c; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jM7ol5R/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XI16ux8c";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jM7ol5R/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XI16ux8c"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B99AA4D2B5;
	Thu, 26 Mar 2026 14:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774534010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=56SYl4wN1cV5bF8lILV/KJbGoDkwNtKfH8MM/AN2vjk=;
	b=jM7ol5R/eE19QiFwAhd4zfRiMPM04Bivf4tU6uH+4/E6U853tgCuiQTTbSEqkoNYgFzkxz
	EhBndCO5z20/T2rngcOsBbq8F9g9YwnPt9uGytypMLHxQKEQFcqkwqXqq2NLtb1oqPo8jB
	qmkD+XQPPLb/XclsYp4hhh+vh+1YgpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774534010;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=56SYl4wN1cV5bF8lILV/KJbGoDkwNtKfH8MM/AN2vjk=;
	b=XI16ux8ce8XjD17TMUaz/xwcGVxAFi2mr4U8OXkAEHv63PZfhJ2VGxPZYT5D/OitJ/O+32
	574DiDojJijkCyDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774534010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=56SYl4wN1cV5bF8lILV/KJbGoDkwNtKfH8MM/AN2vjk=;
	b=jM7ol5R/eE19QiFwAhd4zfRiMPM04Bivf4tU6uH+4/E6U853tgCuiQTTbSEqkoNYgFzkxz
	EhBndCO5z20/T2rngcOsBbq8F9g9YwnPt9uGytypMLHxQKEQFcqkwqXqq2NLtb1oqPo8jB
	qmkD+XQPPLb/XclsYp4hhh+vh+1YgpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774534010;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=56SYl4wN1cV5bF8lILV/KJbGoDkwNtKfH8MM/AN2vjk=;
	b=XI16ux8ce8XjD17TMUaz/xwcGVxAFi2mr4U8OXkAEHv63PZfhJ2VGxPZYT5D/OitJ/O+32
	574DiDojJijkCyDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9FE74A0A7;
	Thu, 26 Mar 2026 14:06:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YbgJKXo9xWnADgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 26 Mar 2026 14:06:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 57B54A0B3C; Thu, 26 Mar 2026 15:06:42 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v3 1/2] mpage: Provide variant of mpage_writepages() with own optional folio handler
Date: Thu, 26 Mar 2026 15:06:31 +0100
Message-ID: <20260326140635.15895-3-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260326140257.15908-1-jack@suse.cz>
References: <20260326140257.15908-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2862; i=jack@suse.cz; h=from:subject; bh=JhMy/iHlwlyRYT1YUHqsIg1XlqHaZnQlQ+7hIwhi2HU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpxT1rOtDgPXPlOhTOtqLms5WlxodHXG2Oa3Yqc EzjyJWKajqJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCacU9awAKCRCcnaoHP2RA 2ZQmCAC1udjRNRMTviTiGvWIz1XLk62jzuAFotBZ6Mz/1plsBCkh9dAHhvj+gNJVhIVldkgylSe Lq/zArHcAEYU+whDdjJThvc3dhZqmOBRT8VmGpN9ryzWLouDT7R8M+uf/YpgtSMo2mDLtJpU47t SCCiQEf+Hb6xJwEEGb1G70kQazQknoXED0MQuLHQVEKX/SG4BN05ezSBjj+V4Bq/Djdk+8IB+OR Oq+/uxrn5W4U9eCmEopt3SmFioAyh9iGOXumUVSJMRmF1px5PDJ/VrL2QuvLpzhCb5gIIjz5QYx GGP+nA2ovNjuIWLzhXNQwFkg11iZPcL4ehaB2aR+G1kTmwAC
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.79
X-Spam-Level: 
X-Spamd-Result: default: False [-6.79 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.973];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email]
X-Spam-Flag: NO

Some filesystems need to treat some folios specially (for example for
inodes with inline data). Doing the handling in their .writepages method
in a race-free manner results in duplicating some of the writeback
internals. So provide generalized version of mpage_writepages() that
allows filesystem to provide a handler called for each folio which can
handle the folio in a special way.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/mpage.c            | 21 +++++++++++++++++----
 include/linux/mpage.h | 11 +++++++++--
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index 7dae5afc2b9e..9095f3f983a8 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -655,8 +655,10 @@ static int mpage_write_folio(struct writeback_control *wbc, struct folio *folio,
  * address_space_operation.
  */
 int
-mpage_writepages(struct address_space *mapping,
-		struct writeback_control *wbc, get_block_t get_block)
+__mpage_writepages(struct address_space *mapping,
+		   struct writeback_control *wbc, get_block_t get_block,
+		   int (*write_folio)(struct folio *folio,
+				      struct writeback_control *wbc))
 {
 	struct mpage_data mpd = {
 		.get_block	= get_block,
@@ -666,11 +668,22 @@ mpage_writepages(struct address_space *mapping,
 	int error;
 
 	blk_start_plug(&plug);
-	while ((folio = writeback_iter(mapping, wbc, folio, &error)))
+	while ((folio = writeback_iter(mapping, wbc, folio, &error))) {
+		if (write_folio) {
+			error = write_folio(folio, wbc);
+			/*
+			 * == 0 means folio is handled, < 0 means error. In
+			 * both cases hand back control to writeback_iter()
+			 */
+			if (error <= 0)
+				continue;
+			/* Let mpage_write_folio() handle the folio. */
+		}
 		error = mpage_write_folio(wbc, folio, &mpd);
+	}
 	if (mpd.bio)
 		mpage_bio_submit_write(mpd.bio);
 	blk_finish_plug(&plug);
 	return error;
 }
-EXPORT_SYMBOL(mpage_writepages);
+EXPORT_SYMBOL(__mpage_writepages);
diff --git a/include/linux/mpage.h b/include/linux/mpage.h
index 1bdc39daac0a..358946990bfa 100644
--- a/include/linux/mpage.h
+++ b/include/linux/mpage.h
@@ -17,7 +17,14 @@ struct readahead_control;
 
 void mpage_readahead(struct readahead_control *, get_block_t get_block);
 int mpage_read_folio(struct folio *folio, get_block_t get_block);
-int mpage_writepages(struct address_space *mapping,
-		struct writeback_control *wbc, get_block_t get_block);
+int __mpage_writepages(struct address_space *mapping,
+		struct writeback_control *wbc, get_block_t get_block,
+		int (*write_folio)(struct folio *folio,
+				   struct writeback_control *wbc));
+static inline int mpage_writepages(struct address_space *mapping,
+		struct writeback_control *wbc, get_block_t get_block)
+{
+	return __mpage_writepages(mapping, wbc, get_block, NULL);
+}
 
 #endif
-- 
2.51.0

