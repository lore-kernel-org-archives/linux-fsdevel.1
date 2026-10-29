Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793313228;
	b=4X61WYiyPcRe6QUw+2epISrZnYxjYlSEqcJSW3wPmdPUQLRp2wS4bN4XAqDcp45pkBsO
	 gJhM8f+0sZHMiRGN859rKS4NAOz+iOP3/Z03DEQvtBnByNYzrtR7I2wjXO8HvdWhpTGLU
	 FYxtk9gLDAxtq3OYPrc8v38pL7agSRlpnHWm++zH+AIrYDa+jpEmdlj9XMxRW5PMAqd3L
	 xekeaZ12N+WzktOU7kXAbEyDEKNJdkriaZK0qqas7cZuFflQGGfI2Opft2YLo7FeHsSV2
	 RoVTb8Wleu6GP3ifSmyhF5MLY9W8SRAlmXo82Zzy5yf4o9IslViOuI8OLRfmreJrx5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793313228;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2C16if6DY4JWsOG2lgpyOm+rUUE2AWwmlNktllWtOWQ=;
	b=xfqbywPcGOaowlWNdZgWUuO3dRPpV4MumEV1fkjmq0L25UL4CYiBLxzerR+ebTFyOYu5
	 Gt+ZwjgJdumNrmtCJYOYfPipKQOVLhY1Ru+JHD7HMpHOHpr2iP7yP8i0/wIFqCRaek019
	 ZN0MhmStVoeDaZdKJhIHKw9Wbl7NoQXh7ZT2SmzDmFv2RINy7CSZyl/tf97O4zcD3id4n
	 BjoA2EOfkmKCUoR84cl+LhEmpe0JS5RqGhmn/UjYfyHnuYV+pVGvnvbSw1MZYq4Xaulkd
	 fv8cbc8TmAoxxgFD4Myz8RyxXy4l5u9bKNiTkhTdLT9RrvSnpU3ShPf5kqvc+PYFctg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="t/bNGN/n";
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24012606A326
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 22:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24012606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t/bNGN/n
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so1200525e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 15:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793313226; x=1793918026; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2C16if6DY4JWsOG2lgpyOm+rUUE2AWwmlNktllWtOWQ=;
        b=t/bNGN/ntazoGXxm7cEZZ+GwsGGsVh+C/0Yut+b49ElxU09W4nXbv1RAqNfYKvcJHq
         gOGys9TQp9AY0Af1UtWfeQ94USgYjsksf7rqxv43aOs4K/6L4QwE/YkFsmJPISOhN3Ib
         /nbmG8zYiEi8kSCiQybCdUzIBXmdKKb6/yNOgeJ/0pNXqt7/CSdeVO2Q2JdQCILUuTF7
         qwCtWsvbTtAAjeMV4A4cwc8R16QkWvQsJ/IU6Cz0mRo6BSolCCS4gHWpxoa7KDLD3O0t
         uVtXEeLvOC1hcynSXlCTgEgiaRd5A1TtFFfR21YrZO4HhQE0tjgHG9m1BJNgGd0EVTZp
         VZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793313226; x=1793918026;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2C16if6DY4JWsOG2lgpyOm+rUUE2AWwmlNktllWtOWQ=;
        b=0uTAyV4EQbpG3y3EkuSc1aKnmo5fbH14peBry0Ppk2REaMXs0wUwCaycshcmsOiy8O
         UPgvPtDb8XYAKJ0Pz2ubjtDkMZhZJYZwVi7UXHUvFsQF50zZLZlsUQzHpUzDlW2pWXCv
         kKkxLFJtWfwHWMT5D8V+XR0y541OJA1TRYUaOd5B4hhtJdoRQvafchWOcYctCiJy9zs5
         uoat9i/Ek8CVybzCHrHO8/Pw7tMcNgV6wHfZJd3wTwvQhWXDGZK5gl2V+l0f2Az/la+E
         g3LJ5NgIQHgjpMwiB2nu8zbEfJzw2AY74ky5uEViCl/FvwquC+sU7nnewFoviyV1y8bs
         nlyA==
X-Forwarded-Encrypted: i=1; AKwUvBxZtHAL7TGf0BqIcu/3t3YhgJEtMS77DlilbvHVmb2lA8KeSwPCsRvkaGqCHtuDfQVpj4t2HFeZ+WiEKL8g@vger.kernel.org
X-Gm-Message-State: AFq9FYJdFjiJpcWBixT/DaO+R0qODLbEB/ATjEcw9FsVUduSr3ZTTPDa
	oAlXB++Ved6AEWLDjF2bV3nT2g/P4nh8STr9g0PvihU/OFKzjYbXckOOPiaKUqNQ
