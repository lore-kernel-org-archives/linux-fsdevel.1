Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6FE351C3C
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 15:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777305140; cv=none; b=JoRUjeYYY+mFfDj6gBlTJqMOp1e4x98CGvSAtn6y697B0tLmkHSD7AvA/jVrCMPUI6abwKciuiWhYXsMqisHhiQOcry6WfF0ppGKBLmDv+E6st7oIO4Coit6IV7/b3oL5vB3ly03dwVwYblN58SN0Bsab1T82Fx0cRNJSwZRQYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777305140; c=relaxed/simple;
	bh=eTk+lxFizvk5OH9bvq2BhLcOTQzxzjd9be9uN6z10uY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eN8wkVPzgmBr+JY1vajljnRcYM83sQeHuk8Bz7S/JVfRYaIfWYIr12IjiHBkYhbGAQLDIVz+nVWZk0+zW3/5LNXV/5Zsqba7DXjfynE5RnmZhjGK7HDGZakVm4b3HbheAxM2RSc1sGylLtj8npwQbYsVGFo7wMlkeiQmZjsTzZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BHgCZT8h; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wOfo/rQ0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T1mr9ZIz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+iLU1mmz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BHgCZT8h";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wOfo/rQ0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T1mr9ZIz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+iLU1mmz"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1FC706A83F;
	Mon, 27 Apr 2026 15:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777305137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ueMDijM+KRNJ7u8kxNsJ1ttF7vmElxins719UzGE0nA=;
	b=BHgCZT8hIQt6oruZ7YJdfEYxlA58bX7+4ZJCFuAHk6Cu5Kja7fdEbfUGHO2mrmFc2k5QyI
	59yX6/6XOGJujKTVKMHbDby/y8mCRzZvmFQLBpsqvUXNhmKmfQmLDyotHWGdtQ0Go/ZE3h
	6/UjqtCcbptXYHgS5/b/xS773yAwSUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777305137;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ueMDijM+KRNJ7u8kxNsJ1ttF7vmElxins719UzGE0nA=;
	b=wOfo/rQ0qfFBQFchwNWt0j1dUIhz+WYuBA8gpoHBZKk18uMlXI+wOQ4Q3emUop6eu4QEKT
	qrizkOyb/Nz/K8Bg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=T1mr9ZIz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+iLU1mmz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777305136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ueMDijM+KRNJ7u8kxNsJ1ttF7vmElxins719UzGE0nA=;
	b=T1mr9ZIzA6rvgH1yFa9DN/IMW3bahSxzhV6iwlJMkW5jX6UDElvKDDHoIvfqAUAAjElO9c
	5otyAzcBfP7LQZg2hUMQMlJgTBchxYi/Ukxi26BXzV7LT/7dVPc0f2UkhMhO4TT/dbPRVo
	Ev0wc1lbXnVXzlu40qnO+ipghD52LQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777305136;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ueMDijM+KRNJ7u8kxNsJ1ttF7vmElxins719UzGE0nA=;
	b=+iLU1mmzYp10OUXYTuiYwS8Ia9cXDTn9fYEF02xXGFFHFQmcUlmog6BMNqXLhoj24yw6sb
	4FrtTVA8r1ax7xCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 17460593B0;
	Mon, 27 Apr 2026 15:52:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /ASmBTCG72kcawAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 27 Apr 2026 15:52:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CEB5AA0B3C; Mon, 27 Apr 2026 17:52:07 +0200 (CEST)
Date: Mon, 27 Apr 2026 17:52:07 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Fsnotify fixes for 7.1-rc2
Message-ID: <fpk463rrvt2yisauvvxmwnsboigqh6rj4wokkee4xkezzdlqvr@nixbnm5cx2ia>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.com:email]
X-Rspamd-Queue-Id: 1FC706A83F
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v7.1-rc2

to get three fixes for fsnotify / fanotify.

Top of the tree is 4aca914ac152. The full shortlog is:

Amir Goldstein (1):
      fsnotify: fix inode reference leak in fsnotify_recalc_mask()

Ethan Carter Edwards (1):
      fanotify: Fix spelling mistake "enforecement" -> "enforcement"

Miklos Szeredi (1):
      fanotify: fix false positive on permission events

The diffstat is

 fs/notify/fanotify/fanotify.c    |  2 +-
 fs/notify/fsnotify.c             |  2 +-
 fs/notify/mark.c                 | 57 +++++++++++++++++++++++++++++++++-------
 include/linux/fsnotify_backend.h |  1 +
 4 files changed, 50 insertions(+), 12 deletions(-)

							Thanks
								Honza


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
