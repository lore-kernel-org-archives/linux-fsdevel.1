Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793271437;
	b=17I1mE0bXjh3kS6n8G0xd4j6x4X9PwjtErpmg5bYoq0nai477A5y1GHofau61KPfiFKc
	 Zt1zf8HayLVCJ+jg2kYYql8/g91mJ8pnAsUkjea6on0Ughn+hbpTqI7Mc0dZeGIpNF1vl
	 Y+pUhgcIHriBzAYzq1TlKzPsE5Vr8OL7zngiQxklWITceQrW9Grrw00m8TIu/tG5MJ13z
	 suoD58F8COQN2GaVdRkVOn1qxloFwnims+UqE0hjfR6L+StBTPrOTAGew0BLoFUMcs+PQ
	 QWFFoklGOPSDVruyZ7c169+ZxoGTMV/Zid02JkBUP1MZwrtwGJhOVHMgLB6CUGOqHrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793271437;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Spam-Flag:
	 X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=eHLr56sFD2D2TWh1Q3BE7l/mRjeL6DJWJN7ujgMW5xw=;
	b=vdr30C0zVxlv0Z2SwEw+Bnq64gEFg5rC+kh+1NaLqijPK6HXHdIVp7xI21g9Ft+k64m+
	 ynT4nCCPD24yJrir7VkKoUE9e3A4CiR1a0CWSMSo85EmdbzjQt0Zj/v47FdFNQ0Cdm3+0
	 Fb2S6bDOId0NBCs+NnAmmnOfZgIqYKcRf6tCdIve7flqQ67ATw8GOdqjgwpVIRWD2rTEE
	 KSv+Y0URhPZDYhtu469udqza8+am6A8xkWZgBPYbFRQor2JIzYxV+jVSrWaQpw48IvGT/
	 dkQwy9qQhmSt8gP7qdDRy3Ft28x+53zw8XKTXtDA0T+pdFUFuFOKiv5PnCFQUHMJPzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="jemv/8D2";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=aqFHd81y;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=q1cvKuD4;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=GMehQJnw;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CCD606A31E;
	Thu, 29 Oct 2026 10:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6CCD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jemv/8D2;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=aqFHd81y;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=q1cvKuD4;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=GMehQJnw
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0F1A52213F;
	Thu, 29 Oct 2026 10:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793271435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eHLr56sFD2D2TWh1Q3BE7l/mRjeL6DJWJN7ujgMW5xw=;
	b=jemv/8D299Zjj9ZER5bhD7DSMwR3Sz1cOmsws1LW2NYsHuHjziLl0Hy9jcuaq/qt8gZ0cn
	uiOpfWvrgZagT93pmyQT2X+hxZRHdmYz+fios5rAZZXdLLa0yeDdWAvAFhJhPW3HwIfxAw
	DAgtHgI+UT25n0sG7a3ePIAnHx8UgDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793271435;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eHLr56sFD2D2TWh1Q3BE7l/mRjeL6DJWJN7ujgMW5xw=;
	b=aqFHd81yjn6tarGzEZif3s0HX0wwWsUrsz+Gd3gbqZKySA2lFfY0zJDWjUHZt+Z9mf31XA
	BEEHQL7oWRe/v8Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793271434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eHLr56sFD2D2TWh1Q3BE7l/mRjeL6DJWJN7ujgMW5xw=;
	b=q1cvKuD4pyYlJAe5EpZbRM5WGtXRnjEc3GQ3o4wduOZvwrdmk7gkmOqwodxAjdv3OMfnoa
	yY0iJg3QvVSAkIlhswCR9JPJj0SKVOxK/VMZaCxfqMPb2BQp6ASTKGMnUjyTg/w5faHXzc
	gdoe5bO6yd1dUBFaQt/K3o+vJQXl8FM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793271434;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eHLr56sFD2D2TWh1Q3BE7l/mRjeL6DJWJN7ujgMW5xw=;
	b=GMehQJnwzewnI8GEKLcG3ZvC78IYSsbj7sv6+8Ld820TetOjFhPcfAXwnE8jWfYKPbxpux
	zPjaOhYk7w0ZPnDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81E941339F;
	Thu, 29 Oct 2026 10:57:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9HVAFYkm42qKYAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 29 Oct 2026 10:57:13 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: coda@cs.cmu.edu
Cc: codalist@coda.cs.cmu.edu,
	jaharkes@cs.cmu.edu,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH] coda: fix timeout sysctl width on big-endian architecture
Date: Thu, 29 Oct 2026 11:57:01 +0100
Message-ID: <20261029105701.3829-1-fmancera@suse.de>
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
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-11.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -11.80

coda_timeout is an unsigned long, but the "timeout" sysctl entry uses
proc_dointvec() with .maxlen = sizeof(int), so the handler accesses only
four bytes of the eight-byte variable.

On little-endian this works, since the four bytes are the low half. On
64-bit big-endian they are the high half. The sysctl reads back 0
instead of the default 30, and writing N sets coda_timeout to N * 2^32 +
30 seconds, so a stuck upcall effectively never becomes interruptible.

Fix this by using proc_doulongvec_minmax() handler and adjust the
maxlen to the right value.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
Note: found this while fixing a similar issue on SMC sockets. This is
janitorial work, I don't think CODA is used in big-endian at all.
---
 fs/coda/sysctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/coda/sysctl.c b/fs/coda/sysctl.c
index 0df46f09b6cc..73bc48460453 100644
--- a/fs/coda/sysctl.c
+++ b/fs/coda/sysctl.c
@@ -18,9 +18,9 @@ static const struct ctl_table coda_table[] = {
 	{
 		.procname	= "timeout",
 		.data		= &coda_timeout,
-		.maxlen		= sizeof(int),
+		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler	= proc_doulongvec_minmax
 	},
 	{
 		.procname	= "hard",
-- 
2.56.0

