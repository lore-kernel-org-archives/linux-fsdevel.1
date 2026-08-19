Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B368F35DA6D
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787150801; cv=none; b=tDUa+8CRRNOTQn3EzEoyeJ+op2ayW6sDwB4jOzAo47tj6PzpTLIVZ8D+gGZJ4BKe4SeFUXQTch/LowqyVCJ4+izvnzzva9zZxIi45QXC9XzgIkW/6BSvxIsxdK2IiEyurdMjCBgAjfBxg40150rZiwRUUJf2Eo/dknqmDldTKu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787150801; c=relaxed/simple;
	bh=eLTM2hhkq46wiV5Q7YSfPJ9j4uSg8UEDA+f/WCG44L0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AF2jBNvTmD94koEfEr6Z9Kff8PGwyLn5UN0Tou8c/sHeqAPuZoZbPHuiBagRLdqu9kkzuAobxmHeMZPqXYeLhJzCNhelCArEiA4OLDyi40QL87NtNvsqcE2X7UxZM0EmYMiAH9kvMD6HH8ekl1+nkOPr6VRHOTfJyhLDLP8OAUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PKDnz0R2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=69ejflw7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uDYHmbke; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=s0c6hggm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PKDnz0R2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="69ejflw7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uDYHmbke";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="s0c6hggm"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5160D3EA4;
	Wed, 19 Aug 2026 14:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787150793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=wAeZhR3KG7xxIyQBU6Hfsyc6qraZl7W7oTl/S2nbul8=;
	b=PKDnz0R2wnYNHpy8mVFWxsmUpouKLPJsDuXMCVkQVoXrQ1ParU5gasiwi5PbaB+h62xWDZ
	56mZHtLZSoE/ajFLanj/DdORwRTmZRw49yJ9qowfmRpjvPqHGsRRVU/OfC6q84XxVyTmDK
	s5AiZsZ/+OwFA8ZZ33rzwzfSCNbNQBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787150793;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=wAeZhR3KG7xxIyQBU6Hfsyc6qraZl7W7oTl/S2nbul8=;
	b=69ejflw7eQCBLbyleGHBu0VVSKIaC2RoSuzdHrObaDCM0susItc45nBUkz8kx/j3mwznPy
	ofTTridxhfpKQvAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uDYHmbke;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=s0c6hggm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787150789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=wAeZhR3KG7xxIyQBU6Hfsyc6qraZl7W7oTl/S2nbul8=;
	b=uDYHmbketvQYPlaYdBy6yKaXg18U3MHniwh4KDHGYS56UyFcnxETCy2jQXFiOzHtLtW9r4
	oTq9AcD1L/RCgxleN+mIDg4JBKsNGiscGlLBQLzTtgvZYFg/bpccHZFCATB6SUKVE/6cZm
	8p0N1LHSqblOCCGi3sax5j2DDTP/IKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787150789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=wAeZhR3KG7xxIyQBU6Hfsyc6qraZl7W7oTl/S2nbul8=;
	b=s0c6hggmkGcn+ksgtctE6MzT5wW3YY58mm9I0s7aiSaBAG56OO3zMi7tYhaZoqJj3guO3c
	trtLabgH8A5/wKAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49D4B2F81;
	Wed, 19 Aug 2026 14:46:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6+H+EcXBhWoHGgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 19 Aug 2026 14:46:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E823BA13B2; Wed, 19 Aug 2026 16:46:28 +0200 (CEST)
Date: Wed, 19 Aug 2026 16:46:28 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Fsnotify fixes for 7.3-rc1
Message-ID: <dwdmf4x7slx3pnpxddsnv3u6r72uduvvksk565ptmspjrigp75@h4ljktlfnt4f>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 5160D3EA4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v7.3-rc1

to get a couple of assorted fixes (mostly stuff spotted by Sashiko) for
fsnotify subsystem. I'm also removing Matt as a reviewer because he was not
active in fsnotify in last years and after he stopped working for Google I
don't have a working contact to him.

Top of the tree is e422777fdd47. The full shortlog is:

Chengfeng Ye (1):
      fanotify: fix use-after-free of file range info

Jan Kara (1):
      fsnotify: Remove Matt Bobrowski as a reviewer

Xuanqiang Luo (1):
      fanotify: initialize permission event watchdog state

Yichong Chen (2):
      fanotify: stop permission watchdog when timeout is zero
      fanotify: report full event length for FIONREAD

Youngjae Kwon (1):
      fsnotify: Fix stale object mask after concurrent mark updates

The diffstat is

 MAINTAINERS                        |  1 -
 fs/notify/fanotify/fanotify.c      |  4 ++--
 fs/notify/fanotify/fanotify.h      |  6 ++++--
 fs/notify/fanotify/fanotify_user.c | 29 ++++++++++++++++++-----------
 fs/notify/inotify/inotify_user.c   | 15 +--------------
 5 files changed, 25 insertions(+), 30 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
