Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597338;
	b=suGRGh5S2Ozf4LzHOhCE+Y9Wfzb2yaxaTkYf7V1jHxuJIPhdD5pBRlWBCqdGfcRXAiHn
	 lxl02icazgT3UzCW6F8DG5JRmEMFVw1vbmdqkREpuCLx+7Uusgn/eIUscZlv5Fu58K/Vb
	 zIDkuaBgM6fmBlMafusJUuOaN4REhNK4k/FRwWcJrqoDvgejRKxKiMLWa75ipbvDh/mxz
	 XLOCPcyxEy+be6uP+a5TGKcK42lavDDMC32dbaR0K3VUSTvpNts30JX1bcQf5Fj+UMZvJ
	 bXuTKz6huKj3bG0dshZ2w3CuAkqyXLQW4ZzuelrNdMZ4RXSuTuaYgQzKUXDMPfqnYOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597338;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=UYnqcGU/Ec09I0M3fo+Qm2+xWCsLA12pBs2w+1NsMtM=;
	b=tDsj8CgEm02fnruP2G7RGvUdAulaohW6iY4XDWG7Y9PPKFUFnpSnEYGCqZzAejGQQGGq
	 r40dJLo8uIXSe8EgrjMPTtZ8bG1TSq31sRYQOylT+nnMLJcELWjeiydlhoc1w71T4MMY3
	 br/8C25FVPqgmxAUS9gz+Jdz0T96jnHq/5XKxk4v2kojMS7FNrn8X3wESYxhr/GepyfKK
	 pvgy5PGW+++uIwSAS2DEvoYR5Mo8LSS3St2gS3qrBHXSniMwuJZC6jdGv2rgPFe6Q4J4P
	 HEojTyTl+/KI5mNHGCzUXsQXAsuKGWf97gxHzzDRgw4n8shbSoV82+VDc+W1rbtvf5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=cCbC7Jqd;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="9Yxh/UTZ";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=cCbC7Jqd;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="9Yxh/UTZ";
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81894606A31E;
	Wed, 25 Nov 2026 09:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81894606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=cCbC7Jqd;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9Yxh/UTZ;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=cCbC7Jqd;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9Yxh/UTZ
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 736DA1F456;
	Wed, 25 Nov 2026 09:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795597335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UYnqcGU/Ec09I0M3fo+Qm2+xWCsLA12pBs2w+1NsMtM=;
	b=cCbC7Jqde/PXOkb1jfvZj4LxjJZioBJG4WIlxTwwod4mrKhvLBR1Ml+phVG9hDI48ZONdU
	4RKUY2/le6VBQuUSnpz/djMv29ORbW1c22eO/ojCvMpS/scqmvzykQn37yM7CkyIe7uKyF
	iSgX4jkBiF3UKhJqLbsJut4usuK43Ck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795597335;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UYnqcGU/Ec09I0M3fo+Qm2+xWCsLA12pBs2w+1NsMtM=;
	b=9Yxh/UTZ+V3BlOnp48RMbcR6Ph40Xj/lpCz6F610l4h33frHwmdyiBwsvjwL0RBQ1W6Yxa
	xrRI0fW1784AmMBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cCbC7Jqd;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="9Yxh/UTZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795597335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UYnqcGU/Ec09I0M3fo+Qm2+xWCsLA12pBs2w+1NsMtM=;
	b=cCbC7Jqde/PXOkb1jfvZj4LxjJZioBJG4WIlxTwwod4mrKhvLBR1Ml+phVG9hDI48ZONdU
	4RKUY2/le6VBQuUSnpz/djMv29ORbW1c22eO/ojCvMpS/scqmvzykQn37yM7CkyIe7uKyF
	iSgX4jkBiF3UKhJqLbsJut4usuK43Ck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795597335;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UYnqcGU/Ec09I0M3fo+Qm2+xWCsLA12pBs2w+1NsMtM=;
	b=9Yxh/UTZ+V3BlOnp48RMbcR6Ph40Xj/lpCz6F610l4h33frHwmdyiBwsvjwL0RBQ1W6Yxa
	xrRI0fW1784AmMBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B2B3134CA;
	Wed, 25 Nov 2026 09:02:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UVguChekBmvVDQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 25 Nov 2026 09:02:15 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id D267827BCD; Wed, 25 Nov 2026 10:02:14 +0100 (CET)
Date: Wed, 25 Nov 2026 10:02:14 +0100
From: Jan Kara <jack@suse.cz>
To: Alexander Mikhalitsyn <alex@amutable.com>
Cc: code@tyhicks.com, brauner@kernel.org, ecryptfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, Seth Forshee <sforshee@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ecryptfs: release inode on error path in
 ecryptfs_lookup_interpose
Message-ID: <ykuz2hhjgnfhwnh7srst3ev4yqetv5jrs3vn5idwr5jfynszax@zrbrypi5phon>
References: <20261124195430.105522-1-alex@amutable.com>
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
In-Reply-To: <20261124195430.105522-1-alex@amutable.com>
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 736DA1F456

