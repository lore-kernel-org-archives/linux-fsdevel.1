Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793309750;
	b=af6ET2ssKJ5op+/UizUyAjHp41sjXb9vqvxUl0j2Cst/DXsgflTFDMyBFttIj5hCVUC8
	 yHn5w9CCyNKdSDnLjIq4b2udcRMre/iv0H2bX1jI65V4Sx/K2zR0DV5qXZQ8jzA6Sg/mC
	 fcae+sl3c/RoQff0YYOKe3A9avZgSccdj6v3UxkQ0GkrIoAaaZKTwRRioYD3w8kAmIrrd
	 MzfLVNWLNVIl6acjS2PbZHh61fmoZwfBygO3o19dvjy1xkH2h+3krShxmJpbcr8Ddw9Fn
	 TAZAHUUMZ7Re2DqbQzYgYEPfw/zDiSlSJFSbC8isyniz/xw2z7GcneFs2sEt3KJk6rw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309750;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=AjT67sODfv8LIA3zVwUGB//ZCy/sHbwEFOtaC99aW5g=;
	b=Rhxn/IXJnLI3RvvQvwhvEEbnPfVQA9l3X6SGfCKYPmAq/jvrxCwIpXNdkQErZAdT8hXT
	 AzP0H8ZQ0ZaoPU9FWlXEGBWGH3fzFPEAuh7t3Au+6mTAvLM4pYCmaQJPEeGuLcELAFt+x
	 Be46epjAao341NUPPG35qcKMnfOsa9bxnwi1gtWOJmWLJsJpnm/BxSLyTeenk44gdfvVI
	 7daFt4f+f/60L/pq/ohM6HhGbdoYGxOZM8qG3+R8hEc83k8UbnGP9bvdgiktU/k6sxxtD
	 tCD6zU73opSgvPIbm6dp3H8nxh0oup2YYQA/hJuwZpj6gbEMvBKGaL2PXBb0MfLcp7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ny4Qf79m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C090F606A31C
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 21:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C090F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ny4Qf79m
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c43fbcb4393so2380666b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 14:35:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793309748; cv=none;
        d=google.com; s=arc-20260327;
        b=CgOXXHJvatsh3S1RJqlHPlCgNjibMkUYGBn4Nz4K8cCTLFSWzq9EUkrQY+MrAtyg1z
         +03BF4KwZc9IbgvtQVzUp5zIRrMSOXc5XJuaxw0WfSHVgUNhTK+MLI6OCpEGqM8gPw8g
         QXxXNjm6gKF8qb7rhv51VWWTkhknWwkY28NQ9szJwW3/+flO76w5klZ6hoJz5i2o0q12
         PGZzj1wntORQthM7CZP/IlEASzdaT/j85Bpu6rhlpEngg2qQLbXkrH7A7BE0/rwhun+t
         r9QZSirnIJngRtZXXhWDt0JbjH1Qcw0A/jd2OoCdtmFnINdC+qVTUt35onL/v6RnSoT8
         1Qjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AjT67sODfv8LIA3zVwUGB//ZCy/sHbwEFOtaC99aW5g=;
        fh=EawQxjZrXV8bqb4oa2YwwIznPD6Kv+m7Klul5Bk3tww=;
        b=JSuotYeUAWJYW6jmy5tsiH8hVQrnwhcLoMVFbiFZlfWtjjQpKRX6LeP5hceyRVo0HA
         SzfF8+GSlHU9QQcm5DCmyv2UtLGT4eToASk9waylPlBN1mrSvR4z3iZaSaeR4HjyG8va
         dZxzhiF+fvFR8Ll3Rn6A+iItZMjKdZb60/O9bqIwcJihxosizEZAa++6iRkwYioP7Exg
         Tp2MEWXPcIi7q31gMwsjshc/bLdVsxkKzbNzcxqU/HzOz3tyfUzgERV4lEPL7R4OuGdl
         rgbUv3fXzz7U+OjcsmmE3174kGPcD8mYRvciUl1gLfG81mi50rm4xB9yfcwCPHzmQ4Ev
         dKRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793309748; x=1793914548; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AjT67sODfv8LIA3zVwUGB//ZCy/sHbwEFOtaC99aW5g=;
        b=Ny4Qf79msA3Ol1Y6e8/IcUAH9yOvaHBe2q/r2VBC2ELpk56XQeNul05malBDOFT8ku
         3iNV5LUh1WN6OSi58GJtPL1CdzJ6Gfdq1EwPPwQTHQ+fJYrr4uuUNxUlmh+B6VBLkI3H
         ZEj0B1DaLGuydvsPOrmNnyN+V5M9uzXhIOuB8IAfuS4x7RzFZc8EHwvHkIbq2HZsSAXO
         f8K9v16/gbB/xNpURIL1Ixe+3ZCyFOiwul7kpsyeMIznZ8WtYjV+3pMV90juEncbUJ39
         jANFHK4YH+YJxQHzX5N4bA9Y7nUKExBRqIOMrQJ2r0F5nLrYhReYCpQZmLjrgHbgSrOi
         AU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793309748; x=1793914548;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AjT67sODfv8LIA3zVwUGB//ZCy/sHbwEFOtaC99aW5g=;
        b=w4SiAe9rR7OmkwTzRhf5enknjgBiYzL0aFZQvqV7WSTkw0g8HWIlhesH+QR+7Aoyhc
         7vXWL/8D5wNkD6Ib8boA2ZPZOHJ/B8t30Zo4123RVrPok1SZF2eVuRLZP0LylgKrITDZ
         /NSKlruDXhx1Q46etqB05PG3H74zszNaOClCXygn489/cM7A1VHQIfQsjrX1flf3a3gK
         QGt4bQeDn8h6P+artm4Qt8QjMIKaBwDoME5kMbVoBj3hjh3izoSGFjProtxKfIXDOyXw
         FZ0Qx6xzgB7uhgVGTuGBEzGBzbfrd5abmEvpqTyB0oZc0XV0Zip+43EG286+gNlizSo1
         dJdw==
