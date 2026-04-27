Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0913E3033EB
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 14:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777300439; cv=pass; b=U8xCq0O+2H7j6zA7nKmld5MLxfUsHh5ly2Lg1ZlKPrtUWky+tFjh9S1X55Mgjf2daQ4EeivDvn4nzCb3St9n9UjISCPg8yaGf8xaVFQFPr8GE0PQg5GIO/l6P7GSEYZrLEsqGFkPrsr5Co1+9YwAUXoV5EnPiJxE8OA71QfgEI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777300439; c=relaxed/simple;
	bh=BxBDIJpOCEN9cmK7Xc3qnTtKGs1GTwEe6Gc287iXtLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bmsQU12NPMtrQoGAE2RRqKxg9TpEthx9D1zKEpRMBw1iT/LI5ll4O2nSfSF3vPPsqZa1cPuKJSQ9QZqr7Kxo9LjBVKmJj0CF2/PA0aGb17L3j/aSiInU5A65G+su4IK2n51dHcYkhV5WzwqLSwhRTINRAKSo/KO9J+r9MunDANo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fg7lEW6B; arc=pass smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fg7lEW6B"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-43d7650202fso7846733f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 07:33:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777300435; cv=none;
        d=google.com; s=arc-20240605;
        b=M/NSDQJYxE+vzmcEmqQ3QDJcEDo6n5C01jmimRbWh5S2T64sX8IJGiaXKKu18Ca/O4
         QBOGvJLhlUWQKMw5b0TsNA42uE3Uo0YQuojciv76AeTB9WcVns+qWR6L1xw90Se3/zc2
         1lIPXLleEL9z0vBPU56/Gi99bfEmm6zzcR5ShEipq2IXZSy/PO2Foh0w47VWS1LBejSV
         pIDkWAzEpVCuFf92Hn4ViV0lq2sAFC97GgHBzbEZ+iiuiash5XqQxWDFuxkTQLl+jePN
         zV1dChDiCQDqWe8Vz+rvWKkE0LIc+7EYfLruXoXnfQSbQVzH3Gno5vBQt6bRIU8G6Hjg
         PmnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pFu1HBFOkQUkkUSIPtiTt9PSDYzJQuwVt6q+ET8HXT8=;
        fh=LXl9+yG+agHJZn4OMgtgrbpktWiH/8zaAthEi8/enzg=;
        b=kVsKHR6tUuzmHpW7qMHLVrQgoU4ptMww2aWVct9qOPXX1KjqkXi9+TCUjQD7NxibvG
         UOYAso7hXU53fRqB5hHyIkvYjFY4RWlMWJkisAxQBHWIebyOf7PjrwrzIteRGOE/ytoY
         mzHNNARPrk692lDB/sccnl2ynlJfwH8BpMr2WfbxZ2rg+4ixiEmsFoe/I9IjN/9TG0UT
         l8gHZpLztCr2Sw5mAagcnMVrJSC9HobP/N6v6ALDUNEDWiCn+nlVT9Azs3OOtvSMFFt/
         I6CxribitLl5u5N0nh7p5erU3s0fS0pp8X5aO2WnvJgS6Map8Kj/H+61BaFE0PX30/t6
         uW4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777300435; x=1777905235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFu1HBFOkQUkkUSIPtiTt9PSDYzJQuwVt6q+ET8HXT8=;
        b=fg7lEW6Btht96XYQoo3Bu45XSjelEwr/rNUaNMxN5Q9HHjCmzkizrvkLQ/sgQEA/Hg
         Z6nNTGaZgv7qJYWlkU09sbvus0KzCLnHr5wGA+axsn7gcESH3xEKyw2W4jPKQXPLmmiE
         nG/KPsfwL96b7NYjTFsnu86cIJtn3oJoDQD1klXl157DrMX3Dvv+iqQJvEJ4NuJDQYak
         ngAI5xVEa7A4pdoOqpdL8FfbscBryWB8UhtZDc8BhCf4pYLNr1QJd4Vd3XupgU4hwKLZ
         EoSMcApEG2MhxIWKHWVHVBepuycD5K+u43Wsw2fyvYuvobBW1+gl8Q3OCpDyBjJU5+s6
         wYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777300435; x=1777905235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pFu1HBFOkQUkkUSIPtiTt9PSDYzJQuwVt6q+ET8HXT8=;
        b=iEg+q7E6QArVpQCfjGmH/tunFZkbjwyUguKNu7G1PlhomtFxw0ERk9ODeR5B4aalza
         KbPa4tYyECdGK3jnMyLTrLi5pXTHBLDgWN4sYD7YDsZPzsC6aF+Cu2tzDUvvzSLMgvBY
         +xEvcOn4mzViA2eveUL/GdPf6ZttgEckeq1WYp7ZiblwAukHsXvwsNBeXPtM20B91NAO
         VC3rc9bL8F/FcYpcmanBI+1CYABzzlGCJW7PX0f0WwdYPd/Ny1OhucgaEhd3/3Vw6C5+
         j5qhlqdms+3MT/nLmhYxUz511sroQFweu9tGwhFgd55JXTUplcSBPyHkOWNKLwB0ROMf
         IGpg==
