Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2165743499E;
	Thu,  8 Oct 2026 12:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791461030; cv=none; b=Kh8k41qrCGpaqvWjHqIVELOjc6NlDjrH36u3pjj6j+97DZumtk/Jy8sOCZHQrOOYFriO+XitWeh7I0vta+8huo7bVD/NDX7dHY66Ntwy0XqmzpDikvWSKOHgV2OftDn2cOod6yrGWL76p0prm//DvABKo0O4m/5rHAPQfTI/bjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791461030; c=relaxed/simple;
	bh=k2udc5r3lz+ULPE1HJz84d9GB4jYwoVSWncGwVeIGbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqMdKq/7uuWT2JCmrv4bd6ksibADA6qU1BThmBTtzw03vYksXCTMPWtgHA6RrRnShY9kEWp6+TatvUB8+9bitHa3a4l/ZyAA/zKfY5D3h/S5kRFbK/owlDCEx4ycwJHazpBSogJRTCJImxHGzAL+O6HJAQg2jvEhsyxTsSV12gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3A07B21AFE;
	Thu,  8 Oct 2026 12:03:47 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 128991339F;
	Thu,  8 Oct 2026 12:03:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /QL/N6KGx2r4KAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 08 Oct 2026 12:03:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 965AFA13FC; Thu, 08 Oct 2026 14:03:46 +0200 (CEST)
Date: Thu, 8 Oct 2026 14:03:46 +0200
From: Jan Kara <jack@suse.cz>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: jack@suse.cz, amir73il@gmail.com, repnop@google.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fanotify: report names longer than NAME_MAX
Message-ID: <txmkexkbyhoakvzwkqkfdwvuwmrgqstxgktzhhqgk7d5e4muvt@mycm6zmovaa4>
References: <20260926020851.2938961-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926020851.2938961-1-matthias.goergens@gmail.com>
X-Rspamd-Pre-Result: action=no action;
	module=Unknown lua;
	unknown reason
X-Spam-Flag: NO
X-Rspamd-Pre-Result: action=no action;
	module=Unknown lua;
	unknown reason
X-Spam-Level: 
X-Spamd-Result: default: False [0.00 / 50.00];
	TAGGED_RCPT(0.00)[]
X-Spam-Score: 0.00

