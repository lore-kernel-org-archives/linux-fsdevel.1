Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2132FFDCB
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 May 2026 20:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777925675; cv=pass; b=Oh1M7Wp63Rn9wEMpGbL7dXWia5R9GaSCQva3WfS8Xt14VXFGZh4Rzu/Fy4qnEFnGe6V2SWh11FVk3aLqTzb3zejPN5nlkyNVHeZyXSaq5BLDzwF/NAHmlU4Wf/s0jUDiHQAH5DenLqmq6ge6rKUsFnZGFa1tLs+Ve0HOB984Za0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777925675; c=relaxed/simple;
	bh=EUvJ9obLHOrc/VdLy0f/NpAYvu5fY/mSXWQhaybFraA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O4ZNTUHMxUAZJy8Q+CBDhg7yQhMIZ9yoBOe3jIqEmBSop18XnvOZUt8RB1IrHfHCPjeFcBZuIorCg57jm3jCfevzNKvvFma+CgcQveaZ7+vtCB3OXb/BjoXI0NmCCe/gruJmvb1h8cuVPNXIsH6QNaPvPO9UfoI08o3Z9tUCb1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KOuuH2po; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KOuuH2po"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c70e27e2b74so1437355a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 May 2026 13:14:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777925672; cv=none;
        d=google.com; s=arc-20240605;
        b=etaKk6jTcgbjyZKdX6PfGLwaikaw46xhqHvp4hEtPzossGCkeRYdJrNRei9egcGLHn
         F+djhQxohA6Q9sk7nOfxWp0R7mgtijv1NeyzxkKjd1ERBrBQhdlo+wTQMok9TX/ZaVKZ
         M/toX4f8CJV6d54Dzz5LbNoGsx7BoBAm6MpS2HUivVgiaPQvM0SZloK9nDuKAKmGDyDn
         ANyxF/6EmPVhASvaOTuAVMVX7gG3cufTru6hreNlyslcuXZxJONq2vCDCfeYi5IbA3Mg
         GW4KFkF/p20fpAqjqfV2SXPDDksJS94hYUyN+lHly6K6GPdPo0+UUzc3xQvObFRyruM2
         MxWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q3hSbRXPUjpKlP0OUaWzuKOPeS3ICzNcvwmTq3T3NAQ=;
        fh=jyDDtdDzWmfiseIXl711eAC5bWX5sFWpGQ5YOPhhq3M=;
        b=dXKcxbqovOjhv49hUYDtRAIlR0QFVh0dLKBa5DGKQsfi2GUqAeMFsHC322XJCZ4g1/
         m3XcgVzhH6xhx4SynOreXXbrFGA6Xwb8YWrMiL786gcPPNeJHl3HG98St25+pb3nHEMK
         TTbypSQ8vidS7V3GhFJgVWIbvpciPOdH1da6n7gsNyRugPcrssSfdkbLCARyXmpobYWL
         tZ9dM+wfy5OKNcUE+xiUI92Xsd4RB+hLj8yW1EFD/Rgnfejqh26MggU8m/2VyQKQ+cWt
         7G1vHe1zfkMMNFJIWMNkPtP4jH1vJ+gKgZQn8uRY56W5fwE9+1eywoiyexOVb846s91f
         AGtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777925672; x=1778530472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3hSbRXPUjpKlP0OUaWzuKOPeS3ICzNcvwmTq3T3NAQ=;
        b=KOuuH2poO+/mmqRSZdvJkGzQgZ4HEYgOqNOXOfB2tmtrstfeZzRZ7zmRqdPCNHWbub
         0oSKqnp04NjD4y216VGzVroXJZ9OZr+wUDoy8MnEsEEnwspjuc6fkU6om3HP9snYTBdr
         nKovV9bYdKltJYulkFGG/smrvEMkHdFjH8y+VnO+UvBRHUrascI3l0OlKiDY+d2yp93/
         o2P7JHJatW0szduBib9UcA/VIhZpk1vuZShmriCvJ4fvCbdx9QVg9bqZRkj20U1R9e92
         BUH9zLrvg+2ot+3w0iXJVIn9hrJjUz7xPqcOI47Yl+DGMuGNW5+h8cj2c3u+SSHP7+A5
         ewaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777925672; x=1778530472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q3hSbRXPUjpKlP0OUaWzuKOPeS3ICzNcvwmTq3T3NAQ=;
        b=dHqLAKaYJv+5xO1EA6lV2Y0aFg2w4dv6tVQNGMqAAlvMyEa1R25Rd0klGmkfkm1R02
         pmON2BKp4SaFYHowqekD6y+d3yjfVhwUOoBp+DgIQ412IVT7aimtjJkBHBfLSAGzKFe5
         cSuL+tXW53ZQkagS+/JlGDp99KjG0rFDcbjsoyK7+V5pJuaE4se+589ZR9cLeP2OtnJ+
         G4DupGKEIu4miE18tC6I31LNzVj4BVTWQZoexkX2u1z2J1c44JRCNxnnS5b+FgfJ/82S
         7xnUiYPrnIDHESL0lX0LoEIfp8BxA0PyZ/hFiWRUQVgUHLu9HWErmr6Jb3NMDHRrC7Gx
         rHHQ==