X-Forwarded-Encrypted: i=1; AFNElJ+EgbmMLskOm+sibaX6JiwIzq4aIHnL9/7z6v427p5ybtGn+nmRFRO9ZNfgQuCVdvIg0H5v27i//fN49sz4@vger.kernel.org
X-Gm-Message-State: AOJu0YxceBS1kAg9I4EnwdZRTTcR0wY6qbYxRmopAAPNIcU5cuDvN9z3
	Yi9mEgxA2wjdfBHzp/HK7n6rt6ZU+jEGilP31+Xvd5JD/l+NUcuzVp4kBM5XgUCeJZcuIOwcsYe
	/+EXUFBaHeelr/T3NRNqYZvRfQJ1anmY=
X-Gm-Gg: AeBDieuTd7eMBNZ4pyeqZWE+pWQflecmdU/AAYJsHtI5aWk4fJjKZltj1XDrNI1L+gU
	NaZU4DT/lCvgl341925JFqY+ZbccX0ggWUwsjAqGtTKcQl8fTeMrAEepWVDElzvH7U1RlMNfxOx
	FmXEbI7q3w8PX0fR6dLKgLjTGIefQmAFSzja5YAMH1wfkQzp9hGl8na9TkVr+rFPUF/L+AUpa7e
	P8Fc8pBrJb0bkYzOpfz1mok1H1aB3L6s8x7DvHVJPqhuTVNVtPytzMJ0on+Txre2GVP5QzkDDo/
	4WZ6x/afDPM+hvgdtDWZ4bXVNHMbnaXwpT2LM/GQlg9opEHDtWsBWXAZ1OPX/x54AJzDSaIzhX4
	DtB5Vb5IDSMUaYVo+FdlGnmHBzIV89I33q9fbcIc7Th5I65J6nyPKClOyvG1yMGQXBb4=
X-Received: by 2002:a05:6000:2503:b0:43c:fde7:f1 with SMTP id
 ffacd0b85a97d-43fe3dd3a84mr67619523f8f.18.1777300435210; Mon, 27 Apr 2026
 07:33:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427001602.38353-1-dwindsor@gmail.com> <20260427001602.38353-2-dwindsor@gmail.com>
 <CAP01T74iuSDJeL6g=5yLdYGb-VcESK1SYY3R1S1r-CtQEsW+oQ@mail.gmail.com>
 <CAEXv5_heSFK5rZYtaJG70Xgv92Um6Dbq8b95PtnpKy7XFwpKUw@mail.gmail.com>
 <CAP01T74WBjcMXbWYeaWB-oTk-bUzoxi_EEALDpT1hFUEOovnpw@mail.gmail.com>
 <ae82Vv0RWzcXqSaz@google.com> <CAPhsuW60SRXZbFYRDm-QaTiB8tTtJD_N4jk1=680x5UsZmpj9w@mail.gmail.com>
