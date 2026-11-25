Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795638327;
	b=sbSpIpCu2eX7cupJWRsJO5UvsrA3nfFJfkJiEBWaNqZRkZwSGBwmhQTtBdD2Qv+PZTH1
	 s02EzawyG0pTHXWg+0LKJfR9EPhmN+7CJGdiZ5dvQ52wUjmcw4juyr/K/mdCxt35/Flqk
	 eWEJvbCxpTtvZ6wFDSQpUSbhtN+tUK9WWUUniKWQf5bE0hTwU7Oj8dcMQbzClLNjdVsUf
	 7k+4yIYt8tL7lN5WADiFivPLcEo8//C3nKR+t/vDZO0YpwMhIcOUXbFaQAdGZ6TeopSXm
	 0/FR4ZTtVAlSMThZGWgqwJ7wG24EJcASsyFCjxfc3zExSNKiFSixRh4HhjLoeIYwJ0g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795638327;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=iLkN+MWQxnheW7WlW33tdTgTSE87b9Cd5EByIUSUt0Y=;
	b=qO2bnF8/z6ENQVdGMFSQ71UYlyEblS/5AAxxwnl6rO7D7ySTRBmODp0Rt2by8zBz/D4o
	 eRfOVCzs8SPgcTIxCoCFRf2a369gTiTSLHG6mtpeHaA8usxYHV4zHcy21Bg/Ndz6gsaiK
	 HaUpFOu2fikzzax8gpQVHhG8GGuHOkeiDPoXiQ9bOUUjKu2eGwWn1EjtTG2fFq0RGD5Z6
	 FRU1PdFMrQB3SgSfF5Rv1BzIYs/jDNxwryBqrg3fcBs/cA5q+xZ50fHQdAhYyz9I5DWkK
	 eZTLC6zX9ri7tMoDrK9hz779nqmG47xy6MFATUPE5d92bRzotx+Mn619Dtk7lrhEbvQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VGTkEe60;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6162606A331
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 20:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6162606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VGTkEe60
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4bb606491faso33507605e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 12:25:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795638325; cv=none;
        d=google.com; s=arc-20260327;
        b=E/O0NfOlTOycKQSQsIsq+Y6VsXRQA3p1cblHa7wNbEqqmM+jxq4EYF3RHYmXkN4Hg9
         kV+M13ow+C6j5Y6IOc3QMgK1sK6Xj23NWIU1g++QZjiSKl3C8vyFD0UCx+oqrs/+7msH
         LOmdvWk+vOWyLecCaQUjhFXZaLr4CPcmEO1+FjCIcXWMW0qC5aDDtlK1PyhlF8AMTD3X
         RwnMRGCUeIlZUis+16LgMVLPDyXyaXGvcV1G2ToG6Dr2Ta6ECFzhV+Xf7jjuEo7Pn28Q
         HAXcHN+XKJEGdMa0TikkftgExaVG84sezMdKt2SXfnh+KjwAUi+hCp6xXA0PFMOYw91P
         OseA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iLkN+MWQxnheW7WlW33tdTgTSE87b9Cd5EByIUSUt0Y=;
        fh=MVMApQYv5s+9DpK81xLc0MPpVWvqlzP28o988vz9VzI=;
        b=okSYZEoCo9h2tuuR6zLLQYsu8XRDAAOp6GnbUpGp4iijE4ZWRnLsUK0jPIHkEc3xEB
         eFswt/NMwKCXeqBOR1shfJqn8u9Msw3hBek+OdDP8TA/MWcvVJ0I4dLLLxj2BIiaesCh
         WpF11oWXjaSnQ9N5aCqnDQRWSi4idcOs/gICql30uYTqrXWNhBpi+HhTT7Yeg9jk1yrE
         uSv0yQ5H9fAbyx3UmR1q7egfav++Ez7AFNXZe1XMgt4pEycyV7LxgefTV6keMYUDluzB
         jGhkr/fbr/yl6xjjStcLxZkAARznzGYiyV/pcgM7uphG8aBfFw/rSh58Xy8fnnbYsI4L
         SqYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795638325; x=1796243125; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iLkN+MWQxnheW7WlW33tdTgTSE87b9Cd5EByIUSUt0Y=;
        b=VGTkEe60t+uBwP6aPNkx43z8z6QVDU++15cRElqDwWfUU1e3fenr6BMJd5yqV3dDA9
         eA8oe5NrXkEHwUBl11jkg8wDy9tp6iawyGZI+I0+8a2wm/AuGn7WAhBNnP2di4ncRBvi
         GP3YhRSf4B9UmdV7WIelY3jLTHdu0tTd4bRuWc/VAf3Fh8E191oj8H4DZfnmEdqvuSvf
         lvk5witmPseoMyw5ddMdhJcD0iLXJtwNtHf9gbVkgQ0gxiXToJG0KG+IUwwsY4py2sxa
         ccRb9lzGiloOKwBt5gcRe4juUs/njCMJygqqqKLSHmyPKP/n+m05YI4EMSm+xl9SMO+n
         fT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795638325; x=1796243125;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iLkN+MWQxnheW7WlW33tdTgTSE87b9Cd5EByIUSUt0Y=;
        b=rjvGqh75AzNeK+wKDZc9/JtVToov8cvXzmeQG72L2NbmbDkD7o7P1yOkBwV5g7g7PI
         8aDIYyQNPXH3gt2qXseDxmn7sN1ErTeot/FF9YfVUP2zROsnKx82TRe1o7eO2vDARbXy
         8Pv6JDl30EdmW1MbkYWaGMZbKzGP75vrA7bA+KKTlhjw/lhygAl5zI5oMpq7h7jENMvm
         m/6xffivDFZQmwCnRKFzhOnwOBDmMyFLCt77vstJE5H356iIvTzqed3EqdYv68EZCvsv
         EQuDoK+y6qpLpGUReAn9g0bHPn2RyABzAtWnjA8I82nYpCTaTCW52+2G2IGLgsywvJol
         o69w==
