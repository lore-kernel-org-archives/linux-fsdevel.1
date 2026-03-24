Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064EC3F0A9F
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 12:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774354107; cv=none; b=Y2iYt1ZDruGtuqNGFdtUDRHbBpYdYGoO0VqDaADUECw8Pjukt5vrdiRMDlH+5rOurcsWc1IlHuwCgmvMG0i63WuySSqBhrJK/iOZTefrEPFzShG3H1Z5uQJUwPJ0tjw0BjVjUJLgsMiUrYacM2DlDXmi4Di0uC73CKBQQcte1sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774354107; c=relaxed/simple;
	bh=7OEqnwGFNSajUTg8u4QbVGqWY/OSwjAG7i6SJ1JM1Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lNGFCZfboK0i9UNF0hHWoeFL4jnFXkkNi2hY81+w0xos6b7mfZNHZeL5VRTxUhwPyXCnGn+iqp2fn1xD/33ODfT9sH2ON0pMJI8q6BNt47rCz8W5PjLYtLrlLMZf9DLIbz3BIA22PgPACRFFQLjl7X4/VYTaUqRLXZN/4VVwb1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWP8d0Fk; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWP8d0Fk"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439b2965d4bso2743277f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 05:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774354100; x=1774958900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FW/uf6tO+ED65arVB0aoGz5GoGXatXSP8a3bFlkE0kE=;
        b=XWP8d0Fkiq+N6uGfr+AfaQpc1iYfyhz4a8PH4MKiRYDGNuP9nfIzrzQc3pzTM0JanR
         FMKl7a6bdPP5cxmN+sp+mevLwtXPjlb54aXHyEWn5e4Yhl5aL8VGOFJSMPHEXz8sRu9n
         TzBmsaHHQn87zYqZdzRHBggYLhf9WAUpKYYQ0W3jdQEB04YU6ftmvCwem6dnfL6SgRiW
         wDGl7T9pkX/wYlX6RvRNXVOUx6n9hxia7LsPuo/w/zZu8sQsukce0QYyD7BLwFrsl7PB
         6iDjF15D283UaO7LJw9bchs6ZH0trEW52hEJ1nKi4UDUlNmuyZV9sa4z8jLiO8GOOjtF
         EWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774354100; x=1774958900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FW/uf6tO+ED65arVB0aoGz5GoGXatXSP8a3bFlkE0kE=;
        b=h2ao4ArELC4J+Gp4gQJpA3wOkplgokfbiXmDNXOrQ9GWlfbTuNSz+MF0nngDzU1+ip
         i/MhIw6ltnpq53F34pzoXuwImUEpq9i9yEZkQGVjq0Qj/cZQaNY02RAdJ/JkzYH623Mz
         sRKUko/nhnwiGPn3mTM0RHUqbT+liMLzY9HjUqIpUx/tPjqlxZWjGFklsm4FBZadZ+iI
         UQKKomlf01DId9DBlJ078WMMVeZsgQxXSRyHX88m2IwNBar+ZUqIphbjJfK6IVStMpyC
         ROU95WRkr3VdXufUffeOIVayhdqWQ2apVsHcmDrtxwi6M2387ZaZHlZKjaOSqdRGkEWI
         dSdA==
X-Forwarded-Encrypted: i=1; AJvYcCUvfOhg2CwwDXa/ExuBkFmNfUVs8vmOubVyBy9jCk3CW4stBnszwFLLdYWkIzbgGMANRvi+B7H8JPoYUNcO@vger.kernel.org
X-Gm-Message-State: AOJu0YzdMqt/4H6nlnpf68wQ8xqDBvexDiY8+WphLtQhrChgHfi3WN+4
	FtnpZ9P20Xds+19uKJYoRrg9bOLWSGcXY9zTqSPQItrtEdXZiTTMXQC+
X-Gm-Gg: ATEYQzx5CjJoPHW9du+v39QRy/fe1GvtVgf5jJclJbOso+DhclghgOYmV8YpHauOldS
	i3feBhVDFOOHiYtzr4JMbzImr66nDjdHWVkTX1sVoQv2XqX7XFx0dOpYnBP8XNQVOBm8YapMvCD
	Ux5z0hWbGjbVUBbFjzMW7Wxz8EHr5LOnyR4xTgJi61yjzRcqTFOYgwj8qvHjptrq2WFf5xsJUYx
	raOhCc+XQOH9Jrt3FbCQfhiQ7bl/aW0RTRAxUgZL6nEQEzFK6ADZtqKU6o67uB5Q4XaQf9wzos1
	NGlKATCe0JViUsySa3Y+NUp1CmZjbfxmcIOMVHeAug/AlGuoc4d/twOxZ/xmy3KknZtoAILIj/r
	6ZB/yHRwPfYIXTyNwV7kXEdpaiS1Gceeyx5/OFYTT1o7Y1jVsOBuNaUtSboBWgbE094CqtkqZIZ
	SB0BSYUKW9H9lTuj1ET5BeDWlmwzgx9bAGhjfPMFBJkinwc1cMhIcPEwT+gXnzUBTgzJ0+zR0RV
	8U=
