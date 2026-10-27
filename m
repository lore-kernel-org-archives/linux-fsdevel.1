Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793138878;
	b=rJ9YsY2LqaM3zWaIBroXKddEsGDNoRQH82pZle3TPlGIScjJToCC1pZVIu5TOESLEnCJ
	 p1Tb3aCZJhctsMsb1SEGvKLAxiT5mGikUdwG/+Y9Q49AnofNTKVTBQvb74pWLeBayhmIy
	 b2bh2VAHrIVlOancuJgpu6BoSy5+bh2/UpC8wfevb0i/qEd0Tc+a7QITAvVYuprlHN9nH
	 VLuqUHlM5qSovU+FGadXfsfsNRzSBq19+Xj2fn9yqZRfW8mpqmyAoDpLdxrQ+wCKsl8sq
	 K1fOdRFlNNw1MFmih4dI1UNBotFFsfXLSUVvLhbfa+020c0K04YhpC0EWfkRuG73lqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793138878;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Ca2YyfdF81F97G9Km6YN3E8m5/e8rC9hjJrfVgW4DSM=;
	b=tFDtIFKpH7Mk/0Wn50g5ZOMzMm+jMl4p0lr3JbFK47zokvXgath9+qbVuKsB8IjLA/eG
	 hfAfrBzu+8i8vPvECcwzc60Mevbhdx5AvKvA6eQ8pFwkPyOiWjmEJMAWwqST0g5hcTwdX
	 4RzSzyPnCx15WoC1KyvMAxpCjw/WNz8Tz84UuBNyUnNJL3JwqmL8CaZoPro664awkYwjb
	 ++V3qdyCq0Do1xiGMHaIm4+h6fywpVcGO/8/2AtKhS3cAnFIXPmy45JivwikLSrNSMAxH
	 LsH6XKVL0idZgvc58J6F9WOWp3PkmJZkhDP/xACRhgsJOd38pFSZQvtC6RplsrhSRbQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JndHwKJi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF002606A31D
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 22:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF002606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JndHwKJi
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c169ae1cb26so225467366b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 15:07:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793138876; cv=none;
        d=google.com; s=arc-20260327;
        b=S3OmUWpyBOX9zfLvGdc4BF55KOOT+IDqcdl/aTgCZ1Ir5W8O0lSgfPQGkwpY9gHgxs
         XETr/seGjXiSrGQ4qXkx8Z5o5l98R/X1qGoQEYWOhOFoVe76J0EfGMQSamOB7oaqS8Qs
         llGUSsLJBvYkQ858ipe1E8st8ISWj6tkKtGZp31L9mHVM2dHgyAQcCqME/aZCXmfj+h8
         PCgVQ0Sb1Sk8V8+542uRmZLU28r1KeLtaCYqNwzDGqgm6RjEdAwelVmlVQ1itBOzdy/B
         OO1N+kWn1l8k3b9jXz6B2LHxotu/eXRZFrkx4Wth7I2M2jhUeTt3+M2HShjFi/0xOa21
         VCZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ca2YyfdF81F97G9Km6YN3E8m5/e8rC9hjJrfVgW4DSM=;
        fh=Y3JAl0XzPwE2zj4EcOUEhyQ3iOkaU2Me9YFBC1Ejnf0=;
        b=abRCYU7HWbJzBUHcwwAYTxpoAV9cWLl1r4LfCRddtMx9dVjW8mujedGQJvvt9s3uLs
         PCYkdsh317ncg1sIeH5q8P34xzcQKE3krS4kYm64rrewPOkJL4RCa3xzQN/SC3P6IvGG
         inxltoyAKhNeL7n2S3luRzUQ+qoKFdBRvxmSPmBH2xYVK1Sj35amAqT9h73yDD96QqQb
         Kvsi2PEDUpBK6CBGNUfu5NAOoaJl5lWVquoh9G7QViz8AQLstrBXthB+PEbIg9Gl4piH
         hAIfC+U19HIEoPwqxLxR6ExwheUx7J2oAoWu71/S6iB0UFY9+vpuvvq4pzpGdvJi7pEs
         z1BA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793138876; x=1793743676; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ca2YyfdF81F97G9Km6YN3E8m5/e8rC9hjJrfVgW4DSM=;
        b=JndHwKJiqoQdimfnFC/tOH0NOP9CxQKxSiHFIN7R0ytrfsF1otC25j8OT21ypOBaw0
         SeH274c5gs94bjO0YMSWpQNXnGDmaTecGn12SItZKlKn2t20O71XSnnuJyjslHTVxzrE
         aAuZ1VDMdN0s8JEith1PGtfJvP5bQ3t6fw0A06t14GU6kC17bHFf55OjmQW375eIxizr
         i2JTJ5g1ClaP/isCuqEeFHpCWCC9L8W2JDWntColXyJVJbpXJhsN0FnMsx/BvsZ43C79
         9prCEcfErHTtXqtmR20XD7L0Eg4tfpbIY/LNsw94YqE/9dDt2m4t1kDcuTu9qRDguQ/g
         fS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793138876; x=1793743676;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ca2YyfdF81F97G9Km6YN3E8m5/e8rC9hjJrfVgW4DSM=;
        b=H1GSSVMitlZqGSwqmuJuG/p0JRHRFeZRSEKiI2hHcr05Br+/pkGRGChfNPyp3jCZUk
         W8DVn0+e7Enn3DShljtCJt50MygN85LOXqHix8YWAgyQx2KlXUyjcvL4/vLtDbZR8IL+
         sJEvHWpzJ0xs8H+b8jBfEHCXI/k8REHbvy3eHo0ZshH+L2Goybml+GluTCs42/EfyJlf
         65zowWNY31vtazRM5hJI0RGQ7+ObaaPhS3p2DFI/7+XIhQhKpsCE7W1G8bSAVKq3eGmC
         tMqARhzUs/KkI70YgAV2KzAz/qiwEbDyrAyYU/6Qnwvfw9C4Hp7TipMzilhEoF7S2bm/
         OPLw==
