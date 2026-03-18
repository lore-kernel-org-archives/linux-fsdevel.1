Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D1C33C18B
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773843706; cv=none; b=DHKnLToArksl6iOVSFXKAdf4w5KivmAb0rRtBA8vdd0dBhIBNM7f8jeiaZFXryDcWpNLb+gJ/doKxD/DvwGkXoZ2BvHdjJk1kahu69gdcUAP6np0kBMf7FbiAe+OCDMk3EtgIlTFT8A2300x4mF88xmhNB8F60EuQeQ9JBhgMn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773843706; c=relaxed/simple;
	bh=f9UR7y3ZwgsV+TuelLXCYwXJUhQh+u9OBvw9waB8xX4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g3IMELKZ68aN7GBJNkyX+2+Nkx3l+Pl80NjbM27eErT4wr01K/SZ1pFqU+v1VEcDsdSRGOwYEvRrffbDfm9nnmr80m9due0AXbIYRXHEjRz68kUTdPjjr3az9JeB9Hxl9U+0k4DUdNJ7WmEJOmdWf3ggW2zH+szbnf5ZiqJljjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrdRsWqD; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrdRsWqD"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so58302365e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 07:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773843702; x=1774448502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zYhSwAzJ9BUGywvFLIYkG2/r1jfBmm8GGSh/9Q1A0g=;
        b=WrdRsWqDXbGtBEfOt6YM+/liaf1v1mM1HoTtwER98BxA/k5ivL1tML5ZrPcq0U+Zp6
         eRRqathyP66VfISV6cu+ta9N0cjGciGsCIi3Fzaccyz2a2Ww9jz5KZ7rfeChiJpj5tl/
         SP2az680eesGRJxArqFSqvtQ2rT3hE2tgviIoT8Nedj3mtguZ3Gzi3Cjkol+fUUmvTBG
         o3CVLSpoQU8mIvfK+YM+n5Q5KmEhTTEZwIjYZM8uNjIVf4/J82lbhP19DzPpdTAL3UXU
         amKWc9Cw4TOz6kF87wWq5oLLVsbfFO+63TXf5AbcGMdvbObx5XFiIbxG3KJV52wTZRah
         ec+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773843702; x=1774448502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0zYhSwAzJ9BUGywvFLIYkG2/r1jfBmm8GGSh/9Q1A0g=;
        b=Cqx2bJBmQsGGCQvWSkOKH5dg3VpkmttPRHbeQybbX3MZXDMJ8Oi9q2O46KM1XcWc/S
         EkeR2LgUUHG8/XH9YStFvSD9rMAFO2quy/vC71WvsxujYteFtGN3x5MswkHboniYcjz0
         A/yRBCrAzdFM4nmwPwEZN3FME4p0uXRH+nS5dtmR5nhBE519Do9MjzjJFOg8XUxWNFTF
         cOVljVQiYaz5y5lDFasv+6d8QbJhiwXw0TKJWDTT98VNfIhJ0dKYgwLVvjs9Lbkt1tgY
         IzglPeLNH3rA2C5DOmspeWcpWWUq4cflJ9cxb9XskTj00aOoe2UYqvcA67QDGOfz0d0T
         d7hg==
X-Forwarded-Encrypted: i=1; AJvYcCWGczCdYrsFOGDvUQGY7SFFV/7QEuf1DhGfUycevTmqsrrMCApj/BEEO0NISgU4iJUvJ5uGNxDZ8G1c0Lnw@vger.kernel.org
X-Gm-Message-State: AOJu0YwstjurK6xzR1ptdVsygHrlhSzIDbvvWc0N/q34H3rRRUDN1W8+
	MdjbOkc+CK7iC9pe9xggpQwtnQxM2u8HJ5oWykwEvhg+BQOzGDRjwQTB
