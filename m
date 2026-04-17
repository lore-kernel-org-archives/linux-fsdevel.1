Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6D723D283
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 01:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776390380; cv=none; b=A1D5EvANrftZz96NUrRpCFlX7bobg9ClNOcXz7tp0CuQB2UiMQ0RFIX0lo7akVEZAG50kyF/075ruNFyGxC8pH5r915rs2hQIQxzXuvOyNRL/nWNq3ayaAcuzgtZrgzPh5uEswq7Q/7crNLGi78byb9I8LSrS6A/Nu9dhZ0hmyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776390380; c=relaxed/simple;
	bh=ZRJX8CNoXZvic0Ybm/T5AFU/a2lLFpBHz2IJefsXF04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PskA179aMDPRu+4NAujqM4zSxluL4qpPFdYrZZVADtZ2/TJGrOnra2QVGcII3RY40eFrJK8FANwxAfUCkS+YeZG0E1KrrtkQY3OmjFIiCzKw91m01U3pRufvEqKwIv4twsXIRIYW56ZpXkWwyzPAfzgXVhA8I5HtsdFb0pdv5ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b5Ac9iXo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zYUyQdXn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b5Ac9iXo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zYUyQdXn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b5Ac9iXo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zYUyQdXn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b5Ac9iXo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zYUyQdXn"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 404956A936;
	Fri, 17 Apr 2026 01:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776390372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=OGzF7Yi40Gm2TNXJQlgKLjahaFlkUzmMxA1OR2Usmts=;
	b=b5Ac9iXoatDDGWqAm7pXvB9nFYOJGS0o+FqgPLzqJ6QvzGFzJcnklRwQzGv9tKuCqZfJCb
	A37RWNE4EqwoxEd6Hpl0Qtj2mscY4J5idMF6q1gbIfNFc57DOQJWX9gUyvNzarTeeybggZ
	KoTv2HDO6/BhHWypuA0HVbb9fr8xNlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776390372;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=OGzF7Yi40Gm2TNXJQlgKLjahaFlkUzmMxA1OR2Usmts=;
	b=zYUyQdXnR3dypiIvsXxxl0s0c4FdSXBZupbB7WUkWBkL8owOrml7K4GziV+lLNVeRF+33k
	mdp7PBQ8ofz8oxAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=b5Ac9iXo;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zYUyQdXn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776390372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=OGzF7Yi40Gm2TNXJQlgKLjahaFlkUzmMxA1OR2Usmts=;
	b=b5Ac9iXoatDDGWqAm7pXvB9nFYOJGS0o+FqgPLzqJ6QvzGFzJcnklRwQzGv9tKuCqZfJCb
	A37RWNE4EqwoxEd6Hpl0Qtj2mscY4J5idMF6q1gbIfNFc57DOQJWX9gUyvNzarTeeybggZ
	KoTv2HDO6/BhHWypuA0HVbb9fr8xNlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776390372;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=OGzF7Yi40Gm2TNXJQlgKLjahaFlkUzmMxA1OR2Usmts=;
	b=zYUyQdXnR3dypiIvsXxxl0s0c4FdSXBZupbB7WUkWBkL8owOrml7K4GziV+lLNVeRF+33k
	mdp7PBQ8ofz8oxAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 03263593AE;
	Fri, 17 Apr 2026 01:46:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uIW9NeOQ4WmiPQAAD6G6ig
	(envelope-from <krisman@suse.de>); Fri, 17 Apr 2026 01:46:11 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: corbet@lwn.net,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>,
	Mel Gorman <mgorman@suse.de>
Subject: [PATCH] eventpoll: Add sysctl quirk to avoid synchronous wakeup
Date: Thu, 16 Apr 2026 21:46:00 -0400
Message-ID: <20260417014600.1513306-1-krisman@suse.de>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 404956A936
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

Upstream commit 900bbaae67e9 ("epoll: Add synchronous wakeup support for
ep_poll_callback") fixes a bug where epoll did not honor the "sync" part
of the wake_up_*_sync request by the original waker when waking up the
epoll waiter. That patch is correct, as I understand it, because it lets
the caller decide and the most likely general case for a
producer-consumer application using epoll is "wait on data on the socket
and then consume it".

Nevertheless, it caused a regression in a proprietary database benchmark
that communicates over TCP on localhost. The TCP detail is only relevant
because it will unconditionally use an WF_SYNC (in sock_def_readable) to
wake its waiters.  But, in general, for threads that are just signaling
an operation via epoll, and not necessarily consuming that data, pulling
the application closer to a cpu-intensive waker task can actually harm
performance, as there is not much data access to benefit from data
locality.  This seems to be the case for this workload.

This is a tricky case for an heuristic, IMO, since it would be hard to
predict what the epoll user wants.  I considered adding an epoll_ctl
flag to let the user configure the desired behavior, but it feels too
much of an specific scheduler detail to be exposed in the syscall API,
and it would likely cause user confusion.  In addition, it would require
recompilation of user applications needing this behavior.

Instead, this patch adds a new sysctl for a system-wide quirk that can
be enabled only when it is known to benefit the workload.  While
different workloads would benefit from different behaviors, it is
unclear these exist in parallel and that reverting to the older behavior
would cause performance regressions.

Cc: Mel Gorman <mgorman@suse.de>
Fixes: 900bbaae67e9 ("epoll: Add synchronous wakeup support for ep_poll_callback")
Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>

---
I get the fixes tag is hardly appropriate here, but it serves as a
reasonable way to link to the original patch.
---
 Documentation/admin-guide/sysctl/fs.rst | 10 ++++++++++
 fs/eventpoll.c                          | 12 +++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
index 9b7f65c3efd8..9052ad3f8404 100644
--- a/Documentation/admin-guide/sysctl/fs.rst
+++ b/Documentation/admin-guide/sysctl/fs.rst
@@ -338,6 +338,16 @@ on a 64-bit one.
 The current default value for ``max_user_watches`` is 4% of the
 available low memory, divided by the "watch" cost in bytes.
 
+force_async_wake
+----------------
+
+When an epoll event occurs, the kernel will attempt to "pull" the epoll
+waiter task closer to the cpu where the task that initiated the event is
+and switch to it sooner.  While most workloads benefit from this
+behavior, this switch allows disabling it, leaving the epoll task where
+it is.  Setting it to 1 can harm performance for most applications, but
+might benefit others.
+
 5. /proc/sys/fs/fuse - Configuration options for FUSE filesystems
 =====================================================================
 
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 23f3c6ac0bad..aed0dcc50530 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -257,6 +257,9 @@ struct ep_pqueue {
 /* Maximum number of epoll watched descriptors, per user */
 static long max_user_watches __read_mostly;
 
+/* Whether wakee should always be waken up asynchronously */
+static bool sysctl_force_async_wake __read_mostly = false;
+
 /* Used for cycles detection */
 static DEFINE_MUTEX(epnested_mutex);
 
@@ -332,6 +335,13 @@ static const struct ctl_table epoll_table[] = {
 		.extra1		= &long_zero,
 		.extra2		= &long_max,
 	},
+	{
+		.procname	= "force_async_wake",
+		.data		= &sysctl_force_async_wake,
+		.maxlen		= sizeof(sysctl_force_async_wake),
+		.mode		= 0644,
+		.proc_handler	= proc_dobool,
+	},
 };
 
 static void __init epoll_sysctls_init(void)
@@ -1318,7 +1328,7 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 				break;
 			}
 		}
-		if (sync)
+		if (sync && !sysctl_force_async_wake)
 			wake_up_sync(&ep->wq);
 		else
 			wake_up(&ep->wq);
-- 
2.52.0

