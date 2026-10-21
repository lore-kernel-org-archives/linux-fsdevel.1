Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598209;
	b=De9BAQNwfKix8k7YfvXaJiFSXrjZcgw2rQDTxF0cgJ1hUCU8T98Ggco9QfotfMZLyGWl
	 ETTnyukJVPQ/4tN2T+/s5YgK4YaKwqUSrslCl2kRAuQWyzqEtUk9h9q18CgDWE8pvV2Ng
	 zgeF7r5h8cXXGVfEowk75MGy+mIuWo+Jn0GaRX4x0g5ShISmnwpz99/D1XMNYtRY43MaU
	 XTfavP2FmNeuBACsj/9j7r2V2B09Km4iXq/6xOZkSMVKcf7RJhHOFB8pJvuFhMkm+j1GN
	 9W9tMqMKLyeTQZ1aLiy1VjXNw8f51d7ll1lvt3GEebyV+Q79AZNbGP0A7tcPTvPeoDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598209;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=jdCYLxMR/KDlJL5AcHTQ/nFiu/gS+Dwd0/bR4c9HPQQ=;
	b=P8gwmuGihlT8dogPh/tGY7+MjTDvlhfnMY1LiXkSrza8ozUF+p60FsPtt/F4Fla9KaEQ
	 yKQhgfnaacN1WfpfDqKiHNjdVZ7pdKcOBOf26SgsUGDCQfDjjUPdTNjWqSuuBDth4mhhz
	 D5iCQ9u8RWmHJiDTdxoe4CuGALPST/h+Re52m3aPoub5U/3sSVXTaeojPS9QimjPp/F83
	 u4zlRKBbH0zMe32w6dPNM6qzK1mrad4HTVCNsNIKJPrancf9WV1I9yALuYhuL3zemdCoP
	 KjluU0TrCGPswmOCCPBFKoIWRYGdgDXPJ0LHvwIKF0oO/4/CjSKeqHr211HyVN9phKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=otoRSIu1;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YmgB9wRh;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=otoRSIu1;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YmgB9wRh;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2AD606A320;
	Wed, 21 Oct 2026 15:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF2AD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=otoRSIu1;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YmgB9wRh;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=otoRSIu1;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YmgB9wRh
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2A9EB21CD7;
	Wed, 21 Oct 2026 15:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792598207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jdCYLxMR/KDlJL5AcHTQ/nFiu/gS+Dwd0/bR4c9HPQQ=;
	b=otoRSIu1HrFALEyWbolxbKSwqySa50/qVEXjq7qGQ++H0J6KSagnSdLuHNZkfnChoXkx6L
	Hf6kjQ6miAU7LpCW7gQ6xm4R4Iw89SI10czPyYRbYAjL/YppjopwBe1E+S8yo9sQjnaPME
	w/oC8xHuEj16HPMJxvaVu/t4sbxKoKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792598207;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jdCYLxMR/KDlJL5AcHTQ/nFiu/gS+Dwd0/bR4c9HPQQ=;
	b=YmgB9wRhAl+jzBk8lCyHWwn5dDv+VJKZhxjbfwQ5IiRmRfXEB23q023XowK5n+lp0QAl9d
	D1nhZbH8/aSYuvDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=otoRSIu1;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=YmgB9wRh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792598207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jdCYLxMR/KDlJL5AcHTQ/nFiu/gS+Dwd0/bR4c9HPQQ=;
	b=otoRSIu1HrFALEyWbolxbKSwqySa50/qVEXjq7qGQ++H0J6KSagnSdLuHNZkfnChoXkx6L
	Hf6kjQ6miAU7LpCW7gQ6xm4R4Iw89SI10czPyYRbYAjL/YppjopwBe1E+S8yo9sQjnaPME
	w/oC8xHuEj16HPMJxvaVu/t4sbxKoKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792598207;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jdCYLxMR/KDlJL5AcHTQ/nFiu/gS+Dwd0/bR4c9HPQQ=;
	b=YmgB9wRhAl+jzBk8lCyHWwn5dDv+VJKZhxjbfwQ5IiRmRfXEB23q023XowK5n+lp0QAl9d
	D1nhZbH8/aSYuvDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 886A2134FD;
	Wed, 21 Oct 2026 15:56:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +7XTF77g2Gp/MAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 21 Oct 2026 15:56:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E5F0FA1418; Wed, 21 Oct 2026 17:56:45 +0200 (CEST)