X-Gm-Gg: ATEYQzxReG7+UBfzEAw0y8XgX5zZ+h4QEP9XGYr/E2qsgt3RaeM5GdEgNeA4rbyfRXC
	8NYcucIQblBnbt/zApacUobEmntw8XwxY1S6H7pA4p1vM9+O7N1IWaRg3ZiGZIEpXiIadrnJ46V
	1hy2KRrmYUuwX+9inFH+SF3YaVfC8147DbxDdIHQZnC8tZObL0x9sdo+8PlkBCj81LavJc/7PsM
	Z5ObRm33FyJjRH2ZkULf4xgbFyV5FUUur8+Mb9Wpeka7oDEj2zSL4YFB08WODIS34G4i4a+hn6e
	EPvd0VKms4TJ25SukonJzojWL8nxiCM5p2K/vRqBJbyQHDTY1XkhFP8Bj0ysm5IfLIQtWowPtY2
	Ppss/lT8oFyGRkoKKZumevMmEJnZiLT67CMhBknYxGizEGP+AWmttaN7lJP4jul95Myi3ceNnl/
	NmBJqDYxdq9VSu/4fwabdMT4QC5lBAewPuzeO0b1vtF8D8KI4Tzo91w5yGoov/49jn0JNcA6Y4Z
	Ak=
X-Received: by 2002:a05:600c:470f:b0:485:3baa:af14 with SMTP id 5b1f17b1804b1-486f44410acmr60416925e9.18.1773843702145;
        Wed, 18 Mar 2026 07:21:42 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f4b83930sm21092845e9.17.2026.03.18.07.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 07:21:41 -0700 (PDT)
Date: Wed, 18 Mar 2026 14:21:40 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Linus Torvalds
 <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] fs: Replace user_access_{begin/end} by scoped user
 access
Message-ID: <20260318142140.3f94510c@pumpkin>
In-Reply-To: <f46941437f681cc72fc5a84fa768f65b952f43c6.1773830446.git.chleroy@kernel.org>
References: <f46941437f681cc72fc5a84fa768f65b952f43c6.1773830446.git.chleroy@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Mar 2026 13:22:43 +0100
"Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:

