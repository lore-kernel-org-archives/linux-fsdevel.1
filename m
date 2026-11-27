Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789520;
	b=hcEiJZscvrrl6btoEXn0krT/1rX0I1rsQZiHE48AcsI7D4vPm5/Md7rpJ1kNFf26O+V+
	 yIEgkliP+ugly4IuRh95baALqnYCXDOMTfDSzI6OIuEAuJLyDgxe7Bat5XiQB40YLeO0l
	 bTxNWePV9NBjvZ56k0YMSGr4QgMa6h0ix8PsWWzhcy0ZHaQ89n8bNsE/S6DiOzoDT6q/i
	 1hAaAduss5bZNXW4y5pkXR1MqU7I/omip2fd/KclA24E1SydrqME0RGNfaVxkDUVc2dse
	 nR/pw3LYDDiVK49y3JEOQa2K9bKx/ouz3OQ7Cwq0Z1/iKPy1OVy952c8hKJ3WpQnu0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789520;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=1RR3j3GSdZT6IKLGBH+lNgisdIJmzYMmJUFY1yaeWLY=;
	b=OOdsdodadYvPkJf8wYEj9aK3iWmIy7gQLJ1zTymE8EvoIAtVtMFdy0x7EazkUDmWciXs
	 I0r1TDaraL/kOeqGyBSPH7SNQO9z21ND1txgEkS8qinkLVo3ew6mgzOI5T0XoO/3wwS7a
	 Bav9CFdLWCSGtrHv0Z0pzLUuOAU3RRLdrsjq2s1D8OIMrKu8mAXSSz2xZKnjwPy1GfLkT
	 C64D+govSvzTg7Hhzw4hRaO+ElePuXTkderehTaQ6P8y0pL71gCZSGTWj4vdYUnkL5y7i
	 R9oVaa591qwReTi1N8tocr72KzjtmwZ8OenRMFizsJBUJTzvjMbnKulVka+fgW/Caxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=eZ7G9z62;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=XCR1WeQL;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=eZ7G9z62;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=XCR1WeQL;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0035606A6A9;
	Fri, 27 Nov 2026 14:25:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0035606A6A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=eZ7G9z62;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=XCR1WeQL;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=eZ7G9z62;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=XCR1WeQL
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BF22B22999;
	Fri, 27 Nov 2026 14:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795789517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1RR3j3GSdZT6IKLGBH+lNgisdIJmzYMmJUFY1yaeWLY=;
	b=eZ7G9z62LsAfqaQ0V/d6CZ/Myw5MOo1jf20LAnXeVBKXIPtnuKBrUMobKQmdVOsYG2ey1Y
	Zns5juVxfuiFY5uSvpjDu9yGSl3dUJi4fihCS47YbXq+O8wNi4RoZ/KagACaZRxgGNrGa9
	Hp4OA/GCEXxpbZHWwXgkjteiorD9FmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795789517;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1RR3j3GSdZT6IKLGBH+lNgisdIJmzYMmJUFY1yaeWLY=;
	b=XCR1WeQL72ryZyRyj3yToXPcnZ8EnUhW2fy7b1IkFPWEIknAaiOsx7GtT66Kha6raMqYqn
	WZfNZhAkGkDruWAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eZ7G9z62;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XCR1WeQL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795789517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1RR3j3GSdZT6IKLGBH+lNgisdIJmzYMmJUFY1yaeWLY=;
	b=eZ7G9z62LsAfqaQ0V/d6CZ/Myw5MOo1jf20LAnXeVBKXIPtnuKBrUMobKQmdVOsYG2ey1Y
	Zns5juVxfuiFY5uSvpjDu9yGSl3dUJi4fihCS47YbXq+O8wNi4RoZ/KagACaZRxgGNrGa9
	Hp4OA/GCEXxpbZHWwXgkjteiorD9FmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795789517;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1RR3j3GSdZT6IKLGBH+lNgisdIJmzYMmJUFY1yaeWLY=;
	b=XCR1WeQL72ryZyRyj3yToXPcnZ8EnUhW2fy7b1IkFPWEIknAaiOsx7GtT66Kha6raMqYqn
	WZfNZhAkGkDruWAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9360413432;
	Fri, 27 Nov 2026 14:25:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id itwnG82SCWvtTwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Nov 2026 14:25:17 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 24C3A5104B; Fri, 27 Nov 2026 15:25:13 +0100 (CET)
