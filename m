Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61883A7852
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 17:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774544582; cv=pass; b=qQv4sBlsZldzdx1mQTmLIEnwrslBHlQXYxXjjeabb7P/ryr8IRRie3qfMVIn2IlFRdPKztDEwCy5qGX0kf6cfcKJCeA6idYXvzTJSWFN9LgXK7fMw//0xv7g0txyC8GRmhDQmFB/YcPJ2QF9Vk5xXkaxpwBRUGzTrZ9xE6KXde8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774544582; c=relaxed/simple;
	bh=LE4SX80+/pcvjw5cGh11DHDijHyZaE+JSHrRUibRHlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUXRqtvhTrC0AZE8SkX0MkODAO+oAsajwW7CgC2Axrx/Qob/3jEVrC9XgMAm05sR9Y09eNptVhUe1m6GSu84irHKmem1xW6lsEDReqkr5IBleDvfwEkNJpiFoZ2xgi1mrJclL3je1wAyqsXzS9gokTjPuzZzmCJvA0L4u3VnIP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7+dQ8lt; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7+dQ8lt"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b932fe2e1a7so151774766b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 10:03:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774544579; cv=none;
        d=google.com; s=arc-20240605;
        b=MtQf78cYDmhnFcS9E66I1UJUgmKuUSOEVPxMK4Ky3CmKXdJxvfO3rxw+DqiIuZHpHa
         WDM9k6F6uKUO/Hs8fv8bdzt8MTtjr58c2YpgSbvgxU1O16nRz2EAaft9KBjC8ox+vhwV
         hk4yBRB/DBWzITr/AWf4bWxHne7JdfbfIjmmeL2upM2JSJWMfiWM/I6DdF3u5enZTxz0
         sKkoK3fUXUuduffvtyI/3SWr0Eus1kcnWD8r8iKFUlqj8oPo19i5DeLWROqKlZ+yXwtH
         4LyPDQH1HK4/arIkPkOW5m1MD4eFePrM1vsO6HRLi3Clc61xduixiqvkpZpOFBry+QIL
         nkjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sYBPgojaaKvYmQKhiDRzrsGmLAPEawLtY8ezJ39nqQ4=;
        fh=2LTGdgXN/z4EYYwrbz9n2WHYLfTef4zziFec62dx3nI=;
        b=YuPXS0DWJh+5DZ96ib1X4fPyPlG3CElu7vx+3dio6U7SLzYnM7naXOaZRlYt3ZCbe8
         GGfbt//KR4MnDRUZRP85qcu5D2VST82b1oP0xMP2nnECn1PdGqgQtQuGJ0wy3Djn08rY
         7vL0f+E5vdmZYT9pWJuExxOOEoZhoBMgcFaAwTu/bfmY5c1XKP1NlXN/d79HvV6HD5Xh
         MRhpL4j1qGHXxlPWDqN5OZ0A55SbiPpJqxSzoBsEZcs0CA80XQPS/ojuwtY3lWUumNg5
         v9dqtWOjE8TXrTzq7Yqz1N1bLAz0emrve9Ji6wS8fY+qjXMKC2qxafI4Mi2Wc6trZv2O
         CqVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774544579; x=1775149379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYBPgojaaKvYmQKhiDRzrsGmLAPEawLtY8ezJ39nqQ4=;
        b=V7+dQ8ltT74D0QeEn/KX5d2N7Qi3jTGt2sYQ/BJTorW4WGieaLfprSDGIiE5KeluBw
         6+BjnmFMKSR2m+bCY88DEYRdJREA2+lbxqzHW2TovDAC9CRCtnc18fw2ks9+Ou0kQaes
         VUUPLZzak9EINwUyrpKDTR0ygx9h6aBoB+yMNF9AhJ2wOo+vEvi2Nh7bWgkZLgpBk8hn
         EsoawHsBbBns9WvJrKkL51bs2qbWLQEnnQwP9AdAh6i8na5S0Uje1aFcu/S26Gau/bFG
         r9XWY2Z8t4Bcc/K20uwcTlSqLULzqokJt66DcNpMnripRZWNH1EEd8hKHxbY3lV0wkH8
         lKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774544579; x=1775149379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sYBPgojaaKvYmQKhiDRzrsGmLAPEawLtY8ezJ39nqQ4=;
        b=lWjyh0StmOqUsIu0Cjp7okv3QDIsfkN4a9ZaJgsCV8Qf17yPlB/37/aq+HXQTtIbTx
         bKZF0ELnipyNOydEHIn4yd1q6jMdjsVS+nptQ4wHpbIRl4mI9KqmBRmERw9X4+7ghOTf
         uintQH3O2eFkUbumSPI1/IMYZoFQu71OhgCzKkhL8BHTWo/8wSnRJMBgzrFAnVdU+7h1
         ChbiRljC+XFri/wkdimL6+7Pmc/cbj6Y62uy0lv5rYpt4DTF7s7xdWPewAY9n+bWP0ql
         xSq6/3Kj+Cp3dAUPBaN1Api3zfF2+o0NQ90wP/nDTiscy7nC0WUmk0wEBSV3RVCPA12k
         3IgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKLhG6ctYjfbolIxthQMPzFMCMbx3UG/s0b6wMCEd8vv6Ze7n8JdyB0yAKdL0JnpNpcxnK62Dc9c7YYLlE@vger.kernel.org
