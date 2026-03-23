Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B322737B02A
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 16:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774283442; cv=none; b=I/gJxZ3Are+OBuYF4KZByxGm4K7sWNLr4X/CFdFKWCZOSQXJlRGaJ1o4PZ9smV1kX/AeLRTQZ2FfxJ/R/m9G5dcIi3qaxbFzH4MnLKH3z1m+et1f/c8Blic/GtvSl+qZWFXTZhKhYkeuO1YI6+9H6zwd5YsLCKbq5qwu6wCN34k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774283442; c=relaxed/simple;
	bh=OGtjOocrdKlqdiQI/dLkm6fbhUNhmW9EfdpUfc3cwlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KGUYMJmwl9/ODD/5b5y+JGU5kyRyp9RdidjfLD8OEdmPkuQkAxgJfjQfmaY+F8jA65kwVw540NLHj9ILyjo23bnUUOI41f0BRfXv9X7iUgTJ8VOlIsfHpnUoMZrU22c+5usgSaw/+pSdHXcLXroDU5ucfC/ASwJ6ZBGjxNoYxvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=24Luw+Zi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b8AtuUMm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2Zcsqt/C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q+fbfhhz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="24Luw+Zi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b8AtuUMm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2Zcsqt/C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q+fbfhhz"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0DF365BE42;
	Mon, 23 Mar 2026 16:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774283433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i5iuLS0psgv4UG8NJ/JK0vW/OF0QFB3QPjhdjzpUBtM=;
	b=24Luw+Zib8abmfPFof4TwsNu04kCpEOSr4001cUnVAelXrgllci1V58YTHqZ/v8BDYBjc9
	AyrzP6i/t1nfuBIMPNM+OXECbWbjPFntL1kYX2itWnAo5BFTWsWZl2XBT0FEsBJa8Qah9W
	BoZc8ubauZnlBBfo4dFDGZwgl83inI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774283433;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i5iuLS0psgv4UG8NJ/JK0vW/OF0QFB3QPjhdjzpUBtM=;
	b=b8AtuUMm7kSBU/govh+vlhMS6Zss7tx58cCkgwz4xlt5WuLG/Yg8SXOg4FHqtHIMjeuSQm
	ykC4qMw4n9/7cRDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="2Zcsqt/C";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Q+fbfhhz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774283432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i5iuLS0psgv4UG8NJ/JK0vW/OF0QFB3QPjhdjzpUBtM=;
	b=2Zcsqt/CyowgVP56Qowv78KB2Sv/kq5rICPB9xRd94WPsQKh/thw0vCGRKKf/nqUVIqM2w
	YijCTKE9bof9FrdmsO+OLodhLlHVW7U4pfsEQf7z/NvSCANoG9xZZDpqbUfTqqPYkyR7To
	PzMg/L6p7K5XLiXThgKAbn97u7KOYlY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774283432;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i5iuLS0psgv4UG8NJ/JK0vW/OF0QFB3QPjhdjzpUBtM=;
	b=Q+fbfhhzdZqMWDwz1BK8FGkc+ErwaOq+pNxisuAR1orr3uZV/ZT0Zr01cBbIYbTAFZozlN
	WroFkOxR105JhFAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 042CF43982;
	Mon, 23 Mar 2026 16:30:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NiD9AKhqwWm5IAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Mar 2026 16:30:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C15F9A0B52; Mon, 23 Mar 2026 17:30:27 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: <linux-mm@kvack.org>,
	Jan Kara <jack@suse.cz>,
	Jianzhou Zhao <luckd0g@163.com>
Subject: [PATCH 2/2] udf: Fix race between file type conversion and writeback
Date: Mon, 23 Mar 2026 17:30:12 +0100
Message-ID: <20260323163015.3734-4-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260323162617.2421-1-jack@suse.cz>
References: <20260323162617.2421-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2889; i=jack@suse.cz; h=from:subject; bh=OGtjOocrdKlqdiQI/dLkm6fbhUNhmW9EfdpUfc3cwlI=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpwWqYOmwFD8j2urUJzv7/cLydciVl2UeoswRcJ BTSLcAUzOiJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCacFqmAAKCRCcnaoHP2RA 2XYgB/9V8mQRIPq9vDoBcx1bRAbmrW1/uL/mI4rfohUfnFh/qEkQZtyM3/QN03HnY8cEM/W0028 w2s0CpKdbvsvXyC33a7GwXIo/DOz62sTIWa2IU6JsnFyVzKd/0egxhm/+jxuzI+ZiOM83zYx0+b Rg5ubVg82HBb4qWSEcGkgdZjipqjhikuDbqqgimiPpRvdt7HPmkiDL7co2aPsTnxUq5ex++Mzkf owMvK7cZjli3eTLmJQ2ygWh5+QpGAYlhu088hkXzKGuhIgQMhF8ASDPr/VpvhRmNN3rcjWHLame 7AHapxq4ZT+eyKe2n4wW+V5dhQgZgOEzXP1qCeakSXCP1neE
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim,suse.cz:email];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim,suse.cz:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,suse.cz,163.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[163.com]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0DF365BE42

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
 fs/udf/inode.c | 44 ++++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 7fae8002344a..8ca73893ce2c 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -181,34 +181,38 @@ static void udf_write_failed(struct address_space *mapping, loff_t to)
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
+
+		folio = filemap_lock_folio(mapping, 0);
+		if (!folio)
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
+		if (folio_prepare_writeback(mapping, wbc, folio)) {
+			folio_unlock(folio);
+			return 0;
+		}
 		memcpy_from_file_folio(iinfo->i_data + iinfo->i_lenEAttr, folio,
 				0, i_size_read(inode));
 		folio_unlock(folio);
+		mark_inode_dirty(inode);
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

