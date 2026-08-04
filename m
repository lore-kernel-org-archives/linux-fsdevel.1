Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A594048380B
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 17:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862883; cv=pass; b=eiwF9GVp5nsvcVhBoqpl5dRzFV6vi17+xAUks1Luikw2s1ia9JuJjmVSXWeNkRBjcXIg3B3sncgR+/lNv4chbhGikkCBeF24QwNVMKLo26ryO8cgxEVk3pkhy9l99yEbyaXHfP13EvfOjII4EEKSBZwvtXhBslfm2iJyULsC9Wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862883; c=relaxed/simple;
	bh=NN7RQwZEWIcd3u0Kef8iTQYndBZrEjQokV6obVKC/Dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F7zoDDCVRo3jqRAAvSNAOmdvSRNOuKh/tCjeFrNbMwZ/EKkGrdt5u/9pdYgAQeIxcOt7klP6iZ8xpxnBW7oKwvJEJ3BoMjMAS9hjFj2JNcDyp4EPzSv1gcUdzcbiMuwIgXSTiuMEP4nHZTnTJCGTxlGfkUW1aYUP+1TI72TtEGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SZHhjSu+; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SZHhjSu+"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cb5b8572b70so4132289a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 10:00:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785862855; cv=none;
        d=google.com; s=arc-20260327;
        b=NGVDCuSxHo7LZ4rrsp8jcOPIbnOwvStYyCAVc3cNfxzDPlm1f8xMWhRM6c2GWWXeUw
         L7JV94DzbPIaJikpcUWF2kZSiZwf1s6mH66HLoo+7aebMSCW02vLPsngLw1V8+udWMTC
         OCsCeJbhMcAMK7nh/uYT3FKkIQsX/sk9Hn7tpRXhWegeWmVzDkKcOtJya5IVbA8IO3vA
         k8UaQcmQ+3kDab8C9NMHLO/A6Z9kRKQMqzWOnh8iiLho9kC/h8B0FJP3R/+VELM0FtUZ
         3uMJVbubN9Hcp7RaAEaPMuPx7LNBDX2WJg6SRbzfZWdgO4EFUg9Mc+h7vhryQF1InzkC
         5gAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d0whWseHxQspZUWpMNteiPZ9cq9DmnQxMjSfFcf9OVs=;
        fh=j+ugDgMUSSROHH/+h6LNvUshJ/meEK91hP0kVy/X2jk=;
        b=QsopzT7YH9hAuJCsNJ4XsYeWu8xmMxdr5uiEE6dIiSCuLTZCal2cX6hD/2rFWqZ8wx
         O8szASTBWXGPgUCnodMTCDTT9J+OCNyvQzFJdNt0Il5/nNJ3/0W0epCLC+RbwlN5bi8l
         4h5YrB5SENGK1mmV7ZKfiLpJDrQZAo8pUQZQsf51I2by2UDUwF6IG6VVA7B5WWPRQmL4
         DoGCqkGWRP/JPE27Vjsp5op4KmPIj7oYE7qiXcE5DFz/L87pDDLOU9jiWvJPiuYm8nxF
         +qixeS6qUYjV1jNCxPFegovT7spUwJDvtn7gBIVS8AZnH1SGksZTHEpASHj1nD+kwY1S
         LKhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785862855; x=1786467655; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d0whWseHxQspZUWpMNteiPZ9cq9DmnQxMjSfFcf9OVs=;
        b=SZHhjSu+914kO7qex0mPblU4m6opNNQ8SYzai3bSARLJLgxVPtp34YzgW7oNbu+Fuq
         4k48OU3THdvgN3jqv+jM8b9hg4IuP4x5ZijnVcsu409eI/9qvBshVlFF9iR0I16pcYE9
         8EkVEiEQ0LZ4BthS/SlV0K0QhtVk8no3npBUgkYyjDuhrbnahz6Q6mEKaxT+xuEvfw+O
         HGBFPVy/uByJ5rIO9oNE0+N946LUW2e2Kdacwu07ETwulGTTUCTxb1+jZ4znPHIPIpVC
         FB1jraJdPJh9m/LBOHcBHjtCTxZu8G794pvx/MD3enegq88zBZWC0w0rApfKO0ybDjfA
         3Bnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785862855; x=1786467655;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d0whWseHxQspZUWpMNteiPZ9cq9DmnQxMjSfFcf9OVs=;
        b=bJGCqO8mfg6vZ2DaugiJs3tSjQ53/HonFtTn1f8I6HUrGLSA8BL1/uChB/jIvUNFIA
         JQ9npcRPxFRiBut2n20QB+nbc9MJXdrFRbzx5oZ4fceiXLGuFHtIy+bu5emOzm9AK13D
         JiafBWN07ADLpyFqKDvMoLnnleUdJvZ0Vx0t6GkTPVpxLZSqcUQxLqoOlXqjO3+Y5T/g
         G+dHGnrgngPLNAtOY4bVUzzvtm5lUEClbz7Jhhnvuan6HhVkbT3NpJpACo+/kzTB3+1K
         qroqIyWwHJWfQxn4v+sKlD0yetRaTVBJLUAusL+rnEtj2v6PHbZmFqdRgG1TOhuLCbW9
         wMGw==