Date: Fri, 27 Nov 2026 15:25:13 +0100
From: Jan Kara <jack@suse.cz>
To: Junyoung Jang <graypanda.inzag@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Gwanhyun Lee <gwanhyunlee@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udf: check device specification EA size before reading
 impUseLength
Message-ID: <aenojzzie7giakrb2x566zobnw7vmt6dybybemo73hi5tdmdxd@f7y4lgygqme4>
References: <20261126224353.1552397-1-graypanda.inzag@gmail.com>
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
In-Reply-To: <20261126224353.1552397-1-graypanda.inzag@gmail.com>
X-Rspamd-Queue-Id: BF22B22999
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.com:email]
X-Spam-Score: -13.01

On Fri 27-11-26 07:43:52, Junyoung Jang wrote:
> udf_get_extendedattr() only verifies that the 12-byte genericFormat
> header and the declared attrLength fit within the inode's i_data buffer.
> However, udf_device_spec_valid() reads the 4-byte impUseLength field at
> offset 12 before checking that attrLength covers struct deviceSpec.
> 
> If a crafted UDF image places a truncated device specification EA (with
> attrLength shorter than 16 bytes) at the end of i_data, reading
> impUseLength triggers a KASAN slab-out-of-bounds read in __udf_iget():
> 
>   BUG: KASAN: slab-out-of-bounds in __udf_iget+0x3d41/0x3f20
>   Read of size 4 at addr ffff8881025a0f27 by task busybox/51
> 
>   Call Trace:
>    <TASK>
>    __udf_iget+0x3d41/0x3f20
>    udf_lookup+0x1b5/0x1d0
>    __lookup_slow+0x18f/0x330
>    walk_component+0x2b1/0x4e0
>    path_lookupat+0x112/0x670
>    filename_lookup+0x17b/0x4f0
>    vfs_statx+0xd8/0x160
>    vfs_fstatat+0x77/0xb0
>    __do_sys_newfstatat+0x9f/0x100
>    __x64_sys_newfstatat+0x91/0xf0
>    x64_sys_call+0x331/0x9f0
>    do_syscall_64+0x47/0x110
>    entry_SYSCALL_64_after_hwframe+0x67/0x6f
>    </TASK>
> 
>   Allocated by task 51:
>    __kmalloc_noprof+0x13c/0x250
>    udf_alloc_i_data+0x19/0x60
>    __udf_iget+0x2b03/0x3f20
>    udf_lookup+0x1b5/0x1d0
>    ...
> 
>   The buggy address belongs to the object at ffff8881025a0000
>    which belongs to the cache kmalloc-4k of size 4096
>   The buggy address is located 3879 bytes inside of
>    allocated 3880-byte region [ffff8881025a0000, ffff8881025a0f28)
> 
> Check attrLength against sizeof(*dsea) before reading impUseLength.
> 
> Fixes: 9a2390959685 ("udf: validate the device specification EA before using it")
> Cc: stable@vger.kernel.org
> Co-developed-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
> Signed-off-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
> Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>

Thanks! I've added the patch to my tree (just undoing the sizeof(struct
deviceSpec) -> sizeof(*dsea) change).

								Honza

> ---
> Tested on 6.12.118 with KASAN; with this patch applied, the malformed
> inode is rejected with -EIO and no KASAN report is triggered.
> 
> Disclosure: An in-house LLM-based analysis tool developed by the authors
> assisted in surfacing this bug candidate and drafting the initial notes.
> All root-cause analysis, patch code, and QEMU/KVM reproducer results
> were manually reviewed and independently verified by the authors.
> 
>  fs/udf/inode.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
> index 29900065673c..b4e34b345ff8 100644
> --- a/fs/udf/inode.c
> +++ b/fs/udf/inode.c
> @@ -1345,10 +1345,12 @@ static bool udf_device_spec_valid(struct deviceSpec *dsea)
>  	u32 attr_length, imp_use_length;
>  
>  	attr_length = le32_to_cpu(dsea->attrLength);
> +	if (attr_length < sizeof(*dsea))
> +		return false;
> +
>  	imp_use_length = le32_to_cpu(dsea->impUseLength);
> -	if (attr_length < sizeof(struct deviceSpec) ||
> -	    imp_use_length < sizeof(struct regid) ||
> -	    imp_use_length > attr_length - sizeof(struct deviceSpec))
> +	if (imp_use_length < sizeof(struct regid) ||
> +	    imp_use_length > attr_length - sizeof(*dsea))
>  		return false;
>  
>  	return true;
> 
> base-commit: 25faec9ce61c01fb45abf812a222c5b43c3cd5c5
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
