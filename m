Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795638315;
	b=frVcwLGoYVKpd/ir0WkevCcfseM/gDVMFml5pP4U9Seh42UIxWYanvavgOCy5XuF0EjY
	 sslv0DNxFupBPgDLktbA2ENo/GGELILcgzcTR3wZmcs5AgFKS6bNkTSytuvag0y65yo0Y
	 Y2IPZN0NMQLArpezO6haqIK8MtiOJQlp7XNEB/OUz6F3J2reRCmqWTxfZD9duoZTBQpfC
	 qyIAuySkJSH/PFQfZwHJqxLkWOoCqz9RhlJ8d2yYCGQDoJs0EiCqbfmSl256EYmmccTKB
	 lHHd1T9y80oQ+HFOVi5mb81lsaSKvCjLpr1bC0WG8qyc7p4++0ZGt0nSg4Eo2xmT0XA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795638315;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=tNTrkUuaHlHdlSJ9SFhPuXAnSzxCe+1wYBLFF6dY6Vo=;
	b=lqEBAAf3kT3SdDfeMlRLz6wPbrxDg2fP1gxCwLLfv6QVQ5Wfckqbu+JI9JN1LT1BX2/A
	 aQEEJ1Itzl94vJnOuahBaxUl2qvGynUA2pEJq3XbpZI+xos+FsMEkkyenMh+QVxpP+h3T
	 CzAwz7oa6WUzwPhW1qP/MpmGAzcdxG/rgK+ev3DNSkOmgeWwgdkDgSbgnBCQ3KM/s3yrw
	 fVMyma9tJV9a/opdNJdNp+xUyNZqws8GeYDTa+3hzUOC6acU8gUQSGBpC0X+4NBQNUE4R
	 nhpMBqeNgKuugoCVmAN+RIJWQUhkOENrBYrpQa5xQQkv0PIzk4BDP6kOzsyjt+rUNsw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FsVUFq4K;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC73F606A331
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 20:25:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC73F606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FsVUFq4K
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4a34ffd3e39so3419065f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 12:25:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795638313; cv=none;
        d=google.com; s=arc-20260327;
        b=ipf5hfO7WW4SyJjgMTCPK6/L1tsj53FZCjqW1hm8asIkRAlGFxadQk3Tf5GIREkBTf
         Cp508QVCcpaWNbd7uw5U/w0vWzsQ1l6s+6xFbXjQB3B2rQsnESjmb5+Dy9JzhZIMSltG
         0cfX56/SDuadjCM9VkCKcefZOBUWn7pl6GsqoeqP52gCfyR76Q8/z5OYhZIBzGblRUi1
         69rq3cgvgZjH6ouaZ6LqGKp+sy/OZ6tzWAyACqQ9ogCPmLseeDRj2Ufn9cgj9prO+ZoK
         Xr/ZAizHfvPSRAUsh6j6pxo07Dt0TmjBcTM03jvPL8ohneRE837BKlpttl5/QsoVhua5
         Yvow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tNTrkUuaHlHdlSJ9SFhPuXAnSzxCe+1wYBLFF6dY6Vo=;
        fh=bGg/nV+M0Ec5RG8SLQx9SfMxnCePUhIlEtEpNRa7YdU=;
        b=CDPH2woxXG8JjD7b4U8udpmcu2/uhBTxC+7zqjlyfUVeGFeOcf/sk/p6vsSdhKKDT7
         bMQ8Yg+kd690wahbS+jx6+B8w/+ZuycYlW6NBkDNfLj1nkJCgzSh0q+bjoTesQtvBDA/
         kj3tMd+Bdp7ydqFnTn9vxgdv15t2x5OT2ypSEe3skQaqYakssqtX5zdRq3Ab7XqOlEHb
         JDtjR/rpsg2gzD+4y6OApRGAfRVjF2JFnXTArBfJH3lvgzzqEEsJ8uW8cc3vkL3TTpnW
         kKJoaJ5y83BneO/gd0HMSdOPuGFF6nsgwliJylnkheFgjbwF/lHtSvZJqoLrc1ro86lM
         Chwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795638313; x=1796243113; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tNTrkUuaHlHdlSJ9SFhPuXAnSzxCe+1wYBLFF6dY6Vo=;
        b=FsVUFq4Kxydr5a/GRpviIjKPXJDEjD+WqAdPZ1XWo1WKh6FISDbmtggw9Zb9JFW3df
         my0mKvhcR7rXcURvxIiyLaU0x8G53jEG3RdWyadxD5Sjrd3S3bRm9m2X9eRmHdgcwpBt
         kJEx19iUSOYIvPsz94vQNgXJI2BVbCnizYEbhclF+Ay+piUCPYbizA3IKKECYAyth31c
         1cycvaj0oJ30o2SFzRwfoCqCkfAxS5IRdiXE6Aygof4B197kFd92a26XgWumaMHu5NwL
         j2GNWzFlP3MDK3hmVarn2zbz/A34WRbObbIdjkRH2C2OpDhJyhYRxAmTFIj0Zm516Hlh
         0Dhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795638313; x=1796243113;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tNTrkUuaHlHdlSJ9SFhPuXAnSzxCe+1wYBLFF6dY6Vo=;
        b=TLhr2mhOKKVQdLsB0p0rDGXES6CgKTihZ3UIY0dKK7Z7Q9p8StgwhANOmwC7jhe+c3
         SM/9FuXLCSh3fyHmVXh7kqQy7oSJQlAcMiYkwmTw1AMVsw5Z9CvLxuA4+xbEwO/xHDhE
         so7XjhveT2kuxbdPl+XnqLBxUSySiWZ7VzxlGRn9PmCntC83HYvblqyH23+zE9ULAIxk
         0JP4FjhQpgiGfVy5jhtGmk3GEA6fZ3y5TJPjPL9WVN8Miv8cFICVW7ozVCU4YNe2Q7/w
         qnBj4vOzahwACFjZHMwT8Wh+zOht+FB2hBskhAOyLcX6bexwk04PJqqMjsincvhYKBEf
         zA5A==