X-Forwarded-Encrypted: i=1; AKwUvByWAtUlEsIOevR59jD5aBnVTMGFpdYCokLXoeGa0wjwCJiW0a4wUrA8YFuQDNaQizwbLQXJYQDJxQWdHv1o@vger.kernel.org
X-Gm-Message-State: AFq9FYJUuWdT318IE/LaG2+lqr40msjAGTuielpVOsMjbrI/1jGZUvj6
	oj18yf/zvPkT4vb35XPOTBsTPEOPQRoMdhNU82BoaV1XIBi8YbkFchW9IaUtYgNU3F4uVhZPbN0
	ak4JBYfbneLCMDRww5+3kKNFonMadFpyQXJ/Gdh33
X-Gm-Gg: AYBFou3lfXMrlZXenHu1oz40YC5dCI9omooxqJGK5wB5tup5o9mzigbJ+7z1n9RLGAJ
	rpzH28H/dzNPMpsvaaoUDA2EYZbVzc5bvl2zjzaygBtaMXO5NPSQXcRS0skkudhQXmS1Yo01y2U
	33JaQ6BVmALyoYjgcKDF2DoZDgBgMpOGiAm7DS0eDRGSUWO2y4xNKmHWpWev8Y2XagN8qcVirRH
	nY5OnOoa0ikZARPGc/peePBLqfJpj62+nuRzadWvw6KIIQb53auXlUNdOx5piLerFEGlI8jhUdv
	68v02/ZxES4KbfhOR36Jqlg3MmLVBF1hHp193yj0tszWYKWwfTM/RIEltdt29Ef18anBSlIL5Tw
	ZcRT0zrNEVC7znd7oLmZW0sUczofnfWgEl20FiaXl4YVLR3iwsMTQ6XpBceU0ovrYsqPMDFk=
X-Received: by 2002:a17:907:805:b0:c3f:a728:b437 with SMTP id
 a640c23a62f3a-c4ca7ac07eemr32967066b.45.1793309747666; Thu, 29 Oct 2026
 14:35:47 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023001603.560210-8-wusamuel@google.com> <20261023001603.560210-12-wusamuel@google.com>
 <at8dNNb4vwovNZcZ@krava> <CAG2KctpMEuK5OJSedSFshNMSwOqe1g87m2ZOKBhn=Z5iCA45Aw@mail.gmail.com>
 <20261028140127.7bfeab46@pumpkin>
In-Reply-To: <20261028140127.7bfeab46@pumpkin>
From: Samuel Wu <wusamuel@google.com>
Date: Thu, 29 Oct 2026 14:35:36 -0700
X-Gm-Features: AclHuK84Rx0Zv6bqYRMUgm-AA1OaD1X9ao32PPa3PHwJ78sUr0bqSyZbITTizzQ
Message-ID: <CAG2Kctra0GYjkzggB0cdMxPK-b9U9x-m+gR6E8goAYvhsNXEdA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/6] libbpf: Resolve typeless ksyms via
 KALLSYMS_QUERY ioctl
