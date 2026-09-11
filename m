Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5BB46982C
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789116730; cv=none; b=KEoesw2KWQ9ddQkTwm2HSEcIegLol+FDO0Dqbk1QpXxsQ/qmX0ZniU6+rG6tsSm920QuC5Do+BxsEUkWuFlkJAiX2uyHmMiQCOvIZvxnwSBO0UM7VKn+K0W/S/sJehLG4O+2WkcB2RykKlpdhlFH8d0vZjxzaSzqorgnywgxG48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789116730; c=relaxed/simple;
	bh=avqoHDTNDP0cr+11QWk6Aa9K1cFRty+3fHmLxPaiUJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxdLTvwwsmqeMyA/uapGvdXRE12QrJF0OV1+qB5qjo5hDZAEeQfgKCKBKwrauamQKBP+zar73Hb3WzuPASTRXMa3bI0f5xOmDHw/GkPMw6lwFxDtNOAgKWGqAMZ3/9wK5JdgzyT2SWM7HBJcqgwlWAkPiotFdsUpFOrA0ZDQAgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=st1FxkHp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0bbW30OX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KbOpvMfq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ICjy6isH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="st1FxkHp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0bbW30OX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KbOpvMfq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ICjy6isH"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9D7A021D33;
	Fri, 11 Sep 2026 08:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789116722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dz6C2louXbYTzx8xCxkNV3bt+061Wbi54iimb+Q9SME=;
	b=st1FxkHpLKZygnEUBYPlh/AesXJkGTfNrIUaaH0N+3JkEQ4QuDFL9PZdBBKBlpEoqAVgew
	kDf82GS1kvkUgxMhLRJqun0q9fR1A8ahRnbDlVY4ldycfv+2oTKxVqd095BV1h/R9uHG54
	mEHiBkEcfyKuLPZESjgd1JYuKYF8nZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789116722;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dz6C2louXbYTzx8xCxkNV3bt+061Wbi54iimb+Q9SME=;
	b=0bbW30OXrCXZxdM03u9STOjde++HznqxAZFAdZo0x2Zp7hM8/PRYSSWHGTaMuI82nyfiAC
	Ukpk8n3jA9sV5xDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KbOpvMfq;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ICjy6isH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789116718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dz6C2louXbYTzx8xCxkNV3bt+061Wbi54iimb+Q9SME=;
	b=KbOpvMfqc9jsb4/1MAy1bQTj2Gk9NQ394MgyUW57y4LiFXOdvLtGy010gjaMsK2y4U4D2p
	LCMzu5BVoa/j6BJrKVeevL1ovgAXn0VSYIwgqFzUtNF4tQjQ9E9RrVVLxoPOILJLoOxZHf
	Xxu+Hue7CYSbsK/eESekyGHgMkUg9mA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789116718;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dz6C2louXbYTzx8xCxkNV3bt+061Wbi54iimb+Q9SME=;
	b=ICjy6isHfvoK/KrXyuQz0AlZtp1n4XW4iaKpqvlMv7ZT34+XwN63zcAErAPKcOQbttcU+w
	GgJnnXqQUk7PSFDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5959C13770;
	Fri, 11 Sep 2026 08:51:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q1LIFS7Bo2qwHwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 11 Sep 2026 08:51:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C30D9A079E; Fri, 11 Sep 2026 10:51:53 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: <linux-mm@kvack.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Mikhail Rudenko <xyzzy@yandex-team.ru>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 1/5] writeback: Fix missed lazytime flush
Date: Fri, 11 Sep 2026 10:51:37 +0200
Message-ID: <20260911085142.1774803-6-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260911081309.14137-1-jack@suse.cz>
References: <20260911081309.14137-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1480; i=jack@suse.cz; h=from:subject; bh=avqoHDTNDP0cr+11QWk6Aa9K1cFRty+3fHmLxPaiUJ4=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBqo8EfRGeRkQdTdJvHqmm1VeT0FuPNhKPDbcqMI fRgMInHWgiJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaqPBHwAKCRCcnaoHP2RA 2Yt4B/4hrEuD8MXrdckW6oSMpK+y/q2VrKuwDqDBvMrXlCgYkmvwwmR9kzc6D8FoRdU8PmVjTbC GgU1P7kjv0pq7LDXTd2gyHFO8SrDOpdEdjoSRHOM1B6qUyPvZoQENCVq8S//oomjqX5xRyZ4nZT Au/QsMQcZzvc42jczSZ5DwCxVSZrO0ysjJfRWnMd2oR6SlWpTlKGEOcQ7+2JgSnyPbuu7r/W497 QBzMCKr89DISfcXNfADzTcgJNgMLkSktsOBVaXe+HT/o555AnZh6pDocY668gD+XX5LnQIEPdrU LXxq4nclsDtyBGT3J/Du3rg8879NVl2d7dy+g6R4+cuNyLKT
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9D7A021D33
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.cz:mid];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -3.01

move_expired_inodes() moves to b_io list inodes which were dirtied at
current_time - dirtytime_expire_interval or before.
__writeback_single_inode() however calls sync_lazytime() only if the
inode was dirtied strictly before current_time -
dirtytime_expire_interval. It can thus happen that inode with dirty
timestamps gets queued to b_io list, then fails the check in
__writeback_single_inode() and as a result is just placed back to
b_dirty_time list with a refreshed timestamp and so timestamps aren't
written when they should have been.

This is a very difficult race to hit in practice but changes to how
dirty time expiry is handled on last iput() will make this much easier
to hit.

Fixes: 5fcd57505c00 ("writeback: Drop I_DIRTY_TIME_EXPIRE")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index e744f9f9d43f..bb4546d147dc 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1807,8 +1807,8 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
 	 */
 	if ((inode_state_read_once(inode) & I_DIRTY_TIME) &&
 	    (wbc->sync_mode == WB_SYNC_ALL ||
-	     time_after(jiffies, inode->dirtied_time_when +
-			dirtytime_expire_interval * HZ)))
+	     time_after_eq(jiffies, inode->dirtied_time_when +
+			   dirtytime_expire_interval * HZ)))
 		sync_lazytime(inode);
 
 	/*
-- 
2.51.0