X-Forwarded-Encrypted: i=1; AL+hErF4ZocoGQy7eenC1Eu3QF+sRMVv2+BAga2GxjlYLx2akNOzmosQEDQOL8YUzhZqakADySfwL5WlD0S32Zaw@vger.kernel.org
X-Gm-Message-State: APuU4Z8oLUEi9XV+ePMPsSufeyZr/i6dptsT+v2rj16dzWNM2TKP4cvw
	JblUvhF0aNOS3jCbnFrWm/Uwv78sxs9H8nldVni5MN5J+R7uA9QPGY2bFGc0VPsYL2UrX+4RCbP
	Jv6WmOoooLbWpevCLXwmlH/rdZ39ATb8=
X-Gm-Gg: AZFdTZck7JxSllPhU1zvR4r5vT+i+06U6EHxB+hGfQVHIEuJfU+xfC4YhhQBkKW0zc5
	Clox4RypoaePM13Tj/Ww7eLpgDu3xEC+ITteRXi6HoRCiFcNFQ+dmcUzuOA73Yv0JaRd9t3YIXP
	rxswXS83zJ3tBzYxahJw2Ap1x0fGTo+XFsxbnBPobbS/BU8kqhGO+6R+E0QEEzVJ5aEhWgiLgTq
	wXGNwLgfYF+Fkp5j7LVaQbqc5mD+IyXjk0LV67N8hsmZNO8hXpJExnhSrrlHX1n8d7Ncqd39/i4
	K2WOu6PE+wFeFcUZqfphcECiWAhzfil1JpwSxnwSRdi/TAlyPwh/TaEyw+GqAKEFTKDsxCizSIr
	pFpjmi8UVyGp1DqI6xs3nsjQlfFYrDOrMGVZD4RuivVw69P2i6tZjn3xbsJlQtysb0kNoXLtNZw
	l/tMWNr6Kn9UWoVwkv8ymkIRSwPYgKRHUbo8taaig=