X-Forwarded-Encrypted: i=1; AKwUvBwBdRH3KTpujrOhpmYpeBvBEWD23QitsWzDGWp0yy+7A2q49m1xYTSMVqsuXX3NNXV95XILfaH8epqtzvjf@vger.kernel.org
X-Gm-Message-State: AFq9FYJOptAwIj9r36xmOnSLiDR8C5h6+QYSIAMu+Dn5d7A4m+RoKeGO
	Q2UB0+ZNw08c1FV6DR+Ycvjf8DhKZKYMlfc6hw+qmAQdUhJwuDk3wWpW2eMYRa9FBzHx1K5trtG
	Q+2bBPuzyVo+3DbssKrijhNMKWmIZJumH5AraKz13
X-Gm-Gg: AYBFou3G/ksyH4wcjOyFo6zXojthmZBizmu9GSSML7Da/pnGSjORROHWpPuuvJtM6gS
	3dE1146Q4GhglzDMHjIZUgouLRxfphOtq5LvmBSxwX0RdZI6EAZmCAGATVyGLKt1vorgQqCOsqF
	XR+O0ZFwFBUGwaJx2I+KZXUNNFkEx0Qe850fpOSZFOvtXY4/3Ij60J7nIPCtG40a/u+FQCKw672
	SAQZLOHq0WU/idDuf58vAgbf216dS4JT36VkkgjUp2hS5G1aYye2X0bzBWiDo+ZfVzkVSCzpibg
	IPH0Pe/7wLN/QNxRSi7aiQ8NuQU4bkiiSgiE2Vu2uQOD2fJl+IovX04exbcSWFjYDMX4+kjspXt
	xc3mCDTAtEybzKfiGsEuDLQuPXCSjCLHYTsiS9lGFR4b96faQ8Lka32Dc5iwH1qgyHANXMB7pAh
	PqT+Rfykci/RU7
X-Received: by 2002:a17:907:97d5:b0:c2d:c80e:8366 with SMTP id
 a640c23a62f3a-c49bd9e20e9mr50496066b.0.1793138875790; Tue, 27 Oct 2026
 15:07:55 -0700 (PDT)
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
 <at8dNNb4vwovNZcZ@krava>
