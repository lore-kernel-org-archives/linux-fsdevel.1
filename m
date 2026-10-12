Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA23E455637
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 08:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791793462; cv=none; b=FM4Lo6LcK8ziQjmUscCEqoxMKRiXYzwiPnWlbihLxI+8Bk9xZ2zB59i7jovZDVDFllWHuY9i5/HUKqyTcUjVyRk+DkJxGNRrvk7yyxHEJlx0obykBjS1uoC3xwB/mOYuCQ+JXS2aufngj730VTZt6pko4Ih2DXvLN8qobuyiqJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791793462; c=relaxed/simple;
	bh=q/GSyAYlC73bY1ffIrf+AcoWWY6+CO3n77kKwbH1Z0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N9ERQ5p+0OpqWSbCI7DPd39cE9w2GKxkPaD3dR2RqNgTMQnakXCrWjtWMp/bvlvKVHoXFGYn821e3LPMwdtoWci6p8Nb5JqDGhVIP2QZt5K6X3Ay4S545JQ7QyCf1Jw2+135SR13vPpJMbknFjw9pbyKwl/ByGs0cn70fR7wMpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ggo6qnBg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=H3uCJtkF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KoOpSGjb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lAXyifDo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ggo6qnBg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="H3uCJtkF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KoOpSGjb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lAXyifDo"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F1FF621E43;
	Mon, 12 Oct 2026 08:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791793453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Olt3ZgSa2UaXkQo/gyyeUGbIfs1fUSSm5urEkriKz5I=;
	b=Ggo6qnBgXypjIRWXtAP1AFs4OwNXHhs+3J/NJo+0vutZgDP7stupCtPg17nDWPfu9q15Pe
	ZE3Sclcll0AYcRN+uXUV5Qd3I08HYKXk3wHQfAro+pPgaRGr0x0GABk/Ce6cX5UsLL0xpy
	sJ2n9vgrpDeCfniKekHHlfJAkpXjHu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791793453;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Olt3ZgSa2UaXkQo/gyyeUGbIfs1fUSSm5urEkriKz5I=;
	b=H3uCJtkFuHv6IGPtL0cQBAf32XW4GCaW/JIqCsYfJ2rXT+y23fgoEL6qIkWMZlMkiXGhZw
	gwX7mK0+M22pJeDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791793452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Olt3ZgSa2UaXkQo/gyyeUGbIfs1fUSSm5urEkriKz5I=;
	b=KoOpSGjbevtf7bER5nbMnOHLNZW4NzbvrfrJBDZYJ9s/6FPkPdEi0TPDbSivKvB8NaNOyP
	Qo9X3U7Sm6sCsSwgVlcAzVYDNO6HhgWmabcSNJH9mVgdJQDe7SIoLuDUbJKheMzYanw2Xj
	mLh5o1JwHW1b6gcXkbpg+f2WbixNH+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791793452;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Olt3ZgSa2UaXkQo/gyyeUGbIfs1fUSSm5urEkriKz5I=;
	b=lAXyifDouFVdI0vO5LUuj0Sq1EdVrY8coXuPB5YJR1leKjvV573UxfB78qJQnLbb3SghuF
	6xPe2cmkCdmdI7CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8821213794;
	Mon, 12 Oct 2026 08:24:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g1geEyuZzGoOHwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 12 Oct 2026 08:24:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A0FAEA140C; Mon, 12 Oct 2026 10:24:10 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: <linux-mm@kvack.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Mikhail Rudenko <xyzzy@yandex-team.ru>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 4/7] fs: Defer reclaim of unlinked inodes
Date: Mon, 12 Oct 2026 10:23:42 +0200
Message-ID: <20261012082356.3121725-11-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261009133253.20102-1-jack@suse.cz>
References: <20261009133253.20102-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1687; i=jack@suse.cz; h=from:subject; bh=q/GSyAYlC73bY1ffIrf+AcoWWY6+CO3n77kKwbH1Z0w=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBqzJkf1UVyyk+1usmrk7vODGw4uFw0itng5/yQX 7ttZEIlSmyJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCasyZHwAKCRCcnaoHP2RA 2dNyB/9w/MG5IP2tDdJDgZrSKv9EB34cgdYqW0eT6Nq1XJJSFCkrT8X7GSwPz1DLoAajflSosiZ NcSe/PjC0LZbdE/js+hk+u9Jfu4R4KTQQ5PgjfTAH+R0oxtBziirKJCymjzdr/0X6bVqvuka+ts zfoYdJUQQLWMoyumxQKnsKhiX/LJPk5QShDoWj7/fkjU3eh305zlBsQlhTkpxkEGoLLfqF3HCmx BIvstG0txarWVbfy98k/+ktMbKo1QTz3NTqeVNKL256JI7AwRJDde843HoJHPprPKrftHwzkZY6 krBby55ausged1wD4Mchg4/I5S/GZOPe3182lrKsdvyBexm+
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
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
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO

Sometimes it can happen that reclaim of some slab object drops the last
reference of an inode that is already unlinked. The frequently reported
case of this is a reclaim of overlayfs inode dropping the last reference
of an inode on upper filesystem. Because the inode is unlinked, evict()
will delete it which generally requires writing to the filesystem and
memory allocations - not good from kswapd or even direct reclaim. Defer
inode reclaim of unlinked inodes to a workqueue when the last inode
reference is dropped from a reclaim path.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/inode.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 0128db61217e..0b6335df9b48 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2214,6 +2214,23 @@ static void iput_final(struct inode *inode)
 	inode_lru_list_del(inode);
 	spin_unlock(&inode->i_lock);
 
+	/*
+	 * Are we going to delete this inode while in reclaim path? Likely
+	 * reclaim of some object (e.g. overlayfs inode) ended up dropping the
+	 * last reference to an already deleted inode. Offload the eviction as
+	 * it's likely to require memory allocations and block on IO. Since
+	 * this eviction was triggered by a reclaim of unrelated object, the
+	 * inode is already outliving the operation that originally deleted it
+	 * (unlink, file close...). A slightly longer delay thus should not be
+	 * observable by userspace.
+	 */
+	if (current->flags & PF_MEMALLOC && !inode->i_nlink) {
+		LIST_HEAD(defer);
+
+		list_add(&inode->i_lru, &defer);
+		queue_deferred_reclaim(sb, 1, &defer);
+		return;
+	}
 	evict(inode);
 }
 
-- 
2.51.0

