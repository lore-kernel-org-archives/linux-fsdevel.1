Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795521549;
	b=Xm4jqyGpm6v3c4R08Rw3ZMp1aop90rFMAdFCFw3mMQPMry9kytXA10///1ix2pXITXa4
	 /UaFLPSPNin0EGUijVqZV/BoaKwsGzMfvyDu3T7pUxz0BOU7dBVOoBijRnizbjhwxryHA
	 iiup+qReMZ1WIxxRylUEHu/deictxP7MVzXbaobtKMAFp/ZI/PDk9/MMapLmuBVv4VkBX
	 b4n00KxQ4NQJKjEqiju0GpbEBoTmpWzEEyTKtpnrHKE1GVGyMFGv1eHpv1XdHV3AM2auu
	 0ioX0UgfIAQkSDTLV6kK11s3KdHJz1Oh96sHHjN/BvZlrjIoAa/73qXTY0jmYl1rjaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521549;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
	 X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=4dvS7ZLhan4maAO1jAthEDA4qGJsixJKMD6dhLuWOMw=;
	b=Eguc4y02NtPq+8BBmndCGIpFmJGZ9THLaMilBYOg+6QqGIFvRhkbPGvouIgirsyd6z2P
	 EzpuzrOkKS4jbSVX5X7V37I/9lPCBQXd6bRcda8R78AJDg/02j5XFUQmIhseRJqRpV49d
	 jdMfePWjZzs3ewVAkwZpavBIw/3c+sd4cu1j1G8pNyJ401Rb2oLVuYreCrIdYXAklP44x
	 s14lrJ7LB8l0pgjck6l1PWhiJZPIwmVI5vlOdZf5yfCgRsegwqSDeoKup6PtaF7nu8/Cd
	 cEUCoFfTtYwK0Fjg1QCBGASHbJbHWN0gIoyKGWo9SJM6y3N0XidhqbA6SGjlMajuIvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=UNYAnBg6;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5u8ilGDe;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=UNYAnBg6;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5u8ilGDe;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB7C606A327
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 11:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AB7C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=UNYAnBg6;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5u8ilGDe;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=UNYAnBg6;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5u8ilGDe
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 774C01F388;
	Tue, 24 Nov 2026 11:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795521547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4dvS7ZLhan4maAO1jAthEDA4qGJsixJKMD6dhLuWOMw=;
	b=UNYAnBg6BHEkqKgbawJ/fAuTWWPkIsJGBvWHHDKzopwsoTc02gGd/+m2W2DDnQexohN8fM
	N5H7+K3kBRsyXJyXtevNorvI8eOQmUPMVCZrtT/CaM/6pV2y37N5PPSiFZj6H7gSE9L9ul
	CU40RL2b6Z1JkUxRAVRHocj0DdS1VbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795521547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4dvS7ZLhan4maAO1jAthEDA4qGJsixJKMD6dhLuWOMw=;
	b=5u8ilGDeQW8E3L/oWFkjq5xiBD5CfmqMsQ2+X4Jg2s49Jq3IPRZT3y8pliM0gbzz1IDtNL
	aa2N7j/1LN0bcwCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795521547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4dvS7ZLhan4maAO1jAthEDA4qGJsixJKMD6dhLuWOMw=;
	b=UNYAnBg6BHEkqKgbawJ/fAuTWWPkIsJGBvWHHDKzopwsoTc02gGd/+m2W2DDnQexohN8fM
	N5H7+K3kBRsyXJyXtevNorvI8eOQmUPMVCZrtT/CaM/6pV2y37N5PPSiFZj6H7gSE9L9ul
	CU40RL2b6Z1JkUxRAVRHocj0DdS1VbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795521547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4dvS7ZLhan4maAO1jAthEDA4qGJsixJKMD6dhLuWOMw=;
	b=5u8ilGDeQW8E3L/oWFkjq5xiBD5CfmqMsQ2+X4Jg2s49Jq3IPRZT3y8pliM0gbzz1IDtNL
	aa2N7j/1LN0bcwCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B64313736;
	Tue, 24 Nov 2026 11:59:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cBneKQp8BWtKZAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 24 Nov 2026 11:59:07 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id E00712784D; Tue, 24 Nov 2026 12:59:01 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	<linux-mm@kvack.org>,
	Mikhail Rudenko <xyzzy@yandex-team.ru>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 4/8] fs: Defer reclaim of unlinked inodes
Date: Tue, 24 Nov 2026 12:58:48 +0100
Message-ID: <20261124115850.3512-12-jack@suse.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1687; i=jack@suse.cz; h=from:subject; bh=Sf2JWdFsQy1u7TCe/OfACrFdNWvBNlkYL7de6vW/KLQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBrBXv8vBQwjao9n51leSYLrf9RiT9fdHqp3NXb+ bppjNo+ZQqJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCawV7/AAKCRCcnaoHP2RA 2cAMB/4vNfLyy0JglxreKU9SyfYA6xvsORqfYfP8oxZuiZymNWvBLXfEEI8X3YVm78uU6T64Dh9 JYlZ21TWpFoBUyDP4nzB8s5+Tq6ccUkwgiZt7BONjfIi0af2XAO1B4qb6BbxcO3ot5GU8p9zhLF TNtVNYh9UOpzwq2FNobKRnGWbYXluPlakFDArxPxPmY2MMhQx2xLOfi6HXfTF5mVLhZzzwWWncl VW6qQ4QhEzrTmsZ7EQ4j00+vX9cQY2k7DHHplEdh/mqHvi6CMQ3IRulX1J+Srn+sEUkKSIg8nCv hL3CK8F+Cg1itCetU/XT9A7i12wzWF+xG5kAnUkBwYdsttyW
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-11.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.991];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Score: -11.80

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
index e08c6f0b0336..4ffafb101718 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2239,6 +2239,23 @@ static void iput_final(struct inode *inode)
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
2.53.0

