Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792745265;
	b=UIkfdTi7/t5/3BYSx6BxR+d5ywqrDMeUTWRXeGFMQe+Kg734+wuLWFe7CxLdX5Tkzxc9
	 m5Fx7Gc8ipiR3a1THV62wuFmXuz67hOnxQAzgdIJa4DaJ/I+TjG8FeXGkFBKtsEAhX7Dz
	 WuFUcpgQXiFu8dlcCMLrzz99n72DJv2xX6v9BMh8QctzGR7VyeK3uXpd2yrPKIIorrGSm
	 vAbyyAPpdnLbwrXDcK4CT7KvEB4NW6cdCkhjPB9l6h5zFDjN9Mk2ENnVXbR/yP8EpliO7
	 sljAQsFmVhm9Id964J48CjpE4mI4Js+HQbSF2A+rQI0t0Vzz/PjfELxbu0eCiFWYZsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792745265;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding:X-Rspamd-Queue-Id:
	 X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spamd-Result:X-Spam-Score;
	bh=obPbERGRR5+CE5G3w+/lCzYoCqRarehtdYwYyrv6ElI=;
	b=UG0s0b1se9bh12ks4w72+BbLYB+9OxWDZN8yL2FI4VLdpjMfmU5vGtU01Rq4vzhftZ6n
	 WTwvTrHqmbinX8Gbj94crOI8JE6V7kDUxDg+b6QmuBF7ky1rwhVD/KC5JYK4xujmY3seu
	 d2E6banRedY3prgVkFElG6OjxEMLbCkpgMbfr+51D+j28kgX7Ao26Hp0xr0PbTFgDryth
	 GkGpmvFMQHK/AutPA//nouIpgqR7jsIdWJeTqle08q1ZUHWyGXpnnsisM/HbxKY9fiLZ1
	 Eg55K1OoMamU0D7OgAE3p1hBKy1Kr+SCz/X9Zj/wapjT8C2KL9E1fKT+f/jg92Wbsfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=EmYQf+vD;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YOic1H1S;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=EmYQf+vD;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YOic1H1S;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02115606A31D
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 08:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02115606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=EmYQf+vD;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YOic1H1S;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=EmYQf+vD;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YOic1H1S
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 012661FA99;
	Fri, 23 Oct 2026 08:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792745263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=obPbERGRR5+CE5G3w+/lCzYoCqRarehtdYwYyrv6ElI=;
	b=EmYQf+vDvxK42P8qQwbO7tvKyTKYklaTQiKs6b0PyEfR1w+9ljt152s08sHN3XHGrz6ng/
	qtKChgVy3wNHKb5Bktn4bIs05wfpmDzFyqh3jqNlCiU/Ip9peU2tp4s/fqa4HfjdBJDr53
	bV2YiNcnJgcBHGapFspzij1+YRpq9a4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792745263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=obPbERGRR5+CE5G3w+/lCzYoCqRarehtdYwYyrv6ElI=;
	b=YOic1H1Se0xA09gQcIOaqT3qwhSmNO8KInBKtN9NEoZsf0YYFewI2k91ckXTBZrVLgJlgG
	jbQ+v57Fl7gevbBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EmYQf+vD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=YOic1H1S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792745263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=obPbERGRR5+CE5G3w+/lCzYoCqRarehtdYwYyrv6ElI=;
	b=EmYQf+vDvxK42P8qQwbO7tvKyTKYklaTQiKs6b0PyEfR1w+9ljt152s08sHN3XHGrz6ng/
	qtKChgVy3wNHKb5Bktn4bIs05wfpmDzFyqh3jqNlCiU/Ip9peU2tp4s/fqa4HfjdBJDr53
	bV2YiNcnJgcBHGapFspzij1+YRpq9a4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792745263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=obPbERGRR5+CE5G3w+/lCzYoCqRarehtdYwYyrv6ElI=;
	b=YOic1H1Se0xA09gQcIOaqT3qwhSmNO8KInBKtN9NEoZsf0YYFewI2k91ckXTBZrVLgJlgG
	jbQ+v57Fl7gevbBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 984B1133F6;
	Fri, 23 Oct 2026 08:47:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M4s5HC4f22ryGwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 23 Oct 2026 08:47:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1DE62A1415; Fri, 23 Oct 2026 10:47:42 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Finke Lennart <lfinke@student.ethz.ch>
Subject: [PATCH] udf: Validate extended attribute space is large enough
Date: Fri, 23 Oct 2026 10:47:32 +0200
Message-ID: <20261023084731.3585174-2-jack@suse.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1093; i=jack@suse.cz; h=from:subject; bh=gyWZZ1YZ+IYxpFWoq0stJr4IBtdUA4srUoqtPED/gHk=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBq2x8jDODLAhlb0GJYyVfZGK+Zi6NRUlUDZyQkq f5+nBVKrUiJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCatsfIwAKCRCcnaoHP2RA 2TflCADBrSradklS1AHZYJymrbN43l02tCqEngZCgiUxC3/y2RkMBgv8F3P+xg0xKNVD1ZNAUb/ eQZNYWif1VnVoV+dOywp9ZL1UwA8knn3gNkND9zz0ldV4ymgHuph/OZVr3Db3T3QKiTB2khswCT 7RxrdJ30C8J7Y4Xs5yE/tZ+OpJo9vJEfWjte5XyI4pjugD4ehTHKgt+iDXVfkM/KbKbIpw6odd2 1yyhzmwLcZI2AC3zxBLMQw/W5pgGuchXRwbFjOnSpElILtiDkNgkkHUHIe94k8Yo7Jv18ZVgTRH wAys8XzoDxff2hJXqu/gVHs5SZjrrf7WYkfVwIo2iK1MSYs3
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 012661FA99
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-12.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -12.01

When there is extended attributes space in ICB, there must be at least
enough space for the header of this space. Otherwise the fs is corrupted
and other offset validity checks could underflow.

Reported-by: Finke Lennart <lfinke@student.ethz.ch>
Fixes: 127b0d87649f ("udf: Avoid confusion of missing and corrupted extended attributes")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c | 5 +++++
 1 file changed, 5 insertions(+)

I plan to merge this fix through my tree.

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index bacf2a86161e..88b1c7d351e1 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1607,6 +1607,11 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
 	 */
 	if (iinfo->i_lenEAttr > bs || iinfo->i_lenAlloc > bs)
 		goto out;
+	/* We need to have space at least for generic descriptor */
+	if (iinfo->i_lenEAttr && iinfo->i_lenEAttr <
+					sizeof(struct extendedAttrHeaderDesc))
+		goto out;
+
 	/* Now do exact checks */
 	if (udf_file_entry_alloc_offset(inode) + iinfo->i_lenAlloc > bs)
 		goto out;
-- 
2.51.0

