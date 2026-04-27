Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1578B258EC1
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 03:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777260251; cv=pass; b=kfsMNm2FA0oMsup5OzS1ULZ+VO11yMwKkvQIOvQftGMN7gBUCplhx/gw+VJKnAokledRyieLOhQDjpUj2y7Dnytl/PQbYMG1TBEt5BJ52nllwC2UUgyZUrpa3IMZDKP/TtoV8zKA2ayYf4qBnmI4qObfTF6Cft+wFGgisXBPPJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777260251; c=relaxed/simple;
	bh=5scMGizBEZQ+MRt1lEr1zuH+6NL7GMmtobGuYdV0JtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Clf3q03YlmcLTD7FYQdw8+/bkMGwV/+NtnUTiWQi5m4MaCieHc/H72TCO2EOOMWT2XsprapkqzYV15n4QLfuwijSzBSWVBw34miegpyBq7FbkvLW1V+olZThJ2n81xsICP3TGsMZentkGDk4ZrMTdMTRhTRlIy+ooNSuyLEXyro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNefJAuf; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNefJAuf"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50e97863425so72845031cf.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2026 20:24:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777260249; cv=none;
        d=google.com; s=arc-20240605;
        b=fwrxdI4P/M2T7NiTlsbope+f6R74rYBOi2zSFzXCgnL58Hu/3Qg6IKwZOv25n/f5Uq
         CYrVvBBVnSnksqENTKzpjY6Q4GaodJqEf1UgfD/E+Ks7P/uusi2J4RPFvQOMx3OzyMdX
         ws2QimXhJHqnRD9JwUL1rL4mdVVd1i9Y7WKqePowkO9JH2eElSHnjdE826vMQ3Ibu09j
         2xNBIj1JXbLw7y7nWj1PXkXjbkt9jNA0EdIfaA6oCY3lnizZsKWZEii7Bz7UeYNGZO0j
         Uot/ZhGmFXbVBp9L0gY3ahCCDP57IdiAGxtNx9vGPuIrVP2FanIkmTRKAUPLLynwcRJ6
         e7sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2zE68H0RpKyKb+UxxWIY0vid0AEaBVY0DBcP4n4sG7w=;
        fh=+YZqLLrNZnSl9o4z1HmCLbJHmz3QXRMXhDotbcByjhE=;
        b=dqoI6tLODYVxo0sZYtnBJByeNPDd1CaLJn1VnXmh7yhuu2NZxJ7nb7WAaSmn1qfmTW
         3BD9lWpb2iL3aWOyfoWAOmPnrcd5kN4hySAZIei4SoVwebaw1SyqqjCBoIWOGybmxlwK
         GJE9ZA766tcd8JtU653nq/WttjA+7SbtpJ7A7u1wHA5IEBRghLhCF/8iG6xJullVGjRG
         gOG/3GBoR9vH5lCfB1aXBLbz+c8jFtlWotYvakR434LEczK/2xzGyosCr/ZpBkVpcO1k
         Gn10z9maOIxkFQmH/D09YwU0lpyuIz3VvK1oos9og2qtN7CiLOyZDUaZibWkVs8iuYbq
         eXmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777260249; x=1777865049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zE68H0RpKyKb+UxxWIY0vid0AEaBVY0DBcP4n4sG7w=;
        b=ZNefJAufyWGznw27IG/u0F3FYcP8TsMm3USawUoCjfR5T+l1F/1NEkjhSgvVKwyg2/
         VfHTz63Ur+sU67l870IFMK2bB+eqc6pVLKYKhfMWV77p0Ts7Qzpzz8Kvelf9hfETnR7l
         847n6nL3AuQzLErajeLlQh9jyLgBXDy63+97Z8m/ZqBrv2phit/G9Y0eQCzlulhQ5vja
         QcoH6gprOgVLQlma6Jyewdgs2SOR27H24qLLbe7WQ54rthMRDjgQ3o4rf9HCZSXZvNJb
         wsQPBrvg9Gk3sSKAWddauav3oTTSCPJtBHR8hxGrCnjgRXam9Pt+BRdQQIyFZPloxPKO
         nXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777260249; x=1777865049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2zE68H0RpKyKb+UxxWIY0vid0AEaBVY0DBcP4n4sG7w=;
        b=gJm5Sh65Blky3dcYIlajgVCOuuhAWOqTljgMSTexA53oGVXfhXtrKK51ukhxOspIIs
         rvBeGpTGJQ8PKZfQziNsYhcwnLRdXJIHux1/HWDRLT7eD90a9FDoPq7Zlldap74zCxQ2
         o+xLFrxzKGcwrQjnBmEItUDB67fC6hF5qG0PNBow7w2nR2kJ+CITbVfXbg6qU4qDNuHh
         IQTp3HkyYZoeG2bUfMaOBncRb/Bfuog75vnBPMzyrnXng661pFcN3EArNMQU74/9nD9v
         pkwmA0S9dzjvKUpNkgTNf9M/qpDrM78WFJ4Ny31U0MLH56uko7bz1JVa61wkW5RWZFnN
         LEuA==
