Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301273F44DA
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781534821; cv=none; b=fXsHaIjmXKiGCm5DsGTOcj1wzpf/BokER5vQv8QrfvSs+VRu+9aGoQqYOMZEGG6t4ISZeaPQ5oHCkLfe/ZuXe0h5ytY5xbMz3k4/DQerIdYE+s/qudZQrnSMtrcOB0iI5cwKxjyrRvB6nRBm9uRbX6nspk6Xojn5u9MXnsrz7Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781534821; c=relaxed/simple;
	bh=E/s8OeLU0lyRJTMkr9UJJITvs51zFWD7vDd94wz13s8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Iv1f+kNI1Uc7kJKZRcLkK8TKWm42w8AVzT4eyudB8HIU6wIwQx600GMzweBzgpttn/FscXqbDwJrmLj78CVUpmF6NUUNJ5018FMsWHX6T5fpFBS9P/chF7WU+KS/9ld7PFFoK8rxsEMcxUiL9HkfDT1R+CRZYOLqbEP60qlwXuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PC5bXR76; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IwzF7U1N; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PC5bXR76; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IwzF7U1N; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PC5bXR76";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IwzF7U1N";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PC5bXR76";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IwzF7U1N"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 286E76A7D7;
	Mon, 15 Jun 2026 14:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1781534818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=TdbizQCql5N090RV/sZd22vLfzOeMDO0gacXCH28QMY=;
	b=PC5bXR76sN7nvS1Hu9oGIGgSsV1iuwkZRRud34jucmzmU/hUW6vOOVpBzrnT5AiO1kD43S
	KSdjl78P818YMx7xf/2tgbHjIDUfS/5wfXdigPoxfkTQsxdICa+LFLnlkSKVEBND2js58J
	foszveoM8JTIOtYUmTdC1bbQQeRpgSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1781534818;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=TdbizQCql5N090RV/sZd22vLfzOeMDO0gacXCH28QMY=;
	b=IwzF7U1NKEah5bB5EJyFklm1a+vhEw39mFi9CYKIzWqxe9aU1XN2/S/kL/5xU1HjuKi/Eh
	BHIb8pP0K2XBPBDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PC5bXR76;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IwzF7U1N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1781534818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=TdbizQCql5N090RV/sZd22vLfzOeMDO0gacXCH28QMY=;
	b=PC5bXR76sN7nvS1Hu9oGIGgSsV1iuwkZRRud34jucmzmU/hUW6vOOVpBzrnT5AiO1kD43S
	KSdjl78P818YMx7xf/2tgbHjIDUfS/5wfXdigPoxfkTQsxdICa+LFLnlkSKVEBND2js58J
	foszveoM8JTIOtYUmTdC1bbQQeRpgSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1781534818;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=TdbizQCql5N090RV/sZd22vLfzOeMDO0gacXCH28QMY=;
	b=IwzF7U1NKEah5bB5EJyFklm1a+vhEw39mFi9CYKIzWqxe9aU1XN2/S/kL/5xU1HjuKi/Eh
	BHIb8pP0K2XBPBDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1FB03779A7;
	Mon, 15 Jun 2026 14:46:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Oxe1B2IQMGrnfwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Jun 2026 14:46:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BFF6AA12D2; Mon, 15 Jun 2026 16:46:57 +0200 (CEST)
Date: Mon, 15 Jun 2026 16:46:57 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Fsnotify changes for 7.2-rc1
Message-ID: <ljorgdnz6rwsg73eozwdg4uzg5gqdaazqdv4lyyt4nuc7b3ouy@vdbnsxmez4t2>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 286E76A7D7
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v7.2-rc1

to get:

  * fanotify improvements for pidfd reporting
  * small cleanup in fanotify_error_event_equal

Top of the tree is 82c6dd20479b. The full shortlog is:

AnonymeMeow (2):
      fanotify: report thread pidfds for FAN_REPORT_TID
      fanotify: allow reporting pidfds for reaped tasks

Thorsten Blum (1):
      fanotify: simplify fanotify_error_event_equal

The diffstat is

 fs/notify/fanotify/fanotify.c      | 22 ++++++++++++----------
 fs/notify/fanotify/fanotify_user.c | 33 +++++++--------------------------
 fs/pidfs.c                         | 10 ++++++----
 include/linux/pidfs.h              | 18 +++++++++++++++++-
 4 files changed, 42 insertions(+), 41 deletions(-)

							Thanks
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
