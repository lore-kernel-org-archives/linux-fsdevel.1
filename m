Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64606282F1E;
	Mon, 31 Aug 2026 10:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788172356; cv=none; b=ePnRM14f7cSUtnRJFvdI/iofXwcnUMkY674I+PQaKSnerW9IspSNoSHmWvOzLGzdEMYrojE/8AyJ8PuAp+yKut9HVDIvlUbrdQXX6FUqtPzt9v/NAyUxKExo3q9okembH1hhoXsEES2rL/WJpH7mkThV5mRfbLPVW1+l2X/MD/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788172356; c=relaxed/simple;
	bh=GczyA7v0iKnbEXrVLW+F6aZQQ7fSZMX272ybm/ztJXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hkqv9mmFmTQfJDc6w17784GW2krNKcbFHPrXmhDc8LlrxgqZidyCcmQmUak1/DicBjjv8IdWsS32Ug4gz3JfXxvq7Ix1farc+smoFj9CctbnRgZtwBIY6VHwVrOxlbFg/o4KV7bQKwR5mJs31u7d7H+9Trcw6gqVAR//nv/6Df0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=njJY3XjG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cSzdxqYU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PNgBLCTP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rIW5owKI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="njJY3XjG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cSzdxqYU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PNgBLCTP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rIW5owKI"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 57D0E1FB59;
	Mon, 31 Aug 2026 10:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788172278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XRNex3+qBCItCxn6F7Fzem4nZKhsLA2RzviX5fQd4ZQ=;
	b=njJY3XjGU3Bz14vXgqoqn+NsNq6Nz/gLb3gqWLr/UyPP2aQHnC6Nf3hRErE4sUf8+eLeHd
	0dt0T3P3YkJGASgW4vtpErxStvJYm+HLPh7W7a8cfVilQxeCR/56N0VHKd0mIkLt4d4zwh
	PoHoa1V+p8bjdbuiIn8zanZAMYWqCUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788172278;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XRNex3+qBCItCxn6F7Fzem4nZKhsLA2RzviX5fQd4ZQ=;
	b=cSzdxqYUS8jTeCgx5/rgOrNm7chcvB0FovGN1z9Cvn7IshDthADEHZkkzBRSLB+J92thq0
	qZc6NSnAqL6t2WBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788172274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XRNex3+qBCItCxn6F7Fzem4nZKhsLA2RzviX5fQd4ZQ=;
	b=PNgBLCTP9hoIXVm3KTEa4zcBGRTAEqk0QfXKwsLmt3mrt/kecez4SeLUnPWleHUYYXbmUZ
	pOAn+6Ti5ilSpGny4eQHpeNuOxkiI1ihgzGMFc8p8nfzOs3Qv2QciUlY8v8/tntApMC+o/
	I+vEf3pt1/X0ceQ0tgAapWpREoEeEKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788172274;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XRNex3+qBCItCxn6F7Fzem4nZKhsLA2RzviX5fQd4ZQ=;
	b=rIW5owKIexNKRTaz7DMNWlgO9rj/wwxZGa6KeXY0aIV25cvNH+NfEFf93wgoDFz6XAM5q5
	1/BDqV1KJ+ExBmCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 362B113515;
	Mon, 31 Aug 2026 10:31:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 15QfDfJXlWpcEQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 31 Aug 2026 10:31:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BE79DA13B5; Mon, 31 Aug 2026 12:31:09 +0200 (CEST)
Date: Mon, 31 Aug 2026 12:31:09 +0200
From: Jan Kara <jack@suse.cz>
To: ZW Tang <tangzw515@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [BUG] fanotify: WARNING in fanotify_handle_event with crafted
 msdos image and long path
Message-ID: <3kzvlb3wpzbg6k6ttzp6rh2cfmz3hmmmlisgxjn5u4xmaaqibm@qkre7flkhejl>
References: <CAA2SOT5mWrS_KN38TRCu_KfTjpG6fyaytqZbOb25Pb0kfqZ3gQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA2SOT5mWrS_KN38TRCu_KfTjpG6fyaytqZbOb25Pb0kfqZ3gQ@mail.gmail.com>
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org,mail.parknet.co.jp];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]

Hello,

On Mon 31-08-26 12:32:57, ZW Tang wrote:
> I am reporting a warning triggered by a syzkaller reproducer on
> Linux 7.2.0-rc3. A similar issue appears to have been reported upstream
> before, but I can still reproduce it on Linux 7.2.0-rc3 with HEAD commit
> 1137d8b5df06137fb49513cc923b3b24d94cb809.
> 
> The reproducer mounts a crafted msdos filesystem image, creates a very
> long pathname, installs a fanotify mark, and then calls execve() on the
> long path. During execve(), the file open path triggers fsnotify, which
> then calls fanotify_handle_event(). While fanotify is constructing the
> event, it hits a warning in fs/notify/fanotify/fanotify.h.
> 
> This looks like a fanotify name-event encoding robustness issue. A crafted
> filesystem image together with a very long pathname appears to trigger an
> unexpected name/fid event layout, and fanotify_info_copy_name() reaches a
> WARN_ON_ONCE() path. The kernel should probably reject or truncate the
> event cleanly instead of triggering a warning, because panic_on_warn turns
> this into a kernel panic.

fanotify complains that the name length is greater than NAME_MAX.  If I can
guess, the problem likely is that the msdos filesystem (vfat?) allows a
file name that is longer than NAME_MAX. Which would be a bug in the
filesystem driver, not a problem in fanotify... Ogawa, care to have a look?

								Honza

> 
> Reproducer:
> 
> syz reproducer: https://pastebin.com/raw/JqBwvgbH
> console output: https://pastebin.com/raw/2jnY4jzL
> kernel config: https://pastebin.com/raw/RgvQ5DPY
> 
> Kernel:
> 
> HEAD commit: 1137d8b5df06137fb49513cc923b3b24d94cb809
> git tree: torvalds/linux
> kernel version: 7.2.0-rc3 #1 PREEMPT(full) (QEMU Ubuntu 24.10)
> 
> Relevant log:
> 
> loop0: detected capacity change from 0 to 128
> 
> ------------[ cut here ]------------
> WARNING: fs/notify/fanotify/fanotify.h:217 at
> fanotify_handle_event+0x3e93/0x4800, CPU#1: syz.0.17/10761
> 
> CPU: 1 UID: 0 PID: 10761 Comm: syz.0.17 Not tainted 7.2.0-rc3 #1 PREEMPT(full)
> Hardware name: QEMU Ubuntu 24.10 PC (i440FX + PIIX, 1996)
> 
> RIP: 0010+0x3e93/0x4800
> 
> Call Trace:
> <TASK>
> fsnotify+0x1105/0x1be0
> __fsnotify_parent+0x6b6/0xd40
> vfs_open+0x2e6/0x3f0
> path_openat+0x29a2/0x3e20
> do_file_open+0x216/0x310
> do_open_execat+0xe8/0x430
> alloc_bprm+0x2b/0x900
> do_execveat_common.isra.0+0x1a8/0x5d0
> __x64_sys_execve+0x93/0xd0
> do_syscall_64+0xc4/0x7a0
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
> </TASK>
> 
> Kernel panic - not syncing: kernel: panic_on_warn set ...
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