> Scoped user access reduces code complexity and seamlessly bring
> masked user access on architectures that support it.
> 
> Replace user_access_begin/user_access_end blocks by
> scoped user access.
> 
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> ---
> v2:
> - Fix build failure with CONFIG_COMPAT
> - Handled checkpatch.pl output
> 
> v3:
> - Fix again build failure with CONFIG_COMPAT. I was obviously too tired when I sent out v2.
> 
> v4:
> - Introduced local size var based on Linus comment on readability. Not a dirent_size() helper as suggested as both sites are different.
> ---
>  fs/readdir.c | 94 +++++++++++++++++++++-------------------------------
>  fs/select.c  | 35 ++++++++-----------
>  2 files changed, 51 insertions(+), 78 deletions(-)
> 
> diff --git a/fs/readdir.c b/fs/readdir.c
> index 73707b6816e9..8fa615b7e950 100644
> --- a/fs/readdir.c
> +++ b/fs/readdir.c
> @@ -184,6 +184,7 @@ static bool fillonedir(struct dir_context *ctx, const char *name, int namlen,
>  	struct readdir_callback *buf =
>  		container_of(ctx, struct readdir_callback, ctx);
>  	struct old_linux_dirent __user * dirent;
> +	size_t size = offsetof(struct old_linux_dirent, d_name) + namlen + 1;
>  	unsigned long d_ino;
>  
>  	if (buf->result)
> @@ -198,18 +199,13 @@ static bool fillonedir(struct dir_context *ctx, const char *name, int namlen,
>  	}
>  	buf->result++;
>  	dirent = buf->dirent;
> -	if (!user_write_access_begin(dirent,
> -			(unsigned long)(dirent->d_name + namlen + 1) -
> -				(unsigned long)dirent))
> -		goto efault;
> -	unsafe_put_user(d_ino, &dirent->d_ino, efault_end);
> -	unsafe_put_user(offset, &dirent->d_offset, efault_end);
> -	unsafe_put_user(namlen, &dirent->d_namlen, efault_end);
> -	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
> -	user_write_access_end();
> +	scoped_user_write_access_size(dirent, size, efault) {

The problem now is that it isn't obviously clear that 'size' is correct.
If nothing else its definition is quite a way up from the use.
Perhaps putting:
	size = offsetof(typeof(*dirent), d_name) + namelen + 1;
immediately before the scoped_user_write_access_size() would be better.
Perhaps even renaming it dirent_len.

	David

> +		unsafe_put_user(d_ino, &dirent->d_ino, efault);
> +		unsafe_put_user(offset, &dirent->d_offset, efault);
> +		unsafe_put_user(namlen, &dirent->d_namlen, efault);
> +		unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault);
> +	}
>  	return true;
> -efault_end:
> -	user_write_access_end();
>  efault:
>  	buf->result = -EFAULT;
>  	return false;
> @@ -287,23 +283,19 @@ static bool filldir(struct dir_context *ctx, const char *name, int namlen,
>  		return false;
>  	dirent = buf->current_dir;
>  	prev = (void __user *) dirent - prev_reclen;
> -	if (!user_write_access_begin(prev, reclen + prev_reclen))
> -		goto efault;
> -
> -	/* This might be 'dirent->d_off', but if so it will get overwritten */
> -	unsafe_put_user(offset, &prev->d_off, efault_end);
> -	unsafe_put_user(d_ino, &dirent->d_ino, efault_end);
> -	unsafe_put_user(reclen, &dirent->d_reclen, efault_end);
> -	unsafe_put_user(d_type, (char __user *) dirent + reclen - 1, efault_end);
> -	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
> -	user_write_access_end();
> +	scoped_user_write_access_size(prev, reclen + prev_reclen, efault) {
> +		/* This might be 'dirent->d_off', but if so it will get overwritten */
> +		unsafe_put_user(offset, &prev->d_off, efault);
> +		unsafe_put_user(d_ino, &dirent->d_ino, efault);
> +		unsafe_put_user(reclen, &dirent->d_reclen, efault);
> +		unsafe_put_user(d_type, (char __user *)dirent + reclen - 1, efault);
> +		unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault);
> +	}
>  
>  	buf->current_dir = (void __user *)dirent + reclen;
>  	buf->prev_reclen = reclen;
>  	ctx->count -= reclen;
>  	return true;
> -efault_end:
> -	user_write_access_end();
>  efault:
>  	buf->error = -EFAULT;
>  	return false;
> @@ -371,24 +363,20 @@ static bool filldir64(struct dir_context *ctx, const char *name, int namlen,
>  		return false;
>  	dirent = buf->current_dir;
>  	prev = (void __user *)dirent - prev_reclen;
> -	if (!user_write_access_begin(prev, reclen + prev_reclen))
> -		goto efault;
> -
> -	/* This might be 'dirent->d_off', but if so it will get overwritten */
> -	unsafe_put_user(offset, &prev->d_off, efault_end);
> -	unsafe_put_user(ino, &dirent->d_ino, efault_end);
> -	unsafe_put_user(reclen, &dirent->d_reclen, efault_end);
> -	unsafe_put_user(d_type, &dirent->d_type, efault_end);
> -	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
> -	user_write_access_end();
> +	scoped_user_write_access_size(prev, reclen + prev_reclen, efault) {
> +		/* This might be 'dirent->d_off', but if so it will get overwritten */
> +		unsafe_put_user(offset, &prev->d_off, efault);
> +		unsafe_put_user(ino, &dirent->d_ino, efault);
> +		unsafe_put_user(reclen, &dirent->d_reclen, efault);
> +		unsafe_put_user(d_type, &dirent->d_type, efault);
> +		unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault);
> +	}
>  
>  	buf->prev_reclen = reclen;
>  	buf->current_dir = (void __user *)dirent + reclen;
>  	ctx->count -= reclen;
>  	return true;
>  
> -efault_end:
> -	user_write_access_end();
>  efault:
>  	buf->error = -EFAULT;
>  	return false;
> @@ -446,6 +434,7 @@ static bool compat_fillonedir(struct dir_context *ctx, const char *name,
>  	struct compat_readdir_callback *buf =
>  		container_of(ctx, struct compat_readdir_callback, ctx);
>  	struct compat_old_linux_dirent __user *dirent;
> +	size_t size = offsetof(struct compat_old_linux_dirent, d_name) + namlen + 1;
>  	compat_ulong_t d_ino;
>  
>  	if (buf->result)
> @@ -460,18 +449,13 @@ static bool compat_fillonedir(struct dir_context *ctx, const char *name,
>  	}
>  	buf->result++;
>  	dirent = buf->dirent;
> -	if (!user_write_access_begin(dirent,
> -			(unsigned long)(dirent->d_name + namlen + 1) -
> -				(unsigned long)dirent))
> -		goto efault;
> -	unsafe_put_user(d_ino, &dirent->d_ino, efault_end);
> -	unsafe_put_user(offset, &dirent->d_offset, efault_end);
> -	unsafe_put_user(namlen, &dirent->d_namlen, efault_end);
> -	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
> -	user_write_access_end();
> +	scoped_user_write_access_size(dirent, size, efault) {
> +		unsafe_put_user(d_ino, &dirent->d_ino, efault);
> +		unsafe_put_user(offset, &dirent->d_offset, efault);
> +		unsafe_put_user(namlen, &dirent->d_namlen, efault);
> +		unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault);
> +	}
>  	return true;
> -efault_end:
> -	user_write_access_end();
>  efault:
>  	buf->result = -EFAULT;
>  	return false;
> @@ -543,22 +527,18 @@ static bool compat_filldir(struct dir_context *ctx, const char *name, int namlen
>  		return false;
>  	dirent = buf->current_dir;
>  	prev = (void __user *) dirent - prev_reclen;
> -	if (!user_write_access_begin(prev, reclen + prev_reclen))
> -		goto efault;
> -
> -	unsafe_put_user(offset, &prev->d_off, efault_end);
> -	unsafe_put_user(d_ino, &dirent->d_ino, efault_end);
> -	unsafe_put_user(reclen, &dirent->d_reclen, efault_end);
> -	unsafe_put_user(d_type, (char __user *) dirent + reclen - 1, efault_end);
> -	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
> -	user_write_access_end();
> +	scoped_user_write_access_size(prev, reclen + prev_reclen, efault) {
> +		unsafe_put_user(offset, &prev->d_off, efault);
> +		unsafe_put_user(d_ino, &dirent->d_ino, efault);
> +		unsafe_put_user(reclen, &dirent->d_reclen, efault);
> +		unsafe_put_user(d_type, (char __user *)dirent + reclen - 1, efault);
> +		unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault);
> +	}
>  
>  	buf->prev_reclen = reclen;
>  	buf->current_dir = (void __user *)dirent + reclen;
>  	ctx->count -= reclen;
>  	return true;
> -efault_end:
> -	user_write_access_end();
>  efault:
>  	buf->error = -EFAULT;
>  	return false;
> diff --git a/fs/select.c b/fs/select.c
> index e0244dbe4429..75978b18f48f 100644
> --- a/fs/select.c
> +++ b/fs/select.c
> @@ -1004,17 +1004,17 @@ static int do_sys_poll(struct pollfd __user *ufds, unsigned int nfds,
>  	fdcount = do_poll(head, &table, end_time);
>  	poll_freewait(&table);
>  
> -	if (!user_write_access_begin(ufds, nfds * sizeof(*ufds)))
> -		goto out_fds;
> +	scoped_user_write_access_size(ufds, nfds * sizeof(*ufds), out_fds) {
> +		struct pollfd __user *_ufds = ufds;
>  
> -	for (walk = head; walk; walk = walk->next) {
> -		struct pollfd *fds = walk->entries;
> -		unsigned int j;
> +		for (walk = head; walk; walk = walk->next) {
> +			struct pollfd *fds = walk->entries;
> +			unsigned int j;
>  
> -		for (j = walk->len; j; fds++, ufds++, j--)
> -			unsafe_put_user(fds->revents, &ufds->revents, Efault);
> -  	}
> -	user_write_access_end();
> +			for (j = walk->len; j; fds++, _ufds++, j--)
> +				unsafe_put_user(fds->revents, &_ufds->revents, out_fds);
> +		}
> +	}
>  
>  	err = fdcount;
>  out_fds:
> @@ -1026,11 +1026,6 @@ static int do_sys_poll(struct pollfd __user *ufds, unsigned int nfds,
>  	}
>  
>  	return err;
> -
> -Efault:
> -	user_write_access_end();
> -	err = -EFAULT;
> -	goto out_fds;
>  }
>  
>  static long do_restart_poll(struct restart_block *restart_block)
> @@ -1338,15 +1333,13 @@ static inline int get_compat_sigset_argpack(struct compat_sigset_argpack *to,
>  					    struct compat_sigset_argpack __user *from)
>  {
>  	if (from) {
> -		if (!user_read_access_begin(from, sizeof(*from)))
> -			return -EFAULT;
> -		unsafe_get_user(to->p, &from->p, Efault);
> -		unsafe_get_user(to->size, &from->size, Efault);
> -		user_read_access_end();
> +		scoped_user_read_access(from, efault) {
> +			unsafe_get_user(to->p, &from->p, efault);
> +			unsafe_get_user(to->size, &from->size, efault);
> +		}
>  	}
>  	return 0;
> -Efault:
> -	user_read_access_end();
> +efault:
>  	return -EFAULT;
>  }
>  

