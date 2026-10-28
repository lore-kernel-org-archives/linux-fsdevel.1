Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793196092;
	b=S/F6Rc1PGHnNPKgTK1lbTXfSfuBD/Z8EpVmkxZq856p078qszKSz3QDqOtxyjuWWyjH8
	 /q1Z3zwmm+VQm9y1m8qq2xHQjmt0sZlQWi3Am6HqDi6X5y+2H8fejqJKHB4OlSzxKQltX
	 eFyCrTqNy49vc4AQxQa8ffe32g6MycUKajogNjumacjixvc+gQvEoYz/LyQw8+SSoCLmQ
	 Ynuas46P+WqarYVFGWnERnZywhbSxtiK/9cR3h0aX222hNM8s0NQsfsQueDIvYKq0do9l
	 tfhCl9cDkflx9hMq7aVlT/VXXTTGW07obdiIIk5u8Ge212PGy1OoeAxmq14piAp2yYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793196092;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=SyqHXLptMiWk+aCTehkHAqNtA/ZhM3lq7X8/7qWdG8M=;
	b=w2zibwPnSsQKCLTLecWziX7aDxZBJfo9CA7lfdjvXhFX8pAR8vW7hsTNRVeq0iuiBjjH
	 snF9VPXhN1KwQUslPtjfeENrXFV+8WwqoaHjPNopkvOKbsEebp7BQVlP6B1oeaVUZdZWR
	 Zv+nFi6Zy2vX31frbfvtOdLY1+yGRNAa7yMboE5VipPKX8TdoEBJmw5heAJL6lGEx/kzX
	 B1DVfqc6FGpXv1RpeRKayl25X6FeHdLq8l+3SUBD+bI9+QiBE3qsEPRjQr0pbCAMXnHEu
	 pG/Zr7xxRH19lxMO+4wrsmPTyXZ/fbYZjG8J1q3/Pf80OdjnjbMb5v1FV7J513qXFxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C+Avdvfv;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF81A606A320
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 14:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF81A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C+Avdvfv
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so11108415e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 07:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793196090; x=1793800890; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SyqHXLptMiWk+aCTehkHAqNtA/ZhM3lq7X8/7qWdG8M=;
        b=C+AvdvfvOS6eZqnIPGcHHA6edwh215Q6BYf6rpPcMrZGP4WZWdun+wsy3jEWahcGrq
         9iIH3D3gvwx3zERKa61VhoEFGdYVzxNgssZAFryfXY+B2HuXgqghRpnvugie9X5WiCA5
         4hV+U6mC4H+xZVw+x8nzdzRes9Cpk+4ayaaCM3InxToAAySusdVxigJDUc1SUxRYKyjY
         mOgHjphdjDJfa9OB8tRgy0mhuNJdpX7ZiWBy98eOZHQQ1s3wf1T18gieMWXmMJ4QwdAu
         mK02yU8AWERDQyU8WcOeA12odTUGEIruRJahl959etQ2dsYyUNaN3KgI8CiQr3EeibAv
         B6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793196090; x=1793800890;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SyqHXLptMiWk+aCTehkHAqNtA/ZhM3lq7X8/7qWdG8M=;
        b=FVIs227MC1HTkkvle53hwo+sZcyuv5JzA9CGhwVpHANROs2IwwIvhpt2OkUaLUiFR6
         ScjwlLWV2AT9FQQ0vWVOIunYGB3HJ9x727jOIQI6JnXD6eIXskLCRYxPHMuRuP22bJqE
         SQakbRGo4GlUa+Gu6g01QSCAkpyLpdSvV5OlYn5xTQe7E13ehP3yxx1VG4U7AO0fokHN
         6XVpp3J3FHgvo75JnVQZVbgUUwQvjkumpgPUM0DgLEdjpZuRep/xGqbUTdA0wdbkHWVD
         TWcxz5miVI9HcwLNUlFW+MdVJ1vLAQRljYEmS6+cTuaWhKWNnjCeZkBCPUmHLaqBU+hq
         MYjQ==
X-Forwarded-Encrypted: i=1; AKwUvBwmmO8vbmN6rwJvf5mgooSdpSgJoOBjyAec9YVImL7UIMlqWF2DQGV/Er6pzJGzjcyzqCeh6sYYAlDJXMry@vger.kernel.org
X-Gm-Message-State: AFq9FYIgH9M8OIdq5gFMSpgJz3hwPn26CBdf4uRgbCuScv11+1olNaI8
	nGn1ks500OJeUJ4TqSgOjwlhFT+UfO4B1FZemzQxz6TGWcbuIpaKf7h/
X-Gm-Gg: AYBFou3LdBbpwkpTTTQGwcZgP1dDbqgJxYQJdhUzq+Mk6A8HcMhr+6iyHQcT2xQF4Jx
	THV/U6zuEA3/eMN8Q5ZEyEMSD5qozLBCtSxcnIW4gtj6xgoJEVnPZDy0eZ/uTpHxHEiXX0svb38
	KE0prKN4cgrYJXxbbUqwGYd539L32i9WkXLAHRyVW47HTzC3gQfOmUAhaXzROBRt7fcaIrZgV5b
	86ALpoPX5Vf1NqHaOTTdn2nlHxtZ8tnQSJf1Lx8wv4eM2b+dyPwQnYOHuVC3KkVYdwBOkx2s9qf
	KPLd1V9SRrc4tBOSrSDE8B5/eP5TgVnCj113BdCsa3U0QfeNy7hRVOV2Om1WhJn9Zt1mKbDrK7x
	IimjTD5DbgaJ8IqGme04aRqbe470HW00F9CQCazxWbpNf7wXp6eOOJaKF3WmL6l8Uae/ih/vrqk
	+a9M++aYpwrAC2EyYIwxHQ4cAQDBom/hYoRY336btPwwOmrKaZbVeRoDvCZXpzZ0o+WrJg3d3Gn
	azV2BbnsI6WaeFJMd5t10PHu65YL11QR50D4z59NQbyV8FhjqcxnfRUyfGN4BA05AbzUPU8nKNn
	zmzo85TKe/nlCYso5kBTUZy91rw4INiSZGsn8rrOI8zOJVd7xQYGzcskZ1J1ETc0kg==
