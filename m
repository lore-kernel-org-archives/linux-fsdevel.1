Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795521550;
	b=mCwHX/vlyjLov7dioyVZUjAzjAtDA4wKWbY/OSNoFX2Cpp3i0OXJ4mf7ceWGW6Vpopci
	 EeThRIGFrigFL3yG13jkgeX/JRJnNIyKQ1F0Qx5SuG34z3bHrOwjyBM7bdW8Xku+ZrZSc
	 k/r7lsK104DnjGTm27Zy1vmEJCuNZEIYMDKlUm30yCOd9cZRlxRqxnXrXHQNTnZZ92iYb
	 TTsB65WxYTnLJv8k6xP6jPkGbsrzQ35erJADrzTzGq7eyF/20P2G14IvXzH0IK53EXA2E
	 Kjscvo2dHAuddfibBIjOlN+BppN52QrQKMci5Pk7IMVU1QX6GkYXTJlHpYD9Mqzl/mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521550;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
	 X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=VqHNRpMmBb6Bj8xpyW6r4He0IHjzmwjAY09SSNXVEvQ=;
	b=wsGiSl2PhfiW0k821aD2WhSJHtkjg3KI6+zuMaTJiTToedImK4cH9s66XkBt5KugMltd
	 aMOqFkU1EPsR0NnieLsVOuLuCCizaZlgLyjX4VfWlc6LR//QlGvPzjz+v0jkgtFUQh+zd
	 63lLSK0awUcmCebMZJ1kBQs5U3DmXEpLwdvXooHeUcj+sCN7tvbvFAmHEd341GGAIDmHU
	 rNqsCnC2xxt/zHn4JRphTgmIP1wpPaADsWD3JbuJtBTY5LqqEyNLYJObiZ5gA1KMt0FGL
	 HxZHEFBciUerJbiW2A2l6RQh2JC1d1VSgr3GijAJgLnQAieehIH1cSWqfMAQ7qZCZPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=UrAvxO0T;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=OwvUBuBk;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=UrAvxO0T;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=OwvUBuBk;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE8E606A32E
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 11:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AE8E606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=UrAvxO0T;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=OwvUBuBk;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=UrAvxO0T;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=OwvUBuBk
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D0F141F452;
	Tue, 24 Nov 2026 11:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795521547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VqHNRpMmBb6Bj8xpyW6r4He0IHjzmwjAY09SSNXVEvQ=;
	b=UrAvxO0TSU9Ubl5Z0wZOtRGxFWIYb90mtsx3vRFmk8nHG7qPU9+Z2mQ6hpcDaj8KLmOKX5
	FQcPUWJICWO5YKbqpwJi1N1ReyLfUA/MDc3WK1T/PwuVggxsNqpOKx/pz9+cw0lJ2Ws51M
	IQDBgMczIbL0Rl0rEQgubfKmN3cqq+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795521547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VqHNRpMmBb6Bj8xpyW6r4He0IHjzmwjAY09SSNXVEvQ=;
	b=OwvUBuBkSY4H6zCoqrs100LydVmVtJONwgB0mZXXwK+Lh5lw+VTRd0a4AB2vMlgGOg/mo0
	0ffDgmC4A+/6tXDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UrAvxO0T;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OwvUBuBk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795521547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VqHNRpMmBb6Bj8xpyW6r4He0IHjzmwjAY09SSNXVEvQ=;
	b=UrAvxO0TSU9Ubl5Z0wZOtRGxFWIYb90mtsx3vRFmk8nHG7qPU9+Z2mQ6hpcDaj8KLmOKX5
	FQcPUWJICWO5YKbqpwJi1N1ReyLfUA/MDc3WK1T/PwuVggxsNqpOKx/pz9+cw0lJ2Ws51M
	IQDBgMczIbL0Rl0rEQgubfKmN3cqq+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795521547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VqHNRpMmBb6Bj8xpyW6r4He0IHjzmwjAY09SSNXVEvQ=;
	b=OwvUBuBkSY4H6zCoqrs100LydVmVtJONwgB0mZXXwK+Lh5lw+VTRd0a4AB2vMlgGOg/mo0
	0ffDgmC4A+/6tXDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 545D91376B;
	Tue, 24 Nov 2026 11:59:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id v4Q9Dgt8BWtWZAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 24 Nov 2026 11:59:07 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 025D227855; Tue, 24 Nov 2026 12:59:02 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	<linux-mm@kvack.org>,
	Mikhail Rudenko <xyzzy@yandex-team.ru>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 8/8] ext4: Defer inode reclaim if it has preallocations
