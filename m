Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792668356;
	b=nU6QC6CbPI+4o2npTxvL17onytaGag0p4rCu8g0CC+YAiMWdeaTGTlrdRXbImPGq/YCh
	 twZ5kKW6nzhHNmQir4ViJtZv42VjT9lWYVlDsOZnlKsPhGu45nuEQggIWN4ExCstbY+jM
	 QK8sf/Xep7YKs/q7lbmpfoI+QXqQw3931GgAxLPfmA8nhs0jT//QMkzxDNWRwC1hheBla
	 RkprNHmPXV7E9uX7csjKOJT82P/1IMiKdpEwkE98hn8U1l2XyHjW4+JcgyJhcAq6CXLqn
	 gJTGYwaolGnu7n9mz43m8Wqt8pVS+7Q3APL0qzppt/Ow0yoc33N0hxmmAU6+qvTHikA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792668356;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding:X-Rspamd-Queue-Id:
	 X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spamd-Result:X-Spam-Score;
	bh=UOFwG9+UWjIJtC0v9FlYAnlid9dUa057hoG52/PZ4ec=;
	b=FN7swi+zM5KSEKzThXIh5mSolLYfZ6CKpBM/8TtAiRWXma5oghJEK6ycj16uQEwfkxZK
	 056Devq8yoDFFoeHQgCbAytMBUvMp+d6t2xHzc9I6yCsZa6FgwkgrjSorMLUwY569RBkH
	 4ri+OMnrSQMSo9buu4buMCnfHG7jAmCb1CtlTQVRtBUxz3/IUlF6sN9QWsnRNHyvcsFy8
	 8JNh2H9fJwD2G6aRVNdXbBO0nzrcD8zQO2+jpVk7xN16z/YsBu6KtWW86iU+HDbZekwMV
	 LqYu9bf24jja56yDIH+acTDUevI7tmEu4Qw4GByk6h6KGdMbGRj4M3InJUM68meZJdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=p7hKr+Ez;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=L23p0lo0;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=p7hKr+Ez;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=L23p0lo0;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAEC606A319
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 11:25:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BAEC606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=p7hKr+Ez;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=L23p0lo0;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=p7hKr+Ez;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=L23p0lo0
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5528D2217D;
	Thu, 22 Oct 2026 11:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792668352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UOFwG9+UWjIJtC0v9FlYAnlid9dUa057hoG52/PZ4ec=;
	b=p7hKr+EzIon0BBgdHfptwKM++SNkreRAiwDM4PXVKflogt7vTOlu0V/atF32WeUcO2k7Nb
	LymuwidXRpkf0cJgHVV8pFN1W0rQU43oxGwlpNqzNKa+c+UQIaRxpS8TIrp5CSrp/hn21r
	I/3e+yC16WG4xcc4FTzk6nW3kegHe/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792668352;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UOFwG9+UWjIJtC0v9FlYAnlid9dUa057hoG52/PZ4ec=;
	b=L23p0lo0NyybLd+rS3k2+RDkgu4Rb4kCxBvkNNiPmKrt5JKCSQdUab23LJb0hIFi5I2wBj
	k80yomL1EMM2qmDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=p7hKr+Ez;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=L23p0lo0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792668352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UOFwG9+UWjIJtC0v9FlYAnlid9dUa057hoG52/PZ4ec=;
	b=p7hKr+EzIon0BBgdHfptwKM++SNkreRAiwDM4PXVKflogt7vTOlu0V/atF32WeUcO2k7Nb
	LymuwidXRpkf0cJgHVV8pFN1W0rQU43oxGwlpNqzNKa+c+UQIaRxpS8TIrp5CSrp/hn21r
	I/3e+yC16WG4xcc4FTzk6nW3kegHe/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792668352;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UOFwG9+UWjIJtC0v9FlYAnlid9dUa057hoG52/PZ4ec=;
	b=L23p0lo0NyybLd+rS3k2+RDkgu4Rb4kCxBvkNNiPmKrt5JKCSQdUab23LJb0hIFi5I2wBj
	k80yomL1EMM2qmDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 330A7133F3;
	Thu, 22 Oct 2026 11:25:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7WbKBcDy2WrYZwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 22 Oct 2026 11:25:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AFD49A1417; Thu, 22 Oct 2026 13:25:51 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	linux-aio@kvack.org,
	Jan Kara <jack@suse.cz>,
	Cheng Yongkang <teel4res@gmail.com>
Subject: [PATCH] aio: avoid request count overflow in ioctx_alloc()
Date: Thu, 22 Oct 2026 13:25:35 +0200
Message-ID: <20261022112534.3513745-2-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1560; i=jack@suse.cz; h=from:subject; bh=YXJuss/QFH+2eSBPLJ4w2m5qq63mJV9zaIgSoyHXl7Y=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBq2fKugGKCNrv2VFXI3qchz5g676Qr5v+YOhq9d Ma57C9D0NyJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCatnyrgAKCRCcnaoHP2RA 2THnB/9eOOdD3i1rCBraKR9Y5OW0ssHSIvDDDyKIOBPtYDK8lSMprtKJGgMSUvEcmTjj/q1C2aL UqzfvueWwEgkaPfzSJCweBdTNEJ31dQFU8sFneSW8TDvHGQRagqWal6vc/RT7rwQ4iMK37q+OAr pPn4wtxkERPwRhdXf7tTAsmUX5iGcMa8pzzrlYlTpSfmd3KDuObRVh8FOLxr+yhZ57xWiT/fYwy Zgm8gafG8uJ/e/OoCFMaBfakOYOglhZ2w/Mv6zj3pf2NRvQxWetkKWsqBb1cXsl2t33j/lwz62T i8hskVBnNipM46qcvpevhwsGfckrL/4kLfxddKn8Qqk+yNmi
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5528D2217D
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
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.cz,gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_FIVE(0.00)[5];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -12.01

ioctx_alloc() saves the 32-bit nr_events in max_reqs, then doubles
nr_events before checking the ring-size bound.  For
nr_events=0x80000001, the doubled value wraps to 2, so the ring check
passes and aio_setup_ring() builds a one-page/127-slot ring.  The
original 0x80000001 is still stored in ctx->max_reqs and charged to the
global aio_nr quota.

If an administrator has raised fs.aio-max-nr to at least 0x80000001,
an unprivileged process can create that context and make later normal
io_setup() calls fail with -EAGAIN until the wrapped context is
destroyed.

Check for too large number of requests before multiplying.

Link: https://lore.kernel.org/all/20261022091748.3653127-1-teel4res@gmail.com
Reported-by: Cheng Yongkang <teel4res@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/aio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 4f32b45cb8a0..2086c0f263f6 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -805,13 +805,12 @@ static struct kioctx *ioctx_alloc(unsigned nr_events)
 	 * counters at a time, so make sure that isn't 0:
 	 */
 	nr_events = max(nr_events, num_possible_cpus() * 4);
-	nr_events *= 2;
-
 	/* Prevent overflows */
-	if (nr_events > (0x10000000U / sizeof(struct io_event))) {
+	if (nr_events > (0x8000000U / sizeof(struct io_event))) {
 		pr_debug("ENOMEM: nr_events too high\n");
 		return ERR_PTR(-EINVAL);
 	}
+	nr_events *= 2;
 
 	if (!nr_events || (unsigned long)max_reqs > aio_max_nr)
 		return ERR_PTR(-EAGAIN);
-- 
2.51.0