X-Gm-Gg: AYBFou309o+kY4ctQ0N065tkM41LwxnMTvmdQCBSHzTOJrG9V4hBZ8rLht23wCiPtpV
	DaNQlvJ3WQuQ2IXgWKIZ3uRi9KQ/ZQ8TwrAjZzzuq+YmGAe3W+AYYHjJW23wlI95JfcyAC2RPRN
	C7gvRXf3csU0QJjS6gRsT9gN1mZqJJ/KYsgZOR+eJURVbN27YbkUwwFYL7YWMxE+bFFOARc5KCD
	EA5aGj87F3jPmKXshYKOWmu7ckWW/g3LGmfZcfn+Z1ld9Ce4XMhB4XJYcYV0jPtnf5WIcuUaT/0
	KFapkfIALp6GjY7eA1eHDIFiFKtLc90zQ6sh0U7MvHH8rZg3/MMvuw1EqOlhWKbpqitKJAoWQIc
	SyGQlaVlJoaSkOPGA/Fep+JYBl1aUMedqIguri9FhNRLtg72yO+giWSQr6ig1KTpV3h5Fp+/+jO
	+EIOnOyc1OKmbe2Ajl58vMa8o1VBZd4d7tYDjXiAwPJvcsM0kU4+7oh3J0+Fl7lmH5rKomwQ0GP
	pvzBUAE3DBtn7rBGc7nqLCL5UK9OsA8PveSBhs1KXxIdTPZrXvE00ZuIOusrZW/RQXnLOSYzVh5
	7zPhDQrN0EAxfPrm/V2oj5RfvV9ue7eDVCmNPLK1/jgnhJXzo7VZTArcPCsDiN+CjFy67CKKODC
	jGUbsqOUYuEM=
X-Received: by 2002:a05:600c:4687:b0:4a2:10f9:37db with SMTP id 5b1f17b1804b1-4ac16fa4dadmr7994095e9.7.1793313226338;
        Thu, 29 Oct 2026 15:33:46 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f3229dbsm91077035e9.1.2026.10.29.15.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:33:46 -0700 (PDT)
Date: Thu, 29 Oct 2026 22:33:44 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Samuel Wu <wusamuel@google.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Emil Tsalapatis
 <emil@etsalapatis.com>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH bpf-next v2 4/6] libbpf: Resolve typeless ksyms via
 KALLSYMS_QUERY ioctl
Message-ID: <20261029223344.5dbe60d5@pumpkin>
In-Reply-To: <CAG2Kctra0GYjkzggB0cdMxPK-b9U9x-m+gR6E8goAYvhsNXEdA@mail.gmail.com>
References: <20261023001603.560210-8-wusamuel@google.com>
	<20261023001603.560210-12-wusamuel@google.com>
	<at8dNNb4vwovNZcZ@krava>
	<CAG2KctpMEuK5OJSedSFshNMSwOqe1g87m2ZOKBhn=Z5iCA45Aw@mail.gmail.com>
	<20261028140127.7bfeab46@pumpkin>
	<CAG2Kctra0GYjkzggB0cdMxPK-b9U9x-m+gR6E8goAYvhsNXEdA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Oct 2026 14:35:36 -0700
Samuel Wu <wusamuel@google.com> wrote:

> On Wed, Oct 28, 2026 at 7:01=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Tue, 27 Oct 2026 15:07:44 -0700
> > Samuel Wu <wusamuel@google.com> wrote:
> > =20
> > > On Mon, Oct 26, 2026 at 2:28=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com=
> wrote: =20
> > > >
> > > > On Thu, Oct 22, 2026 at 05:16:05PM -0700, Samuel Wu wrote:
> > > >
> > > > SNIP
> > > > =20
> > > > > +static int bpf_object__query_ksyms(struct bpf_object *obj)
> > > > > +{
> > > > > +     struct kallsyms_query q;
> > > > > +     struct extern_desc *ext;
> > > > > +     int err =3D 0;
> > > > > +     int fd;
> > > > > +     int i;
> > > > > +
> > > > > +     fd =3D open("/proc/kallsyms", O_RDONLY | O_CLOEXEC);
> > > > > +     if (fd < 0)
> > > > > +             return -errno;
> > > > > +
> > > > > +     for (i =3D 0; i < obj->nr_extern; i++) {
> > > > > +             ext =3D &obj->externs[i];
> > > > > +             if (ext->type !=3D EXT_KSYM || ext->ksym.type_id)
> > > > > +                     continue;
> > > > > +
> > > > > +             q =3D (struct kallsyms_query){
> > > > > +                     .size =3D sizeof(q),
> > > > > +                     .query_flags =3D KALLSYMS_QUERY_BY_SYMBOL,
> > > > > +                     .sym_name_addr =3D ptr_to_u64(ext->name),
> > > > > +             };
> > > > > +
> > > > > +                     err =3D -errno;
> > > > > +                     if (err =3D=3D -ENOENT) {
> > > > > +                             err =3D 0;
> > > > > +                             continue;
> > > > > +                     }
> > > > > +                     if (err =3D=3D -EADDRNOTAVAIL)
> > > > > +                             pr_warn("extern (ksym) '%s': resolu=
tion is ambiguous\n",
> > > > > +                                     ext->name);
> > > > > +                     break;
> > > > > +             }
> > > > > +             ext->is_set =3D true;
> > > > > +             ext->ksym.addr =3D q.sym_addr;
> > > > > +             pr_debug("extern (ksym) '%s': resolved in kernel to=
 0x%llx\n",
> > > > > +                      ext->name, ext->ksym.addr);
> > > > > +     }
> > > > > +     close(fd);
> > > > > +     return err;
> > > > > +}
> > > > > +
> > > > > +static int bpf_object__resolve_typeless_ksyms(struct bpf_object =
*obj)
> > > > >  {
> > > > > +     int err;
> > > > > +
> > > > > +     err =3D bpf_object__query_ksyms(obj); =20
> > > >
> > > > hi,
> > > > we could also add similar support for libbpf_available_kallsyms_par=
se and
> > > > probably in some other places like bpf_get_ksyms.. which makes me t=
hink it
> > > > could be useful to have KALLSYMS_QUERY support for multiple symbols
> > > >
> > > > thanks,
> > > > jirka
> > > > =20
> > >
> > > Thanks for lookiing over this Jiri!
> > >
> > > Using KALLSYMS_QUERY for libbpf_available_kallsyms_parse() would
> > > theoretically by O(m*log(n)) instead of O(n*log(m)), where m is the
> > > number of tracefs symbols, and n is lines in kallsyms, with n >> m.
> > > But AFAICT, libbpf_available_kallsyms_parse() would only be called in
> > > pre-6.5 kernels, for kernels without commit 83f74441 (ftrace: Show all
> > > functions with addresses in available_filter_functions_addrs); so this
> > > ioctl could never be called. =20
> >
> > Isn't that code also O(n*log(m)) ? =20
>=20
> Yes, sorry maybe I wasn't clear before, but the current code is
> O(n*log(m)), and the ioctl approach would be better since it's m
> lookups of O(log(n)) for vmlinux symbols, where n >> m. However, this
> is a red herring because that path only runs on pre-6.5 kernels, which
> won't have this ioctl.

I was thinking of the ftrace_lookup_symbols() code (called from
bbf_kprobe_multi_link_attach) which O(n*log(m)) (the wrong way around).

David

>=20
> > I've got a patch (I might send it after the merge window) that changes
> > one of the ftrace functions to look up every symbol by name, not just
> > when only asked to look up one.
> > It can also use the 'callback' function to detect duplicates.
> > That should be massively faster - especially with my ~18 fold improveme=
nt
> > (also waiting for the merge window to end before posting a new
> > (not much changed) version). =20
>=20
> Excellent, I'll keep an eye out for it!
>=20
> > Does look the the code could do with getting the 'symbol name table ind=
ex'
> > for the symbol so that it can read the entries sequentially from that
> > point onwards.
> >
> > David
> > =20
> > >
> > > And regarding bpf_get_ksyms(), it loads all traceable functions and
> > > needs the full syms table, so a /proc/kallsyms should fits better.
> > >
> > > I did profile a slightly different form of querying multiple symbols
> > > at once [1], but didn't see much benefit. struct kallsyms_query is
> > > extensible via size and query_flags, so we can update in the future as
> > > needed.
> > >
> > > [1]: https://lore.kernel.org/all/CAG2KctozPSev+EXSpHitM3JWfjufQaEjsPJ=
HS_1HJ1wSm7sJ1w@mail.gmail.com/
> > >
> > > [...]
> > > =20
> > =20