X-Received: by 2002:a05:6000:4382:b0:43b:3f2d:7d43 with SMTP id ffacd0b85a97d-43b64242a62mr24623752f8f.8.1774354099901;
        Tue, 24 Mar 2026 05:08:19 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b8567b2e2sm2306326f8f.33.2026.03.24.05.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 05:08:19 -0700 (PDT)
Date: Tue, 24 Mar 2026 12:08:17 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Linus Torvalds
 <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] readdir: Introduce dirent_size()
Message-ID: <20260324120817.6300b352@pumpkin>
In-Reply-To: <c20d2f8f6817a39401155cfc80f0dff88df116e0.1774350128.git.chleroy@kernel.org>
References: <c20d2f8f6817a39401155cfc80f0dff88df116e0.1774350128.git.chleroy@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Mar 2026 12:41:15 +0100
"Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:

> In several places in readdir.c there are calculations of the total size
> of a dirent, which contains a few fixed fields plus a name field with
> variable size. To add fun every dirent is of a slightly different type:
> - struct old_linux_dirent
> - struct linux_dirent
> - struct linux_dirent64
> - struct compat_old_linux_dirent
> - struct compat_linux_dirent
> 
> Replace ugly size calculation by a macro called dirent_size() which
> calculates the size of the structure based on the pointed type and
> the name field len.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

Reviewed-by: David Laight <david.laight.linux@gmail.com>

> ---
>  fs/readdir.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/readdir.c b/fs/readdir.c
> index 73707b6816e9..fb910dc2f52b 100644
> --- a/fs/readdir.c
> +++ b/fs/readdir.c
> @@ -22,6 +22,8 @@
>  #include <linux/compat.h>
>  #include <linux/uaccess.h>
>  
> +#define dirent_size(dirent, len) offsetof(typeof(*(dirent)), d_name[len])
> +
>  /*
>   * Some filesystems were never converted to '->iterate_shared()'
>   * and their directory iterators want the inode lock held for
> @@ -198,9 +200,7 @@ static bool fillonedir(struct dir_context *ctx, const char *name, int namlen,
>  	}
>  	buf->result++;
>  	dirent = buf->dirent;
> -	if (!user_write_access_begin(dirent,
> -			(unsigned long)(dirent->d_name + namlen + 1) -
> -				(unsigned long)dirent))
> +	if (!user_write_access_begin(dirent, dirent_size(dirent, namlen + 1)))
>  		goto efault;
>  	unsafe_put_user(d_ino, &dirent->d_ino, efault_end);
>  	unsafe_put_user(offset, &dirent->d_offset, efault_end);
> @@ -263,8 +263,7 @@ static bool filldir(struct dir_context *ctx, const char *name, int namlen,
>  	struct getdents_callback *buf =
>  		container_of(ctx, struct getdents_callback, ctx);
>  	unsigned long d_ino;
> -	int reclen = ALIGN(offsetof(struct linux_dirent, d_name) + namlen + 2,
> -		sizeof(long));
> +	int reclen = ALIGN(dirent_size(dirent, namlen + 2), sizeof(long));
>  	int prev_reclen;
>  	unsigned int flags = d_type;
>  
> @@ -352,8 +351,7 @@ static bool filldir64(struct dir_context *ctx, const char *name, int namlen,
>  	struct linux_dirent64 __user *dirent, *prev;
>  	struct getdents_callback64 *buf =
>  		container_of(ctx, struct getdents_callback64, ctx);
> -	int reclen = ALIGN(offsetof(struct linux_dirent64, d_name) + namlen + 1,
> -		sizeof(u64));
> +	int reclen = ALIGN(dirent_size(dirent, namlen + 1), sizeof(u64));
>  	int prev_reclen;
>  	unsigned int flags = d_type;
>  
> @@ -460,9 +458,7 @@ static bool compat_fillonedir(struct dir_context *ctx, const char *name,
>  	}
>  	buf->result++;
>  	dirent = buf->dirent;
> -	if (!user_write_access_begin(dirent,
> -			(unsigned long)(dirent->d_name + namlen + 1) -
> -				(unsigned long)dirent))
> +	if (!user_write_access_begin(dirent, dirent_size(dirent, namlen + 1)))
>  		goto efault;
>  	unsafe_put_user(d_ino, &dirent->d_ino, efault_end);
>  	unsafe_put_user(offset, &dirent->d_offset, efault_end);
> @@ -519,8 +515,7 @@ static bool compat_filldir(struct dir_context *ctx, const char *name, int namlen
>  	struct compat_getdents_callback *buf =
>  		container_of(ctx, struct compat_getdents_callback, ctx);
>  	compat_ulong_t d_ino;
> -	int reclen = ALIGN(offsetof(struct compat_linux_dirent, d_name) +
> -		namlen + 2, sizeof(compat_long_t));
> +	int reclen = ALIGN(dirent_size(dirent, namlen + 2), sizeof(compat_long_t));
>  	int prev_reclen;
>  	unsigned int flags = d_type;
>  