X-Forwarded-Encrypted: i=1; AFNElJ9ekIc9EGAK/ZIKDy6S+PscVH9NdWUdRzp7LSvJ63AUJVYdK1N6gWg9cnmor1cpTqSadeJvwAu7RiEX8/mA@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+aN+bP+N7m4ZuWUwCKJZ7D9gjENjFUmmaZxVSc8HUbybvmDui
	VzlZVEMtKnZtVD1lFHwpxxMYmEgCZ+tNpjTtEVL1GhH6E9dc5lxiB5S3nrtsGsR6HcTjH3/FiPW
	8zDmkyTGLi4K137gYcHCVlltaf1v/VOI=
X-Gm-Gg: AeBDievvad3DJlBGZDr5UxEktXQLlnAl6BaR18v+0Je1rNUYhacuyL0uFBh6/YmCrEZ
	pOxX7nGmM+W69f+tywSAjWhCJztGb5M3fc9/4gHZKrspA7nakHdVnEvuNhck9i52uSPwwmQnz95
	XWmF/tqsUYx0cGoGSIrTCjGDfiHDMphwHVb4qnS9plM8QtSnB7MPX/LC5Hsgcd4Hmsogd5TcK9J
	VJ0wAkwTIbAfRVn4ROkRcjsvuk9HIei3NnAyGXGTfX/MiPPQdy2sOz8y5JdnyXPvPWuqKVR7bLv
	ysewVPPC3x0EgR16RJrnwEqzClkwMybw6K/iDKwqb/aJZ34VwxrFr2NcPm0htw==
X-Received: by 2002:ac8:7e82:0:b0:50f:c15d:3f65 with SMTP id
 d75a77b69052e-50fc15d4453mr321942841cf.1.1777260248936; Sun, 26 Apr 2026
 20:24:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427001602.38353-1-dwindsor@gmail.com> <20260427001602.38353-2-dwindsor@gmail.com>
 <CAP01T74iuSDJeL6g=5yLdYGb-VcESK1SYY3R1S1r-CtQEsW+oQ@mail.gmail.com>
In-Reply-To: <CAP01T74iuSDJeL6g=5yLdYGb-VcESK1SYY3R1S1r-CtQEsW+oQ@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Sun, 26 Apr 2026 23:23:56 -0400
X-Gm-Features: AVHnY4LNYufhxdoAmceUuZwiccpvrcrEMwYgU2MUvTWN4N_kz_NZl2ifuCum7P8
Message-ID: <CAEXv5_heSFK5rZYtaJG70Xgv92Um6Dbq8b95PtnpKy7XFwpKUw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Song Liu <song@kernel.org>, 
	Jan Kara <jack@suse.cz>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 26, 2026 at 10:57=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Mon, 27 Apr 2026 at 02:16, David Windsor <dwindsor@gmail.com> wrote:
> >
> > Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically set
> > xattrs via inode_init_security hook using lsm_get_xattr_slot().
> >
> > lsm_get_xattr_slot() claims a slot by writing to xattr_count, which BPF
> > programs cannot do: hook arguments are not directly writable from BPF.
> > To hide this, the BPF-facing API is just bpf_init_inode_xattr(name,
> > value), and the verifier transparently rewrites each call into
> > bpf_init_inode_xattr_impl(xattrs, xattr_count, name, value). xattrs and
> > xattr_count are extracted from the hook context, which the verifier
> > spills to the stack at program entry since R1 is clobbered during norma=
l
> > execution.
> >
> > A previous attempt [1] required a kmalloc string output protocol for
> > the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all LSMs to
> > provide xattrs for inode_init_security hook") [2], the xattr name is no
> > longer allocated; it is a static constant. We take advantage of this by
> > passing the name directly. Because we rely on the hook-specific ctx
> > layout, the kfunc is restricted to lsm/inode_init_security.
> >
> > Link: https://kernsec.org/pipermail/linux-security-module-archive/2022-=
October/034878.html [1]
> > Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?id=3D6bcdfd2cac55 [2]
> > Suggested-by: Song Liu <song@kernel.org>
> > Signed-off-by: David Windsor <dwindsor@gmail.com>
> > ---
>
> The explanation and code make no sense to me. Why not pass xattrs and
> xattr_count directly as arguments, even if you choose to restrict the
> kfunc to a specific hook? Why does the verifier core need the hack to
> spill the context and extract the two arguments?
>

xattr_count is an output parameter; we cannot currently write to it in
bpf as there is no verifier support for writing to int *.  xattrs and
xattr_count can be fixed up by the verifier, so we only require the
user to pass the name and value.

> pw-bot: cr
>
> >  [...]
