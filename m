Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433E3331A63
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 03:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782186569; cv=pass; b=hc42AXyhkNoR9ODiaqBAmOtPro5JKCbtDcAUFrMQD74EkMIYeuWSiaH9ybggr87TdyKRz/iQqCo3u+IQewgW2WtXMS4KIC/2Of2siwGZTE66F99TpbfwTlRqs0MkMSOujVvWpjkjwFE8cDH2afg7OrkDhwfXucvv8xRAxHe79Jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782186569; c=relaxed/simple;
	bh=RR1hHV2J785WpEVHL0k8zZuvODXfgsvw/MD1CpAaxyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cwAbSoXelZB8JYKWpbI+fYsYNb164cktPiKpDMv+QAjNs5DH1hd7NuK0aTBNXV/c7+meRV9kW6dHLPyonomly83oPtv4C+qRUyokeScazBxd2FJT/JU42mV4ggqtH/pupD7QkfjjM6w3O7uXYCMXIC23COWh4jJGfXd5MmX5WoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2VXEIsq; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2VXEIsq"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8dc544dda2fso45262756d6.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 20:49:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782186566; cv=none;
        d=google.com; s=arc-20240605;
        b=IW9YQjab3KqBv5xSOjgaEfxYhVMC4DYFeZ1C1BMuruMXMgY9uYiQyGo36tAf5VC2xn
         NtC16yFhEH7Mm7AUiGrWwn34Kvi+i1YJJlLLInYnzbtQVT9E3c+iQVnXzFIwGi/5c4Es
         T/cV4QBBsD+uZB2YH/qqrfvHaRPPqAnPKN3U8KhLwuZ51t6RvDOrmeHMfZUcC6hYZJK2
         aTGD8wEcMOrSuvlzkM/ujIpg01rbfv7KhMRHctoKx4OPhRF+DcPzaerDdPGXzNnthlhC
         M5RIis9gE/jHrI0KJ0m0/IYwPrpf5N8C4S28tWw2UCqny+R1Xl6t2dGiToNlXMWK/dFF
         UzaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hg2qvAeQyfTz4Manlgss62I8/Xh54jm/4GmfoVCRIRc=;
        fh=zS3tXtrnyAVlGl2GaUHi5jpEKZebMGdWBrjQkTOf810=;
        b=DqqgpoUBU+KB6N7kUCM6vcHOe8Y0DLJQfHDp5z6yyrn0Od2Z3OuBexF3ozuyYQNl5R
         vUoSXy8QDUdOyUW+kDijvl31rhJxP68indv+pK6dvIHT+OHHX8aM3zfluAbVroiurHgV
         2OAFeA6puymk9+fbj1Z2+mk9WdjIxqohb1VS5fyzdSYZjdTSeaWXeFytSNNV2cqkVpCA
         rT1FgAO26MulLe96CVV/Ge6Hmr9LdyCdm3WM/meIffPyRVfF5KighhzMjkb4mtriy4dO
         bp8sj9nF9fuz5+aJQvHppD8w0mcpFjYgmFVdUqbd3mjYqVXthVfjh2N82VtT89VvRIeh
         XMtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782186566; x=1782791366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hg2qvAeQyfTz4Manlgss62I8/Xh54jm/4GmfoVCRIRc=;
        b=f2VXEIsqUPpQtjzWk0AALYcAw5dv8DgPoC1lxGm4F7afw/MKVYqNjJNlgIpQXVMtgB
         dW5+xn/gyQj5jdqGUMXn+Jfp+EpOjWIh47APFF4MBi94JfvRNK62E0uyJceJpIZ8f19v
         NZAIB1LF6TxkN29Hp/30I1I+5xCSibfaWZpgPvb1wuPYAHHQ5QX1y5Bnz6TsJHlZbeec
         ufbpPfihOBmn6fcoPthWWE8D+UgNn1K1XFX8Jyfer0Y29qAdXkbr53xdgWpZ+JI1oEyX
         GB0KzvLZRKvJfuNkCb8lVZE0sn5SavxJfY1+yCEH7FZuZMAv9zqTicbx1jkwweQl5SyK
         1Cfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782186566; x=1782791366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hg2qvAeQyfTz4Manlgss62I8/Xh54jm/4GmfoVCRIRc=;
        b=qHeNr1cy/DYzpd18BMJFyQvCCAEJXcYog7fyH/tzw8WkvdNJmxouEhsaZNGQT+N1yG
         ZGSHg5ZZLlM/lzzxXB9YBAcu+kbOo5w2Qr5VjJ9JjV+KEmy6sIGZ8hiCIt4a5ivc5N5d
         y88jm3VNTPHmofw7fEr1B6H/imlkMLlZIKK1gDOTPb4UCZszQbn6Wl3oLYcedNQYgsgy
         Ipx1ydaaiu8ue3Wp3lyw/8rhU1VlOxXIIOiHyVfMaBchPrfI7cxsYdIQ4YCBAxlRW8S9
         TzLvvUX2+llYt4323gv2v7qLJXjFWhSTB0JQ75/CpcsneR3Y8Nl72icD2aKphai8xDqY
         uwNw==
