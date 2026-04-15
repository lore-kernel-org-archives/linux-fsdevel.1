Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768AC23A562
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 10:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776248382; cv=none; b=okigpUrLvlflq88tVTR2xpx5MzJnPQrXT/qwR9h/4LvxsBsaJlzuDDb2H4qB+siRdv2WOqMIBmyNQWHd7nmi4pPS+c5TPkGsUJuMpVGo8tVnPN32o/bbmwqOAmr3eI5+oiIEBYbDttZ6Wdcdk24DWghmscxUX1q7OM6OOShI9D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776248382; c=relaxed/simple;
	bh=6roUJwzwZ0fhCmhmT2/XGAvoMbLmy+pFYp90EFfer0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sQeuMm2zeMw43Kj7jKQDXEBC2+Yd0iUJ1kjZXJOCHppyh0oLLs84yYTewltN00SIWZLAVlyKBUSnDGEKJzrGbnHw6nYr6oV+NAgg8Odd3qT/tXqJNF+yuSK9njnV1AMxBHi9MjOXkzk5lCm1NOwX1XGcU1EmpBvrXxqSk600MM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FNNe+jFW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DKrBP+Qo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FNNe+jFW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DKrBP+Qo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FNNe+jFW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DKrBP+Qo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FNNe+jFW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DKrBP+Qo"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 845466A7E3;
	Wed, 15 Apr 2026 10:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776248379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=x+uNiCJewwA27z0JohqRn5xkValtWUJGF8JiOnySkFo=;
	b=FNNe+jFWxVbKeB6iON4RucVd4XwReIumuP4QGezkVQGXbPcoj9luQKo1lD820vgk4qR8te
	Jc14vEzY40J+p1A6kD58pPIh9obRjmnCVXFMSuOjd8pKISZxVRBf3kutlN5Pq4ye+dVbjT
	WYelOc0bZ0FvNqjYLuhMt8wuyk8hikU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776248379;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=x+uNiCJewwA27z0JohqRn5xkValtWUJGF8JiOnySkFo=;
	b=DKrBP+QovqHWV4ct/p6CGBU0B+eZfCkHRceiqJmUkw5niyKuaPHtxyRfmiiW3Bdexah6rK
	XS2hPtgWkjcJd7AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FNNe+jFW;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DKrBP+Qo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776248379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=x+uNiCJewwA27z0JohqRn5xkValtWUJGF8JiOnySkFo=;
	b=FNNe+jFWxVbKeB6iON4RucVd4XwReIumuP4QGezkVQGXbPcoj9luQKo1lD820vgk4qR8te
	Jc14vEzY40J+p1A6kD58pPIh9obRjmnCVXFMSuOjd8pKISZxVRBf3kutlN5Pq4ye+dVbjT
	WYelOc0bZ0FvNqjYLuhMt8wuyk8hikU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776248379;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=x+uNiCJewwA27z0JohqRn5xkValtWUJGF8JiOnySkFo=;
	b=DKrBP+QovqHWV4ct/p6CGBU0B+eZfCkHRceiqJmUkw5niyKuaPHtxyRfmiiW3Bdexah6rK
	XS2hPtgWkjcJd7AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A5AC4B964;
	Wed, 15 Apr 2026 10:19:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1azYHTtm32llKQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 15 Apr 2026 10:19:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2C8F0A0B59; Wed, 15 Apr 2026 12:19:35 +0200 (CEST)
Date: Wed, 15 Apr 2026 12:19:35 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Fsnotify changes for 7.1-rc1
Message-ID: <6mrxhg6cbhfmo6dff7b5jgxxckemswceme7xltwa3rpas4dbqp@5b576nbeagp5>
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
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[suse.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 845466A7E3
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v7.1-rc1

to get a couple of small fsnotify fixes and cleanups.

Top of the tree is 0fdbe845534f. The full shortlog is:

Chia-Ming Chang (1):
      inotify: fix watch count leak when fsnotify_add_inode_mark_locked() fails

Ondrej Mosnacek (2):
      fanotify: avoid/silence premature LSM capability checks
      fanotify: call fanotify_events_supported() before path_permission() and security_path_notify()

Sun Jian (1):
      fsnotify: inotify: pass mark connector to fsnotify_recalc_mask()

Thorsten Blum (1):
      fanotify: replace deprecated strcpy in fanotify_info_copy_{name,name2}

The diffstat is

 fs/notify/fanotify/fanotify.h      |  5 ++--
 fs/notify/fanotify/fanotify_user.c | 50 ++++++++++++++++++--------------------
 fs/notify/inotify/inotify_user.c   |  3 ++-
 3 files changed, 28 insertions(+), 30 deletions(-)

							Thanks
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