To: David Laight <david.laight.linux@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 7:01=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Tue, 27 Oct 2026 15:07:44 -0700
> Samuel Wu <wusamuel@google.com> wrote:
>
> > On Mon, Oct 26, 2026 at 2:28=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> > >
> > > On Thu, Oct 22, 2026 at 05:16:05PM -0700, Samuel Wu wrote:
> > >
> > > SNIP
> > >
> > > > +static int bpf_object__query_ksyms(struct bpf_object *obj)
> > > > +{
> > > > +     struct kallsyms_query q;
> > > > +     struct extern_desc *ext;
> > > > +     int err =3D 0;
> > > > +     int fd;
> > > > +     int i;
> > > > +
> > > > +     fd =3D open("/proc/kallsyms", O_RDONLY | O_CLOEXEC);
> > > > +     if (fd < 0)
> > > > +             return -errno;
> > > > +
> > > > +     for (i =3D 0; i < obj->nr_extern; i++) {
> > > > +             ext =3D &obj->externs[i];
> > > > +             if (ext->type !=3D EXT_KSYM || ext->ksym.type_id)
> > > > +                     continue;
> > > > +
> > > > +             q =3D (struct kallsyms_query){
> > > > +                     .size =3D sizeof(q),
> > > > +                     .query_flags =3D KALLSYMS_QUERY_BY_SYMBOL,
> > > > +                     .sym_name_addr =3D ptr_to_u64(ext->name),
> > > > +             };
> > > > +
> > > > +                     err =3D -errno;
> > > > +                     if (err =3D=3D -ENOENT) {
> > > > +                             err =3D 0;
> > > > +                             continue;
> > > > +                     }
> > > > +                     if (err =3D=3D -EADDRNOTAVAIL)
> > > > +                             pr_warn("extern (ksym) '%s': resoluti=
on is ambiguous\n",
> > > > +                                     ext->name);
> > > > +                     break;
> > > > +             }
> > > > +             ext->is_set =3D true;
> > > > +             ext->ksym.addr =3D q.sym_addr;
> > > > +             pr_debug("extern (ksym) '%s': resolved in kernel to 0=
x%llx\n",
> > > > +                      ext->name, ext->ksym.addr);
> > > > +     }
> > > > +     close(fd);
> > > > +     return err;
> > > > +}
> > > > +
> > > > +static int bpf_object__resolve_typeless_ksyms(struct bpf_object *o=
bj)
> > > >  {
> > > > +     int err;
> > > > +
> > > > +     err =3D bpf_object__query_ksyms(obj);
> > >
> > > hi,
> > > we could also add similar support for libbpf_available_kallsyms_parse=
 and
> > > probably in some other places like bpf_get_ksyms.. which makes me thi=
nk it
> > > could be useful to have KALLSYMS_QUERY support for multiple symbols
> > >
> > > thanks,
> > > jirka
> > >
> >
> > Thanks for lookiing over this Jiri!
> >
> > Using KALLSYMS_QUERY for libbpf_available_kallsyms_parse() would
> > theoretically by O(m*log(n)) instead of O(n*log(m)), where m is the
> > number of tracefs symbols, and n is lines in kallsyms, with n >> m.
> > But AFAICT, libbpf_available_kallsyms_parse() would only be called in
> > pre-6.5 kernels, for kernels without commit 83f74441 (ftrace: Show all
> > functions with addresses in available_filter_functions_addrs); so this
> > ioctl could never be called.
>
> Isn't that code also O(n*log(m)) ?

Yes, sorry maybe I wasn't clear before, but the current code is
O(n*log(m)), and the ioctl approach would be better since it's m
lookups of O(log(n)) for vmlinux symbols, where n >> m. However, this
is a red herring because that path only runs on pre-6.5 kernels, which
won't have this ioctl.

> I've got a patch (I might send it after the merge window) that changes
> one of the ftrace functions to look up every symbol by name, not just
> when only asked to look up one.
> It can also use the 'callback' function to detect duplicates.
> That should be massively faster - especially with my ~18 fold improvement
> (also waiting for the merge window to end before posting a new
> (not much changed) version).

Excellent, I'll keep an eye out for it!

> Does look the the code could do with getting the 'symbol name table index=
'
> for the symbol so that it can read the entries sequentially from that
> point onwards.
>
> David
>
> >
> > And regarding bpf_get_ksyms(), it loads all traceable functions and
> > needs the full syms table, so a /proc/kallsyms should fits better.
> >
> > I did profile a slightly different form of querying multiple symbols
> > at once [1], but didn't see much benefit. struct kallsyms_query is
> > extensible via size and query_flags, so we can update in the future as
> > needed.
> >
> > [1]: https://lore.kernel.org/all/CAG2KctozPSev+EXSpHitM3JWfjufQaEjsPJHS=
_1HJ1wSm7sJ1w@mail.gmail.com/
> >
> > [...]
> >
>
