Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795173598;
	b=nW2sncu545cKiqU9wmQHPOA335se+mkM7dUhkKizQjY52VOZlK/YbCdhL3oA90z7/Hh7
	 8j3iLtzoETvW1Rxo1rLJf54Y4J0ZC5+fVqIaVkvHi2NEZUKUhpARO3trL8qTIQ93og4ic
	 0Z+mVQBNxLHXaHL8zXYUBREpFQJmWmpjHnjDMTiySF6QL0vdyIhCBn0/doQIaCCt9LvuE
	 PHzcSChUWvEHf6vB79A6hZF6xwmtd+I403tqrhwGS52k2gKnnhAQwpDUSRcjI1SCVuZO6
	 r0ODUSX6H5RtDGz/C6b6+Z42cNpSb4JQdx+0kdwpwHLKo/7uHvOagOVrqH7YzkjCtWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795173598;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=svddqoV3Ly3xh24WZbUpNnjtB7dnR/ALWSPjqd0L+s8=;
	b=jUH9F/3r5W4fx4bXHC5M21K3VidiPD7ZiA8uYPiZpaiBvyBDz9NDAT3xiu/UPqw0ul7W
	 sLd22dX1bDn+NwQ8sKheRZrWoWL0ZzKz2ZiEy42xskJsabfxd8bX4CGo4+d0uzpKiMRWc
	 VlrSGdEcg4E9hJ24MdiY0nt7xd3IWXP2OcCwbyx7b7kMAEfiqXX4C+fTXeDkHmrO8A2HJ
	 lWyh6m3KZOhzjxKHr5iBlhRUATIKkrKR4JVQXpqhI234R+YwfIe1f2HRfgVS/DM2gJVD9
	 Xys2ZRuERVuUubdc8YUT6tBHVBM4KgJ31veSl/5kTCMHV2jV6z2wbgWeF2QHovI7E2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="y1k/j2d3";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=z3Z0shYT;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="y1k/j2d3";
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=z3Z0shYT;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E410606A320;
	Fri, 20 Nov 2026 11:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E410606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=y1k/j2d3;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=z3Z0shYT;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=y1k/j2d3;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=z3Z0shYT
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9CD931F441;
	Fri, 20 Nov 2026 11:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795173595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=svddqoV3Ly3xh24WZbUpNnjtB7dnR/ALWSPjqd0L+s8=;
	b=y1k/j2d3GrMgMjiy4lzvR+MNH0uBpP45GD1za82IX5ZtXVRYDAIkQlxAHbLC5DPgI3QBLP
	a5FxfTX9mfdl+05P9JArLaW7hi2ZoSahpPkjtoz/seTeg7XXpWIVrN+qEI7CP8NEtzgYpe
	yNxwf9ioDb45XNgN/oAsjwI8I6T3vGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795173595;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=svddqoV3Ly3xh24WZbUpNnjtB7dnR/ALWSPjqd0L+s8=;
	b=z3Z0shYTcV7bR32/yGoPEFQdxMqD2Zf+7VMhtlNSBMCYjD57xlgPR1vRLukV88pDO1LsvF
	VYQldct+ihmRFwDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795173595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=svddqoV3Ly3xh24WZbUpNnjtB7dnR/ALWSPjqd0L+s8=;
	b=y1k/j2d3GrMgMjiy4lzvR+MNH0uBpP45GD1za82IX5ZtXVRYDAIkQlxAHbLC5DPgI3QBLP
	a5FxfTX9mfdl+05P9JArLaW7hi2ZoSahpPkjtoz/seTeg7XXpWIVrN+qEI7CP8NEtzgYpe
	yNxwf9ioDb45XNgN/oAsjwI8I6T3vGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795173595;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=svddqoV3Ly3xh24WZbUpNnjtB7dnR/ALWSPjqd0L+s8=;
	b=z3Z0shYTcV7bR32/yGoPEFQdxMqD2Zf+7VMhtlNSBMCYjD57xlgPR1vRLukV88pDO1LsvF
	VYQldct+ihmRFwDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74BE71342D;
	Fri, 20 Nov 2026 11:19:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ME+iFNssAGvzaQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 20 Nov 2026 11:19:55 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 057C225F29; Fri, 20 Nov 2026 12:19:55 +0100 (CET)