X-Received: by 2002:adf:e010:0:10b0:4a7:518f:bea6 with SMTP id
 ffacd0b85a97d-4abb3a4d2b1mr26580561f8f.28.1795638312899; Wed, 25 Nov 2026
 12:25:12 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113221248.3535369-11-wusamuel@google.com> <20261113221248.3535369-14-wusamuel@google.com>
In-Reply-To: <20261113221248.3535369-14-wusamuel@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 25 Nov 2026 12:25:01 -0800
X-Gm-Features: Aa3M54pvd_ufUhqcRiZwrOrjoyqqBDQhM2r6c2QuhvkGt5RO4ZEh7lWEiXzteDk
Message-ID: <CAEf4BzYLqCCwxSAfuzB-wZiae_tgf0yxAVsFc_wzfRAdeqjDtw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/9] kallsyms: Add KALLSYMS_QUERY_BY_NAME
 ioctl to /proc/kallsyms
To: Samuel Wu <wusamuel@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	David Laight <david.laight.linux@gmail.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-modules@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 2:14=E2=80=AFPM Samuel Wu <wusamuel@google.com> wro=
te:
>
> To find a few kernel symbols, users such as libbpf parse all of
> /proc/kallsyms, which is several MB and text based.
>
> Add the KALLSYMS_QUERY_BY_NAME ioctl. It finds a symbol by exact name or
> by prefix in the entries of /proc/kallsyms, with vmlinux matches first,
> and optionally in a single module with module_filter, or all modules by
> default. Each call returns one match and its position; pos + 1 continues
> the search, until -ENOENT. The output returns the address, the size, and
> optional name and module buffers. A buffer that is too small gives
> -ENAMETOOLONG and the required size.
>
> vmlinux symbols are found with a lower-bound binary search on the sorted
> names, module symbols in one pass, and ftrace, BPF, and kprobe symbols
> with the per-index getters that read() uses.
>
> For versioning, the struct carries their sizes, so the command does not
> change when the struct grows.
>
> The command uses 'f' 0x30; register 0x30 in ioctl-number.rst.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Samuel Wu <wusamuel@google.com>
> ---
>  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>  include/uapi/linux/fs.h                       |  43 +++
>  kernel/kallsyms.c                             | 319 ++++++++++++++++++
>  3 files changed, 363 insertions(+)
>
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documen=
tation/userspace-api/ioctl/ioctl-number.rst
> index fbc3537fc9ee..f5dbb597257a 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -250,6 +250,7 @@ Code  Seq#    Include File                           =
                  Comments
