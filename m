Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563431;
	b=IwJk6C+Zy9+H8PIHd5y4SBIJ0phh+uzGGSsWB7hkUg/TNYdbsfJMeZzgePd8arPaPTFt
	 MOfNxbgDIPZF8x3C0HtgxQqBO+pHIMduBh0mk85ux24UW97+D4UyEasUCLXtsVL9Em4sc
	 oSyC7pT53R1sD6SY4i2mOyhDFg6CiV+HravlMwe6DG7pIZhky3dCnUWwFPXLFj0rFdC99
	 yrDphsX586L+HcvIa4NNqkxPgpCt9ZIVakgnK4xHgsMj4KwrjrCPlbd7pQcS4hTJsXBy0
	 zQBa5mQW3AiPHiMk86xVh39Z2t5mchSnf9Jz+E2h1O0dNPV1eZ0O7wyOBJBFuhFhz6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563431;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding:X-Spamd-Result:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=+x/VYLgCoLJr18NIJjZRU3DhBViNeKWdWZfDkLyeYg0=;
	b=WcrPspuT36ZbcLTpmc6dovyJ2/g0TKzv/lmXxND6fvc/ulmRB5x1V9WIxXIkrrOK6cwB
	 ykWKvP0SyptO2wStRg3JK/qmySduIl3U1H3jDWUMocjCFRedwt+o7Q9HMyh2IraF5oco9
	 5k/nOrTFmZdLGZ9n17xM0yNK5/o2dQtkR0iotVe7FZWUBsdqlbecq97gw0XWKg4MPiZcO
	 ucGWkKydYWDttFPjv76kqyp81UfHbyVAmyVJWnanC7krfn4lCElo/Sllo676saw8kYkMc
	 vyu9LTEsphb8E2sNJFFExZLT/hPTq8MBPE3wgCLZ60ntniF2odQs92yRq+cVsHYnF7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=C+bO4QLz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vPiS3x0b;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="lO/pR8Df";
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1Hu2fRdO;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DC4606A330
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 09:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6DC4606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=C+bO4QLz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vPiS3x0b;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=lO/pR8Df;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1Hu2fRdO
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BC33A221B5;
	Fri, 13 Nov 2026 09:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794563429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+x/VYLgCoLJr18NIJjZRU3DhBViNeKWdWZfDkLyeYg0=;
	b=C+bO4QLzGfTxrlHPCH2lNqSusvLaAL+aDzhxPcWIxOFPl+Eh1aZ1WF0dAr7t5FRkgVEjMF
	ciRp1JDLb/peKCIEqnihIiJH5i0BqlN3ujGj695VEC9tVXWEP36dRGw0ICuW2B5WyAGo2N
	JMpMCDFNFaO3D3eOuVvLQgSOe3Jtz4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794563429;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+x/VYLgCoLJr18NIJjZRU3DhBViNeKWdWZfDkLyeYg0=;
	b=vPiS3x0bepFTXUFD8Ct7kxvgO18i1V8++GQZTs00An4HvXfj1Tt4z4BSUNGH5rPzmpfwVB
	9jemuCgGndgOvNDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="lO/pR8Df";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1Hu2fRdO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794563427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+x/VYLgCoLJr18NIJjZRU3DhBViNeKWdWZfDkLyeYg0=;
	b=lO/pR8DfpqaCWxCT+Us8TWpsJTyIIfHkhRYNmtirUjMt8aGxIMfENDQ45ftgd4SS9oPoQJ
	xYWf7E+llu5tg9Cfst3gv76193QZh+Z3FnUjjV5DT64txi/6e+FZWaQKCwKJEnb5eXfpDa
	nx9ofpl5YTiaNnb0FooPlz0XRXnxfes=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794563427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+x/VYLgCoLJr18NIJjZRU3DhBViNeKWdWZfDkLyeYg0=;
	b=1Hu2fRdOhSaXGgkG1CGQGwGt55sLoivE50XiOzAXTOCcdoDJeBlK+1n4YHvMqJ6cKfU+aC
	X+AUNQtfwwRx2kCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 823551344A;
	Fri, 13 Nov 2026 09:50:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ghNGEWPd9movWAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 13 Nov 2026 09:50:27 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id E4D9722C63; Fri, 13 Nov 2026 10:50:18 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Scott Carter <bscarter11@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] udf: fix udf_readdir() to not loop on corrupted entry
Date: Fri, 13 Nov 2026 10:50:15 +0100
Message-ID: <20261113095014.744206-2-jack@suse.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1212; i=jack@suse.cz; h=from:subject; bh=vS6ZOrT86yPU2Cz8FdWk1JFwc0gqGLrbTrk1WSdhYJI=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGLK+3Q2LKHJ23ZLTGp3K3nwv/zxT9un1ik/1rLa9e8p4T f+uwPyaTkZjFgZGDgZZMUWW1ZEXta/NM+raGqohAzOIlQlkCgMXpwBM5Jgf+/9KmbxUjoWTDRRn yPXcCU0Md9IoOyxkPavgo5Za2SfhukIPbbvYlUXvHrRXH9XU0u6U/Gt1m/v6K8f0L8dPWAVwhbJ LR++TS7QKXngzfI6t6trulrVW+kdun/GSXenTEjux6Vu7wqmpCWL9FgqVS7kYGgWFr+XJXiyu1Z oqJmFqeWDP8r8nTjcpiHCWSzAYcl02V9h5iVuYu7xHjVG4rPOi20QOhsmdy9cJ2S5tUigJONMaz lP9IKwqdVXqhMPHfXgOHm3y3Nm7RK5pWr7+pYx9yzP31u783OB9NPuiaHRjTXe3hndXhuCypH0b rJbt2/4wa01kjsQ9kUknfrzWYdjW8YZv/qcCx8k9W6UB
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -12.01
X-Spam-Level: 
X-Rspamd-Queue-Id: BC33A221B5

When UDF directory entry is invalid, udf_fiiter_advance() will first
update iter->pos to point to it and then report error. However
udf_readdir() will not store iter->pos to ctx->pos in this case and
hence next udf_readdir() call will again emit the last correct directory
entry and fail again thus looping indefinitely. Store the current
position in ctx->pos whenever it was determined as valid, even if the
current entry is corrupted to ensure progress beyond the last correct
entry.

Reported-by: Scott Carter <bscarter11@gmail.com>
Link: https://lore.kernel.org/all/CA+UmNqbcPPegp=x8rsV8t3mbOsseknKo54=fsru6gb3PQjg+Dw@mail.gmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/dir.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

- I plan to merge this fix through my tree

diff --git a/fs/udf/dir.c b/fs/udf/dir.c
index 425e3c162935..12869b19acfa 100644
--- a/fs/udf/dir.c
+++ b/fs/udf/dir.c
@@ -115,10 +115,8 @@ static int udf_readdir(struct file *file, struct dir_context *ctx)
 			goto out_iter;
 	}
 
-	if (!ret) {
+	if (pos_valid)
 		ctx->pos = (iter.pos >> 2) + 1;
-		pos_valid = true;
-	}
 out_iter:
 	udf_fiiter_release(&iter);
 out:
-- 
2.53.0