X-Gm-Message-State: AOJu0YwDJNnpUxfmLd6aBYUZzhvIA+f5poKQbV0Pqb1YhxOxJsZj/o6W
	Hp8C+SrB9iM3+yFdyjbyVKLRfWUhaRnsY15AIpREfCdAzKVnM6au8pLTe6oex/uMcrWK9sHSyQ1
	rqglw+hDmzlQS3C7oZWOJXNuc145vrNY=
X-Gm-Gg: ATEYQzxBKAjbqHKv8w5TTWnjIbxNytNQep948FVgGlo34SCierpkgT4PZi0vFYBc97v
	FwdR/UKT2xZWsZ8QLnx7XbUv+HKCP1pruiZLj/vkI8/0gjC6AqhXSOAQOCt6LDKevWFR0U9aK0u
	IoCVWwIy8/3O4K1cw8aPNv1ZPRxvtHhe73CC2atGJvzdqTAq0LBIOFNPgGq5CM7jdoZ+2PCbQX4
	n4M5Tpm3/OIkbLdKxTnVPPQ0P9vztVv7MVDn9n3RU9QkLZCVvjMpNVnRFAYg943pFWgll5U+YzW
	izD7GkWKbnalO21rX92e+S8qK8WC2YQADGNTqWWcFA==
X-Received: by 2002:a17:906:134d:b0:b97:9099:7b3 with SMTP id
 a640c23a62f3a-b9a5429fdadmr403096266b.44.1774544578621; Thu, 26 Mar 2026
 10:02:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326-work-bpf-verity-v1-1-efe9edc46ddc@kernel.org>
In-Reply-To: <20260326-work-bpf-verity-v1-1-efe9edc46ddc@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 26 Mar 2026 18:02:47 +0100
X-Gm-Features: AQROBzCxQ7LTWEHJc61oO6lXBkCBYyHWnkzwlNxMnle4MieOI_dPRQ2jeYsmgHk
Message-ID: <CAOQ4uxgQgv7W=92kR017PG-AZSLKsUoYjnZoVHCoQwXRitgMuw@mail.gmail.com>
Subject: Re: [PATCH] bpf: add bpf_real_inode() kfunc
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, linux-fsdevel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 5:53=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Add a sleepable BPF kfunc that resolves the real inode backing a dentry
> via d_real_inode(). On overlay/union filesystems the inode attached to
> the dentry is the overlay inode which does not carry the underlying
> device information. d_real_inode() resolves through the overlay and
> returns the inode from the lower, real filesystem.
>
> This is needed by the dm-verity based execution policy implemented in
> systemd [1] where BPF LSM hooks must resolve a file's backing block
> device via inode->i_sb->s_dev. Without looking through overlayfs the
> device lookup would return the overlay's anonymous device number instead
> of the actual dm-verity block device, causing all overlayfs-hosted
> binaries to be incorrectly denied.
>
> Link: https://github.com/systemd/systemd/pull/41340 [1]
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Acked-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/bpf_fs_kfuncs.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index e4e51a1d0de2..fc30aa906b8c 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -353,6 +353,21 @@ __bpf_kfunc int bpf_cgroup_read_xattr(struct cgroup =
*cgroup, const char *name__s
>  }
>  #endif /* CONFIG_CGROUPS */
>
> +/**
> + * bpf_real_inode - get the real inode backing a dentry
> + * @dentry: dentry to resolve
> + *
> + * If the dentry is on a union/overlay filesystem, return the underlying=
, real
> + * inode that hosts the data.  Otherwise return the inode attached to th=
e
> + * dentry itself.
> + *
> + * Return: The real inode backing the dentry.
> + */
> +__bpf_kfunc struct inode *bpf_real_inode(struct dentry *dentry)
> +{
> +       return d_real_inode(dentry);
> +}
> +
>  __bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
> @@ -363,6 +378,7 @@ BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE=
)
>  BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_real_inode, KF_SLEEPABLE)
>  BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
>
>  static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_i=
d)
>
> ---
> base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
> change-id: 20260326-work-bpf-verity-a43f28baa242
>