X-Forwarded-Encrypted: i=1; AL+hErEq8q82AUeeGibYL2rAUVvOnJS0SsVQOE+tehEZc8nxVpgUBaiIcTlVgLzNt7pSn6XZ7gY5rXY21np6sOTR@vger.kernel.org
X-Gm-Message-State: APuU4Z+eiZ6WWwp4ehYgeapmBjYks8iz7nwOOofpRT9dVjq9k2U8h5JY
	StCgrBh8w2tG8aOk2G4Vbn8QPWx01iMQe88MnBSQLX2K2Z3JhC5re+GexROyfmc0UyasTb70y1K
	W2q+6n+YfJkUjgz7cE9IYdMuE5DRfcxc=
X-Gm-Gg: AZFdTZe2RBw/P3ay5GK7GLg+GeSQhhk7v0HHQnt62RUY+J2nozxyIBkHlU4DgL24y59
	vI2UQxeDK3yP3BKEm+FhVFYB9mGGP08fjX4fC83KkT2p0CthhJIhzobfSbFL3VtAIgqnuTxi+88
	ic1ninM1UZdOOVKQX9K0xiAammDClTN4hr90Kgz2EUBERdm3KuwmgboWcOZkI3/RMmgpaDINzwa
	HTDxDbn8IiutDTv9nG45dMLtTzL4PtFWggZ6nC4ATYWIvlW+o27oxttyh5znR4/1pb90knIog9S
	xHBXZ9CCXCECiB862BYb7JBgXu/ov1ttUq7jBNLK4N6l24Je8OZ5zzXVJIOtdRewMJXBdC+n5+/
	z2mt5rcSjrJHz7jPwSzTk3KMtdec+VgH6bB+4PwwdadN13tXXIDKpCuXrybauP/UYMQHV2MZrHO
	WWOf/t3te4X32zUWWrzDKL6fRtKkDL49jHqSPTBX0=
X-Received: by 2002:a05:600c:46cc:b0:4bb:6f41:399f with SMTP id
 5b1f17b1804b1-4bb888236a3mr398384805e9.24.1795638325248; Wed, 25 Nov 2026
 12:25:25 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113221248.3535369-11-wusamuel@google.com> <20261113221248.3535369-19-wusamuel@google.com>
In-Reply-To: <20261113221248.3535369-19-wusamuel@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 25 Nov 2026 12:25:13 -0800
X-Gm-Features: Aa3M54rCmMPBEx135c6vF9MhBqdEKKVbA2tVr-knpTqUbo_Og9Fm0v--QDk1gek
Message-ID: <CAEf4Bza48tGhcUhFRhSSv3qijV0uF8YrAQcLM6Qv9az-8zvK_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 8/9] libbpf: Resolve typeless ksyms via
 KALLSYMS_QUERY_BY_NAME ioctl
To: Samuel Wu <wusamuel@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Petr Mladek <pmladek@suse.com>, David Laight <david.laight.linux@gmail.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-modules@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 2:14=E2=80=AFPM Samuel Wu <wusamuel@google.com> wro=
te:
>
> libbpf parses all of /proc/kallsyms to resolve typeless ksyms.
>
> Use KALLSYMS_QUERY_BY_NAME instead: exact names, plus "<name>.llvm."
> prefix matches. Ambiguous matches at different addresses fail the load.
> A missing strong extern still fails and a missing weak extern is 0,
> without a text scan.
>
> On any other error (e.g. -ENOTTY on older kernels, or -EPERM), fall back
> to the text parser.
>
> Signed-off-by: Samuel Wu <wusamuel@google.com>
> ---
>  tools/lib/bpf/libbpf.c | 99 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 97 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 44134421bd7d..f3f3475a64d3 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -59,6 +59,34 @@
>  #define BPF_FS_MAGIC           0xcafe4a11
>  #endif
>
> +#ifndef KALLSYMS_QUERY_BY_NAME
> +/* 'f' is PROCFS_IOCTL_MAGIC */
> +#define KALLSYMS_QUERY_BY_NAME _IOC(_IOC_READ | _IOC_WRITE, 'f', 48, 0)
> +
> +enum kallsyms_query_flags {
> +       KALLSYMS_QUERY_NAME_PREFIX =3D 0x01,
> +};
> +
> +struct kallsyms_query_sym {
> +       __u64 sym_addr;
> +       __u64 sym_size;
> +       __u64 sym_name;
> +       __u64 sym_name_len;
> +       __u64 sym_module;
> +       __u64 sym_module_len;
> +};
> +
> +struct kallsyms_query_by_name {
> +       __u64 size;
> +       __u64 query_flags;
> +       __u64 query_name;
> +       __u64 module_filter;
> +       __u64 pos;
> +       __u64 sym;
> +       __u64 sym_struct_size;
> +};
> +#endif
> +