X-Gm-Message-State: AOJu0YyfGVr1aqHRkPaF3FxwtlbZHb5Cnw0pBvCkY8xA6j7HIKsH1xbw
	qU7a0X7r0qzK3xo6jBUI4KFIUOOSgNu3debgW0+I5EVYuEACGJixm1VCRHU/KMb0nr+oNAOiAz6
	JuY8K9siKWmOpqpz4PiJLkyKJdnFfOZPNvj0lUNAZ
X-Gm-Gg: AR+sD13kaP8YK+VDyGupbZ+OI9WJee1S90qny80fgO83j3zU5sdl1Vu/ncHz1InNofp
	v6ZezsVQfOhzBiSzuHH90R0vtKP5Lao0DQDojtB3vYkHZwzgimLNSmWMfywovE1lPMa8sUOlaHP
	sIChW2BWA/1K0dNCgngHyQvVMGWTD8iBJQfK6vE9krt6Bxvpp7aygfW/wD/4giQnVgxj6bQLuKC
	t7AS8sKW5iJ0zusbS6iFJcbsO7xBU7mh3eZvuodERmsLJDIw38Jlbb6A5QKEo87Aae1zlp1KLc1
	OFvdG9NjAsMt6sTCMZkfY17597oLddQPPGXgD0frdaT7
X-Received: by 2002:a05:6a21:3204:b0:3c3:834e:89b9 with SMTP id
 adf61e73a8af0-3cb85e7370emr306570637.17.1785862855065; Tue, 04 Aug 2026
 10:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804034204.3487077-1-libaokun@linux.alibaba.com>
In-Reply-To: <20260804034204.3487077-1-libaokun@linux.alibaba.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 4 Aug 2026 13:00:43 -0400
X-Gm-Features: AUfX_my2GHODSgWpz7u9PLF5sftBX1mO9fjStT4uqGF3r0dq7sFB5ilyjzEJ3cE
Message-ID: <CAHC9VhTWuX6D0yeBKr0bPbJ_mKUdiLYRtQpcwq-jJgovY_akDA@mail.gmail.com>
Subject: Re: [PATCH] fs: fix user path of nested backing files
To: Baokun Li <libaokun@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, amir73il@gmail.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, serge@hallyn.com, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 11:42=E2=80=AFPM Baokun Li <libaokun@linux.alibaba.c=
om> wrote:
>
> backing_file_open() derives the path to be stored in the new backing
> file from user_file->f_path.  This is incorrect when user_file itself
> is a backing file, which is the case for nested stacking filesystems,
> e.g. overlayfs mounts where the lowerdir of one overlayfs is the merged
> directory of another.  Since commit def3ae83da02 ("fs: store real path
> instead of fake path in backing file f_path") the f_path of a backing
> file holds the real path of the intermediate layer, not the path that
> the user opened.
>
> Commit 924577e4f6ca ("ovl: Fix nested backing file paths") fixed this
> for such configurations by passing file_user_path() from
> ovl_open_realfile().  However, commit 6af36aeb147a ("lsm: add
> backing_file LSM hooks") changed the first argument of
> backing_file_open() from the user path back to the user file and
> derived the path from user_file->f_path again, silently re-introducing
> the problem.
>
> As a result, files mapped through a nested overlayfs show the wrong
> path in /proc/<pid>/maps and in perf/ftrace mmap records.  For example,
> with two nested overlayfs mounts:
>
>   mkdir -p /ovl/{lower,upper,work,merged} /ovl/nested
>   echo hello > /ovl/lower/foo
>   mount -t overlay overlay \
>         -o lowerdir=3D/ovl/lower,upperdir=3D/ovl/upper,workdir=3D/ovl/wor=
k \
>         /ovl/merged
>   # at least two lowerdirs are needed when upperdir is nonexistent
>   mount -t overlay overlay \
>         -o lowerdir=3D/ovl/merged:/ovl/lower /ovl/nested
>
> mapping /ovl/nested/foo shows a disconnected path instead of the user
> path:
>
>   # readlink /proc/self/fd/3
>   /ovl/nested/foo
>   # grep foo /proc/self/maps
>   7f6e2c100000-7f6e2c101000 r--s 00000000 00:24 15813027 /foo
>
> The bogus path is derived from the f_path of the intermediate backing
> file, whose mount is a private clone that d_path() cannot resolve.
>
> Fix this by using file_user_path(), which returns the outermost
> user-visible path for backing files and falls back to
> &user_file->f_path for regular files.  This restores the behavior of
> commit 924577e4f6ca ("ovl: Fix nested backing file paths") for
> overlayfs and also fixes the same problem for the other
> backing_file_open() callers, fuse passthrough and erofs ishare, when
> their user file is itself a backing file.
>
> backing_tmpfile_open() has the same pattern but is not affected: it is
> only called by ovl_create_tmpfile() for the upper layer, and another
> overlayfs is rejected as upperdir by the DCACHE_OP_REAL check in
> ovl_mount_dir_check(), so its user_file can never be a backing file.
>
> Fixes: 6af36aeb147a ("lsm: add backing_file LSM hooks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>
> ---
>  fs/backing-file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

The selinux-testsuite runs clean with this patch applied.

Tested-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
