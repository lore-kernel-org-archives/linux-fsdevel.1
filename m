Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6301446C00
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 08:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791793462; cv=none; b=BruPNrABId6pL91DHwVfSIp4DTuPzxAseNffbImnppJaZpGOFnpJApw/F3rkA33lirP+C9SU6oYeus+PxP7gOBQiE9NJNiAjwFRz7mreqgKguRtbupfG+BqFRvzK6tjoxx710K03uY7smEzDi+bS96K6vd0OEU1BgWggnsUtNVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791793462; c=relaxed/simple;
	bh=doSl7XwBgbwlZmLOj7HhzP4E5NF4QH+660GbTlfCOcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLhGAip10kqWzG0kUEmQYZ/rgj0lIq16NG5HQ4bxQsDY0xQOQ+34Gsbr5reKg5Xk3otjV2iEN6L+HfCpsmFvBroo6/SIK7vIHKIPnvBqGEBkoeH7AzhlfPbnBgAHWatKfcOcEOqdHz9A2+Fv7kjDUMxstKcYFOKThNw4aZkUrfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=h6gjn1W+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5SkmMt+b; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nEffw800; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lzZ7p/zC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="h6gjn1W+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5SkmMt+b";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nEffw800";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lzZ7p/zC"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8A5D41F45A;
	Mon, 12 Oct 2026 08:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791793453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vi+bzvsD8E4CJNzOzEeUuEWE3GljGIIRGGXMdCc2Rjw=;
	b=h6gjn1W+tzK6MQnnGa2c/NKUA+tn0Nol4a/1+1ALRaG/ocg4Q+zbQSlu++EIqeCEQR0SVf
	iHgrES4j9xrH2tozw2GKB/Ld3i/9phH8QrQkheyNI9z61Xlg8clzI0TYVCDg0/0fAx9p4X
	04Oq2rKHJSZhG3jObrYVyFgUxki1PKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791793453;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vi+bzvsD8E4CJNzOzEeUuEWE3GljGIIRGGXMdCc2Rjw=;
	b=5SkmMt+bgAYS7QknQJNX0vhiLXUIHmhRVMEpzXyhcAZcRsbyYFa5gRGte20vs6/tsgjbWt
	kzLQSLoBLdSViBAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791793452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vi+bzvsD8E4CJNzOzEeUuEWE3GljGIIRGGXMdCc2Rjw=;
	b=nEffw800uNSgigZqhvwVWqtqkwmsKqXlU31fGKOp5muBF1W53CEIpD3c1TG4Fz5NN9eS1K
	k+vg2c0mfrBnS8yxYJsWqDgWIeaykVTjqV6ZFQHldMeyalZpqu+XzyHeC52b5fBsxsxTKB
	z9AohqBo5Iu0360HaW0VdP2wzg8N13I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791793452;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vi+bzvsD8E4CJNzOzEeUuEWE3GljGIIRGGXMdCc2Rjw=;
	b=lzZ7p/zCddCJlhXvIBy1bfa5kLdDLZhYy96xX5qdwEDK3OLbowD/9ok0vNUDMryyeli+sr
	SfPH3WvjXTqEwrCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8F91139B1;
	Mon, 12 Oct 2026 08:24:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dyj/LSuZzGocHwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 12 Oct 2026 08:24:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B04A1A140F; Mon, 12 Oct 2026 10:24:10 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: <linux-mm@kvack.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Mikhail Rudenko <xyzzy@yandex-team.ru>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 7/7] ext4: Defer inode reclaim if it has preallocations
Date: Mon, 12 Oct 2026 10:23:45 +0200
Message-ID: <20261012082356.3121725-14-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261009133253.20102-1-jack@suse.cz>
References: <20261009133253.20102-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1087; i=jack@suse.cz; h=from:subject; bh=doSl7XwBgbwlZmLOj7HhzP4E5NF4QH+660GbTlfCOcI=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBqzJkiIqTi8A+6iwev57YKHpZUBj+QsAzBktcnM fhmESSEi3yJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCasyZIgAKCRCcnaoHP2RA 2UbvCACmwzIBozO5WKYTaTXpO6JD5I3fOaNymfLjuJyLLcn+ebh4Z5Kz7UMrfCe5D6z626IhBKQ ov9yEysLY/Oi0rQiNJxjRO4kmzS+YtSlCQhRGccNgD7h4jya0ATD+efjtQFctvuIYNVbdF7PyPW tBYzXFKRA1yQ5U323We31ZH68mMegT1lzDF8CPtdVQ9U5KqLmlFh2eXQYU82WmyjSqXApa4Lpvq vjIhUXiwtE3I4JfnI8dZiXJlEYN8n4PZN5gE8dKxmKENXAkyn2zEEC4mIv8RJ+SsX536qXXe11A RVDPrMbJh2WrsbTYdu76WTpRaVumBM+RdG13pJBdlqosE3Q2
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]

When we have to free preallocations during inode eviction, we need to
load block bitmaps and run transaction to modify them. This takes time
and also requires GFP_NOFAIL allocations. Mark inodes with preallocated
blocks as needing offloading of inode reclaim to a workqueue so that we
don't block reclaim for long and potentially deadlock MM subsystem.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 06171a11db12..4891f252105e 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3115,6 +3115,13 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
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
2.51.0