On Sat 26-09-26 10:08:51, Matthias Goergens wrote:
> fanotify keeps the length of a reported name in a u8, so it drops any
> name longer than NAME_MAX and warns:
> 
>   WARNING: fs/notify/fanotify/fanotify.h:217 at fanotify_handle_event+0x2e82/0x39f0
> 
> Such names are legitimate on some filesystems.  vfat mounted with utf8
> takes up to 255 UTF-16 characters, which are up to 765 bytes of UTF-8,
> and FUSE accepts names up to PATH_MAX - 1.  readdir() and inotify report
> them in full.  fanotify sends the event without the name, and for
> FAN_RENAME it trips a second warning in copy_fid_info_to_user(), after
> which read() fails with EFAULT and the event is lost.
> 
> When syzbot hit this, Jan suggested accommodating names up to PATH_MAX
> [1], the limit readdir() already applies to a name
> (verify_dirent_name()).  Store the name lengths as u16, which keeps
> struct fanotify_info at 8 bytes, and drop without a warning only names
> of PATH_MAX bytes or more, which no path can refer to.  An event with
> such a name can exceed a page, so allocate name events with kvmalloc(),
> as Jan also suggested.  Names up to NAME_MAX are reported exactly as
> before, and the record format is unchanged: an event with a long name is
> just longer.
> 
> Link: https://lore.kernel.org/all/20241112115059.ecvomkalee5m4i4i@quack3/ [1]
> Fixes: 2d9374f09513 ("fanotify: use macros to get the offset to fanotify_info buffer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>

Matthias, this patch (with slight modification for >= PATH_MAX names) is in
my tree. Would you have time to write an LTP test for fanotify which
exercises these paths longer than NAME_MAX please? So that this code gets
regular testing... Thanks!

								Honza

> ---
> 
> Tested in a VM with KASAN, lockdep and kmemleak: on vfat (utf8), names
> of 258 to 765 bytes now arrive with their name, including FAN_RENAME,
> for root and for an unprivileged watcher; FUSE names up to 4095 bytes
> likewise, also a FAN_RENAME between two of them.  With kvmalloc()'s
> kmalloc() attempt forced to fail, the events arrive intact from vmalloc.
> No warnings.  The LTP fanotify and inotify tests give the same results
> as before (fanotify20 skipped in both).
> 
> 5.15.y fails the same way (the same warnings and EFAULT on 5.15.221),
> and the patch applies there and fixes it.
> 
> Honza, on the msdos report [2] you pointed at the filesystem, and msdos
> now rejects such names (9d7ed813ee5f).  vfat cannot do the same without
> making files that other systems wrote unreachable, and FUSE allows them
> by design.
> 
> [2] https://lore.kernel.org/all/3kzvlb3wpzbg6k6ttzp6rh2cfmz3hmmmlisgxjn5u4xmaaqibm@qkre7flkhejl/
> 
>  fs/notify/fanotify/fanotify.c |  4 ++--
>  fs/notify/fanotify/fanotify.h | 20 +++++++++++++-------
>  2 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index a208a7ec1692..c8289aa8a70a 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -656,7 +656,7 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *dir,
>  		size += FANOTIFY_FH_HDR_LEN + dir2_fh_len;
>  	if (child_fh_len)
>  		size += FANOTIFY_FH_HDR_LEN + child_fh_len;
> -	fne = kmalloc(size, gfp);
> +	fne = kvmalloc(size, gfp);
>  	if (!fne)
>  		return NULL;
>  
> @@ -1050,7 +1050,7 @@ static void fanotify_free_fid_event(struct fanotify_event *event)
>  
>  static void fanotify_free_name_event(struct fanotify_event *event)
>  {
> -	kfree(FANOTIFY_NE(event));
> +	kvfree(FANOTIFY_NE(event));
>  }
>  
>  static void fanotify_free_error_event(struct fsnotify_group *group,
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index 3710543dbf82..4aad60d2aaf5 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -43,9 +43,16 @@ struct fanotify_info {
>  	u8 dir_fh_totlen;
>  	u8 dir2_fh_totlen;
>  	u8 file_fh_totlen;
> -	u8 name_len;
> -	u8 name2_len;
> -	u8 pad[3];
> +	u8 pad;
> +	/*
> +	 * Deliberately not limited to NAME_MAX: some filesystems return longer
> +	 * names (vfat up to 255 UTF-16 characters, as Windows allows, which is
> +	 * up to 765 bytes of UTF-8; FUSE up to PATH_MAX - 1), and readdir() and
> +	 * inotify report them in full. Only names of PATH_MAX bytes or more,
> +	 * which no path can refer to, are dropped.
> +	 */
> +	u16 name_len;
> +	u16 name2_len;
>  	unsigned char buf[];
>  	/*
>  	 * (struct fanotify_fh) dir_fh starts at buf[0]
> @@ -168,7 +175,7 @@ static inline char *fanotify_info_name2(struct fanotify_info *info)
>  static inline void fanotify_info_init(struct fanotify_info *info)
>  {
>  	BUILD_BUG_ON(FANOTIFY_FH_HDR_LEN + MAX_HANDLE_SZ > U8_MAX);
> -	BUILD_BUG_ON(NAME_MAX > U8_MAX);
> +	BUILD_BUG_ON(PATH_MAX > U16_MAX);
>  
>  	info->dir_fh_totlen = 0;
>  	info->dir2_fh_totlen = 0;
> @@ -214,8 +221,7 @@ static inline void fanotify_info_set_file_fh(struct fanotify_info *info,
>  static inline void fanotify_info_copy_name(struct fanotify_info *info,
>  					   const struct qstr *name)
>  {
> -	if (WARN_ON_ONCE(name->len > NAME_MAX) ||
> -	    WARN_ON_ONCE(info->name2_len > 0))
> +	if (name->len >= PATH_MAX || WARN_ON_ONCE(info->name2_len > 0))
>  		return;
>  
>  	info->name_len = name->len;
> @@ -225,7 +231,7 @@ static inline void fanotify_info_copy_name(struct fanotify_info *info,
>  static inline void fanotify_info_copy_name2(struct fanotify_info *info,
>  					    const struct qstr *name)
>  {
> -	if (WARN_ON_ONCE(name->len > NAME_MAX))
> +	if (name->len >= PATH_MAX)
>  		return;
>  
>  	info->name2_len = name->len;
> 
> base-commit: 165768bb70265b5c38cf0b73fafd75be235f8b14
> -- 
> 2.55.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
