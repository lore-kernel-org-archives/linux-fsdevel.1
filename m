Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5018E286D5E
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 17:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785000694; cv=none; b=XHrx12gZmvwauKDq6pB8yjwAcFsZC7G+ip5YQfzwlXcCkw6nwcS2B4KievTb9PoX6jMpASJjX54uld7L3Z86s0oGrGJpnhId8hz+ocJ2/8s1Xtj63h4xpB38YqAuQ/hbOQ8lu1Aspv0aslyFD+mvB1Vx6N0bNv5KI3irMfRLcnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785000694; c=relaxed/simple;
	bh=1d+ahltGl3VM2xiX3dYFFyHgdP4EHkL/G29cqFakBlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncN5jk4sZ1D31G4IIaOjrSbF8ZPEEyiV5bH+SRXrD6PGFyly7AZMJrISqoq4/BIw/9/CsU/qqmNp9KDUSyOAOHXbwdyJezvkbHBzW8SOmT7HIOMZdmqBeltDWobX4WYBksNo0Mkn/EAEsJdk3QPg/UMqclsLcxtDSWdJ6uNAENk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=Haz2gRX9; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="Haz2gRX9"
X-KPN-MessageId: aaedd543-884e-11f1-b2a8-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id aaedd543-884e-11f1-b2a8-005056abbe64;
	Sat, 25 Jul 2026 19:31:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=t+Jqw80vzuyfesh6AjBw0odAn7oHDqCK9i4qg+Orph4=;
	b=Haz2gRX9YZlflCp3oanRaVWeWhi+06DyBaQ+YQDv+brBAka2dxqsEBzrsU7qfqLq+unTyMXelCUcG
	 IwcCwTw+WhBMfWsbaM2CZ8Dzox1vf9E8ZaggMvhtsa/iZVt8odpk584EAczlur75VhYUIP1qwMp3T4
	 WxA2Xf++shiIn6F1u8rzrA6ZnkPvurYDlfCeSht76/UkXEFxIzj24YihvyPTZTgeDoBjSASd+BJ6tn
	 aJsZjr4QDo4cAZ0JTi7Zpy9XeSPAR73lFwro0rvrgNjzNplTivG6RedLORwlJzrCUYb4IpVn0RxkLq
	 2dYuSdEbgpkBCTMimkpvHfbZrqMHvCA==
X-KPN-MID: 33|0mNcx/hy7+/MQtMHSFRtMlqEVOpdoLjZ6B0jAiGIF6KsZswNjzrF9EJLNDS5rwu
 GDQmyNS/7SmdXiwpGSGBcSQjZ/clROHvFbgA6BYmD2p8=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|D7Hc1UxZoJs1GulRgH/CjJmrF5CqN0O4VIo8OnCcY2fU6yzhWRHgKo64XBLvCJX
 qTb3mhe/7ZGmElZTKccaDEQ==
Received: from localhost (142-169-144-85.ftth.glasoperator.nl [85.144.169.142])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id aab91609-884e-11f1-9227-005056ab1411;
	Sat, 25 Jul 2026 19:31:28 +0200 (CEST)
Date: Sat, 25 Jul 2026 19:31:27 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com
Subject: Re: [PATCH v3 22/24] binfmt_misc: assorted small cleanups
Message-ID: <amTy3udkENRN4dL2@lt-jori.localdomain>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
 <20260710-work-binfmt_misc-locking-v3-22-a162f7cb58d6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-22-a162f7cb58d6@kernel.org>

On Fri, Jul 10, 2026 at 11:33:23AM +0200, Christian Brauner wrote:
> Use umode_t for the mode argument of bm_get_inode(), constify the
> fixed status strings in bm_status_read(), give the super_operations
> the bm_ prefix everything else in this file uses, replace the stale
> scanarg() comment which still described parameters and an err
> variable it lost decades ago and fix the delimiter typo plus a
> missing space nearby.
> 
> No functional change.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/binfmt_misc.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index eb56aa6a3ca2..189b9218e5a6 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -291,10 +291,9 @@ static int load_misc_binary(struct linux_binprm *bprm)
>  /* Command parsers */
>  
>  /*
> - * parses and copies one argument enclosed in del from *sp to *dp,
> - * recognising the \x special.
> - * returns pointer to the copied argument or NULL in case of an
> - * error (and sets err) or null argument length.
> + * Scan the argument starting at @s up to the delimiter @del, recognising
> + * the \x escape. Terminates the argument with a NUL and returns a pointer
> + * past it or NULL on a malformed escape.
>   */
>  static char *scanarg(char *s, char del)
>  {
> @@ -309,7 +308,7 @@ static char *scanarg(char *s, char del)
>  				return NULL;
>  		}
>  	}
> -	s[-1] ='\0';
> +	s[-1] = '\0';
>  	return s;
>  }
>  
> @@ -458,7 +457,7 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
>  	if (copy_from_user(buf, buffer, count))
>  		return ERR_PTR(-EFAULT);
>  
> -	del = *p++;	/* delimeter */
> +	del = *p++;	/* delimiter */
>  
>  	pr_debug("register: delim: %#x {%c}\n", del, del);
>  
> @@ -604,7 +603,7 @@ static int bm_entry_show(struct seq_file *m, void *unused)
>  	return 0;
>  }
>  
> -static struct inode *bm_get_inode(struct super_block *sb, int mode)
> +static struct inode *bm_get_inode(struct super_block *sb, umode_t mode)
>  {
>  	struct inode *inode = new_inode(sb);
>  
> @@ -852,7 +851,7 @@ static ssize_t
>  bm_status_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
>  {
>  	struct binfmt_misc *misc;
> -	char *s;
> +	const char *s;
>  
>  	misc = i_binfmt_misc(file_inode(file));
>  	s = READ_ONCE(misc->enabled) ? "enabled\n" : "disabled\n";
> @@ -899,7 +898,7 @@ static void bm_put_super(struct super_block *sb)
>  	put_user_ns(user_ns);
>  }
>  
> -static const struct super_operations s_ops = {
> +static const struct super_operations bm_super_ops = {
>  	.statfs		= simple_statfs,
>  	.evict_inode	= bm_evict_inode,
>  	.put_super	= bm_put_super,
> @@ -968,7 +967,7 @@ static int bm_fill_super(struct super_block *sb, struct fs_context *fc)
>  
>  	err = simple_fill_super(sb, BINFMTFS_MAGIC, bm_files);
>  	if (!err)
> -		sb->s_op = &s_ops;
> +		sb->s_op = &bm_super_ops;
>  	return err;
>  }
>  
> 
> -- 
> 2.53.0
> 

Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>