>  'f'   00-0F  fs/ocfs2/ocfs2_fs.h                                       c=
onflict!
>  'f'   10-11  linux/fs.h                                                c=
onflict! procfs ioctls (PROCFS_IOCTL_MAGIC)
>  'f'   13-27  linux/fscrypt.h
> +'f'   30     linux/fs.h                                                p=
rocfs kallsyms ioctls (PROCFS_IOCTL_MAGIC)
>  'f'   81-8F  linux/fsverity.h
>  'g'   00-0F  linux/usb/gadgetfs.h
>  'g'   20-2F  linux/usb/g_printer.h
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index a46c33692aa2..987569dcdbea 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -674,6 +674,49 @@ struct procmap_query {
>         __u64 build_id_addr;            /* in */
>  };
>
> +/* /proc/kallsyms ioctls. -EPERM if the opener cannot see kernel address=
es. */
> +#define KALLSYMS_QUERY_BY_NAME _IOC(_IOC_READ | _IOC_WRITE, PROCFS_IOCTL=
_MAGIC, 48, 0)
> +
> +enum kallsyms_query_flags {
> +       /* Match query_name as a prefix. */
> +       KALLSYMS_QUERY_NAME_PREFIX =3D 0x01,
> +};
> +
> +/*
> + * Symbol returned by a query. Each buffer pointer and its *_len must bo=
th be
> + * set or both be 0. When set, the kernel sets *_len to the string size
> + * including the NUL, even if the buffer is too small and the ioctl fail=
s with
> + * -ENAMETOOLONG. The module name of a vmlinux symbol is "".
> + */
> +struct kallsyms_query_sym {
> +       __u64 sym_addr;         /* out - start address */
> +       __u64 sym_size;         /* out - bytes to next symbol, 0 if unkno=
wn */
> +       __u64 sym_name;         /* in - user ptr to name buffer, or 0 */
> +       __u64 sym_name_len;     /* in/out - buffer size / string size */
> +       __u64 sym_module;       /* in - user ptr to module name buffer, o=
r 0 */
> +       __u64 sym_module_len;   /* in/out - buffer size / string size */
> +};
> +
> +/*
> + * Find a symbol by exact name, or by prefix with KALLSYMS_QUERY_NAME_PR=
EFIX,
> + * in the entries of /proc/kallsyms, except undefined module symbols. vm=
linux
> + * matches come first. A module_filter of "vmlinux" selects the core ker=
nel.
> + *
> + * Each call returns one match and sets pos to its position, even on
> + * -ENAMETOOLONG. Start with pos 0 and use pos + 1 for the next match, u=
ntil
> + * -ENOENT. Use pos only with the same query. Matches can be skipped or
> + * repeated if symbols change between calls.
> + */
> +struct kallsyms_query_by_name {
> +       __u64 size;             /* in - sizeof(struct kallsyms_query_by_n=
ame) */
> +       __u64 query_flags;      /* in - enum kallsyms_query_flags */
> +       __u64 query_name;       /* in - user ptr to name or prefix */
> +       __u64 module_filter;    /* in - user ptr to loaded module name, o=
r 0 */

similar to the comment on the previous patch, how does the user
express that it only wants to search vmlinux image and not consult
module?

and naming nit: query_module to be consistent with "query_name"?

> +       __u64 pos;              /* in/out - start position / match positi=
on */
> +       __u64 sym;              /* in - user ptr to struct kallsyms_query=
_sym */
> +       __u64 sym_struct_size;  /* in - sizeof(struct kallsyms_query_sym)=
 */

I'd name it "sym_size" for consistency with "sym" naming, and the
comment/doc here is unambiguous about what that is (struct size, not
the symbol's recorded size). seems fine as far as UX goes


other than nits, this API looks great

[...]

> +/* On -ENAMETOOLONG, *ksym is still copied, to return the required sizes=
. */
> +static int kallsyms_copy_sym_to_user(u64 usym, u64 usym_size,
> +                                    struct kallsyms_query_sym *ksym,
> +                                    const struct kallsyms_sym_match *m)
> +{
> +       size_t copy_sz =3D min_t(size_t, usym_size, sizeof(*ksym));
> +       bool too_long =3D false;
> +       int err;
> +
> +       ksym->sym_addr =3D m->addr;
> +       ksym->sym_size =3D m->size;
> +       err =3D kallsyms_copy_str_to_user(ksym->sym_name, &ksym->sym_name=
_len,
> +                                       m->name);
> +       if (err =3D=3D -EFAULT)
> +               return -EFAULT;
> +       too_long |=3D (err =3D=3D -ENAMETOOLONG);

nit: if (err =3D=3D -ENAMETOOLONG) too_long =3D true; is just as short

but also you are eating any other error, maybe write it so that
original err is preserved as is, not special-casing ENAMETOOLONG? if
you get EFAULT later, original error still takes precedence

> +
> +       err =3D kallsyms_copy_str_to_user(ksym->sym_module, &ksym->sym_mo=
dule_len,
> +                                       m->modname);
> +       if (err =3D=3D -EFAULT)
> +               return -EFAULT;
> +       too_long |=3D (err =3D=3D -ENAMETOOLONG);
> +
> +       if (copy_to_user(u64_to_user_ptr(usym), ksym, copy_sz))
> +               return -EFAULT;
> +
> +       return too_long ? -ENAMETOOLONG : 0;
> +}
> +

[...]
