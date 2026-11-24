Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795521549;
	b=LKCuuGbPj8ukI1zWyh18J7pLgcNGxAiWFMuwiE/wOzGUgqFtej9c5mivQAIx5ro3khyt
	 Bv7EezMLC9c5N+6Hso0pSXm8WV/vFAxXtZCGCQ8se3whGZVngkXL3XJ/HYFvB8jA2sPUD
	 3LtPTp/9lZgHtDllA0jUvOWcyNaLBKG6PDS/ZTa2E3O+v+fScbO2YI7QBZg0hksLXEL3u
	 A5UcoFnDlGdZ/b1px3W4dBgYG0iibnQL+R/dtmoAWi2VH3zedMDnivmB2+Ejk6nnpX+d+
	 jvNLe1cY3RAtW7jIf47Uw2wHLYOMsjck+G0JMwh2Ivap12HzKUGHgDrdPla7QZ/D8mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521549;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=lOrzKYoXAZDsQinXLLtvPKctVW1W6s+qcE9bVHQLxXg=;
	b=2k2UyvK+E3kmSbmOmpXo5+xDEENmcO+ai7wfuxBznScyPIU5jFP7jLpQrQhybSW8HmV1
	 /0MIX9vlsDuHnLrzm1Gxnx8eh1UWm6BpYFm9frhEPgQ+kLcNc3hEGq7VpwE/LoTelUS1I
	 kcXrJv6MjDfVTV8pJ3jrOzgVbPmfGF3e4pvX+xFUMUp+ZfRZnAPOCalZ2yUuiiXj9PFsq
	 v8NDqoa5cRcV9UITBTFQI5QSm73bO8DO9fePSKY7cNE9Tu9sivaSgafnQTUaBi5QOygQf
	 yWMNIP3QWE+McGjuqUCi5JDXPNwXgw/MXI9GaVGelPc+TUf3QRxIaC3KoZJfbGs/Ghw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=ctl9NT1p;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ag30EA4y;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=ctl9NT1p;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ag30EA4y;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBA4606A32C
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 11:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FBA4606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=ctl9NT1p;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ag30EA4y;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=ctl9NT1p;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ag30EA4y
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7E6122224C;
	Tue, 24 Nov 2026 11:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795521547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lOrzKYoXAZDsQinXLLtvPKctVW1W6s+qcE9bVHQLxXg=;
	b=ctl9NT1pjBurcDjdlw+QTY4xCR59C1IIQtqcufQDK3nJxk8G3/H+2litKKUXVWiWTSPNmV
	FieV2XXTyihQExoLfMnGAAJEw4789KQc5IUW3LHex7FotPhIQg4Q4pkTZfm1z8A0UHGWLD
	WBKBUX5Vuw+TajZWMAyLxlRV+vbrDz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795521547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lOrzKYoXAZDsQinXLLtvPKctVW1W6s+qcE9bVHQLxXg=;
	b=ag30EA4y20Rkr9s/7LKjtdF8/4QPBxJeLV/3ILvQkwPOwA9140T1+Xer3Es2IUMVAz5XmX
	n/NBxhgj0t6MojBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ctl9NT1p;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ag30EA4y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795521547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lOrzKYoXAZDsQinXLLtvPKctVW1W6s+qcE9bVHQLxXg=;
	b=ctl9NT1pjBurcDjdlw+QTY4xCR59C1IIQtqcufQDK3nJxk8G3/H+2litKKUXVWiWTSPNmV
	FieV2XXTyihQExoLfMnGAAJEw4789KQc5IUW3LHex7FotPhIQg4Q4pkTZfm1z8A0UHGWLD
	WBKBUX5Vuw+TajZWMAyLxlRV+vbrDz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795521547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lOrzKYoXAZDsQinXLLtvPKctVW1W6s+qcE9bVHQLxXg=;
	b=ag30EA4y20Rkr9s/7LKjtdF8/4QPBxJeLV/3ILvQkwPOwA9140T1+Xer3Es2IUMVAz5XmX
	n/NBxhgj0t6MojBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2FE291339F;
	Tue, 24 Nov 2026 11:59:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l7KAAAt8BWtOZAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 24 Nov 2026 11:59:07 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id E5B622784F; Tue, 24 Nov 2026 12:59:01 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	<linux-mm@kvack.org>,
	Mikhail Rudenko <xyzzy@yandex-team.ru>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 5/8] fs: Defer reclaim of inodes requiring metadata writeback
Date: Tue, 24 Nov 2026 12:58:49 +0100
Message-ID: <20261124115850.3512-13-jack@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124113450.3451-1-jack@suse.cz>
References: <20261124113450.3451-1-jack@suse.cz>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1029; i=jack@suse.cz; h=from:subject; bh=NcANvdLSL9uTS5c3IhPYy4gJEYBnvTX5TIsYlIvC2eQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBrBXv9NiH28xvLtQaw6a4N1+JoA2cI8CjwCjIjr FKjea+2GaKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCawV7/QAKCRCcnaoHP2RA 2W/SB/9W9eMDjKT3yZZH1RdHbjoa5Ownf/H8POAlcfH0v9fD4RPNdlFLC0p8Zto6Btk3jWn+iz2 lw3byuu1P1GCdFX4v9hXtFYbQ+dUcXqv9YiY8DF5qEY7XGqatokNBon6HG78Au9/x3sf9n2c1Tn hSm9oU2lP+TAUYdO2teBr2jiLv2ad+zG2hHkhFW2L0O6U6+1uYJig0qeIwva20xYpvwzj+jS24s pbLm6OMSJQMjHf5BgVMhcRSfj50YwHVStGBPtQLL3ue2boVJ7vIfvXo/16KdJ5dbG+saDFiF1h3 smMGuV67yFnLe1yO7r7OD6J9ea2LSlt6EV2SlVCcDlikSevI
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7E6122224C
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -12.01

When we are reclaiming inodes which have I_METADATA_WRITEBACK set, we
have to callback into the filesystem to write out any dirty metadata
associated with the inode since we are going to loose track of it. This
will require IO and is problematic from memory reclaim paths. Defer
reclaim of inodes with I_METADATA_WRITEBACK set.

Reported-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 4ffafb101718..760c730f4a9f 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1083,7 +1083,8 @@ long prune_icache_sb(struct super_block *sb, struct shrink_control *sc)
 				     inode_lru_isolate, &freeable);
 
 	list_for_each_entry_safe(inode, tmp, &freeable, i_lru) {
-		if (inode_state_read_once(inode) & I_DEFER_RECLAIM) {
+		if (inode_state_read_once(inode) &
+				(I_DEFER_RECLAIM | I_METADATA_WRITEBACK)) {
 			deferred++;
 			continue;
 		}
-- 
2.53.0