In-Reply-To: <at8dNNb4vwovNZcZ@krava>
From: Samuel Wu <wusamuel@google.com>
Date: Tue, 27 Oct 2026 15:07:44 -0700
X-Gm-Features: AclHuK_4ySi3E2heiJLIOqDTOIX20dmWcYWcaizjPHfB4zOsCZlZ7RMy9jhhzuA
Message-ID: <CAG2KctpMEuK5OJSedSFshNMSwOqe1g87m2ZOKBhn=Z5iCA45Aw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/6] libbpf: Resolve typeless ksyms via
 KALLSYMS_QUERY ioctl
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 2:28=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Oct 22, 2026 at 05:16:05PM -0700, Samuel Wu wrote:
>
> SNIP
>
> > +static int bpf_object__query_ksyms(struct bpf_object *obj)
> > +{
> > +     struct kallsyms_query q;
> > +     struct extern_desc *ext;
> > +     int err =3D 0;
> > +     int fd;
> > +     int i;
> > +
> > +     fd =3D open("/proc/kallsyms", O_RDONLY | O_CLOEXEC);
> > +     if (fd < 0)
> > +             return -errno;
> > +
> > +     for (i =3D 0; i < obj->nr_extern; i++) {
> > +             ext =3D &obj->externs[i];
> > +             if (ext->type !=3D EXT_KSYM || ext->ksym.type_id)
> > +                     continue;
> > +
> > +             q =3D (struct kallsyms_query){
> > +                     .size =3D sizeof(q),
> > +                     .query_flags =3D KALLSYMS_QUERY_BY_SYMBOL,
> > +                     .sym_name_addr =3D ptr_to_u64(ext->name),
> > +             };
> > +
> > +                     err =3D -errno;
> > +                     if (err =3D=3D -ENOENT) {
> > +                             err =3D 0;
> > +                             continue;
> > +                     }
> > +                     if (err =3D=3D -EADDRNOTAVAIL)
> > +                             pr_warn("extern (ksym) '%s': resolution i=
s ambiguous\n",
> > +                                     ext->name);
> > +                     break;
> > +             }
> > +             ext->is_set =3D true;
> > +             ext->ksym.addr =3D q.sym_addr;
> > +             pr_debug("extern (ksym) '%s': resolved in kernel to 0x%ll=
x\n",
> > +                      ext->name, ext->ksym.addr);
> > +     }
> > +     close(fd);
> > +     return err;
> > +}
> > +
> > +static int bpf_object__resolve_typeless_ksyms(struct bpf_object *obj)
> >  {
> > +     int err;
> > +
> > +     err =3D bpf_object__query_ksyms(obj);
>
> hi,
> we could also add similar support for libbpf_available_kallsyms_parse and
> probably in some other places like bpf_get_ksyms.. which makes me think i=
t
> could be useful to have KALLSYMS_QUERY support for multiple symbols
>
> thanks,
> jirka
>

Thanks for lookiing over this Jiri!

Using KALLSYMS_QUERY for libbpf_available_kallsyms_parse() would
theoretically by O(m*log(n)) instead of O(n*log(m)), where m is the
number of tracefs symbols, and n is lines in kallsyms, with n >> m.
But AFAICT, libbpf_available_kallsyms_parse() would only be called in
pre-6.5 kernels, for kernels without commit 83f74441 (ftrace: Show all
functions with addresses in available_filter_functions_addrs); so this
ioctl could never be called.

And regarding bpf_get_ksyms(), it loads all traceable functions and
needs the full syms table, so a /proc/kallsyms should fits better.

I did profile a slightly different form of querying multiple symbols
at once [1], but didn't see much benefit. struct kallsyms_query is
extensible via size and query_flags, so we can update in the future as
needed.

[1]: https://lore.kernel.org/all/CAG2KctozPSev+EXSpHitM3JWfjufQaEjsPJHS_1HJ=
1wSm7sJ1w@mail.gmail.com/

[...]
