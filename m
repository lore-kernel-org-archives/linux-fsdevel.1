Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7CE222582
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 17:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769016491; cv=none; b=RG2Lzn7l3kXfsSGjEkMyAVXjUXZx0VO4LkuuSMbpyUho0akE9gycsu8urrSZ/4A9T5VM2OP30dFf4uxASZmuUzPyiEbnoG/6r/xZWofB+53IQx24bZCki2wropoJqw0ZRMf/HXnH3hr3uGkLLSyDaBYGTSbkHfkPljx5VLRzy4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769016491; c=relaxed/simple;
	bh=FpE0I7p1w2Ra4XWC7Wk03ok7qoyhQnLdgY/yMLEyV1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qW4hhM5UqbHryiXgnJCul/ZzMLjGueqHmzFLTlfatWnlt76BvMZH6FDhyIbbPvalJ4TpUQ73x9IKc2+dtOQus79Qd78LR6yzlH+/OUE7IyZ+QDL+KEKNrUQPD3TgAEtwvrs0koWhvVz6YwNuEbPWbdqAmPSa65hda4NU6IvfGP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NulDi/7p; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vtzSsu0v; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NulDi/7p; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vtzSsu0v; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NulDi/7p";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vtzSsu0v";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NulDi/7p";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vtzSsu0v"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DC0A95BD55;
	Wed, 21 Jan 2026 17:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769016473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mqydnaIUk4cbF3iLRvq9YrWKdHKgFUqrKv2dqsGRy8Q=;
	b=NulDi/7pye0RBnSl/V2OL2iHUjqOdRoyUYoIyLd9QiJy21jb33tuP/wVGkGSnjQnlzMnp2
	5khCB3L+DXn/22r9eqEIipVsuxQ6W0nqwMZm0Pd28OoFzVXLxYRLF8kiXRJxO+86E/bLVQ
	m+XuzHI6aU4fEM7k3mGGwCmuErtwi/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769016473;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mqydnaIUk4cbF3iLRvq9YrWKdHKgFUqrKv2dqsGRy8Q=;
	b=vtzSsu0vYqSNTburfd9UerqBt9AbLBE5oP8Ig2XwjrL12Y2WjWOHJ3spL06zlfy+Fv2lfQ
	SClWoZUtpWTdrTCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769016473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mqydnaIUk4cbF3iLRvq9YrWKdHKgFUqrKv2dqsGRy8Q=;
	b=NulDi/7pye0RBnSl/V2OL2iHUjqOdRoyUYoIyLd9QiJy21jb33tuP/wVGkGSnjQnlzMnp2
	5khCB3L+DXn/22r9eqEIipVsuxQ6W0nqwMZm0Pd28OoFzVXLxYRLF8kiXRJxO+86E/bLVQ
	m+XuzHI6aU4fEM7k3mGGwCmuErtwi/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769016473;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mqydnaIUk4cbF3iLRvq9YrWKdHKgFUqrKv2dqsGRy8Q=;
	b=vtzSsu0vYqSNTburfd9UerqBt9AbLBE5oP8Ig2XwjrL12Y2WjWOHJ3spL06zlfy+Fv2lfQ
	SClWoZUtpWTdrTCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE5893EA65;
	Wed, 21 Jan 2026 17:27:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OIojKZkMcWlbHQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Wed, 21 Jan 2026 17:27:53 +0000
From: David Disseldorp <ddiss@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2 5/8] SQUASH initramfs: propagate parse_header errors
Date: Thu, 22 Jan 2026 04:12:53 +1100
Message-ID: <20260121172749.32322-6-ddiss@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121172749.32322-1-ddiss@suse.de>
References: <20260121172749.32322-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO

Abort if we fail to parse the cpio header, instead of using potentially
bogus header values.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 init/initramfs.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 8d931ad4d239b..84d94dc71e8f0 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -193,14 +193,16 @@ static __initdata gid_t gid;
 static __initdata unsigned rdev;
 static __initdata u32 hdr_csum;
 
-static void __init parse_header(char *s)
+static int __init parse_header(char *s)
 {
 	__be32 header[13];
 	int ret;
 
 	ret = hex2bin((u8 *)header, s + 6, sizeof(header));
-	if (ret)
+	if (ret) {
 		error("damaged header");
+		return ret;
+	}
 
 	ino = be32_to_cpu(header[0]);
 	mode = be32_to_cpu(header[1]);
@@ -214,6 +216,7 @@ static void __init parse_header(char *s)
 	rdev = new_encode_dev(MKDEV(be32_to_cpu(header[9]), be32_to_cpu(header[10])));
 	name_len = be32_to_cpu(header[11]);
 	hdr_csum = be32_to_cpu(header[12]);
+	return 0;
 }
 
 /* FSM */
@@ -293,7 +296,8 @@ static int __init do_header(void)
 			error("no cpio magic");
 		return 1;
 	}
-	parse_header(collected);
+	if (parse_header(collected))
+		return 1;
 	next_header = this_header + N_ALIGN(name_len) + body_len;
 	next_header = (next_header + 3) & ~3;
 	state = SkipIt;
-- 
2.51.0