X-Received: by 2002:a05:600c:630e:b0:4a6:7d6:821f with SMTP id 5b1f17b1804b1-4a9678bff9cmr50385655e9.29.1793196089864;
        Wed, 28 Oct 2026 07:01:29 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd4d8dsm30164106f8f.36.2026.10.28.07.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 07:01:28 -0700 (PDT)
Date: Wed, 28 Oct 2026 14:01:27 +0000
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
Message-ID: <20261028140127.7bfeab46@pumpkin>
In-Reply-To: <CAG2KctpMEuK5OJSedSFshNMSwOqe1g87m2ZOKBhn=Z5iCA45Aw@mail.gmail.com>
References: <20261023001603.560210-8-wusamuel@google.com>
	<20261023001603.560210-12-wusamuel@google.com>
	<at8dNNb4vwovNZcZ@krava>
	<CAG2KctpMEuK5OJSedSFshNMSwOqe1g87m2ZOKBhn=Z5iCA45Aw@mail.gmail.com>
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

On Tue, 27 Oct 2026 15:07:44 -0700
Samuel Wu <wusamuel@google.com> wrote:

> On Mon, Oct 26, 2026 at 2:28=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wr=
ote:
> >
> > On Thu, Oct 22, 2026 at 05:16:05PM -0700, Samuel Wu wrote:
> >
> > SNIP
> > =20
> > > +static int bpf_object__query_ksyms(struct bpf_object *obj)
> > > +{
> > > +     struct kallsyms_query q;
> > > +     struct extern_desc *ext;
> > > +     int err =3D 0;
> > > +     int fd;
> > > +     int i;
> > > +
> > > +     fd =3D open("/proc/kallsyms", O_RDONLY | O_CLOEXEC);
> > > +     if (fd < 0)
> > > +             return -errno;
> > > +
> > > +     for (i =3D 0; i < obj->nr_extern; i++) {
> > > +             ext =3D &obj->externs[i];
> > > +             if (ext->type !=3D EXT_KSYM || ext->ksym.type_id)
> > > +                     continue;
> > > +
> > > +             q =3D (struct kallsyms_query){
> > > +                     .size =3D sizeof(q),
> > > +                     .query_flags =3D KALLSYMS_QUERY_BY_SYMBOL,
> > > +                     .sym_name_addr =3D ptr_to_u64(ext->name),
> > > +             };
> > > +
> > > +                     err =3D -errno;
> > > +                     if (err =3D=3D -ENOENT) {
> > > +                             err =3D 0;
> > > +                             continue;
> > > +                     }
> > > +                     if (err =3D=3D -EADDRNOTAVAIL)
> > > +                             pr_warn("extern (ksym) '%s': resolution=
 is ambiguous\n",
> > > +                                     ext->name);
> > > +                     break;
> > > +             }
> > > +             ext->is_set =3D true;
> > > +             ext->ksym.addr =3D q.sym_addr;
> > > +             pr_debug("extern (ksym) '%s': resolved in kernel to 0x%=
llx\n",
> > > +                      ext->name, ext->ksym.addr);
> > > +     }
> > > +     close(fd);
> > > +     return err;
> > > +}
> > > +
> > > +static int bpf_object__resolve_typeless_ksyms(struct bpf_object *obj)
> > >  {
> > > +     int err;
> > > +
> > > +     err =3D bpf_object__query_ksyms(obj); =20
> >
> > hi,
> > we could also add similar support for libbpf_available_kallsyms_parse a=
nd
> > probably in some other places like bpf_get_ksyms.. which makes me think=
 it
> > could be useful to have KALLSYMS_QUERY support for multiple symbols
> >
> > thanks,
> > jirka
> > =20
>=20
> Thanks for lookiing over this Jiri!
>=20
> Using KALLSYMS_QUERY for libbpf_available_kallsyms_parse() would
> theoretically by O(m*log(n)) instead of O(n*log(m)), where m is the
> number of tracefs symbols, and n is lines in kallsyms, with n >> m.
> But AFAICT, libbpf_available_kallsyms_parse() would only be called in
> pre-6.5 kernels, for kernels without commit 83f74441 (ftrace: Show all
> functions with addresses in available_filter_functions_addrs); so this
> ioctl could never be called.

Isn't that code also O(n*log(m)) ?
I've got a patch (I might send it after the merge window) that changes
one of the ftrace functions to look up every symbol by name, not just
when only asked to look up one.
It can also use the 'callback' function to detect duplicates.
That should be massively faster - especially with my ~18 fold improvement
(also waiting for the merge window to end before posting a new
(not much changed) version).

Does look the the code could do with getting the 'symbol name table index'
for the symbol so that it can read the entries sequentially from that
point onwards.

David

>=20
> And regarding bpf_get_ksyms(), it loads all traceable functions and
> needs the full syms table, so a /proc/kallsyms should fits better.
>=20
> I did profile a slightly different form of querying multiple symbols
> at once [1], but didn't see much benefit. struct kallsyms_query is
> extensible via size and query_flags, so we can update in the future as
> needed.
>=20
> [1]: https://lore.kernel.org/all/CAG2KctozPSev+EXSpHitM3JWfjufQaEjsPJHS_1=
HJ1wSm7sJ1w@mail.gmail.com/
>=20
> [...]
>=20