there is no need for this, libbpf in kernel can use kernels' most up
to date UAPI headers directly, and on Github we sync necessary UAPI
headers into include/ directory, so libbpf source code can be built
with latest definitions of kernel UAPI. So you can drop this part

>  #define MAX_EVENT_NAME_LEN     64
>
>  #define BPF_FS_DEFAULT_PATH "/sys/fs/bpf"
> @@ -9421,8 +9449,75 @@ static int kallsyms_cb(unsigned long long sym_addr=
, char sym_type,
>         return 0;
>  }
>
> -static int bpf_object__read_kallsyms_file(struct bpf_object *obj)
> +static int query_ksym_by_name(int fd, struct extern_desc *ext, bool lto_=
prefix)
> +{
> +       struct kallsyms_query_sym sym =3D {};
> +       struct kallsyms_query_by_name q =3D {
> +               .size =3D sizeof(q),
> +               .query_flags =3D lto_prefix ? KALLSYMS_QUERY_NAME_PREFIX =
: 0,
> +               .query_name =3D ptr_to_u64(ext->name),
> +               .sym =3D ptr_to_u64(&sym),
> +               .sym_struct_size =3D sizeof(sym),
> +       };
> +       char prefix_buf[512];
> +       int n;
> +
> +       if (lto_prefix) {
> +               n =3D snprintf(prefix_buf, sizeof(prefix_buf), "%s.llvm."=
, ext->name);
> +               if (n < 0 || n >=3D sizeof(prefix_buf))
> +                       return 0;
> +               q.query_name =3D ptr_to_u64(prefix_buf);
> +       }
> +
> +       while (!ioctl(fd, KALLSYMS_QUERY_BY_NAME, &q)) {
> +               if (!ext->is_set) {
> +                       ext->is_set =3D true;
> +                       ext->ksym.addr =3D sym.sym_addr;
> +                       pr_debug("extern (ksym) '%s': set to 0x%llx\n",
> +                                ext->name, ext->ksym.addr);
> +               } else if (sym.sym_addr !=3D ext->ksym.addr) {
> +                       pr_warn("extern (ksym) '%s': resolution is ambigu=
ous: 0x%llx or 0x%llx\n",
> +                               ext->name, ext->ksym.addr,
> +                               (unsigned long long)sym.sym_addr);
> +                       return -EADDRNOTAVAIL;

I think there is ENOTUNIQ which we can utilize here

> +               }
> +               q.pos++;
> +       }
> +
> +       return errno =3D=3D ENOENT ? 0 : -errno;
> +}
> +
> +static int bpf_object__resolve_typeless_ksyms(struct bpf_object *obj)
>  {
> +       struct extern_desc *ext;
> +       int err =3D 0;
> +       int fd;
> +       int i;
> +
> +       fd =3D open("/proc/kallsyms", O_RDONLY | O_CLOEXEC);
> +       if (fd < 0) {
> +               err =3D -errno;
> +               pr_warn("failed to open /proc/kallsyms: %s\n", errstr(err=
));
> +               return err;
> +       }
> +
> +       for (i =3D 0; i < obj->nr_extern && !err; i++) {
> +               ext =3D &obj->externs[i];
> +               if (ext->type !=3D EXT_KSYM || ext->ksym.type_id)
> +                       continue;
> +
> +               /* Check exact name and then LTO .llvm.<hash> prefix */
> +               err =3D query_ksym_by_name(fd, ext, false);
> +               if (!err)
> +                       err =3D query_ksym_by_name(fd, ext, true);

err =3D err ?: query_ksym_by_name(fd, ext, true /* lto_prefix */);


> +       }
> +       close(fd);
> +       if (!err || err =3D=3D -EADDRNOTAVAIL)
> +               return err;
> +
> +       /* Other errors (e.g. -ENOTTY, -EPERM): parse the text file */
> +       pr_debug("KALLSYMS_QUERY_BY_NAME failed (%s), falling back to /pr=
oc/kallsyms\n",
> +                errstr(err));
>         return libbpf_kallsyms_parse(kallsyms_cb, obj);
>  }
>
> @@ -9699,7 +9794,7 @@ static int bpf_object__resolve_externs(struct bpf_o=
bject *obj,
>                         return -EINVAL;
>         }
>         if (need_kallsyms) {
> -               err =3D bpf_object__read_kallsyms_file(obj);
> +               err =3D bpf_object__resolve_typeless_ksyms(obj);
>                 if (err)
>                         return -EINVAL;
>         }
> --
> 2.56.0.679.gc527c65306-goog
>