X-Forwarded-Encrypted: i=1; AFNElJ/LE001oxIQz8cjpo4WX6F9DIOxo+VaWpfJKxTJnDeQ+LZ2lw43cvCrvNRtSdvoKx95FYntpF3zQL8gieSw@vger.kernel.org
X-Gm-Message-State: AOJu0YyGl61VdVAFdsHkOE+EaswOPNmJR+B5aiquugOmNuwcN+pr6f0U
	Y8VyCcIq4YXYuRZccT3+EXTJO4woxanoUuCCqf6Sj3cOiQAJVAws4QepzzPvN6JVdajMrG6AbpN
	czQESWoSybjz/O4kkoswdJM/5JmogZerTpe4f7NPM
X-Gm-Gg: AeBDies6bXosyjUtr4jMu3nFPMxcDLNPELM8rRgZRdlRD+0z7UvDPoJb2JcxH0KRja5
	Aqu4XIIC8ZHy8qzPszS82JsWy07fDFmF8BzhvxSV9oM12G4Z5ctOQbpmmiJtBoSbro5taOP0hNP
	TgnvO44dtg5M1J3ihkm9Y9rYHbvqTCOETUah7K+W+xg8DyLM8eud1Q7SkU2f2XSYkzBLz9oB3oo
	x3oE318+/Ogq+mrJvRcmFPsKGZVAlGR1hk6vjPkpZYBN+2q6MJEqhwhNowGdn76JgqiUCLjJABI
	poNYp3DrDFoHjYMflA==
X-Received: by 2002:a05:6a20:4324:b0:39b:f12e:d53 with SMTP id
 adf61e73a8af0-3a7f1a9cc09mr11311079637.18.1777925671622; Mon, 04 May 2026
 13:14:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503211835.16103-1-dwindsor@gmail.com> <20260503211835.16103-2-dwindsor@gmail.com>
In-Reply-To: <20260503211835.16103-2-dwindsor@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 4 May 2026 16:14:19 -0400
X-Gm-Features: AVHnY4JwbbxWaxO92zQ0YDwE9Y67k5IjHq4HKHTHEoo89ilJEakV5ErxNF9_k_c
Message-ID: <CAHC9VhSy5K5nQTtFUE4BScy1Ur61v7eZW067vTcUYDQeJb13Bw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: David Windsor <dwindsor@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Song Liu <song@kernel.org>, Jan Kara <jack@suse.cz>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 3, 2026 at 5:18=E2=80=AFPM David Windsor <dwindsor@gmail.com> w=
rote:
>
> Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically set
> xattrs via the inode_init_security hook using lsm_get_xattr_slot().
>
> The inode_init_security hook previously took the xattr array and count
> as two separate output parameters (struct xattr *xattrs, int
> *xattr_count), which BPF programs cannot write to. Pass the xattr state
> as a single context object (struct lsm_xattr_ctx) instead, and have
> bpf_init_inode_xattr() take that context directly. Update the existing
> in-tree callers of inode_init_security to take and forward the new
> lsm_xattr_ctx.
>
> Because we rely on the hook-specific ctx layout, the kfunc is
> restricted to lsm/inode_init_security. Restrict the xattr names that
> may be set via this kfunc to the bpf.* namespace.
>
> Suggested-by: Song Liu <song@kernel.org>
> Signed-off-by: David Windsor <dwindsor@gmail.com>
> ---
>  fs/bpf_fs_kfuncs.c                | 106 +++++++++++++++++++++++++++++-
>  include/linux/bpf_lsm.h           |   3 +
>  include/linux/evm.h               |   9 +--
>  include/linux/lsm_hook_defs.h     |   4 +-
>  include/linux/lsm_hooks.h         |  16 ++---
>  include/linux/security.h          |   5 ++
>  kernel/bpf/bpf_lsm.c              |   1 +
>  security/bpf/hooks.c              |   1 +
>  security/integrity/evm/evm_main.c |   8 ++-
>  security/security.c               |   7 +-
>  security/selinux/hooks.c          |   4 +-
>  security/smack/smack_lsm.c        |  13 ++--
>  12 files changed, 147 insertions(+), 30 deletions(-)