Date: Wed, 21 Oct 2026 17:56:45 +0200
From: Jan Kara <jack@suse.cz>
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fsnotify: preserve 64-bit pre-content ranges
Message-ID: <4cak3zsam4wxdhmdvuq73ik6p2pu4peod7sr2etqtja4p5ebnw@7p55nlstgoph>
References: <20261015175701.3674449-1-thnkslprpt@gmail.com>
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
In-Reply-To: <20261015175701.3674449-1-thnkslprpt@gmail.com>
X-Rspamd-Queue-Id: 2A9EB21CD7
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
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email]
X-Spam-Score: -13.01

On Thu 15-10-26 20:57:01, Avi Weiss wrote:
> vfs_fallocate() and remap_verify_area() pass 64-bit lengths to
> fsnotify_file_area_perm(), which truncates them to size_t on
> 32-bit systems.
> 
> Use 64 bit (unsigned) types throughout the entire pre-content
> notification chain to keep the full range. The userspace range
> field is already 64-bits.
> 
> Fixes: 9740d17162de ("fsnotify: pass optional file access range in pre-content event")
> Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>

Thanks. I've added the patch to my tree.

								Honza

> ---
> Tested on a 32-bit x86 kernel in QEMU with ext4 and
> FAN_CLASS_PRE_CONTENT / FAN_PRE_ACCESS with regular 
> (4KB), boundary, near-boundary, and beyond boundary counts.
> 
> requested count    before   with the fix
>           4096      4096           4096
>     4294967295         0     4294967296
>     4294967296         0     4294967296
>     4294971392      4096     4294971392
> 
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index 3710543dbf827..225919d7347bf 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -441,7 +441,7 @@ struct fanotify_perm_event {
>  	struct fanotify_event fae;
>  	struct path path;
>  	loff_t pos;			/* FANOTIFY_NO_RANGE if unavailable */
> -	size_t count;
> +	u64 count;
>  	u32 response;			/* userspace answer to the event */
>  	unsigned short state;		/* state of the event */
>  	unsigned short watchdog_cnt;	/* already scanned by watchdog? */
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 7e2f330fd2837..8657bb94dfa8b 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -157,7 +157,7 @@ static inline __u32 fsnotify_object_watched(struct inode *inode, __u32 mnt_mask,
>  
>  /* Report pre-content event with optional range info */
>  int fsnotify_pre_content(const struct path *path, const loff_t *ppos,
> -			 size_t count)
> +			 u64 count)
>  {
>  	struct file_range range;
>  
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index bda798bc67bc5..a4a29b3650080 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -135,7 +135,7 @@ int fsnotify_open_perm_and_set_mode(struct file *file);
>   * fsnotify_file_area_perm - permission hook before access to file range
>   */
>  static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
> -					  const loff_t *ppos, size_t count)
> +					  const loff_t *ppos, u64 count)
>  {
>  	/*
>  	 * filesystem may be modified in the context of permission events
> @@ -213,7 +213,7 @@ static inline int fsnotify_open_perm_and_set_mode(struct file *file)
>  }
>  
>  static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
> -					  const loff_t *ppos, size_t count)
> +					  const loff_t *ppos, u64 count)
>  {
>  	return 0;
>  }
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index 618eed4d6d724..a25ae4ed879c7 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -323,7 +323,7 @@ struct fs_error_report {
>  struct file_range {
>  	const struct path *path;
>  	loff_t pos;
> -	size_t count;
> +	u64 count;
>  };
>  
>  static inline const struct path *file_range_path(const struct file_range *range)
> @@ -945,12 +945,12 @@ static inline void fsnotify_init_event(struct fsnotify_event *event)
>  	INIT_LIST_HEAD(&event->list);
>  }
>  int fsnotify_pre_content(const struct path *path, const loff_t *ppos,
> -			 size_t count);
> +			 u64 count);
>  
>  #else
>  
>  static inline int fsnotify_pre_content(const struct path *path,
> -				       const loff_t *ppos, size_t count)
> +				       const loff_t *ppos, u64 count)
>  {
>  	return 0;
>  }
> 
> base-commit: 045958acaa75205b31578cb22c4345e28dd2e4bf
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
