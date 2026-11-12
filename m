Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794506212;
	b=eqZkviap1FK3jt9UKB4Tu4lpkryIXO8v7qdicq9su6NxQnDXWzAW9Su+D2meZReHuGQH
	 B4nKl6TUt3xekTAfhbxRTaJ0HMEOxixsUbdJjvz0p6bnpxQYBfoaS3ohpT3Mx31FdwMZs
	 j8DPqHM/P8GAG7OoGlZXP+VuoZPCefG4Vu1nQz/T02Pb/ghGNs2Hr2gLwTL94s6SknzEu
	 zTFJ3NAJIECN+hG0/+cleP8O/G5KWIlytv4ffMCIt1LimtWcQVXi7hTkyl6L6NQshKIle
	 59AKtRxLqw0kL1ctZsPfQv1IoknENjAyFLzYHkwD3SGRpzhOG25Tos8tBss1j+NLVmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794506212;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=QMQK5/Ga5zlr52AaPH9o6uVLJ1IT8a65QapD4mFEmG0=;
	b=ln9q8ccsQ8GT7TI8MhoN9KI54JZwUQD+h7aFKKqCodruul/4tt90MKpc4kPpTjmDmp0M
	 GxkfBt3S0pCWj5CP/gg+fGaHf6Pocl0q8c70VX3+vLQaKUApsws00IANtfLrf6SvXsgiV
	 sDv2oKb4+6BNgH8euQVCuj+yJ4fw2AokVNtx2vOjGSet6zSHaJduar6w0KGn6uf+iAM4i
	 ILQs7lCbz1xrqA4EBdGdu+9kICsqshkD6gfrs28sIrYhAqF5RjyIZG6BXH+BznsLLWQBt
	 hZrSAL0jkV9J7jYnNY3Mw4f7hYylyxi9l2atGZT8Vu/3esLNnrDmc5PHNPCJ0gIb2jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=GMLDkSOi;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149FC606A8AA
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 17:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 149FC606A8AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=GMLDkSOi
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91befbcad6dso861846d6.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 09:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1794506211; x=1795111011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QMQK5/Ga5zlr52AaPH9o6uVLJ1IT8a65QapD4mFEmG0=;
        b=GMLDkSOi35pb7b/8IUfDSIIuqcDlZx2QBaL2QdtcNaTTmNbEgxlZfp0iumV1Orc7le
         igNhglznQ0se6+rd1lwonMXmAykcEzPLvmmY/rLnAJ0Jk0vvu4dDip3qJaoSEqWAoDKt
         coEZWu03f/UhTImKV1PokYwBvQAfon4J7Tb5XFVCS1fjPteDm4aWTPLaoS0A9ShRnUa+
         MqCu8yTPOzywxO1VEKJT+RoIa5XVchkVDuSQToFaz0Uqk6ityVTiJfeKITv1SgphMrVR
         sqG5Q+vS3v86b7M23DO4OlqsoKfWNzAB8SCGZsdSreMkSwwYsZFMtLK9BjdErY4jXx+y
         +Atw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794506211; x=1795111011;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QMQK5/Ga5zlr52AaPH9o6uVLJ1IT8a65QapD4mFEmG0=;
        b=t0a6WtYTlxki+6c++8snpW6UObb7ZBpMMqgQ0XL7zbR+Ue4/bReXjYMNN5ZOaW2Dso
         vcMVz7caGeqRxiSmKDWfay26wPZ76Hln1IBYFlW/b7xqO0yB0biPLSiGnP5HkG+dVUmQ
         7xh9RTp560o5GlxBQYdtaLhONsGUqNthVzNt5KfGxl0ZbzidJDVH26aPVjKUE+oq0b2e
         RsFRKugj7e5Rd73WoPYfIfG5HwY9CpYyRCUYjSkYKOQfZxjcBpmizx8KTLstS5rcniKt
         ZqA3JO7lx3f59l3J3ErkIJDvy5euqdnbouTX7KW0rQyVVbBUMEKuSEF/YHOvzua6WjdS
         FUaQ==
X-Forwarded-Encrypted: i=1; AL+hErGySV+cvwWmXk1KAC/BDRJX/jjsHFHcRB7KkAFL5HqCnLW0Qwfo1vNifGpl3AI8/uTOeUdCKgqZ/rGc8tWO@vger.kernel.org
X-Gm-Message-State: APuU4Z+NNtNYpSJE0PeB1/zI676J9IPmC4lG1pb9EQo5zL9guQAPpNB/
	+Yv3uSv74Z7epe9LrCHxEGdkpyHJZu9IXnOemAv6ZPQNrYblScm+rl0DlE3OSkGVE3I=
