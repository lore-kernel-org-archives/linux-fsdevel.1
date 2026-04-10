Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB60C4400
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 01:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775785122; cv=none; b=WiytrEh3D4YLFy4JRTKraV4IOwCp+rNkekQqYWQLThrxlSabLXQJ5weWrV8Y1Qhro72wEMo7m/yBd3YCSi3FW9z3ly/LQ1nxXUwGlpKiSL2JuSt4bp+Ipl7CDihR9dTIJBeS4Y+WntUXEIzNBivHRt5cUnJTha2lakvNa0kwF94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775785122; c=relaxed/simple;
	bh=jULwVJY16VlHn2/5krce6laxliTnwUN/SJUJVrd5nto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nS7J2cE/d0dBfWRF+PZETksKQWpFPlMvwgfAhLgizJDxPPn4g137wY4AlYUhu4Mh2BshOyEWhnIsTyGa0FoYXexxWRIkRiHmgt479p++4gDAHPY2zQzvkHA5EG4rNrBEFWX9NvA2nMUoLLgjTdqnE/rJqqXItBF8RAht24p3uT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FoQnf2Hj; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fnoSXJY0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FoQnf2Hj";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fnoSXJY0"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F1DAD6A7EA;
	Fri, 10 Apr 2026 01:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1775785113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nx1Nja6q8dogmFHY6ABatI7JgWfcyFSoYgvbo3nW4Nw=;
	b=FoQnf2HjPDFZIs5HDosCOvMgu5qBvKGeogNQZ2aZyJTyzVtPCNAgHNok/qn0+5LqAo7tpI
	eSTHUrydkXpvP+GVYqvQKjzeM7f3/CuOEKdjHIR04DZauGKUH8Lg7zt6I+uJg4yChF22mH
	LZKx6hmnLAl96V2oJbR4I84XeQiQbB8=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1775785112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nx1Nja6q8dogmFHY6ABatI7JgWfcyFSoYgvbo3nW4Nw=;
	b=fnoSXJY0jtj7PhnqoPff2MQ8CnoizWvtghHVPgXC2DaK4rMOqGwTOtwOWAK41wuJjGwRs4
	sXYi0Q/P8F03Ax2GMVS97muWijTZlsYseC93DXLJ1INkCoLbpQT7CjnpxI3OY3Rhy2HqeE
	RT51HMsFahyZ9AcH/JvjTA8ef1qMxX4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC0D54A0B2;
	Fri, 10 Apr 2026 01:38:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7A6fOZhU2GkXfgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 10 Apr 2026 01:38:32 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: Hyungjung Joo <jhj140711@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 1/1] affs: bound hash_pos before table lookup in affs_readdir
Date: Fri, 10 Apr 2026 03:38:26 +0200
Message-ID: <6fa253b38b9b293a0de2a361de400557ca7666ca.1775783818.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775783818.git.dsterba@suse.com>
References: <cover.1775783818.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,suse.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 

From: Hyungjung Joo <jhj140711@gmail.com>

affs_readdir() decodes ctx->pos into hash_pos and chain_pos and then
dereferences AFFS_HEAD(dir_bh)->table[hash_pos] before validating
that hash_pos is within the runtime table bound. Treat out-of-range
positions as end-of-directory before the first table lookup.

Signed-off-by: Hyungjung Joo <jhj140711@gmail.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/affs/dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/affs/dir.c b/fs/affs/dir.c
index 5c8d83387a39..075c18c4ccde 100644
--- a/fs/affs/dir.c
+++ b/fs/affs/dir.c
@@ -119,6 +119,8 @@ affs_readdir(struct file *file, struct dir_context *ctx)
 		pr_debug("readdir() left off=%d\n", ino);
 		goto inside;
 	}
+	if (hash_pos >= AFFS_SB(sb)->s_hashsize)
+		goto done;
 
 	ino = be32_to_cpu(AFFS_HEAD(dir_bh)->table[hash_pos]);
 	for (i = 0; ino && i < chain_pos; i++) {
-- 
2.51.0