Comments below ...

> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 9d27be058494..193accc00796 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -10,6 +10,7 @@
>  #include <linux/fsnotify.h>
>  #include <linux/file.h>
>  #include <linux/kernfs.h>
> +#include <linux/lsm_hooks.h>
>  #include <linux/mm.h>
>  #include <linux/xattr.h>
>
> @@ -353,6 +354,97 @@ __bpf_kfunc int bpf_cgroup_read_xattr(struct cgroup =
*cgroup, const char *name__s
>  }
>  #endif /* CONFIG_CGROUPS */
>
> +static int bpf_xattrs_used(const struct lsm_xattr_ctx *ctx)
> +{
> +       const size_t prefix_len =3D sizeof(XATTR_BPF_LSM_SUFFIX) - 1;
> +       int i, n =3D 0;
> +
> +       for (i =3D 0; i < *ctx->xattr_count; i++) {
> +               const char *name =3D ctx->xattrs[i].name;
> +
> +               if (name && !strncmp(name, XATTR_BPF_LSM_SUFFIX, prefix_l=
en))
> +                       n++;
> +       }
> +       return n;
> +}
> +
> +static int __bpf_init_inode_xattr(struct lsm_xattr_ctx *xattr_ctx,
> +                                 const char *name__str,
> +                                 const struct bpf_dynptr *value_p)
> +{
> +       struct bpf_dynptr_kern *value_ptr =3D (struct bpf_dynptr_kern *)v=
alue_p;
> +       size_t name_len;
> +       void *xattr_value;
> +       struct xattr *xattr;
> +       struct xattr *xattrs;
> +       int *xattr_count;
> +       const void *value;
> +       u32 value_len;
> +
> +       if (!xattr_ctx || !name__str)
> +               return -EINVAL;
> +
> +       xattrs =3D xattr_ctx->xattrs;
> +       xattr_count =3D xattr_ctx->xattr_count;
> +       if (!xattrs || !xattr_count)
> +               return -EINVAL;
> +       if (bpf_xattrs_used(xattr_ctx) >=3D BPF_LSM_INODE_INIT_XATTRS)
> +               return -ENOSPC;
> +
> +       name_len =3D strlen(name__str);
> +       if (name_len =3D=3D 0 || name_len > XATTR_NAME_MAX)
> +               return -EINVAL;
> +       if (strncmp(name__str, XATTR_BPF_LSM_SUFFIX,
> +                   sizeof(XATTR_BPF_LSM_SUFFIX) - 1))
> +               return -EPERM;
> +
> +       value_len =3D __bpf_dynptr_size(value_ptr);
> +       if (value_len =3D=3D 0 || value_len > XATTR_SIZE_MAX)
> +               return -EINVAL;
> +
> +       value =3D __bpf_dynptr_data(value_ptr, value_len);
> +       if (!value)
> +               return -EINVAL;
> +
> +       /* Combine xattr value + name into one allocation. */
> +       xattr_value =3D kmalloc(value_len + name_len + 1, GFP_KERNEL);
> +       if (!xattr_value)
> +               return -ENOMEM;
> +
> +       memcpy(xattr_value, value, value_len);
> +       memcpy(xattr_value + value_len, name__str, name_len);
> +       ((char *)xattr_value)[value_len + name_len] =3D '\0';
> +
> +       xattr =3D lsm_get_xattr_slot(xattr_ctx);
> +       if (!xattr) {
> +               kfree(xattr_value);
> +               return -ENOSPC;
> +       }
> +
> +       xattr->value =3D xattr_value;
> +       xattr->name =3D (const char *)xattr_value + value_len;
> +       xattr->value_len =3D value_len;
> +
> +       return 0;
> +}
> +
> +/**
> + * bpf_init_inode_xattr - set an xattr on a new inode from inode_init_se=
curity
> + * @xattr_ctx: inode_init_security xattr state from the hook context
> + * @name__str: xattr name (e.g., "bpf.file_label")
> + * @value_p: dynptr containing the xattr value
> + *
> + * Only callable from lsm/inode_init_security programs.
> + *
> + * Return: 0 on success, negative error on failure.
> + */
> +__bpf_kfunc int bpf_init_inode_xattr(struct lsm_xattr_ctx *xattr_ctx,
> +                                    const char *name__str,
> +                                    const struct bpf_dynptr *value_p)
> +{
> +       return __bpf_init_inode_xattr(xattr_ctx, name__str, value_p);
> +}
> +
>  __bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
> @@ -363,13 +455,25 @@ BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPAB=
LE)
>  BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_init_inode_xattr, KF_SLEEPABLE)
>  BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
>
> +BTF_ID_LIST(bpf_lsm_inode_init_security_btf_ids)
> +BTF_ID(func, bpf_lsm_inode_init_security)
> +
> +BTF_ID_LIST(bpf_init_inode_xattr_btf_ids)
> +BTF_ID(func, bpf_init_inode_xattr)
> +
>  static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_i=
d)
>  {
>         if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
> -           prog->type =3D=3D BPF_PROG_TYPE_LSM)
> +           prog->type =3D=3D BPF_PROG_TYPE_LSM) {
> +               /* bpf_init_inode_xattr only attaches to inode_init_secur=
ity. */
> +               if (kfunc_id =3D=3D bpf_init_inode_xattr_btf_ids[0] &&
> +                   prog->aux->attach_btf_id !=3D bpf_lsm_inode_init_secu=
rity_btf_ids[0])
> +                       return -EACCES;
>                 return 0;
> +       }
>         return -EACCES;
>  }

