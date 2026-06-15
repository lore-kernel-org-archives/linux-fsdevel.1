Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B82B3D5C1C
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 09:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781515573; cv=none; b=sp/61t7A3fTCQtp96Cnah5jUCetCrLFazXQ1n5sSu9O0LdPeNDRqYUW7UFlXIjYLMvdNBaUKNLYwTKWm7C6pHgIu1tMkwsVmkWoHETihfHzLs/hv6612MhIOEhRtfYktTFADe1NE4AVm1Xx1Vp1x77d5rGIZE1vL9y0BD2b0+jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781515573; c=relaxed/simple;
	bh=pjslUZjcfb0ZawJ5LtHVTFQIPSn+wxqqZlQ8udQvycU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qj7loJVIcpr1R9II4mEsXeXUOlwpq26Vfayv6EvYTuCgthGgztjdUs1ruY8UZJrjdYqPhPwVSCoYqtm6UP93V+sqLQ8bPWhqF1VDdnSZSx3Rw5kaYBF+vPhg/emTIu1AIbRTzksU59dQPtzAAgQ4C6wD2E5xnbAID9/9zpyQdxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6lthsim; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6lthsim"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45ef6565cfdso1406456f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 02:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781515569; x=1782120369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCYaIHNjMNsiMHrKpS1J2bSbUWKjV/eTWEkh6ujIVgk=;
        b=O6lthsimO7oDrDITgoeAftnvEkNvgGsuboHq3GFjRC9fGLy5aGJGYGOqauUIuLW858
         m6C5dpsvVHn/RikvdG3GUid+HC85BVxkS8+uLho89vx6apui6X5rQPkG8FVw1bQsWgAW
         Cq+PEkhh6JxYWqQU32tW8BlWo/91ZmnJ++OTKIQ1TeHNhCD3OomFoxfUTiKl1t6qbSRg
         xYb2PCMmMaxFhMb14QCyGXIMVKtaI1TP/9rBJbK0fx2vtRw4CYpd438/5wu+lBs9MzC4
         6O3hhR7OsHgaFK5MZZR6t5uAk3GGtwmWPn9WMKEd5FbnL/o39QLr7ZQXEEuVRw1Hxcac
         gPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781515569; x=1782120369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MCYaIHNjMNsiMHrKpS1J2bSbUWKjV/eTWEkh6ujIVgk=;
        b=mnoWGXVHOTgAoCAmCjyldazZrIzWiv0cZNw1GYz30/viehok2RrM26C8wZpOksE+4t
         Dc7voMDLxxX/Si2rfDY+6EdxOg3st114xi4/AoS4vltxR6X0nxefvlpgofyySE66ck/G
         qLBB2V7ciRzX5ntlIm1rYb3TDShyNadwDNQdNFLQjAg2D6BO4n388pECgalxefi7VNet
         khQaH98AttJiQpDFyGAZ3rhL7Difhtno/0Rvc1ufD/KSBUBsMxqnNT2ywVz3+CxvxPxW
         OULoOoasE6Yuv1Gj1cMYn7q2duyOvBK6OtyZnbpzvGK0PgxgEkUvN2j22KmkWYbHecDX
         ru1g==
X-Forwarded-Encrypted: i=1; AFNElJ/XdlhrtaKgXqVWf6zW7i7qC9QZq3is/hTxNwNHjDFc74n3nUR/LMgxurbfUKS26z0ufRakc6Zlg2UdTkOB@vger.kernel.org
X-Gm-Message-State: AOJu0YzF+4CcxvvWJUCauYkUPD9UGdP69VWBj+z2BhftHXpiZGRPl33r
	9pqp6e9MvqIWZ/UQH4HfE0XLg+1PtpLLOFtR2il/MbVHMR1TE30FlQrX
X-Gm-Gg: Acq92OEx/W4/TJNT+vXraXkSuzpAfoKyWi6bADamKtPxYU4bAfvKoCT+5kmeHxcKZBT
	cfTvHgPPRa1OFNj+m7LxoGHFOYhtAl5rxGOZliMuLE32ucoh0DOZ44v49o4MszmLR27qqaKI/Wb
	gyjmsqomXrEOEJaoQYOFxbK/8mswC0ct8q0KBAYydDtum/EwjR0dwwzOXEXBOzXVJP1vxH+wEzI
	lLP3OP+TXEOcsB8loqv77VR8y2UhsIBCmE3CdMT3VtvU07bv+qdwrXPB0kekDVjVdWngQM26I8r
	ynsx1fnd7GpsT2K2urDRZ/fWwTZX2M3TsgSba24t4H1dNovt3LR1zFae98+WWfioc4o8Vnp0/j5
	GAlchTIVonUVHhwi2IlNIkjv4cXWhp4UbYePNhiJuyHmzDj4W1IzGSmf9maMzpClDnedr1We6hg
	k2a3uOW7+cWAeEWHXnnnWRPdEF33yfjTLSI7GGM0ea6b/kyrLDNcrs4iYV7qQN
