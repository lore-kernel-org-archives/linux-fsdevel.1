Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792757243;
	b=3uTCJJdlAT+p75CnDowovC75UnLXjLlAlxWuNBuJnhkxwkzUU4SVaFihBtLyn/fNCrBb
	 GA4Lgr6qNl7TBz0RUPrgwjibW5kFFCq8BUiMWdhzi+J4K2C1CN/A9MROOU1mn0rjg8cmD
	 M7XA9gOGuHQ2J7gdDH0XgCDi+WmwJywRWtjmUB2lS6VRpZdsYMV3ayEI1oXaTUV1Y83Of
	 VQhi381B/TbH1M4l7xrk7P+wkMyMCSEOH1/l4unj01OXfJFBbQSD1cYIO3iqCJVvLWzhe
	 vQ/rjqmBTVOJoMTnqDNDi8AIRPyW+KIEU91ZIXeglnK8VzNc0luypzQ0yfHKuBaUeXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792757243;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=XUbrPeQnOgIZP6pGS1DKqXoqEXyF7r5wbaFScABPre4=;
	b=S9jEiiPSUQRk6RjNyuMLGoX3gCRM3+X2MURjdP+mPuBTTBsaVo+U/+MFAyuyJ8GtDDD9
	 6f1DRmdc5cfXtcgPNghBC4OjdLpB5rRu/vrid/5CfjhOw7t+rQ5veOxsrGaQtmFNK6Vp8
	 X0QpnyQCCt1o8J0oX0OUGid8Fmq9YO7YWQ67jZnhl1b6vWNCKe2GVj1monqMA2c7uZ2Fs
	 LHLHSfx3taTPf6lkNS4hGkorbcVW1n+rTnuG+MXeoBhhllSjeFYbqQMKRwuXsS2ccyiZI
	 YSaebn3aF03IOD/D85yjuLS/0OMOFviAi+mDIOAEXIycLFF85n+iKLLYq0HXyT2A9Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=wWhhu1eB;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xK+GmPxI;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=wWhhu1eB;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xK+GmPxI;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87451606A31B;
	Fri, 23 Oct 2026 12:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87451606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=wWhhu1eB;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xK+GmPxI;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=wWhhu1eB;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xK+GmPxI
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A6BD11F78D;
	Fri, 23 Oct 2026 12:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792757240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XUbrPeQnOgIZP6pGS1DKqXoqEXyF7r5wbaFScABPre4=;
	b=wWhhu1eBUmCFKlUZYc7uF/hO9bF8w/izQ8jpz5Hpf0fS+LurDRacXMSjJmvcOA4xypmTul
	5+G4pK35yh68L4+mNt1ty9o/tikdDXQe2ZC9BDdjzwB0qcu8ZyHBcQsGfeOxbNoLREYHiw
	9l55VtkliyBU7N3xmonF6t2bywv3KKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792757240;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XUbrPeQnOgIZP6pGS1DKqXoqEXyF7r5wbaFScABPre4=;
	b=xK+GmPxIpDQK7qAIntmy+r6ZNsSSuOpWutnmoJEHadSIsf74TzsQFg9wrXYRSNs5UewBTq
	NXc1wKSQxDh/21Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792757240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XUbrPeQnOgIZP6pGS1DKqXoqEXyF7r5wbaFScABPre4=;
	b=wWhhu1eBUmCFKlUZYc7uF/hO9bF8w/izQ8jpz5Hpf0fS+LurDRacXMSjJmvcOA4xypmTul
	5+G4pK35yh68L4+mNt1ty9o/tikdDXQe2ZC9BDdjzwB0qcu8ZyHBcQsGfeOxbNoLREYHiw
	9l55VtkliyBU7N3xmonF6t2bywv3KKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792757240;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XUbrPeQnOgIZP6pGS1DKqXoqEXyF7r5wbaFScABPre4=;
	b=xK+GmPxIpDQK7qAIntmy+r6ZNsSSuOpWutnmoJEHadSIsf74TzsQFg9wrXYRSNs5UewBTq
	NXc1wKSQxDh/21Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 84DA7133F3;
	Fri, 23 Oct 2026 12:07:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ux6cGvhN22okcQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 23 Oct 2026 12:07:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1BF12A1415; Fri, 23 Oct 2026 14:07:16 +0200 (CEST)
Date: Fri, 23 Oct 2026 14:07:16 +0200
From: Jan Kara <jack@suse.cz>
To: Zhao Gongyi <zhaogongyi@bytedance.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	jlayton@kernel.org, cel@kernel.org, neil@brown.name, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] filelock: keep superblock active through delegation
 wait
Message-ID: <qtone4v3wl4dualmn744jmywp6newrftdoqomsrstcfniv3zxs@wsln5r4vk32o>
References: <20261023111250.17696-1-zhaogongyi@bytedance.com>
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
In-Reply-To: <20261023111250.17696-1-zhaogongyi@bytedance.com>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,bytedance.com:email,suse.cz:email]
X-Spam-Score: -12.80

