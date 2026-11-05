Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793888037;
	b=kTqviF2hpvSnoG4Voom67/0ywecD6pefGgx8wgLM0C+afxs6R4+S0pmInnOgomS+yprK
	 XpaWVkifj5no7fyhA/3cGXLTSWSdy42p4BskvsWP288YnG5xdMfzl+4YZ4F5/yzR/8Z8o
	 5C+LoVO1QJd/gVYkXgyTm1gfIy3MdczPz3fehH+I/i26mtAHXdDhUAyRcK+h0VTRpJwOb
	 wJZTaHdWGcMN4OV8/w99XscQMTBk+7NONAYhkjvNyDfUN0YJQD+//lCwZlULVSnmtuo0M
	 qyMpnGOD6CYPboteR/zUxp25Yt8CTV8h8s5X5pf2nmpDU/yBUU1ATT0DkJU6BlAhdkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888037;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=++gX4nBdQG/f/V126vbbXgIopFhKDy6QkBYtSpzb1Tg=;
	b=eP99ymR/cGm00vF0wzvdT94YuBTquFBo4JOw89VU5EH7HIY5dGqX6vWQSuXqLwMsE7ED
	 YnQ6Onn9vbLt+wXSCz9b7HmtowaJMxdIr0pBJHkrDtkVtsxijx/nTqyJuJ8xLXI9qDppU
	 FC9aTI5usNZPRUd1MhLqG0YpYy3C0qu1E4igOBheJCeMZNgHG9qRp/6ymmads5nim6JZ9
	 YA7+RGvrHww22aL4FD5WTFYMOufTNU/ludSbVkV/gahCW2oXjAJouHei0FPVlJMfjt75l
	 egnl9bnDE1B68LFZqtnGqaze+S+tUmXx5zPv0VAwzjinKk3vaDspFAe+tJYoauiVWKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="jj6u/R7z";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0Unfvu+L;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=o7yvw8vM;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=koewNcLK;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D635606A333
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 14:13:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D635606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=jj6u/R7z;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0Unfvu+L;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=o7yvw8vM;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=koewNcLK
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 986FC21EEF;
	Thu,  5 Nov 2026 14:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793888034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=++gX4nBdQG/f/V126vbbXgIopFhKDy6QkBYtSpzb1Tg=;
	b=jj6u/R7ztlzA18uOhIWn3Fm6ary/ooD0HzROuFmU+rVe/+kcN3Zf+T5HgI3FotjLXtuRht
	RpV1U30ZFPXojdLp7NNCtPMSns3QPbSRxlnTvHUM7iffgnm1qln6L7zLqSOzEhsZfaWZ9X
	xheB52mgmUjjDnScJfGglIaqEKZzYmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793888034;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=++gX4nBdQG/f/V126vbbXgIopFhKDy6QkBYtSpzb1Tg=;
	b=0Unfvu+LkHcesMtnTP9SEfOPlbttAZSPNjRhMaZoY9z/D6xpyn/xgGIZqC27ep0OmK1KHk
	2v3uijhZyE9+VHDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=o7yvw8vM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=koewNcLK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793888033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=++gX4nBdQG/f/V126vbbXgIopFhKDy6QkBYtSpzb1Tg=;
	b=o7yvw8vMLn89Ch4MKnA1t3SHkoFI+sPRB7i3zUD074AO0YELrUSHFdSS78nQHi25LScBtL
	R8QPL4AN378wrt5KOZlZeWktqfhjhkoP93JH7vw8n6c6GmAtWN99ChReHYUEp2Zd1t1JmI
	dsK5EANWa7cW25JOWC2mdPJa27JhM44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793888033;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=++gX4nBdQG/f/V126vbbXgIopFhKDy6QkBYtSpzb1Tg=;
	b=koewNcLK8FzYDf9/dEvtOc1B4QzPZ7OJt/zuUYC47FZoWA57QunP21CSjwrM/+c5O476ef
	ePTCAbjwaHdw1sDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F787133F6;
	Thu,  5 Nov 2026 14:13:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sjO7EiGP7GrbFwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Nov 2026 14:13:53 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 00311B71C; Thu, 05 Nov 2026 15:13:48 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Matthias Goergens <matthias.goergens@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] udf: Simplify udf_table_prealloc_blocks()
Date: Thu,  5 Nov 2026 15:13:44 +0100
Message-ID: <20261105141344.279527-1-jack@suse.cz>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-12.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,epos.bh:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -12.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 986FC21EEF

Simplify handling when the specified extent is not found in the table
of free blocks.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/balloc.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

I plan to merge this through my tree.

diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
index 75124188e745..b6551cc7c6cf 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -525,30 +525,22 @@ static int udf_table_prealloc_blocks(struct super_block *sb,
 
 	while (first_block != eloc.logicalBlockNum) {
 		ret = udf_next_aext(table, &epos, &eloc, &elen, &etype, 1);
-		if (ret < 0)
+		if (ret <= 0)
 			goto err_out;
-		if (ret == 0)
-			break;
 		udf_debug("eloc=%u, elen=%u, first_block=%u\n",
 			  eloc.logicalBlockNum, elen, first_block);
 	}
 
-	if (ret > 0 && first_block == eloc.logicalBlockNum) {
-		epos.offset -= adsize;
-
-		alloc_count = (elen >> sb->s_blocksize_bits);
-		if (alloc_count > block_count) {
-			alloc_count = block_count;
-			eloc.logicalBlockNum += alloc_count;
-			elen -= (alloc_count << sb->s_blocksize_bits);
-			udf_write_aext(table, &epos, &eloc,
-					(etype << 30) | elen, 1);
-		} else
-			udf_delete_aext(table, epos, &freed);
-	} else {
-		alloc_count = 0;
-	}
+	epos.offset -= adsize;
 
+	alloc_count = (elen >> sb->s_blocksize_bits);
+	if (alloc_count > block_count) {
+		alloc_count = block_count;
+		eloc.logicalBlockNum += alloc_count;
+		elen -= (alloc_count << sb->s_blocksize_bits);
+		udf_write_aext(table, &epos, &eloc, (etype << 30) | elen, 1);
+	} else
+		udf_delete_aext(table, epos, &freed);
 err_out:
 	brelse(epos.bh);
 
-- 
2.53.0

