Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B87389E05
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 May 2026 22:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777934562; cv=pass; b=haGZZZXQdjomhTNTsPcTu1D3VgdGMIJsV7s2Vj1fqnZ/RDvffVWZ5epjFJeN7tEpV+sw+AWRqMhdK1ARFewCc/ev86H0cOpTUNl4LVI7ssOYZ/h0fQouK4uN3LU6PDZotS0RmFIODp3Y2bcsiQmQScMIpOEz/jKk7YHAq+BNygw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777934562; c=relaxed/simple;
	bh=jrK/HiPlfROzpLQwuaupLlvkZBTy1nkn4zGH4/MZ46M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iyaKfvgvDFU39WStUWYrPh9y3kfkr44Bm8dzWYRkSOCuKlDxVNt9shG5I9wEl64/N3+we4HVq9FNOoBT1TK2OZ/GZZfTVmaS6eKsz0Y6+oSbsIKtYGVyMuN//Gm6QZBUA4d0xxfv+ox6VeKgdnHl9qAIjAyRbm1+DDu4HMiwnR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UGi3Z9fJ; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UGi3Z9fJ"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c8025f1c227so1232577a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 May 2026 15:42:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777934560; cv=none;
        d=google.com; s=arc-20240605;
        b=eLR/4g7lPN3zKYtaPTJyTTN5g4ds9t1D9Z911SyVUhLf2SuBrK9WFNspd7EY9SkcHT
         vEKmq+XPdDQQk2SX5U0OKPp0+4qeUMybfLwW+UGkdAGDK+tonsi5RbL0hOuGDZkvTaxZ
         HuQ40h/P3Gamohr3EbRhYC7ObEsg3m8VgWktGNR9vPDr96B1s0gPjqSEUPu6UXZYXP+r
         ANMby1yz+LQkW/8sHr8QBcLR7RulY68kchtSJxs0+QS4wKZmhSQnIwg3M43VDMwBFLZW
         f42egGqYOwx+hfA9kpksChjiUTohiSazxB6FH7tAyUUqPbUwCHwMD+cHBmJniajjQbzP
         dxeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IXBRZAGpUpDHDZmPqiOWgzQrVjT26h5rDl2WnSWzU/8=;
        fh=DA/nrk1TvxJbQr2LgSD5FxTd36IZl47CTgWUlv2hkGA=;
        b=bFh/en8YnQFy9hd/KaH2b5hGZS53lwEmMOPax40nxsipG+WozbEOiXkJ7ynKR81EJ7
         j8TBctvJ5pWMxa1aWSPxosKUfg+hoTqLfNJVoDzlO4DaCUeIw9g01fZq59c5TB5Igchx
         MMUCOG00a3KAT0JkiQy/4cpLqbtX8jFUgcq71fkg/lB5R6sXdRs+WIbIAqyMpvoAlI1Z
         f3VN99oGKMqgEuEmIOYCcP/JOLnkzxr4kxaOMRYrXsdhWt9iD3/TUGhhMdH8DevQ6F6C
         DQsqCi7D7e3llBoX4gw38X/I+i91lamJtI3NmeIwDBtV+xd9Mi6TbbJZYAyG6fUBL29C
         8hsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777934560; x=1778539360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXBRZAGpUpDHDZmPqiOWgzQrVjT26h5rDl2WnSWzU/8=;
        b=UGi3Z9fJLfezyp0OJDVLLNFuIoLRa1wo0OTjff6UNOlY3ZRdPTNMPdO5YcjAc9iyOl
         agb1F/QUPJpTdLppeZa1vhhJ9CJWO6vuQAz0W6fnIwxs5/92na+qXx0bY7Z5CTFYp03C
         R6WaF18KHUojniaVITwSsnJ5fWLuAfuz1zDC+ZAacmzaXr7bNbFx7ZunXCjlp4VWhZ1l
         EfeBeF12UbEmxFtdekM345BWt6iU0Hf51Fujf50LqcFVmZoiCpoNsAgG6AojobDbZAxh
         x8ZpGDJ5PU+eN39u6K/ADsd6KozqsTsvdp6jpJI3RZbXjlm3X+o0N1H1nwDGuQonit9Y
         0kww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777934560; x=1778539360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IXBRZAGpUpDHDZmPqiOWgzQrVjT26h5rDl2WnSWzU/8=;
        b=SYp0h7ZwQ/SudRwCZcf/Y0A+xC+fOKCME5HLcc/U8NtRy1DxbVDDlO2qvA/0bzuVcv
         zpUDBUXmTz3gq0xfTEbGTns6XHsDOwGdKbga3WYTSddbX1KlHZRbYATnDJsrPvppWO/h
         uftneBX1ApbDF+okuk/L/eCVy6PRRSWkQszOPXBSXNr7UxFURzd/KWnBFo+KL3brnqkw
         92lJJH3sU/UmA2Em3tFlSJiSI48AaiEVokWQXQ0/uiJBb4gmAdJLbIxz1fQvfki/BTht
         OvL6OLuF7Dt7/ZJi/JTGIGDV3AX1/BQzQRMGAeJKlnZb2yVmydw9E4nyKQJt5xWyq6Na
         md+A==
X-Forwarded-Encrypted: i=1; AFNElJ+UkJWKass34f/N52eZwKlnxRK4S4JvGFNrv+w0613BFX9HRxItpjKvIlCuy0xonlodlUdmCUquo2JwQZ3I@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn9T4k3Go++e76EZZyHF7bRDFmQ8dowjpxgDH7cPK/KIla99HA
	GhMSPZSXEYRkuJsejmquQK2e4AJgLo97a19BxCzYZvQWJj5urJayXCjhftS6xN4IDdxs/o2Ujqk
	l0j1hPbWVX9ftbejm8curi1uhclILrcKFAyNmm8gS
