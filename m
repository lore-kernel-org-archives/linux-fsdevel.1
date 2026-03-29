Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BD4274B39
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Mar 2026 10:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774781610; cv=none; b=X8nrtfSFRqh1/HQqtfdS1rXk1eN5SX0EAjYO/vgQKfUJWWTZBuML1CxQ4QIndCY57V1UllaJ7dFSx8bEJNhYdBMCL7Izp7aA2MOqU0FHcZt92Jlo5WzxPg2euQ61CfWAraK45RvOL5fw5x9L1eMwDg3CkdQMwMrr97DZPVZ7THI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774781610; c=relaxed/simple;
	bh=B5s6BrBxmKPMlGATL6TG2UgN41wSmnXZdfBl9YC7S2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YziDxYxuCzrGM+LXCitsmTMBQWvXu1qAg+X2Fm4D8ECv9zk98TekfFQS55qkK0hAupH+7pEs+9QAa4V0F/SpODdAztXju5WrhYMlgxkon2RNxmuApDnj+cgW1j61QS3gY1FLZZF7nBjNkYPp2Yax55fFdJPl/8nQ2OnG/SDs1YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rq/xWJPy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xgyoWXtl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ua92QrVn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xTRiFeDa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rq/xWJPy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xgyoWXtl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ua92QrVn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xTRiFeDa"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DCA1E5BCE6;
	Sun, 29 Mar 2026 10:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774781607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RgBSrZopiOptTJCWGnAFa9Jr1wx7RwVRAFzOn8AqQoI=;
	b=rq/xWJPyIqLFSM1GzCBqcFXS6VvUJMnLx5LBGD/ABoDLRguSiC7OJPLf+A6VYihSpaBCd6
	BnEhU64HGtO/B3UFyIaPEYzJNX2kmdp6QLHLloxkBAujVaugKOUp7Q5kzrhVYqOvQXgSno
	jH+lynsu3jjUQ90EnjR9Pwafce0JM0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774781607;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RgBSrZopiOptTJCWGnAFa9Jr1wx7RwVRAFzOn8AqQoI=;
	b=xgyoWXtlW8f5zmensnQy3iS19btIqiRerb8f+AoQHVyEKa+irqlR4w7jadienM9o5G7cSi
	7JeFwgcxQ4K4dMAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774781606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RgBSrZopiOptTJCWGnAFa9Jr1wx7RwVRAFzOn8AqQoI=;
	b=Ua92QrVnkyqiq8JFZtffYAIb9473Zc4YXGrZco2ErNtDt8HnH0aGPK+azQw5DibmjIn5Io
	Oqrr6Vl4T2LkHT+e6frqiJRkE8wuNXIsTs4+wRvltfaXfYpYzZ+VO31hfJreKsO/ZODcRG
	QfYvhG4wnt+jXbEUZeKZt6FywzbwYhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774781606;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RgBSrZopiOptTJCWGnAFa9Jr1wx7RwVRAFzOn8AqQoI=;
	b=xTRiFeDaECkRuY+TR06PW7BajLNufZHVTCnrLFz9NvD4jdAzY8wlC/zhXVQxpTS8ASbEs2
	3PFbfu+dqY24iYAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAD4D4A0A2;
	Sun, 29 Mar 2026 10:53:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BokCJKIEyWkqcwAAD6G6ig
	(envelope-from <ddiss@suse.de>); Sun, 29 Mar 2026 10:53:22 +0000
From: David Disseldorp <ddiss@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Disseldorp <ddiss@suse.de>,
	Petr Mladek <pmladek@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4 0/6] initramfs: test and improve cpio hex header validation
Date: Sun, 29 Mar 2026 21:30:22 +1100
Message-ID: <20260329105307.2876-1-ddiss@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,intel.com:email,suse.de:mid,suse.de:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Changes v4:
- rework initramfs_test changes to use an inject_ox parameter instead of
  having tests pass through an unvalidated format string.
  + drop Andy's reviewed-by from 1/6 and 2/6 to account for changed test
  + 4/6 minor changes for test context and comment
- add review tags for 3/6, 5/6 and 6/6 following list feedback

----------------------------------------------------------------
v3: 20260323150054.3587083-1-andriy.shevchenko@linux.intel.com

The series that introduced simple_strntoul() had passed into kernel
without proper review and hence reinvented a wheel that's not needed.
Here is the refactoring to show that. It can go via PRINTK or VFS
tree.

I have tested this on x86, but I believe the same result will be
on big-endian CPUs (I deduced that from how strtox() works).

I also run KUnit tests.

Changelog v3:
- rebased on top of latest kernel
- squashed patches proposed by David

v2: 20260121172749.32322-1-ddiss@suse.de
v1: 20260119204151.1447503-1-andriy.shevchenko@linux.intel.com

----------------------------------------------------------------
Andy Shevchenko (4):
      initramfs: Sort headers alphabetically
      initramfs: Refactor to use hex2bin() instead of custom approach
      vsprintf: Revert "add simple_strntoul"
      kstrtox: Drop extern keyword in the simple_strtox() declarations

David Disseldorp (2):
      initramfs_test: add fill_cpio() inject_ox parameter
      initramfs_test: test header fields with 0x hex prefix

 include/linux/kstrtox.h |  9 +++--
 init/initramfs.c        | 68 ++++++++++++++++++++----------------
 init/initramfs_test.c   | 76 ++++++++++++++++++++++++++++++++++-------
 lib/vsprintf.c          |  7 ----
 4 files changed, 105 insertions(+), 55 deletions(-)


