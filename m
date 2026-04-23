Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADB93BC680
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 09:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776935023; cv=none; b=F+v11p93I0eq/3qs7M1iNB+qxmvE3rhK62kF4dYQpWyhJAXYHjoHo3rzMh+1BekIZ2OIHh+cAih3G2wbqv9S2LDUFu/b23F0GiEysgUmYjcxF6znzPiI0pzZ7HL65BPjGsSMswRwAKIIu/mjf4rtitNNhxu2AU6kXIvFI1OSV6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776935023; c=relaxed/simple;
	bh=g7qCtyBAzZ6a8iutM+vLhwjCQFKgDnUVyRw65wXYrdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HZNfuX6gu1VuZX8yhwX5z1gWl71vRmWcoFjKanAt0YPJMOGeJoUjbCzz7VBGdN1+iJhw6wB0nMCPsC7QuYnly5pCzKe5f1+On5MI6qXfWu9VW14DcdW3W4IdRgvuu3PHoodteEBzF3ivLQXiwrKYLxfSDVuI/VJ/EL2tx8m5DiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ODxK1WQz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=P2CHQMA1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gHP0ZMk+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B96g0QQ+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ODxK1WQz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="P2CHQMA1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gHP0ZMk+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B96g0QQ+"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ED5B55BD52;
	Thu, 23 Apr 2026 09:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776935018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XpPTy1CDa2bM+JdIe12J2IYejmuTv3TfOKQZi/2mFnk=;
	b=ODxK1WQzoDrCKFe+I61M7NZJT2RJ2h4P55BkacG5Dt50FntUImZkEa8kgLfvHypMqk1Kaw
	IbJZ0K/Oj5J99SybGbAxGbo3B0iUX1/GK04cz6cNLuKq8jB4Ys3DrHcyZ6b0g7J4u+Wroa
	0nOBMp2IERsikm6Zp6adIHhY3DAoqjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776935018;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XpPTy1CDa2bM+JdIe12J2IYejmuTv3TfOKQZi/2mFnk=;
	b=P2CHQMA1Ms8bfXn6A67YaZOxfvb4OKixSRy3ZVA8G+D1Bm6FJPm0vKRL0DAibgcIWLlW7/
	Sqi8fSsoHR5zPjBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gHP0ZMk+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=B96g0QQ+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776935017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XpPTy1CDa2bM+JdIe12J2IYejmuTv3TfOKQZi/2mFnk=;
	b=gHP0ZMk+tVApFmJsPwFKP1j1YsM9xZx9HgbudKgqFexmEDXnneKftcby8SNVk5rab7hQAa
	IS1zEXIaPkO2QHgnibvHu8i9rHyRqhs+7KjR6dXOTkO7RbTZB5u3uT1VfMtKm+wy+jB0BU
	mxBBN3wiwc462tpc8nKQXu9B1L7ZzTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776935017;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XpPTy1CDa2bM+JdIe12J2IYejmuTv3TfOKQZi/2mFnk=;
	b=B96g0QQ+y+yqo6exwuUz+s35BzY6CfcmKAfD8dedduZ4heoVh76m7a8UkcnioxNyqOKQqa
	3rxWLeC2vt7BzLAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4716593A3;
	Thu, 23 Apr 2026 09:03:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4lrPN2ng6WnOFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 23 Apr 2026 09:03:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A6686A0A2D; Thu, 23 Apr 2026 11:03:33 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>,
	Ruikai Peng <ruikai@pwno.io>
Subject: [PATCH v2] fs: Handle multiply claimed blocks more gracefully with mmb
Date: Thu, 23 Apr 2026 11:03:12 +0200
Message-ID: <20260423090311.10955-2-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1249; i=jack@suse.cz; h=from:subject; bh=g7qCtyBAzZ6a8iutM+vLhwjCQFKgDnUVyRw65wXYrdA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBp6eBP8zkg0TA6qgXA7XV5Qe09arD/il+EeCjaQ QXdMMCkIC2JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaengTwAKCRCcnaoHP2RA 2XKJB/9UojSCbFO+KEIVW5c7uynZe+i7DVchEWFZR65hyPb4m1gQpgITVvppxlxKgHbenD5cQQp FqA1NUBT7FDKX6NcgencX/SS7+EGn2DA8ZoLTBiR5FDUeaE85EXmOTdYPiUTVI3YlxiBeiOxRCZ daHQIKG9Kxwa8R+fIiGs08LgMjYpXVmZuLWKGIjjCsdsvPoSSX7qlBKkiBXdy8GkJmMkKiQrkSY Qg8faJtR2oalSpM+LjG9k+lCDms9D6x2Biasg0lDlrx2IelqbalISaP/+HPMY/91RC3l/ASy8Fx Hb5AytBbFQf3jZ+/b0Ld9wTxZtvgrGHLNlToUUx3KcPJjuOt
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: ED5B55BD52

When a metadata block is referenced by multiple inodes and tracked by
metadata bh infrastructure (which is forbidden and generally indicates
filesystem corruption), it can happen that mmb_mark_buffer_dirty() is
called for two different mmb structures in parallel. This can lead to a
corruption of mmb linked list. Handle that situation gracefully (at
least from mmb POV) by serializing on setting bh->b_mmb.

Reported-by: Ruikai Peng <ruikai@pwno.io>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/buffer.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

- fix inverted condition

diff --git a/fs/buffer.c b/fs/buffer.c
index d6e062c42a8d..b0b3792b1496 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -719,8 +719,15 @@ void mmb_mark_buffer_dirty(struct buffer_head *bh,
 	mark_buffer_dirty(bh);
 	if (!bh->b_mmb) {
 		spin_lock(&mmb->lock);
+		/*
+		 * For a corrupted filesystem with multiply claimed blocks this
+		 * can fail. Avoid corrupting the linked list in that case.
+		 */
+		if (cmpxchg(&bh->b_mmb, NULL, mmb) != NULL) {
+			spin_unlock(&mmb->lock);
+			return;
+		}
 		list_move_tail(&bh->b_assoc_buffers, &mmb->list);
-		bh->b_mmb = mmb;
 		spin_unlock(&mmb->lock);
 	}
 }
-- 
2.51.0