On Fri 23-10-26 19:12:50, Zhao Gongyi wrote:
> A caller may drop its path after try_break_deleg() returns a delegated
> inode but before break_deleg_wait() finishes. The extra inode reference
> held in struct delegated_inode does not keep the superblock active.
> 
> After a lazy unmount, closing the delegation holder can release the last
> mount reference and shut down the superblock while another task waits for
> the delegation break. The waiter's final iput() can then enter the
> filesystem's eviction code after its superblock-private state was freed.
> This has been observed as a KASAN use-after-free in shmem_evict_inode().
> 
> When try_break_deleg() saves a delegated inode, take an active reference
> to its superblock while the caller still pins the mount. Keep that
> reference through break_deleg_wait() and the final iput(), then release
> it with deactivate_super(). This protects every caller of the helpers,
> including the mknod, mkdir, symlink and rmdir paths that drop their path
> before waiting.
> 
> Fixes: e12d203b8c88 ("vfs: allow mkdir to wait for delegation break on parent")
> Fixes: 4fa76319cd0c ("vfs: allow rmdir to wait for delegation break on parent")
> Fixes: c826229c6a82 ("vfs: make vfs_create break delegations on parent directory")
> Fixes: e8960c1b2ee9 ("vfs: make vfs_mknod break delegations on parent directory")
> Fixes: 92bf53577f01 ("vfs: make vfs_symlink break delegations on parent dir")
> Link: https://lore.kernel.org/r/20261016093421.90725-1-zhaogongyi@bytedance.com
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Zhao Gongyi <zhaogongyi@bytedance.com>

I'm a bit worried by the prospect of running superblock shutdown from
break_deleg_wait(). But at this point I didn't find a site where this could
happen and be problematic so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Changes since v1:
>   - Hold an active superblock reference in the delegation helpers instead
>     of adding mount references to the four fs/namei.c callers, as suggested
>     by Al Viro and Christian Brauner.
>   - Use &inode->i_sb->s_active in atomic_inc().
> 
> Validation:
>   Built an arm64 KASAN Image with LLVM=1 on af32da41b032, using the same
>   config, guest image, and local arm64 cpufeature compatibility change as
>   the v1 tests. The tested filelock.h diff is byte-identical to this patch,
>   which is based on v7.3-rc7 (24a19b953e2a). Image SHA-256:
>     b7ad342b0020c31ab2be97ceb441ebc38c5840f023350462bb816552fd175870
> 
>   Ran the existing syzkaller reproducers under arm64 KVM with procs=6 and
>   repeat=0. Each test had one run:
> 
>     syscall/variant    duration    programs    wait stack samples
>     mkdirat             300 s         2028          7
>     symlinkat           300 s         2064          8
>     mknodat S_IFREG     600 s         4168         18
>     mknodat S_IFIFO     600 s         4131         17
>     rmdir               600 s         4174         16
> 
>   The stack samples identified the corresponding filename_*() waiter in
>   break_lease(). Every VM remained responsive through the requested run;
>   no Busy inodes, KASAN, WARNING, BUG, or panic appeared in serial output.
>   The unpatched baseline crashes reported in v1 were not rerun.
> 
>  include/linux/filelock.h | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
> index ec11cc6b4..e909db319 100644
> --- a/include/linux/filelock.h
> +++ b/include/linux/filelock.h
> @@ -530,8 +530,8 @@ static inline bool is_delegated(struct delegated_inode *di)
>   *
>   * Break delegations in a non-blocking fashion. If there are
>   * outstanding delegations and @di is set, then an extra reference
> - * will be taken on @inode and @di->di_inode will be populated so
> - * that it may be waited upon.
> + * will be taken on @inode and its superblock, and @di->di_inode will
> + * be populated so that it may be waited upon.
>   *
>   * Returns 0 if there is no need to wait or an error. If -EWOULDBLOCK
>   * is returned, then @di will be populated (if non-NULL).
> @@ -545,16 +545,21 @@ static inline int try_break_deleg(struct inode *inode, unsigned int flags,
>  	if (ret == -EWOULDBLOCK && di) {
>  		di->di_inode = inode;
>  		ihold(inode);
> +		/* The caller may drop its mount before break_deleg_wait(). */
> +		atomic_inc(&inode->i_sb->s_active);
>  	}
>  	return ret;
>  }
>  
>  static inline int break_deleg_wait(struct delegated_inode *di)
>  {
> +	struct inode *inode = di->di_inode;
> +	struct super_block *sb = inode->i_sb;
>  	int ret;
>  
> -	ret = break_deleg(di->di_inode, 0);
> -	iput(di->di_inode);
> +	ret = break_deleg(inode, 0);
> +	iput(inode);
> +	deactivate_super(sb);
>  	di->di_inode = NULL;
>  	return ret;
>  }
> -- 
> 2.39.5 (Apple Git-154)
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