On Tue 24-11-26 20:54:29, Alexander Mikhalitsyn wrote:
> Currently, when ecryptfs_i_size_read() fails we only do make_bad_inode()
> which only removes the inode from a hash. So it's not getting released
> and on umount we get "VFS: Busy inodes after unmount of ecryptfs" (see below).
> 
> Let's fix it by using iget_failed() when inode is I_NEW and iput() when it's not.
> 
> This was accidentally found while working on SB_I_PSEUDO fix.
> 
> ------------[ cut here ]------------
> VFS: Busy inodes after unmount of ecryptfs (ecryptfs)
> WARNING: fs/super.c:731 at generic_shutdown_super+0x117/0x1a0, CPU#11: umount/402
> Modules linked in:
> CPU: 11 UID: 0 PID: 402 Comm: umount Not tainted 7.4.0-rc1-virtme #9 PREEMPT(lazy)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> RIP: 0010:generic_shutdown_super+0x125/0x1a0
> Code: 5d 5d c3 cc cc cc cc e8 19 d0 f3 ff 48 8b bb 18 01 00 00 eb d7 48 8d 3d a9 93 d1 01 48 8b 43 50 48 8d b3 d8 03 00 00 48 8b 10 <67> 48 0f b9 3a 4c 8d ab 40 05 00 00 4c 89 ef e8 17 6c b0 00 48 8b
> RSP: 0018:ffffccc0406bbcf8 EFLAGS: 00010283
> RAX: ffffffff87d54a20 RBX: ffff8a7bc2358800 RCX: 00000000000000b5
> RDX: ffffffff873e7853 RSI: ffff8a7bc2358bd8 RDI: ffffffff87e52550
> RBP: ffffccc0406bbd10 R08: ffff8a7bc235d408 R09: fffff12a00000000
> R10: ffffccc0406bbcf0 R11: ffffffff87d209d8 R12: ffff8a7bc2358d48
> R13: ffff8a7bc2388824 R14: 0000000000000000 R15: 0000000000000000
> FS:  00007fd846e02840(0000) GS:ffff8a7c76af9000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fd84716e8e0 CR3: 00000000037d8000 CR4: 0000000000350eb0
> Call Trace:
>  <TASK>
>  kill_anon_super+0x1c/0x80
>  ecryptfs_kill_block_super+0x1a/0x50
>  deactivate_locked_super+0x39/0xc0
>  deactivate_super+0x47/0x60
>  cleanup_mnt+0x3b/0x80
>  __cleanup_mnt+0x16/0x20
>  task_work_run+0x64/0x90
>  exit_to_user_mode_loop+0x177/0x570
>  do_syscall_64+0x352/0x410
>  ? up_read+0x1f/0xe0
>  ? schedule+0x27/0xb0
>  ? schedule+0x27/0xb0
>  ? schedule+0x27/0xb0
>  ? trace_preempt_on+0x28/0x80
>  ? schedule+0x38/0xb0
>  ? preempt_count_sub+0x4d/0x70
>  ? irqentry_exit+0x2e1/0x700
>  ? exc_page_fault+0x8d/0x170
>  ? do_syscall_64+0x33/0x410
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x7fd84705c1d7
> Code: 0d 00 f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 09 3c 0d 00 f7 d8 64 89 02 b8
> RSP: 002b:00007ffd3839fae8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> RAX: 0000000000000000 RBX: 000055b7f819dbf8 RCX: 00007fd84705c1d7
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055b7f819df30
> RBP: 0000000000000000 R08: 00007ffd3839e8d0 R09: 00000000ffffffff
> R10: 0000000000000103 R11: 0000000000000246 R12: 00007fd8471ba26c
> R13: 000055b7f819df30 R14: 0000000000000000 R15: 000055b7f819daf0
>  </TASK>
> ---[ end trace 0000000000000000 ]---
> 
> Fixes: 3b06b3ebf441 ("eCryptfs: Fix new inode race condition")
> Signed-off-by: Alexander Mikhalitsyn <alex@amutable.com>

I can see this fix already in vfs.git as b793b0bfa631 ("ecryptfs: don't
leak the inode when a lookup can't open the lower file").

								Honza

> ---
>  fs/ecryptfs/inode.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index 48e520960d66..3a966348a578 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -362,7 +362,10 @@ static struct dentry *ecryptfs_lookup_interpose(struct dentry *dentry,
>  	if (S_ISREG(inode->i_mode)) {
>  		rc = ecryptfs_i_size_read(dentry, inode);
>  		if (rc) {
> -			make_bad_inode(inode);
> +			if (inode_state_read_once(inode) & I_NEW)
> +				iget_failed(inode);
> +			else
> +				iput(inode);
>  			return ERR_PTR(rc);
>  		}
>  	}
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
