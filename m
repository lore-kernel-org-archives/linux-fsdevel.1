Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D51C21E098
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776869146; cv=none; b=OJLlKuzPNHAjKJXSOTOa1xoqiJ8jFs1WgGhBPSMj4dk5c+wfAN1jGLcMEvII0BITTnnyywfFslO32BuF6YKFGivEardu6KAS3weup+nZW8CKzaYA+PV+s1aLeduYL+bA4wtpcTonGSCYKyHVIPepObsPKgDmR6fCKJjGqOwdeUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776869146; c=relaxed/simple;
	bh=Z0/ctn5eiQgUy6gVc+bq7KSdT7JCHjyqaEbqkMgHfSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IvsqnI7mRu1/zbetd+rbDGe55+yKTADSbhgvLy063Qs7DvHy7XTb7Px0Jrrtf2J4T4YR/vbGj8284meECUHwFRiVRP1QCSWMvg48vAZAE1erYgL7xRm7KhgAdz7Nv9EfdrIefZJrxbbsTyt9uSznHzaIfWapKTdwYhCE3oczk0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QCTSFZzA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5lykG07j; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QCTSFZzA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5lykG07j; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QCTSFZzA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5lykG07j";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QCTSFZzA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5lykG07j"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 37DFB6A84E;
	Wed, 22 Apr 2026 14:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776869143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TBBaEoVNojPlDOwdDRh0Ia8KwQwN/DlXEohYbFpGMzQ=;
	b=QCTSFZzARVVhxlAJlklSjk5rMgarLw5NEsYbyoKb9WZpfPz2HsMkiNhAsQwQ070CQqimTr
	Dbw4Z3C73RlkgZExForc7N6ObCRKMmXCttSEyOdg19UtLgFz1ORboSgf8CzK6JCc5RZbnw
	R/mxZUdcILfFdQJVlPdp+lRVDPQ+I3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776869143;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TBBaEoVNojPlDOwdDRh0Ia8KwQwN/DlXEohYbFpGMzQ=;
	b=5lykG07jQ0I83ojz1J+QWsA4yPGWbFy/e4LZTBYPx1zoaS6BoD2oyyX+tA5bqC1zuQ8vcq
	Z1DsxuKKOiXYdmDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QCTSFZzA;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5lykG07j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776869143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TBBaEoVNojPlDOwdDRh0Ia8KwQwN/DlXEohYbFpGMzQ=;
	b=QCTSFZzARVVhxlAJlklSjk5rMgarLw5NEsYbyoKb9WZpfPz2HsMkiNhAsQwQ070CQqimTr
	Dbw4Z3C73RlkgZExForc7N6ObCRKMmXCttSEyOdg19UtLgFz1ORboSgf8CzK6JCc5RZbnw
	R/mxZUdcILfFdQJVlPdp+lRVDPQ+I3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776869143;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TBBaEoVNojPlDOwdDRh0Ia8KwQwN/DlXEohYbFpGMzQ=;
	b=5lykG07jQ0I83ojz1J+QWsA4yPGWbFy/e4LZTBYPx1zoaS6BoD2oyyX+tA5bqC1zuQ8vcq
	Z1DsxuKKOiXYdmDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29A73593AF;
	Wed, 22 Apr 2026 14:45:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RCImChff6GlSdQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 22 Apr 2026 14:45:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7C922A0B44; Wed, 22 Apr 2026 16:45:42 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>,
	Ruikai Peng <ruikai@pwno.io>
Subject: [PATCH] fs: Handle multiply claimed blocks more gracefully with mmb
Date: Wed, 22 Apr 2026 16:45:30 +0200
Message-ID: <20260422144529.20279-2-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1214; i=jack@suse.cz; h=from:subject; bh=Z0/ctn5eiQgUy6gVc+bq7KSdT7JCHjyqaEbqkMgHfSU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBp6N8Jumm5ESDaUn9Axk8CiI7xu51WijaGTXNda ESZ9dxQGMKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaejfCQAKCRCcnaoHP2RA 2QL5CADj3UQUd/FqPTI0Z4/wHaSGoX2oDaOvotYR9u2MaJXnBf6gRtKN1LlQL+fK8IFZ9DWPZBX tYjuAcy23cAFXirwHGEkipI0i9GJw07fNl6laXZ0xB1bXHemzvSPgqXwQq5tycSphbpGpbFibw2 tsPMX6WNiVZj3kRe4ym16heQpHIdaov2A6AR7t0yxvyHhNHQbT+i/4p4a3fXOvssZz0Fyf4tXQX puz3GGY+pS2Gjj0suprjoQaizz5O5JyV71yiu+XQ6JnEFJi5f/4x9R41v1XR3AV0n/nM0elx1+2 ZdrhMn3DJ0Pvee5isK71cibNkKl9Pqmi9AWrHOePeMQEQkRf
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 37DFB6A84E
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

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

diff --git a/fs/buffer.c b/fs/buffer.c
index d6e062c42a8d..35e7b63576cf 100644
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
+		if (!cmpxchg(&bh->b_mmb, NULL, mmb)) {
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