Date: Tue, 24 Nov 2026 12:58:52 +0100
Message-ID: <20261124115850.3512-16-jack@suse.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2241; i=jack@suse.cz; h=from:subject; bh=5d0bhwSlVwQ2moUUqSxh3fmdkgNHJa3u6plV1bhKRNk=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBrBXwAxLIOrynhOetNAORZ//kv7Z/0JZmP5nrti l805u8MRcKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCawV8AAAKCRCcnaoHP2RA 2fkwCADuli0r0081nrS/BJ9HGHO6S2HEn0jB8ZM55mc3KOaZ0IoUsUsJzq+Lru5sjQO/rOLSTCI W1cZ9aULpPoSsGelPZ7WXvMmwfj9Kz5mjgCu0AAfZscds6F5ORqvhj2chvOTU3k+hbqG9Rje1eF +4J2m0UoNSEnZk6nR2MswuUlOabi/Iyx/UBaIkQMc1oJB58NeN49oJ12MvpiCMq7zPxbNikrj4k NasownurWyT9KweKiUhshImSHVF5pddOuCmKy/lSBJsbni6R7imN5lVsVhOf0KOy3v+/3s2NBPl oKMHoxZMJTxj0+7O9ZKTmZO4yug7JcetrZXPYuUx2IkDKTLy
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -12.01
X-Spam-Level: 
X-Rspamd-Queue-Id: D0F141F452

When we have to free preallocations during inode eviction, we need to
load block bitmaps and run transaction to modify them. This takes time
and also requires GFP_NOFAIL allocations. Mark inodes with preallocated
blocks as needing offloading of inode reclaim to a workqueue so that we
don't block reclaim for long and potentially deadlock MM subsystem.

We do the marking in ext4_mb_regular_allocator() to reliably catch all
the cases adding preallocated blocks to the inode and additionally when
adding delay allocated blocks (which will very likely result in
preallocated blocks in the future) so that deferred reclaim throttling
has a chance of throttling tasks generating the work.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c   | 9 ++++++++-
 fs/ext4/mballoc.c | 7 +++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e3129353d4ed..efc2f8ebe7ba 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2113,8 +2113,15 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map)
 
 	map->m_flags |= EXT4_MAP_DELAYED | EXT4_MAP_NEW;
 	retval = ext4_insert_delayed_blocks(inode, map->m_lblk, map->m_len);
-	if (!retval)
+	if (!retval) {
 		map->m_seq = READ_ONCE(EXT4_I(inode)->i_es_seq);
+		/*
+		 * Inode will likely have preallocations which are hard to
+		 * reclaim. Mark is for deferred reclaim early so that deferred
+		 * reclaim throttling hits the task causing the work.
+		 */
+		mark_inode_reclaim_deferred(inode);
+	}
 	up_write(&EXT4_I(inode)->i_data_sem);
 
 	return retval;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a15285224cdf..d138c4b697b3 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3113,6 +3113,13 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 	if (ac->ac_prefetch_nr)
 		ext4_mb_prefetch_fini(sb, ac->ac_prefetch_grp, ac->ac_prefetch_nr);
 
+	/*
+	 * Freeing preallocations requires loading bitmaps and running
+	 * transactions. Defer inode reclaim to a workqueue.
+	 */
+	if (!RB_EMPTY_ROOT(&EXT4_I(ac->ac_inode)->i_prealloc_node))
+		mark_inode_reclaim_deferred(ac->ac_inode);
+
 	return err;
 }
 
-- 
2.53.0

