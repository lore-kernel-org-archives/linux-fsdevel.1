Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FC533A702
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 19:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782847253; cv=pass; b=Z7REpxBIoAyCZ+rgQs4v8NYsclixJapDnRiyKM6JIRVCI0Qu3F49wrRrYwq3SqOjSNZqfyEIRv3PcOJm1q2l7oZGK/1QRHc5MH0dAz/d29DxUnIc22ODhU7v0fKN+cY96TrZiEygpdT9XIOpQCIwSeg7lwMmYShDfAiLL42tPps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782847253; c=relaxed/simple;
	bh=65J+i3G6p5lcoZBTC4phByocAAxY190VmOFW7omB01o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e1siwer2mFUgMYN86RtACed3MkrtsD2C9xEwKmzhcqtkbq38OZtOs+FrhK6J+lba1EOB7xGDUB4nHNR4qPqYQIGntE2kHK4MsV+tPDDWK58pEMBttEqh97vYzU9PBlTJLbGQ84AamHK1Ko6ifslrjM5dJOneXsj58yVBAdJ23M4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=X5MxhvYP; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="X5MxhvYP"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-37e0fb87b75so3996761a91.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 12:20:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782847250; cv=none;
        d=google.com; s=arc-20260327;
        b=jZ1zLdd9McUiSONH4NqUnt3vb/oeSSqIiPxFFS1kb2S/Z6Kl8cbFlX/aNMtVZxBXe3
         uuNr7JEzgnj0la2eV/6QT8grA9YKHrfCUqQ9iwdGAtTX/K5Nu7XluxUC/ohmW9G8A2qH
         pf6QL3Ep4+nBT2Q/AoJAFvWrn4VN+NONbdB2fYDc/ltKpb14lDOSD2myiRnc01I1l2F/
         7TrqHV02GoJq3wZzcGXEch4HJ9MMro81FxJgCFXd3jJuAN1FwGzv5SN8KaBWT7MBn1sZ
         wdze0LD4Rl2Az46PPr2vba0rhSizdoF+nJedN+BtqCya86v30adUbEKwXjMbvxafZMru
         /0gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HnheX6+q3F7lhzv+8WY9jgB+q1sOgaN80kpX4FHTGh8=;
        fh=j95E5YVA3XX0hLoLucPmXhxmjzY/dE6YumngqIeMrV0=;
        b=Z4jJE12CteHVvxeef6LvL8Lj7AjoGnAKkf1l+vlNmKehNNZEIwFJKtyxa7WZX2UfV5
         Ahtc1TWnH8WS+udc7JRpQvoAOUhR0TXUzy9x8fZeHTXNksWDk7/VUSjUp9+lgUPnBpnn
         5+1XdyqVdypVGKK2sATxP0HyNvq+1h95cRGIZMC9CHhfxSHNn8p9nk2JXToxTp4P/TB/
         CjD5sUNn7VYaRnEzDBHEL9WtMCF22zpugCk2+VbwioD5ixrZb2O9vwzmjga4zhR18HQE
         LHO/7IYXXXIE+2bcGOY6yjhgHur2LI7lBJMfCu+rnHah2uBctIiLSfmgrEWdh2YIWn35
         8+xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782847250; x=1783452050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnheX6+q3F7lhzv+8WY9jgB+q1sOgaN80kpX4FHTGh8=;
        b=X5MxhvYPRN3WA2wN8tL/ZYk9NZEiQbt3zp7jjJgltzxvrPhMcgDbMg5S+ghGO6JFrV
         O1yiHUL8HLKhu//+JGJnCXi8eneIZaFMBhsfmu5xEyywT94F+72Bu6ykex5UZwL8hC7Y
         x9DHn2EONIrEHKr+zJRocw3ZO6DRVypGamAqAhU47sT6463F2xW51r6rTRektZ8qZs58
         e7c7/MJZFGQ2SLMW7XGcoPsGAHxHtixGOMzTpbI6bkqY+TSgjJ8aoDaBdqw5170xOh/K
         C7n1uxfzAR1/ftJDft78tixUKOMmdPxBEu5FgTwR1H8tgsPowu45eEy5Gat235dRyPTg
         EeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782847250; x=1783452050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HnheX6+q3F7lhzv+8WY9jgB+q1sOgaN80kpX4FHTGh8=;
        b=LW8c1jziG07AEv4SRPUzxILPOQg+EpmRRrNx2WeeH1Z6bxkYQ+UWOLEttoO6uUmAz3
         v+0DuPl7J/aS6++aKsAAlkQiXJNUsvcmzU+TPLTLHn9CV2Y5SXLdF/7L6KH+5GV5vace
         VzKUy+dLshWE5rx84kFEjGHEk385oQa1MUGdVjcfylT8CxaLptcCbbbUCuTXboJmWO1s
         3XRENu+A/2p6Lbb8J8ghUG10jc3pchnLt6C0mImBCyw9rQ1FgKqVuCdCRllQ/bKnpPt0
         sQXNBIEy5WKfJhc6hOe/wGeCjtPPGQcK/09SYH6vXnvQG0gJ6zZVmHCyYJFgEv7pJRBM
         i9Nw==
X-Forwarded-Encrypted: i=1; AFNElJ+0TzuMWDvM65qZ/t0WGUb3B990wEU0S5LOQCLCT9mR9aZqCuV5Y3Jgm1eTIGSyBtc47WueW5ck9a1XAHaK@vger.kernel.org
X-Gm-Message-State: AOJu0YyXwkVROJPMG2c2ia0e85T3myt9JUYILJ0N/NM2R1dSUX58gPNH
	xrWc/LMSKNZv8zsxNdJiT2BHZi/vfRhSTW1wtyNTmiFdGXnziSm0bXwZDgOQybaMlyavW+fpAcj
	woLTuCLnSxKrMg3c4HwMtul+TBCp3zP6KWamPu6ne