Perhaps I'm simply not seeing it, but is there a check to ensure that
there is only one BPF LSM calling into security_inode_init_security()
at any given time?  With the BPF LSM only reserving a single xattr
slot, multiple loaded BPF LSM programs providing
security_inode_init_security() callbacks will be a problem.

> diff --git a/include/linux/security.h b/include/linux/security.h
> index 41d7367cf403..a2fc72e63ada 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -68,6 +68,11 @@ struct watch;
>  struct watch_notification;
>  struct lsm_ctx;
>
> +struct lsm_xattr_ctx {
> +       struct xattr *xattrs;
> +       int *xattr_count;
> +};

I'd prefer this to be simply "struct lsm_xattrs" as "ctx" is an
overloaded term in the LSM space.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 97801966bf32..dca81a22bf83 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2962,11 +2962,11 @@ static int selinux_dentry_create_files_as(struct =
dentry *dentry, int mode,
>
>  static int selinux_inode_init_security(struct inode *inode, struct inode=
 *dir,
>                                        const struct qstr *qstr,
> -                                      struct xattr *xattrs, int *xattr_c=
ount)
> +                                      struct lsm_xattr_ctx *xattr_ctx)
>  {
>         const struct cred_security_struct *crsec =3D selinux_cred(current=
_cred());
>         struct superblock_security_struct *sbsec;
> -       struct xattr *xattr =3D lsm_get_xattr_slot(xattrs, xattr_count);
> +       struct xattr *xattr =3D lsm_get_xattr_slot(xattr_ctx);
>         u32 newsid, clen;
>         u16 newsclass;
>         int rc;

In case you didn't see it, your fix for the above lsm_get_xattr_slot()
usage is now in Linus' tree.  It's a trivial bit of merge fuzz, but
you might want to rebase your next revision.

--=20
paul-moore.com
