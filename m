Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977759;
	b=Xk1teBhmEVNuxB8JzM1IHbh7KuLfvDttRChycrbvXw0xLlD3HYBTbC8qgBnmWGJNApEc
	 hTtahv6Pyn12Fvkui004/yXkk6e5w8O57jR9MJtZApSfjuQaWNGR6nS7o6kQwb4vLeuSS
	 EMtJb503hIrKQ8mtbWNgmL+gITv1A3sSD/BaWA+uAdv2gI4/4lKjNAwEWnJYPqPeBr8eW
	 B4RCzRxgaDYFirDwnU4n4aRnSmo9VC48funb4eVgBXX8M3+rmtUp17pGRawO4UXM98Fp7
	 kEtGXlz678h/lfAxs2SuBIHMx71lBW07zRvYDG3TCRyVVvVPbAULiuaR9Y2CrKTrPTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977759;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=0tIHHkRtf1vApgCgvqjxjZgZ2w4Ns4V7NgAWNTxHFTk=;
	b=OcR5aZI8HCm8KM0QAOpZW1fRAevrzVntMIweeB82PRRk2SJKvnNu1KqGPK8FnMgcywO8
	 WGGfSkIYW6jU6WR89+hGTVLAkr4Ly8+d/ZucamtHLQRsCNxN29rS7qGddhq28Jb8cOIti
	 3MbKt99Niear6VCExYDHWfSb0y9xfnSALofdRwdIAkqWj//Fc6QEW6Db8MVbUyvBmCLe1
	 bGD5v2KJmW7eum0zbW/Z+Jt/cKQrnimAqN9XuiV/RJ2OjruC2l8HFq3dJ6JEfnLQRdvO4
	 f6Pfu4fFmH6InR5+AVVmtcA2BmJp1+2INgpnPKRAdWwJa1xzENn64VX3fdM5X0s123Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=D9zx46Wm;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qYT7j5r8;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=D9zx46Wm;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qYT7j5r8;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979FA606A326
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 15:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 979FA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=D9zx46Wm;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qYT7j5r8;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=D9zx46Wm;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qYT7j5r8
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9251D2211E;
	Fri,  6 Nov 2026 15:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793977753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=0tIHHkRtf1vApgCgvqjxjZgZ2w4Ns4V7NgAWNTxHFTk=;
	b=D9zx46WmXoRx1mmUbw05S8erkQIIUubXyZ+YjeAVhQUBIL30Iuz0O17EnS5Mr3th8D2eLg
	fzO8ygZbWebWnVX8IUrcdl6KlPXC6dI40v3KI+TEbn0P/Tlunl9vE2idLq41LfFd8j8Nk4
	AtC8mDlThLd53bcaQugy3pogK5IlZQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793977753;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=0tIHHkRtf1vApgCgvqjxjZgZ2w4Ns4V7NgAWNTxHFTk=;
	b=qYT7j5r8DKFZNK7QajADuuKbnXMwx1bBHy7Y7iySrwdUiFKXTxcyILqYL9GSvIHGtsRolv
	nF/wSHIjBmj0NvBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=D9zx46Wm;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qYT7j5r8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793977753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=0tIHHkRtf1vApgCgvqjxjZgZ2w4Ns4V7NgAWNTxHFTk=;
	b=D9zx46WmXoRx1mmUbw05S8erkQIIUubXyZ+YjeAVhQUBIL30Iuz0O17EnS5Mr3th8D2eLg
	fzO8ygZbWebWnVX8IUrcdl6KlPXC6dI40v3KI+TEbn0P/Tlunl9vE2idLq41LfFd8j8Nk4
	AtC8mDlThLd53bcaQugy3pogK5IlZQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793977753;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=0tIHHkRtf1vApgCgvqjxjZgZ2w4Ns4V7NgAWNTxHFTk=;
	b=qYT7j5r8DKFZNK7QajADuuKbnXMwx1bBHy7Y7iySrwdUiFKXTxcyILqYL9GSvIHGtsRolv
	nF/wSHIjBmj0NvBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B9AD132C9;
	Fri,  6 Nov 2026 15:09:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p8L/EZnt7WpGHgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 06 Nov 2026 15:09:13 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id ED7CF21BAA; Fri, 06 Nov 2026 16:08:57 +0100 (CET)
Date: Fri, 6 Nov 2026 16:08:57 +0100
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fsnotify fixes for 7.4-rc2
Message-ID: <q7drckhsrlj6opkqs2b7kco3ttp46yi6rwhcrrawrnmckqpm4m@4qheazgvbo45>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 9251D2211E
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim]
X-Spam-Score: -13.01

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v7.4-rc2

to get two small fixes for fsnotify.

Top of the tree is 581230d2ec3c. The full shortlog is:

Avi Weiss (1):
      fsnotify: preserve 64-bit pre-content ranges

Hungyu Lin (1):
      inotify: do not coalesce rename events

The diffstat is

 fs/notify/fanotify/fanotify.h        | 2 +-
 fs/notify/fsnotify.c                 | 2 +-
 fs/notify/inotify/inotify_fsnotify.c | 2 +-
 include/linux/fsnotify.h             | 4 ++--
 include/linux/fsnotify_backend.h     | 6 +++---
 5 files changed, 8 insertions(+), 8 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
