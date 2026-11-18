Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795006529;
	b=T4SMc54tqxXqFEPfCGEp3AmE8UHOPty9Lo/MiM2zW5IcngU6ISmBt/uWh2RwwLipqMtt
	 4lstu0qUEXnfgHX0UKQIGsxD37VLxPnNouybkO8D1LBy6SNWJYFlot9zTrVh50k8ZYknn
	 PQuEBa6n1Bdu5Ldch+uRgSxiNr+YUuYaQsVJhzkD1IawxF9AFKaQBp69dZIixOhLmYIx7
	 zs80hQy47t7lfhexuoayTduqH68EwbUWyVr2wvSOyVay991Y/5/8VSyD6k5qkcp7B5GVp
	 0JRFSLy7TTxZspIIin5RW6bqYXZcfo6R5GiiUcUDiuP+E50nF0kENY5VlZIqsgZ+dWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795006529;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=MrGxyb7w4ndanXowqimguqCFwPDrOE3mSD3YQ6pMNXw=;
	b=lDMhS4CGJnhAVtbklLpV0AEl0CiquVs6bfxZU7kj1yRhOEU43PLNHwj4XXyR7RAHA6MD
	 eF8gE57J0gd+neeJP54/OLKIisReKvbk+Jag3tJIXXalgBNPwO7Jp3EpJ8RDnDggQ00Lu
	 sjbNLUW4uZzX4EnbjHAvpE3KMnaO5OLJi20r2lvi8q4p4SoWc658VYTj/6Sn43FCwSmoX
	 0/PpgA2YCdaBIsXwdoC9wv6mkeNx9AJo1rLQ0VCJLrW3Oxb7IsKAcBGOZuoVWJjxN62oF
	 al6HbKtJv86FiftGSUKf64PLHY/ZDJhRyYwmX4UVj+J5fMTcrT+Gh5KeW+C3XYf6W/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=LQmwE1dK;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vhhl9eA0;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=LQmwE1dK;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vhhl9eA0;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C160606A31C;
	Wed, 18 Nov 2026 12:55:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C160606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=LQmwE1dK;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vhhl9eA0;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=LQmwE1dK;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vhhl9eA0
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 68D151F7EE;
	Wed, 18 Nov 2026 12:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795006527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MrGxyb7w4ndanXowqimguqCFwPDrOE3mSD3YQ6pMNXw=;
	b=LQmwE1dKzttQHye9DbUAcSgcb73AeDe7ty0RoQldUYUI6Ry520WsyBc6dlL+a7U29u4P8c
	vZko3cCH0SFhBC+RFWlC+QeT41visqWyzAtMqM/G8ffBmqT82/4SV5rXW8Giox4e2oOLq3
	vdwezP6+RpsXQnXW5v5qzOg8HIfI7OI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795006527;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MrGxyb7w4ndanXowqimguqCFwPDrOE3mSD3YQ6pMNXw=;
	b=vhhl9eA0izfDy7BsfYWJext14JNoob/JhKzYu3VmB6IjFUh0EjGGme1hZKB8XVgJ+HogAg
	AR+CRUnVAcG4MMDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LQmwE1dK;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vhhl9eA0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795006527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MrGxyb7w4ndanXowqimguqCFwPDrOE3mSD3YQ6pMNXw=;
	b=LQmwE1dKzttQHye9DbUAcSgcb73AeDe7ty0RoQldUYUI6Ry520WsyBc6dlL+a7U29u4P8c
	vZko3cCH0SFhBC+RFWlC+QeT41visqWyzAtMqM/G8ffBmqT82/4SV5rXW8Giox4e2oOLq3
	vdwezP6+RpsXQnXW5v5qzOg8HIfI7OI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795006527;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MrGxyb7w4ndanXowqimguqCFwPDrOE3mSD3YQ6pMNXw=;
	b=vhhl9eA0izfDy7BsfYWJext14JNoob/JhKzYu3VmB6IjFUh0EjGGme1hZKB8XVgJ+HogAg
	AR+CRUnVAcG4MMDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3EAA7134E9;
	Wed, 18 Nov 2026 12:55:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yHdBBz+g/WqVWgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 18 Nov 2026 12:55:27 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id C79822504A; Wed, 18 Nov 2026 13:55:22 +0100 (CET)
Date: Wed, 18 Nov 2026 13:55:22 +0100
From: Jan Kara <jack@suse.cz>
To: Junyoung Jang <graypanda.inzag@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, Matt Bobrowski <matt@bobrowski.net>, 
	Gwanhyun Lee <gwanhyunlee@gmail.com>, fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] fuse, fsnotify: handle embedded NUL names safely
Message-ID: <pyy2dos7pzh5b6jzxpahpza3ignyvzxhtha4rlskupz37wl43y@fdricsqn7y7q>
References: <20261117135146.3174252-1-graypanda.inzag@gmail.com>
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
In-Reply-To: <20261117135146.3174252-1-graypanda.inzag@gmail.com>
X-Rspamd-Queue-Id: 68D151F7EE
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-11.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[szeredi.hu,suse.cz,gmail.com,bobrowski.net,lists.linux.dev,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -11.51

On Tue 17-11-26 22:51:34, Junyoung Jang wrote:
> FUSE READDIRPLUS can instantiate a dentry whose length-bearing name
> contains an embedded NUL.  The fsnotify name-copy paths then stop at
> that NUL while retaining the original qstr length, allowing event-name
> buffers to expose uninitialized bytes.
> 
> Patch 1 skips dcache instantiation for these READDIRPLUS entries while
> preserving getdents() behavior.  Patches 2 and 3 copy the full qstr name
> into inotify and fanotify events.  Each patch applies independently to
> the base commit.
> 
> Link: https://lore.kernel.org/linux-fsdevel/20261115210952.2140036-1-graypanda.inzag@gmail.com/
> 
> A custom LLM agent assisted with initial discovery and reproducer
> setup; all root-cause analysis, patches, and runtime tests were
> manually reviewed and verified by the authors.

Thanks, I've added patches 2 & 3 to my tree. Patch 1 is for Miklos so I've
left it alone.

								Honza

> 
> ---
> Changes in v2:
> - Follow Amir Goldstein's review: preserve FUSE readdir output and skip
>   dcache instantiation only for invalid READDIRPLUS names.
> - Replace the event-name strscpy_pad() calls with length-based memcpy()
>   and explicit terminators in inotify and fanotify.
> 
> Tests on 23c62304dde2 in QEMU:
> - Patch 1 alone: READDIR and READDIRPLUS getdents64() returned normally;
>   the embedded-NUL entry was not instantiated, and FUSE_FORGET returned
>   its unused lookup reference.
> - Patch 2 alone: the FUSE READDIRPLUS/inotify reproducer returned the
>   original qstr bytes after the NUL, with no stale slab bytes detected.
> - Patch 3 alone: tmpfs FAN_REPORT_DFID_NAME creation and FAN_RENAME
>   reported the expected names, NUL terminators, and zeroed alignment.
> - All three together: the above FUSE and tmpfs regression probes passed.
> 
> Junyoung Jang (3):
>   fuse: skip dcache instantiation for readdirplus names with embedded
>     NUL
>   inotify: copy full qstr length for event names
>   fanotify: copy full qstr length for copied event names
> 
>  fs/fuse/readdir.c                    |  2 ++
>  fs/notify/fanotify/fanotify.h        | 12 ++++++++++--
>  fs/notify/inotify/inotify_fsnotify.c |  6 ++++--
>  3 files changed, 16 insertions(+), 4 deletions(-)
> 
> 
> base-commit: 23c62304dde29abe92013d85910d03a77dada35d
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
