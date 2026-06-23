Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F70C8EB
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 21:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782250297; cv=none; b=DZFHFYQqBeBAOOmk9hDlqS+khj8qxq7dpSqFoO/PHHfmYu59/mtRR1EAR5Iw5CrIS877yzV3+AhuftDtj7zZcXz+NqIM/b545/EORhVJ0B44elV8Wfh5GxL4/AI3+bXXALLQJkGRp+tY/yBug7a26alO9QmeyOz/o2TjidFqaGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782250297; c=relaxed/simple;
	bh=0ANTKXSFW/fZWU4QCXe+CkXZkYewYK5/ubk2dOFWLzM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=O/S3ufUrFNsFe0n1wGwZlPdkgPAG0SL21/SJ2TG0IjvHom+9TGeoMDapkxuWYKbOuVGqK+iyUg4ihkPuRd5kViFSXUTpYXTOh7UQ1s7cRh06NRd3+yfEFMt4FyaNRE8L8Lw+sebZTlTM3PxyS5NiA+u2ZaDW9Ep5fuelJFTXdpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=LRu+spQi; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="LRu+spQi"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-13986d61b4eso540620c88.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 14:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782250296; x=1782855096; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUP7w+eH6fgvtXB7JUmSeEA4Y7fDi9ONBSL+3HNE0xA=;
        b=LRu+spQiQlCKjapBDCH/q9E+g+ouG0zIn107PC1X9voBjykgyfkUM585GQgKX1GsxY
         w8wrY4LU52mh83UJv43cCUoDqmjjZahhvQBC0TNkQ1WPupLq5Z69UzexKV8HUYOwxQg+
         ydQ5i7V2mRDV0lzNguNgo2QqdYnqEtgjMhOUZCTbOgT4OoiX43jPBzY1Fmwv1DdPrJnF
         kVv0jvgkq0ZMbBvLXVkrX8b7aSSpWr7da6i/Skkl50/CzR98vlxcpZ7T7KKWxPbaopm+
         GTNfznSWVG63h5MubChbddJy448AcSfd3Fumn35MgGXXJQ64hwp1NwcalLHiofjUyVMl
         ZN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782250296; x=1782855096;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SUP7w+eH6fgvtXB7JUmSeEA4Y7fDi9ONBSL+3HNE0xA=;
        b=SR+TigMpRXlUOcSDjDQhK93bDbUxkW5vtQBUAxfb8HR9zVmXYKiagRODVsmP5bUGkb
         xVpv94wvv4rXtDxjm/n2cidKdgBKnhy3uMiOh27JkKH/Jm7Q+bhU/kaO2YS0h9uewsMs
         9/HE5GvyEq8Ovt3KTRC1uUUvTm2ZDQprMvdRre91APOLaypqXqg/YmP9ocwP+ZtLvgmx
         NCZEcH4rOYe8zXjw5lNlypQTM3BE4FKfXLTY2j7c/CDqbvqHq+Tj9Oflx7vufifvx+IL
         /ur2enLx07lmIOUsktwgsdagLAROKxHrGt+xfYzxzXAQesdU5tQBZ1eWBkzFBXrqCrHQ
         olHw==
X-Forwarded-Encrypted: i=1; AHgh+RqCLWnHD84zNe5IybS3OAK5WbPmUxr8GO38jRtlEv8VRWiipicZDanTDMnV5GYVlzgwmv6911/1OnSAD78Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1HC1otARGzhTLWoTWTekPN28OjUtJuLlPI63MTU5EVZj7S8tD
	6CXHXdVIFJOzQQUd2p9Lvr55UBsXNofUqxeRgf3ztmTIWZ3mo+DglexjKd2YzM68HZU=
X-Gm-Gg: AfdE7cmBDekFfwTGNUI8L9kK1m+jHs8GddpHQnS94cjeplKSnSGK8kC4DKA5tof8bvw
	PK6YC0DKVOY4ibKhKh76qAIkoz+PDzZmjx2yfC6XBIv7xz+myMOIN5gmMSn6st+FuV6d2LDfBGK
	CiztdNdl1rE0+9geK/nTLNKnilWKookPTMAagX+gTfjh2CwEoWEUL57pVNCzuuQLWYnWb0c3RsD
	a1qv8i1dQL7vlC0eHq9zfcqiS212GZqqMqLMM21WKr5kQoWA19GzhBE68dRVmMdS/Ehh+whnKHd
	CKg6dxDCEGEBt0FvrNXRz6cSTsSR4V8TBBvwzI/iFvrduRZk3RyDJ7EriaIy6yyd6jsnPdFYROA
	MHWd56RXwj9ChJTilmxLDVLUg5Snyg/omPrY84I6HiVbHjBxgdGuwEG6N35gLst2tm/wK2w==