In-Reply-To: <CAPhsuW60SRXZbFYRDm-QaTiB8tTtJD_N4jk1=680x5UsZmpj9w@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 27 Apr 2026 16:33:18 +0200
X-Gm-Features: AVHnY4LqkIDPfVb8uImPBj27UWWOVcz7SAlBpnueXBL0kV-JzzdvYtW43eOfPb0
Message-ID: <CAP01T75SBw6NNvBKyPW11JSYY2oh449yoBsWi_GOBR5Kq1ykmw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Song Liu <song@kernel.org>
Cc: Matt Bobrowski <mattbobrowski@google.com>, David Windsor <dwindsor@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jan Kara <jack@suse.cz>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Apr 2026 at 16:21, Song Liu <song@kernel.org> wrote:
>
> On Mon, Apr 27, 2026 at 11:11=E2=80=AFAM Matt Bobrowski
> <mattbobrowski@google.com> wrote:
> >
> > On Mon, Apr 27, 2026 at 05:32:47AM +0200, Kumar Kartikeya Dwivedi wrote=
:
> > > On Mon, 27 Apr 2026 at 05:24, David Windsor <dwindsor@gmail.com> wrot=
e:
> > > >
> > > > On Sun, Apr 26, 2026 at 10:57=E2=80=AFPM Kumar Kartikeya Dwivedi
> > > > <memxor@gmail.com> wrote:
> > > > >
> > > > > On Mon, 27 Apr 2026 at 02:16, David Windsor <dwindsor@gmail.com> =
wrote:
> > > > > >
> > > > > > Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomic=
ally set
> > > > > > xattrs via inode_init_security hook using lsm_get_xattr_slot().
> > > > > >
> > > > > > lsm_get_xattr_slot() claims a slot by writing to xattr_count, w=
hich BPF
> > > > > > programs cannot do: hook arguments are not directly writable fr=
om BPF.
> > > > > > To hide this, the BPF-facing API is just bpf_init_inode_xattr(n=
ame,
> > > > > > value), and the verifier transparently rewrites each call into
> > > > > > bpf_init_inode_xattr_impl(xattrs, xattr_count, name, value). xa=
ttrs and
> > > > > > xattr_count are extracted from the hook context, which the veri=
fier
> > > > > > spills to the stack at program entry since R1 is clobbered duri=
ng normal
> > > > > > execution.
> > > > > >
> > > > > > A previous attempt [1] required a kmalloc string output protoco=
l for
> > > > > > the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all=
 LSMs to
> > > > > > provide xattrs for inode_init_security hook") [2], the xattr na=
me is no
> > > > > > longer allocated; it is a static constant. We take advantage of=
 this by
> > > > > > passing the name directly. Because we rely on the hook-specific=
 ctx
> > > > > > layout, the kfunc is restricted to lsm/inode_init_security.
> > > > > >
> > > > > > Link: https://kernsec.org/pipermail/linux-security-module-archi=
ve/2022-October/034878.html [1]
> > > > > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/=
linux.git/commit/?id=3D6bcdfd2cac55 [2]
> > > > > > Suggested-by: Song Liu <song@kernel.org>
> > > > > > Signed-off-by: David Windsor <dwindsor@gmail.com>
> > > > > > ---
> > > > >
> > > > > The explanation and code make no sense to me. Why not pass xattrs=
 and
> > > > > xattr_count directly as arguments, even if you choose to restrict=
 the
> > > > > kfunc to a specific hook? Why does the verifier core need the hac=
k to
> > > > > spill the context and extract the two arguments?
> > > > >
> > > >
> > > > xattr_count is an output parameter; we cannot currently write to it=
 in
> > > > bpf as there is no verifier support for writing to int *.  xattrs a=
nd
> > > > xattr_count can be fixed up by the verifier, so we only require the
> > > > user to pass the name and value.
> > >
> > > Sure, but the kfunc can. Did you try passing them in directly?
> > > If that doesn't work for some reason, we should fix it instead.
> >
> > Hm, perhaps this fixup approach might be the simplest in order to
> > assure the needed safety?
>
> +1. I think this is the best approach I can think of.

We're not going to add more and more special cases to the verifier.
The whole approach is unscalable.

If the concern is that int xattr_count passed for xattrs can be
unrelated int pointer obtained from elsewhere, can we pack the xattrs
and xattr_count into a struct and pass it as an argument to the LSM?
Then the pair struct can be passed in directly, ensuring both
originate from the arguments passed to the LSM. That should eliminate
concerns about either being out of sync if obtained from different
sources.

Even if we wanted to ensure argument provenance was stuff loaded from
context, the right solution would be some kfunc flag that constraints
the argument to be derived by following the ctx pointer, not whatever
is done in this patch.

>
> Thanks,
> Song
>
> [...]