X-Received: by 2002:a05:6000:2995:10b0:452:6aa0:1d11 with SMTP id ffacd0b85a97d-4606da6d614mr13965634f8f.19.1781515568626;
        Mon, 15 Jun 2026 02:26:08 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2b0c35sm33697256f8f.22.2026.06.15.02.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 02:26:08 -0700 (PDT)
Date: Mon, 15 Jun 2026 10:26:06 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Al Viro
 <viro@zeniv.linux.org.uk>, NeilBrown <neil@brown.name>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] fs/namei.c: use trailing_slashes()
Message-ID: <20260615102606.0d7befa2@pumpkin>
In-Reply-To: <20260614164438.2980769-2-jkoolstra@xs4all.nl>
References: <20260614164438.2980769-1-jkoolstra@xs4all.nl>
	<20260614164438.2980769-2-jkoolstra@xs4all.nl>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Jun 2026 18:44:27 +0200
Jori Koolstra <jkoolstra@xs4all.nl> wrote:

> There are several places in fs/namei.c that can use the
> trailing_slashes() function to improve intent.

I'm not sure it does anything for the readability.

> 
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/namei.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 4787244ca4a7..64b91ed9efb7 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2777,9 +2777,14 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
>  	return s;
>  }
>  
> +static inline bool trailing_slashes(const struct qstr last)

You are passing a struct by value.
If the function isn't inlined then you've blown the stack.

	David

> +{
> +	return (bool)last.name[last.len];
> +}
> +
>  static inline const char *lookup_last(struct nameidata *nd)
>  {
> -	if (nd->last_type == LAST_NORM && nd->last.name[nd->last.len])
> +	if (nd->last_type == LAST_NORM && trailing_slashes(nd->last))
>  		nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
>  
>  	return walk_component(nd, WALK_TRAILING);
> @@ -4524,17 +4529,12 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  	return ERR_PTR(error);
>  }
>  
> -static inline bool trailing_slashes(struct nameidata *nd)
> -{
> -	return (bool)nd->last.name[nd->last.len];
> -}
> -
>  static struct dentry *lookup_fast_for_open(struct nameidata *nd, int open_flag)
>  {
>  	struct dentry *dentry;
>  
>  	if (open_flag & O_CREAT) {
> -		if (trailing_slashes(nd))
> +		if (trailing_slashes(nd->last))
>  			return ERR_PTR(-EISDIR);
>  
>  		/* Don't bother on an O_EXCL create */
> @@ -4542,7 +4542,7 @@ static struct dentry *lookup_fast_for_open(struct nameidata *nd, int open_flag)
>  			return NULL;
>  	}
>  
> -	if (trailing_slashes(nd))
> +	if (trailing_slashes(nd->last))
>  		nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
>  
>  	dentry = lookup_fast(nd);
> @@ -4945,7 +4945,7 @@ static struct dentry *filename_create(int dfd, struct filename *name,
>  	 * Do the final lookup.  Suppress 'create' if there is a trailing
>  	 * '/', and a directory wasn't requested.
>  	 */
> -	if (last.name[last.len] && !want_dir)
> +	if (trailing_slashes(last) && !want_dir)
>  		create_flags &= ~LOOKUP_CREATE;
>  	dentry = start_dirop(path->dentry, &last, reval_flag | create_flags);
>  	if (IS_ERR(dentry))
> @@ -5562,7 +5562,7 @@ int filename_unlinkat(int dfd, struct filename *name)
>  		goto exit_drop_write;
>  
>  	/* Why not before? Because we want correct error value */
> -	if (unlikely(last.name[last.len])) {
> +	if (unlikely(trailing_slashes(last))) {
>  		if (d_is_dir(dentry))
>  			error = -EISDIR;
>  		else
> @@ -6161,16 +6161,16 @@ int filename_renameat2(int olddfd, struct filename *from,
>  	if (flags & RENAME_EXCHANGE) {
>  		if (!d_is_dir(rd.new_dentry)) {
>  			error = -ENOTDIR;
> -			if (new_last.name[new_last.len])
> +			if (trailing_slashes(new_last))
>  				goto exit_unlock;
>  		}
>  	}
>  	/* unless the source is a directory trailing slashes give -ENOTDIR */
>  	if (!d_is_dir(rd.old_dentry)) {
>  		error = -ENOTDIR;
> -		if (old_last.name[old_last.len])
> +		if (trailing_slashes(old_last))
>  			goto exit_unlock;
> -		if (!(flags & RENAME_EXCHANGE) && new_last.name[new_last.len])
> +		if (!(flags & RENAME_EXCHANGE) && trailing_slashes(new_last))
>  			goto exit_unlock;
>  	}
>  

