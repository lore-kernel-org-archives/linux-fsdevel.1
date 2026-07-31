Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A9B2E7BD3
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 20:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785529267; cv=none; b=LR/7h1wdzWXwr1LswcrrGiCrJU9Cs4/H+Ec1YSTENknChFJyCEPCferRPALsQ/rLBW/bfhPvoJSKdSh1JLxX4KY8e4usxtVzfB6pknqzpxNAzcDFF5KZjYq8YRInX9VpiWPwrYcIwFc2GaHffXntPOAPrPdMbinEasr7Bnoa2uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785529267; c=relaxed/simple;
	bh=+NJCTNtGVYu8xBVZDgRKnvfoCy19hD4QWaA8zlNuPTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o8NZ+waML+5CS2lIAgpBJaaethgXTXYf1HEfzFPkXwSeLNwNixtTdA2FCQqS0Mbp2JA3vKM7Wg2BYHjTXK5gK6cnWhqb+bzIDR5cL/2lI3T8UZT5hPiiu1wrO45aCvewFJGUQjjvR5G7iRiVCWAP/i6e97kxk7mURdnTNlFs5q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=raOIzrtv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L0o6f5na; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Jg9IIhgE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oZZXgNZq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="raOIzrtv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L0o6f5na";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Jg9IIhgE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oZZXgNZq"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 922984230;
	Fri, 31 Jul 2026 20:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785529259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xi4hOpBf4tvg+RYfjCPWhtEhyVtAOyOUbKn6cB5v38E=;
	b=raOIzrtvNpgGLqyV05Db5C2rgbHXgqYAjToOSYsGMhD+Ae8Vd61uGy697QHcKm8X7eEzPb
	f/MQ7w7taw1dJP9RDSu8L+jpCwLFHblBWHSFACJ5YOdALE3ao7kg+ejNFJAXYYHNrq2Scg
	dlcMVLUM511a7B+hYXtS++J+RAZ7lg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785529259;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xi4hOpBf4tvg+RYfjCPWhtEhyVtAOyOUbKn6cB5v38E=;
	b=L0o6f5naY6cYurtGxDePsOWsIpeWIbV5jrPvv46mfM/n7x4Hig0nr6Rm/wKVhuCy4E8u0V
	1tRQdkZHqXD47sAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785529255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xi4hOpBf4tvg+RYfjCPWhtEhyVtAOyOUbKn6cB5v38E=;
	b=Jg9IIhgEmj11Q337OJsg/Oz6epIcn1EIITvKqujL4pfLa1LI+RoQIMNQGdQyEUJDR7a9xf
	1WH4Dq0RAe+2zXsRZb7/aGQRqUeiGtKO4n3dq/MN31hkYMnBaWxQU077kxFSBhPz/UDtRO
	o+bc1Qrqt3hQkK4B3/jDN+oDyLI/+ww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785529255;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xi4hOpBf4tvg+RYfjCPWhtEhyVtAOyOUbKn6cB5v38E=;
	b=oZZXgNZqbJqRZ4O305NJy+xAHqvA6FozBOXOiz73WpMHwzS/KQBG7t3EbN4nkTF+nfT8RR
	mwOJ0Q2ef9ObeuAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3EEA2779B0;
	Fri, 31 Jul 2026 20:20:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 71YeA6cDbWqOTAAAD6G6ig
	(envelope-from <krisman@suse.de>); Fri, 31 Jul 2026 20:20:55 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: andrealmeid@igalia.com,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH] fs/unicode: Properly reject invalid encoding version strings
Date: Fri, 31 Jul 2026 16:20:45 -0400
Message-ID: <20260731202045.4050076-1-krisman@suse.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]

Casefolding filesystems can request a specific version of UTF-8 at
mount-time.  utf8_parse_version then assembles the "major.minor.rev"
string into an unsigned int.  There were two issues with the parser
logic: first, individual fields are read as signed int, allowing
negative numbers, second, an overflowed field will result in unexpected
results. Something like the below actually succeeds to mount using
utf8-12.1.0.

 mount -t tmpfs -o casefold=utf8-12.0.256 none /mnt
[   10.867859] tmpfs: Using encoding : utf8-12.1.0

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 fs/unicode/utf8-core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index 543c60c12461..c0a41b712e42 100644
--- a/fs/unicode/utf8-core.c
+++ b/fs/unicode/utf8-core.c
@@ -226,17 +226,19 @@ int utf8_parse_version(char *version)
 	substring_t args[3];
 	unsigned int maj, min, rev;
 	static const struct match_token token[] = {
-		{1, "%d.%d.%d"},
+		{1, "%u.%u.%u"},
 		{0, NULL}
 	};
 
 	if (match_token(version, token, args) != 1)
 		return -EINVAL;
 
-	if (match_int(&args[0], &maj) || match_int(&args[1], &min) ||
-	    match_int(&args[2], &rev))
+	if (match_uint(&args[0], &maj) || match_uint(&args[1], &min) ||
+	    match_uint(&args[2], &rev))
 		return -EINVAL;
 
+	if (maj > U8_MAX || min > U8_MAX || rev > U8_MAX)
+		return -EINVAL;
 	return UNICODE_AGE(maj, min, rev);
 }
 EXPORT_SYMBOL(utf8_parse_version);
-- 
2.55.0