X-Received: by 2002:a05:7300:a494:b0:30c:56a0:ce3f with SMTP id 5a478bee46e88-30c56a0d1c5mr4096393eec.2.1782250295582;
        Tue, 23 Jun 2026 14:31:35 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::2526])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1ba1c32csm20670452eec.6.2026.06.23.14.31.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 14:31:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jun 2026 17:31:33 -0400
Message-Id: <DJGR01P329CF.F5YUUY35XRL3@etsalapatis.com>
To: "Christian Brauner" <brauner@kernel.org>, <bpf@vger.kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 "Amir Goldstein" <amir73il@gmail.com>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] bpf: have bpf_real_data_inode() take a struct file
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260623-work-bpf-real_inode-v2-1-8e8b57dd25f7@kernel.org>
In-Reply-To: <20260623-work-bpf-real_inode-v2-1-8e8b57dd25f7@kernel.org>

On Tue Jun 23, 2026 at 5:32 AM EDT, Christian Brauner wrote:
> bpf_real_data_inode() must be usable from the bprm_check_security,
> mmap_file and file_mprotect hooks for systemd's RestrictFilesystemAccess
> BPF LSM program, so have it take a struct file instead of a dentry.
>
> Amir Goldstein <amir73il@gmail.com> suggests:
>
>   While doing so, rename it from bpf_real_inode() to
>   bpf_real_data_inode(). For a regular file on a union/overlay
>   filesystem it resolves to the underlying inode that hosts the data,
>   but for a non-regular file it returns the overlay inode. The new name
>   makes the "inode hosting the data" intent explicit and avoids the
>   ambiguity of "the real inode backing a file". Document the
>   non-regular-file behavior in the kfunc too.
>
> Both the signature change and the rename are safe because the kfunc
> landed this cycle and has no released users.
>
> Fixes: 9af8c8a54f6e ("bpf: add bpf_real_inode() kfunc")
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
> Changes in v2:
> - Rename bpf_real_inode() -> bpf_real_data_inode() (Amir); the new name
>   makes the "inode hosting the data" intent explicit.
> - Document that the kfunc returns the overlay inode for non-regular files=
.
> - Link to v1: https://patch.msgid.link/20260622-work-bpf-real_inode-v1-1-=
4014eb4cbefd@kernel.org
> ---
>  fs/bpf_fs_kfuncs.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 768aca2dc0f0..f1863a891db6 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -360,18 +360,23 @@ __bpf_kfunc int bpf_cgroup_read_xattr(struct cgroup=
 *cgroup, const char *name__s
>  #endif /* CONFIG_CGROUPS */
> =20
>  /**
> - * bpf_real_inode - get the real inode backing a dentry
> - * @dentry: dentry to resolve
> + * bpf_real_data_inode - get the real inode hosting a file's data
> + * @file: file to resolve
>   *
> - * If the dentry is on a union/overlay filesystem, return the underlying=
, real
> - * inode that hosts the data.  Otherwise return the inode attached to th=
e
> - * dentry itself.
> + * Resolve @file to the inode that hosts its data. For a regular file on=
 a
> + * union/overlay filesystem this is the underlying (upper or lower) inod=
e that
> + * stores the data, not the overlay inode.
>   *
> - * Return: The real inode backing the dentry, or NULL for a negative den=
try.
> + * Data resolution only applies to regular files. For a non-regular file=
 (e.g.
> + * a device node, fifo or socket) on a union/overlay filesystem the over=
lay
> + * inode itself is returned; for any file on a non-union filesystem the =
inode
> + * attached to @file is returned.
> + *
> + * Return: The inode hosting @file's data, or NULL.
>   */
> -__bpf_kfunc struct inode *bpf_real_inode(struct dentry *dentry)
> +__bpf_kfunc struct inode *bpf_real_data_inode(struct file *file)
>  {
> -	return d_real_inode(dentry);
> +	return d_real_inode(file_dentry(file));
>  }
> =20
>  __bpf_kfunc_end_defs();
> @@ -384,7 +389,7 @@ BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE=
)
>  BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE)
> -BTF_ID_FLAGS(func, bpf_real_inode, KF_SLEEPABLE | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_real_data_inode, KF_SLEEPABLE | KF_RET_NULL)
>  BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
> =20
>  static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_i=
d)
>
> ---
> base-commit: 5b33fc6492a7b7a62359157db0f92f5b6e9af690
> change-id: 20260622-work-bpf-real_inode-c3202dbaf0ab