Date: Fri, 20 Nov 2026 12:19:54 +0100
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: use multigrain timestamps only with nanosecond
 granularity
Message-ID: <srvvl6jszz33iwi3qumqh2rle6vwg6fcqp2j7u6u62tb63se35@eycek35vou22>
References: <20261119-mgtime-v1-1-fd28399a5557@kernel.org>
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
In-Reply-To: <20261119-mgtime-v1-1-fd28399a5557@kernel.org>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Score: -12.80

On Thu 19-11-26 16:41:01, Jeff Layton wrote:
> Multigrain timestamps promise that a change after the ctime was
> queried shows a later ctime: inode_set_ctime_current() takes a
> fine-grained time when the coarse one isn't past the queried value.
> But it truncates that time to s_time_gran, and on a superblock with
> coarse granularity, such as ext4 with 128-byte inodes (one second),
> the truncated fine-grained time is no later than the coarse one, and
> the update is skipped. The inode is still flagged IOP_MGTIME, so a
> caller relying on is_mgtime() for that promise, such as nfsd deciding
> whether it can move the change attribute by moving ctime, is misled,
> and the multigrain machinery only costs a fine-grained clock read.
> 
> Set IOP_MGTIME only on a superblock whose s_time_gran is 1. Every
> FS_MGTIME filesystem (btrfs, ext4, f2fs, tmpfs, xfs) sets s_time_gran
> before it allocates an inode; document that it must.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> When I originally did the multigrain timestamp work, I missed the fact
> that ext4 can have an s_time_gran of NSEC_PER_SEC. I think this is a
> very uncommon setup, so I don't see a need for a huge rush for this one.
> Please consider for v7.5.
> ---
>  Documentation/filesystems/multigrain-ts.rst | 6 ++++++
>  fs/inode.c                                  | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/multigrain-ts.rst b/Documentation/filesystems/multigrain-ts.rst
> index c779e47284e8..81ea632c7a4b 100644
> --- a/Documentation/filesystems/multigrain-ts.rst
> +++ b/Documentation/filesystems/multigrain-ts.rst
> @@ -123,3 +123,9 @@ inode_set_ctime_current(). If the filesystem has a ->getattr routine that
>  doesn't call generic_fillattr, then it should call fill_mg_cmtime() to
>  fill those values. For setattr, it should use setattr_copy() to update the
>  timestamps, or otherwise mimic its behavior.
> +
> +Multigrain timestamps are only enabled on a superblock whose s_time_gran is 1:
> +a fine-grained timestamp truncated to a coarser granularity can be no later
> +than the coarse-grained one, so the kernel can't guarantee a visible change.
> +The filesystem must set s_time_gran before it allocates any inode, since
> +whether an inode uses multigrain timestamps is decided when it is allocated.
> diff --git a/fs/inode.c b/fs/inode.c
> index de207f2f95a9..9cc28306feda 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -239,7 +239,7 @@ int inode_init_always_gfp(struct super_block *sb, struct inode *inode, gfp_t gfp
>  	inode->i_opflags = 0;
>  	if (sb->s_xattr)
>  		inode->i_opflags |= IOP_XATTR;
> -	if (sb->s_type->fs_flags & FS_MGTIME)
> +	if ((sb->s_type->fs_flags & FS_MGTIME) && sb->s_time_gran == 1)
>  		inode->i_opflags |= IOP_MGTIME;
>  	i_uid_write(inode, 0);
>  	i_gid_write(inode, 0);
> 
> ---
> base-commit: 65e4fd942f72a9dba0e4e257290c4fa1aa756854
> change-id: 20261119-mgtime-fc070b268bdf
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