X-Gm-Gg: AfdE7ckmYtIj/oeOFD3fzeQ2WROOt26jo5EOlhlzuAzNmRHhDzbhHjnT2jVT/QEUAhT
	/lCTVQE8APCug+SaSSf/QQ4kbvZnci3DhIPCEHSZvhSYFPWbb/C2EPM7G1gHgjlYgv5wFDnLbyU
	+41VqDe60PlmQezSStvmSsjyJa6GEfdD3dxwlrfJWj12+/0hDDseDwq31RFSNqm8nimVCFojI4j
	75L+j5Z72lzS4iJC9GmlqLTjUr+Z6ROqAnIGSzuSCBpEliqA41d7wq5AnmDA5CM5OrEMxF+
X-Received: by 2002:a05:6a21:62c2:b0:3ba:cd5b:3dcd with SMTP id
 adf61e73a8af0-3bfdc69589emr1376925637.36.1782847249974; Tue, 30 Jun 2026
 12:20:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630183956.281293-1-dwindsor@gmail.com> <20260630183956.281293-3-dwindsor@gmail.com>
In-Reply-To: <20260630183956.281293-3-dwindsor@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 30 Jun 2026 15:20:36 -0400
X-Gm-Features: AVVi8CeUWBZtqtU3wWufhJ35rf7KN-O35V57TZRDwEyvAO9h530GFJE7-OayBpg
Message-ID: <CAHC9VhSYNF=_Tfe-D99rHy70EXQVr1ES0arxT09Bidey4zOFdg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/3] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: David Windsor <dwindsor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 2:40=E2=80=AFPM David Windsor <dwindsor@gmail.com> =
wrote:
>
> Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically set
> xattrs via the inode_init_security hook using lsm_get_xattr_slot(). The
> hook now passes its xattr state as a single struct lsm_xattrs object,
> which the kfunc takes directly.
>
> The kfunc is only usable from lsm/inode_init_security programs: no other
> hook exposes a struct lsm_xattrs argument, so the verifier rejects calls
> from elsewhere. Restrict the xattr names that may be set via this kfunc
> to the bpf.* namespace.
>
> BPF reserves BPF_LSM_INODE_INIT_XATTRS slots via lbs_xattr_count, and the
> kfunc enforces that BPF never consumes more slots than it reserved,
> returning -ENOSPC once the budget is exhausted.
>
> A previous attempt [1] required a kmalloc string output protocol for
> the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all LSMs to
> provide xattrs for inode_init_security hook") [2], the xattr name is no
> longer allocated; it is a static constant.
>
> Link: https://kernsec.org/pipermail/linux-security-module-archive/2022-Oc=
tober/034878.html [1]
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D6bcdfd2cac55 [2]
> Signed-off-by: David Windsor <dwindsor@gmail.com>
> ---
>  fs/bpf_fs_kfuncs.c      | 79 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/bpf_lsm.h |  3 ++
>  kernel/bpf/bpf_lsm.c    |  1 +
>  security/bpf/hooks.c    |  1 +
>  4 files changed, 84 insertions(+)
>
> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 768aca2dc0f0..c4023c82f21e 100644
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
> @@ -374,6 +375,83 @@ __bpf_kfunc struct inode *bpf_real_inode(struct dent=
ry *dentry)
>         return d_real_inode(dentry);
>  }
>
> +static int bpf_xattrs_used(const struct lsm_xattrs *ctx)
> +{
> +       const size_t prefix_len =3D sizeof(XATTR_BPF_LSM_SUFFIX) - 1;
> +       unsigned int i, n =3D 0;
> +
> +       for (i =3D 0; i < ctx->xattr_count; i++) {
> +               const char *name =3D ctx->xattrs[i].name;
> +
> +               if (name && !strncmp(name, XATTR_BPF_LSM_SUFFIX, prefix_l=
en))
> +                       n++;
> +       }
> +       return n;
> +}
> +
> +/**
> + * bpf_init_inode_xattr - set an xattr on a new inode from inode_init_se=
curity
> + * @xattrs: inode_init_security xattr state from the hook context
> + * @name__str: xattr name (e.g., "bpf.file_label")
> + * @value_p: dynptr containing the xattr value
> + *
> + * Only callable from lsm/inode_init_security programs.
> + *
> + * Return: 0 on success, negative error on failure.
> + */
> +__bpf_kfunc int bpf_init_inode_xattr(struct lsm_xattrs *xattrs,
> +                                    const char *name__str,
> +                                    const struct bpf_dynptr *value_p)
> +{
> +       struct bpf_dynptr_kern *value_ptr =3D (struct bpf_dynptr_kern *)v=
alue_p;
> +       size_t name_len;
> +       void *xattr_value;
> +       struct xattr *xattr;
> +       const void *value;
> +       u32 value_len;
> +
> +       if (!xattrs || !xattrs->xattrs || !name__str)
> +               return -EINVAL;
> +       if (bpf_xattrs_used(xattrs) >=3D BPF_LSM_INODE_INIT_XATTRS)
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
> +       xattr_value =3D kmalloc(value_len + name_len + 1, GFP_NOFS);
> +       if (!xattr_value)
> +               return -ENOMEM;
> +
> +       memcpy(xattr_value, value, value_len);
> +       memcpy(xattr_value + value_len, name__str, name_len);
> +       ((char *)xattr_value)[value_len + name_len] =3D '\0';
> +
> +       xattr =3D lsm_get_xattr_slot(xattrs);
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

This is not a generic VFS function, it is a LSM specific function, it
belongs under security/, please move the code as discussed previously.

--
paul-moore.com