X-Forwarded-Encrypted: i=1; AHgh+Rq6v/MmXiq3j7wbsLCY6+zf9pru4eYi9mZj1UDr3Tb3D2G001T65Ns/bvsNHtg8bCRIAEkCkx1kX1aTnREI@vger.kernel.org
X-Gm-Message-State: AOJu0YxNLv6snCyf4VYKB6GF3aVRdIJqJPX15O1bmL20CrlLaeplHT7k
	A+z2lXWTSP4EuUyLROyfmCdggQ0fyFmYkYcDwxQ/TjwNYUppa/+MS2Av/M2EzJD1fk+XiWhlGYZ
	xRE/dBkAXOF4B8BNkwHVRUHXnqEJQ5wY=
X-Gm-Gg: AfdE7cn3clgHYL7vmd34CqtiLWir3QaZbPa/V0AkDlt8xrQX+yPWARlmaO3anSMqFVq
	c7SoDcA9ARptle0ihWHEmP8H+uxJ8jt89e1d8bgreTZ6++EiD3P5HOA5c3MZIOxkJxmZlxpmS5W
	WooHcyD1F8dqzjbJStTdetyvB5jKarnF41TtVznIXuX8joxn+y/I3BJnwN/fsEvNKdm+OlNtuAM
	T0H60AGfbNEgSol73/2zgcagefqyzGTyajrEzuZT8gqhsxalrg6vlABrOsZoKOJfeHf2Y86YpN/
	UIB5iiVCCbgE3HJkV77fxz8W/cw=
X-Received: by 2002:a05:6214:c4a:b0:8dd:a358:ee8c with SMTP id
 6a1803df08f44-8df91338058mr230818586d6.23.1782186566075; Mon, 22 Jun 2026
 20:49:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618203411.73917-1-dwindsor@gmail.com> <20260618203411.73917-2-dwindsor@gmail.com>
 <DJFZGYZFMN73.1799LMXW49WZO@gmail.com>
In-Reply-To: <DJFZGYZFMN73.1799LMXW49WZO@gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Mon, 22 Jun 2026 23:49:14 -0400
X-Gm-Features: AVVi8CcisxKRwafLGJbgn3FDnILUrTQohjbGOcGFK09DM9CZwfDUyuni252s2_0
Message-ID: <CAEXv5_jVXS4JoExcd71YkXEE2WXPJ0_9STO-uCwgNF+Eia_h5w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	kpsingh@kernel.org, mattbobrowski@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, casey@schaufler-ca.com, 
	shuah@kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 7:57=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu Jun 18, 2026 at 1:34 PM PDT, David Windsor wrote:
> > +
> > +static int __bpf_init_inode_xattr(struct xattr_ctx *xattr_ctx,
> > +                               const char *name__str,
> > +                               const struct bpf_dynptr *value_p)
> > +{
> > +     struct bpf_dynptr_kern *value_ptr =3D (struct bpf_dynptr_kern *)v=
alue_p;
> > +     size_t name_len;
> > +     void *xattr_value;
> > +     struct xattr *xattr;
> > +     struct xattr *xattrs;
> > +     int *xattr_count;
> > +     const void *value;
> > +     u32 value_len;
> > +
> > +     if (!xattr_ctx || !name__str)
> > +             return -EINVAL;
> > +
> > +     xattrs =3D xattr_ctx->xattrs;
> > +     xattr_count =3D xattr_ctx->xattr_count;
> > +     if (!xattrs || !xattr_count)
> > +             return -EINVAL;
> > +     if (bpf_xattrs_used(xattr_ctx) >=3D BPF_LSM_INODE_INIT_XATTRS)
> > +             return -ENOSPC;
>
> This check is good to have, but it's enough. No need to duplicate it.
> More below.
>

> > +
> >  static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc=
_id)
> >  {
> >       if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
> > -         prog->type =3D=3D BPF_PROG_TYPE_LSM)
> > +         prog->type =3D=3D BPF_PROG_TYPE_LSM) {
> > +             /* bpf_init_inode_xattr only attaches to inode_init_secur=
ity. */
> > +             if (kfunc_id =3D=3D bpf_init_inode_xattr_btf_ids[0] &&
> > +                 prog->aux->attach_btf_id !=3D bpf_lsm_inode_init_secu=
rity_btf_ids[0])
> > +                     return -EACCES;
>
> This is unnecessary. Only one hook will have xattr_ctx type.
> The normal verifier type enforcement will do its work.
>

Good point, thanks.

> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index 1a721fc4bef5..b41b02173e24 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> > @@ -859,6 +859,9 @@ static int bpf_trampoline_add_prog(struct bpf_tramp=
oline *tr,
> >       }
> >       if (cnt >=3D BPF_MAX_TRAMP_LINKS)
> >               return -E2BIG;
> > +     if (node->link->prog->aux->attach_limit &&
> > +         tr->progs_cnt[kind] >=3D node->link->prog->aux->attach_limit)
> > +             return -E2BIG;
>
> No need. The check inside kfunc is enough.
>

Paul wanted this check because it occurs at bpf prog attach time,
whereas the one in the kfunc is at inode creation time.


> >       if (!hlist_unhashed(&node->tramp_hlist))
> >               /* prog already linked */
> >               return -EBUSY;
> > diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> > index 40efde233f3a..d7c44c5c0e30 100644
> > --- a/security/bpf/hooks.c
> > +++ b/security/bpf/hooks.c
> > @@ -30,6 +30,7 @@ static int __init bpf_lsm_init(void)
> >
> >  struct lsm_blob_sizes bpf_lsm_blob_sizes __ro_after_init =3D {
> >       .lbs_inode =3D sizeof(struct bpf_storage_blob),
> > +     .lbs_xattr_count =3D BPF_LSM_INODE_INIT_XATTRS,
> >  };
> >
> >  DEFINE_LSM(bpf) =3D {
> > diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm=
/evm_main.c
> > index b59e3f121b8a..e0a05162accc 100644
> > --- a/security/integrity/evm/evm_main.c
> > +++ b/security/integrity/evm/evm_main.c
> > @@ -1062,14 +1062,16 @@ static int evm_inode_copy_up_xattr(struct dentr=
y *src, const char *name)
> >   * evm_inode_init_security - initializes security.evm HMAC value
> >   */
> >  int evm_inode_init_security(struct inode *inode, struct inode *dir,
> > -                         const struct qstr *qstr, struct xattr *xattrs=
,
> > -                         int *xattr_count)
> > +                         const struct qstr *qstr,
> > +                         struct xattr_ctx *xattr_ctx)
>
> the rest looks good.
> Pls split the patch. Introduce xattr_ctx first across the LSMs.
> Then another patch with a new kfunc.
>
> pw-bot: cr