X-Gm-Gg: AYBFou2LxOUxhrzhoulyTjcwu0N6u0YVGloAGCiY+oEy+4wpJ3I6SL67Qy/GZBfRagq
	uDd8dWKnis7yoDxOPHpJWVDMnddhiCkftOTDbaK58MSl7zzUYY0HJIjyahlg0eA5OMSE9I3SYbu
	TqZO1YRw4g3852eRBEreFQkAg1kWaNrVAHWd1LinSRJXtwYgerKmsbBJTW0NQHXalT/bSJMDPZ5
	7yceUljPm0EhYTP4yb+1hJKSpFJdWYPQD213VbFoSOzcIwC0c9pIHHKHKCClSCRY/T6oAPMJlrR
	jkBsXkOuDtTQHYkITQOZC7fYAALayyywR88ZRQUdfV/8LPGXlUzlec1hxWYr8y0kS30nRhOID6r
	/2TUDa7MMd4NTn7B86VWE0iwheCP+5oOANsFzW/hjR4dY6yTCzPhPwTfKZ/aUmJmCz/HPW31LEb
	Vwo+GhCsAT2S4gE6dvcz0nSkVQCbNRp7hehrE8fcqQlVcdoDFnLsJK+RrM6raw1pbZN6+mxuZ/y
	VbKAj4Y9HJjdXLfd/qtThcFJU6IKy6Qwo4CwwXG5ysB531iBRR6+ol0Ce5lh6s8//yyu2328es+
	VoAjGQ7HtHTnaEo7VH0Tdk0ksoIrTHSKZmHdXbcbwxXYSw==
X-Received: by 2002:ad4:5ca2:0:b0:91e:8160:55b3 with SMTP id 6a1803df08f44-91f2423de34mr511396d6.53.1794506210743;
        Thu, 12 Nov 2026 09:56:50 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d93f10sm1193356d6.30.2026.11.12.09.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:56:50 -0800 (PST)
Date: Thu, 12 Nov 2026 17:56:37 +0000
From: Josef Bacik <josef@toxicpanda.com>
To: Ye Bin <yebin@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: hold freeze protection across writable regular file
 ->open()
Message-ID: <sxlubqvhlkeg4ukyxakquv4e72o4ib7u2o2jtak4qqs6gz5haw@uoty23uvtlf3>
References: <20261112135245.3347102-1-yebin@huaweicloud.com>
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
In-Reply-To: <20261112135245.3347102-1-yebin@huaweicloud.com>

On Thu, Nov 12, 2026 at 09:52:45PM +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> A writable open of a regular file reaches the filesystem's ->open()
> callback without holding any superblock write (freeze) protection.
> ->open() can nevertheless write to the filesystem: ext4_file_open() ->
> dquot_file_open() -> dquot_initialize() may acquire a dquot and write
> the quota file, which starts a jbd2 transaction.  If the filesystem
> reaches SB_FREEZE_COMPLETE in that window, ext4_journal_check_start()
> hits
> 
> 	WARN_ON(sb->s_writers.frozen == SB_FREEZE_COMPLETE);
> 
> and the open then sleeps in jbd2 until the filesystem is thawed.
> 
> The hole was created over time:
> 
>   - Commit 907f4554e252 ("dquot: move dquot initialization responsibility
>     into the filesystem") moved quota initialization into ->open() and
>     introduced dquot_file_open(), making ->open() a potentially writing
>     operation for writable opens.
> 
>   - Commit eb04c28288bb ("fs: Add freezing handling to mnt_want_write() /
>     mnt_drop_write()") added sb_start_write() to mnt_want_write() but
>     deliberately kept the write reference held by an open file on the
>     non-freezing __mnt_want_write() variant, so the file's own write
>     reference does not protect its ->open().
> 
>   - Commit 64894cf84327 ("simplify lookup_open()/atomic_open() - do the
>     temporary mnt_want_write() early") moved the temporary write count
>     into do_last() and dropped it before finish_open(), so a writable
>     open that is not O_TRUNC reaches ->open() with no sb write count at
>     all.
> 
> Since then only O_TRUNC opens take mnt_want_write() in do_open().
> 
> Fix this by taking mnt_want_write() for any writable open of a regular
> file and holding it across vfs_open()/->open().  Regular files are
> checked explicitly so that opening device nodes on a read-only mount is
> not newly rejected.  Read-only opens are unaffected.
> 
> Fixes: eb04c28288bb ("fs: Add freezing handling to mnt_want_write() / mnt_drop_write()")
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/namei.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index f573fd0aacaf..0ee4cf282cf5 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4906,6 +4906,7 @@ static int do_open(struct nameidata *nd,
>  	const struct mnt_idmap *idmap;
>  	int open_flag = op->open_flag;
>  	bool do_truncate;
> +	bool got_write;
>  	int acc_mode;
>  	int error;
>  
> @@ -4935,12 +4936,23 @@ static int do_open(struct nameidata *nd,
>  		return -ENOTDIR;
>  
>  	do_truncate = false;
> +	got_write = false;
>  	acc_mode = op->acc_mode;
>  	if (file->f_mode & FMODE_CREATED) {
>  		/* Don't check for write permission, don't truncate */
>  		open_flag &= ~O_TRUNC;
>  		acc_mode = 0;
>  	} else if (d_is_reg(nd->path.dentry) && open_flag & O_TRUNC) {
> +		do_truncate = true;
> +	}
> +
> +	/*
> +	 * ->open() can write to the filesystem, e.g. when it initializes
> +	 * quota, so writable opens of regular files need freeze protection
> +	 * as well.  O_TRUNC opens already need it for handle_truncate().
> +	 */
> +	if (do_truncate ||
> +	    (d_is_reg(nd->path.dentry) && (file->f_mode & FMODE_WRITE))) {

This is convoluted, you can get rid of the do_truncate flag altogether,
just do

if (d_is_reg(nd->path.dentry) &&
    ((open_flag & O_TRUNC) || (file->f_mode & FMOD_WRITE))) {
	// mntwrite thing
	go_write = true;
}

And the delete the extra else if block. Thanks,

Josef