X-Gm-Gg: AeBDietm3OEJ8lBERgwv+gIL/OrPYdQbqTMgEcIJVXOT9/Pc1uoCJUY1GoBjG0m3LtQ
	7bltUr7hFFZyY2fsn9eeVxeEAUKdkW6yeZXVBwCunZut2rVDUVD5sJ6psSDKIVKplEtcrttN9ZD
	kmsV2/yyI/A8MJ1d6ikPm4itGJFnvIImfdQUfw9FqSK6ebQsV0QpLicDZlG9D6IPFuwf1IvA71q
	Kuh+AiGs5Pis47foQ6Ac7VumDrmT6zrpWKnxo8UG8FnnufzGTfElH0PrO7tPROarLg195YCEPEC
	o2mERsorAqIinKpdpA==
X-Received: by 2002:a05:6a20:7350:b0:398:7792:3882 with SMTP id
 adf61e73a8af0-3a7f1ad975cmr12466464637.16.1777934559848; Mon, 04 May 2026
 15:42:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503211835.16103-1-dwindsor@gmail.com> <20260503211835.16103-2-dwindsor@gmail.com>
 <CAHC9VhSy5K5nQTtFUE4BScy1Ur61v7eZW067vTcUYDQeJb13Bw@mail.gmail.com> <CAPhsuW6sy2cdC4B7Z48-5A-yVX6fmVWxS_fWVjQxiX95KeUguw@mail.gmail.com>
In-Reply-To: <CAPhsuW6sy2cdC4B7Z48-5A-yVX6fmVWxS_fWVjQxiX95KeUguw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 4 May 2026 18:42:27 -0400
X-Gm-Features: AVHnY4JwC15TGqrqFYxmzxatkMEXynJIr-3OCdScUP6s2DMx5Fh0pwblgffVK-0
Message-ID: <CAHC9VhQLN5NA_ZMMNyUdMCZVdwC3VM4PUnzka8xDK5rpR2a3sw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: Song Liu <song@kernel.org>
Cc: David Windsor <dwindsor@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Jan Kara <jack@suse.cz>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 5:40=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> On Mon, May 4, 2026 at 10:14=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> [...]
> > > diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> > > index 9d27be058494..193accc00796 100644
> > > --- a/fs/bpf_fs_kfuncs.c
> > > +++ b/fs/bpf_fs_kfuncs.c
> > > @@ -10,6 +10,7 @@
> > >  #include <linux/fsnotify.h>
> > >  #include <linux/file.h>
> > >  #include <linux/kernfs.h>
> > > +#include <linux/lsm_hooks.h>
> > >  #include <linux/mm.h>
> > >  #include <linux/xattr.h>
> > >
> > > @@ -353,6 +354,97 @@ __bpf_kfunc int bpf_cgroup_read_xattr(struct cgr=
oup *cgroup, const char *name__s
> > >  }
> > >  #endif /* CONFIG_CGROUPS */
> > >
> > > +static int bpf_xattrs_used(const struct lsm_xattr_ctx *ctx)
> > > +{
> > > +       const size_t prefix_len =3D sizeof(XATTR_BPF_LSM_SUFFIX) - 1;
> > > +       int i, n =3D 0;
> > > +
> > > +       for (i =3D 0; i < *ctx->xattr_count; i++) {
> > > +               const char *name =3D ctx->xattrs[i].name;
> > > +
> > > +               if (name && !strncmp(name, XATTR_BPF_LSM_SUFFIX, pref=
ix_len))
> > > +                       n++;
> > > +       }
> > > +       return n;
> > > +}
> [...]
> > > +
> > >  static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfu=
nc_id)
> > >  {
> > >         if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
> > > -           prog->type =3D=3D BPF_PROG_TYPE_LSM)
> > > +           prog->type =3D=3D BPF_PROG_TYPE_LSM) {
> > > +               /* bpf_init_inode_xattr only attaches to inode_init_s=
ecurity. */
> > > +               if (kfunc_id =3D=3D bpf_init_inode_xattr_btf_ids[0] &=
&
> > > +                   prog->aux->attach_btf_id !=3D bpf_lsm_inode_init_=
security_btf_ids[0])
> > > +                       return -EACCES;
>
> We need to mark bpf_init_inode_xattr with KF_RCU (requires a trusted
> pointer), then we can remove this check above.
>
> > >                 return 0;
> > > +       }
> > >         return -EACCES;
> > >  }
> >
> > Perhaps I'm simply not seeing it, but is there a check to ensure that
> > there is only one BPF LSM calling into security_inode_init_security()
> > at any given time?  With the BPF LSM only reserving a single xattr
> > slot, multiple loaded BPF LSM programs providing
> > security_inode_init_security() callbacks will be a problem.
>
> I don't think there is such a check. Also, a single BPF LSM function
> may call the kfunc multiple times, which is also problematic.
>
> I think we will need to make the default bigger, and also introduce
> some realloc mechanism for the worst case scenario. This should
> work, but the code might be a bit messy.

Thanks for the clarification, that is what I was afraid of when
looking at the code, but I was hoping I was just missing it.

Increasing the default is an option, but I don't think we want to
support a dynamic reallocation scheme for the xattr slots, that will
likely get extremely messy with synchronization between the LSM
framework and BPF LSM hook registrations as well as special code to
handle inodes with lifetimes that are disjoint from the BPF LSM
programs ... I suppose there may be a way to do it, but it will surely
be ugly and come at a cost.

--=20
paul-moore.com
