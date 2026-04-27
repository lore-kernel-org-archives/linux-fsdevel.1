Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2496C35F5F8
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 03:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777261386; cv=pass; b=DMoVSvzcyoloc1xQnn6YSVS0DDikeA8U4x8x+YtbcjRsoXZgWjFnobKAuBNQ2FTjSN1RLdEU249RCyA1+7Do0adAnuDP7NOqyHS+Etzec9wuh8C8InZVCl3TTz+RqXh4bAcVAvMK+CjPthoVIspSxbEmOw8dLzngfZ/ZjEfaGF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777261386; c=relaxed/simple;
	bh=t7jMQTzH4WvNAPNg0QKfjgjMMI8uJxMDy8LRPrdEgV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwydV+hH0Yr1tptsWt6dnMfCPyJSHMkaQEeZMArEoSKIk7n72GnChyFHVpObtpjwH4ULkcKEe1wr5hXkPgG/08DfNYsAlVcuESFyGpF53hqBmnBJd0EjaJ5hU2qLsfTPQDgP4pkqEhrTL5SNiigmI8u2qmMqtkwkUvcZyhmX8yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kv56Ns0H; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kv56Ns0H"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8a3342d301aso95969136d6.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2026 20:43:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777261383; cv=none;
        d=google.com; s=arc-20240605;
        b=QVxKwwQHJUwTPGe+5IjuyyHXlj3yqoSc+LAhepZ/YuGfnORVPzBHx0rMzyhJ5xseHI
         a0Y/zueutiAeG63tlLxVhIpe3SNB/u5EA9UfaB8sOUZbon2ked1v2258m313i1NH0OwZ
         wQe6WPAw5gE5PsMWisO67n/zYwJ85FvXNTbu0rtdMRgIWIaO/ClvRn2AfMjEgiOfhR4H
         PP59BGeL53xYh+9g5jPbOz/XtXwFdn2s2kA5h0+srS9T5yQQtaq242ZOayHZy029e5Vm
         hglzDrNYB2RvI0vZyedKKisUri3plR4S0mU2xVedxAz9LqamTUbMwsiSp6HULcTS3Nxg
         KmBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i1wsozKYAd1yUpII51kKd/OUBtsrEEmUo4ZxLHwLHGM=;
        fh=D+gwioHyZdS521S0yx9GKILj0JUftsTxiIY63tIvXag=;
        b=hoaVupKdU4D+Mz2yRt9DHYefY03nZCFvqmjiOzulCiu1U9keZ6zZeNAa5JEnxOsT9H
         Wg/VrJiMgBJ78pIe2SXX8R5TKPu1YH6bFVeF0uJUuV6nHLv5FqUX6zGXBExujdz5TTab
         GNJ3TdiJbgxQKucAsbIfqOjnzggIapOzlTX4LmgGPFjQ9/p1gJUXK55XoY4yY/H0M25I
         NurQcg2WR4I6KVLsRXQ1b2Lu3a3ZI+rT3uA5I+DYH9vuponLqP2/zuYggxjZXCaXDKax
         6xlYedOePWzbdz9VseyxeomnjLFG1jUgHZ7trCxGuCBm8n82uAUZHqUlp8x2nz2zLmVf
         T0kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777261383; x=1777866183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1wsozKYAd1yUpII51kKd/OUBtsrEEmUo4ZxLHwLHGM=;
        b=kv56Ns0H56/PH3riSf5jXuV/d617/NZ4LBdT7ZKMAIuKsf8cjWvmX1wD84IZvxKa4H
         vcPOHfGrU70eLXMzJId0Zy8Wp5YSQbFqFE9VbPYcxeJesHpsPRSwufZJyddSaT+w39T5
         S6Mw+Tr++2zjfs+9gkizI712Uis5FqqRZ3vOEW9UbxE8eZYAykYWP12v409iv4PH4KxH
         hi2LBR5FmZjD1DhiJXvh1qr+un+DtMDRqm05vaGJ9I1SXBdrYEPNsjVYVmz/FpktiXCv
         J0z6aqPzqxzXsvbFlIMm7YF3CqU1K0TztLam1lv6SvqqqdcNtcZeqLDzrZEjTdUWJU7i
         xUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777261383; x=1777866183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i1wsozKYAd1yUpII51kKd/OUBtsrEEmUo4ZxLHwLHGM=;
        b=TgEqGilTez78clP2poCpYQ8EzP9P/mvKwnYgku7df/f32oYocUTeerT7LBw5JIL9Ak
         irUt33WsqO/XWkj0au846wZBQptWj1tt7IGezZ7+QJW1m5botbES3labzd74GVY5nbta
         p32XVal92mIbn5wJ1FbTapnNzWescqUGvhIsI7DHl7QMQq5nYW6UFXyy3NEjGMCEOPXM
         +5HEICAwAaYb9oTcYKbCA3dJo1FE6b+34AlW/rt/F4EYaSfdHeitvU0UsTLENswoZk9u
         gevgDEI/E7RmdHJ8O+UEnG7MRRZJFA5YslInQCKmnAfcJyj/ZVzZxMwHflUsmmCPfdhS
         dhfA==
X-Forwarded-Encrypted: i=1; AFNElJ9GS7dNZQA9+nw1Y0oLzDNdBOCxqetL743Fb8KEc0flxPtpG/rym2mCaw3tWhcMqwYLmanUcxHIN2kMZxSN@vger.kernel.org
X-Gm-Message-State: AOJu0YzycWTkLISwPKEID3YVcWxqLVZMNms2xq1pg5KRiXjs1RD7zIks
	4UhZ0/Dulf37a5uRqnKLLJyqASz4q59bJ+8f08yXX8NNTDaaJAE6wAy0RaNxFdKTD5m9SOcD9RI
	SpnUZJ2mhl8Psst59sqjU/vNX1LoePAb3WXdd
X-Gm-Gg: AeBDievcPgpS+sZLp3R0wwu1TfoRjp5g9XNBxy3e8pO37eMjSrsUwLqD178Wtm2jRnI
	ikKBNGwGqRfJ128xpc/2cAJWE6QlvDdRn+fSmqayeW7JOOJCeV6AT5Zl/ooTHKdjr1hxg3rM332
	L3Mg4VdDSooz9LOJSsvbfA8J/42Fb0uamrVJcuj62yQ8YsdaoSNdhazqcbI2LX7fuPi//kzT6Cr
	PUQEQVEtUoeSbzSCUmjNljTlM+VVO1C/fE3QE9WovCqhtIpxn3ZpMA5aYaPHFzySfKwgCh7QTWd
	qXLCd8jFjjuWyFiPFezMg1OS46jvZHQMl3nNVBlCoUSY9spjfnMWgLDJBEf05w==
X-Received: by 2002:a05:6214:588e:b0:8ac:a48a:a586 with SMTP id
 6a1803df08f44-8b02803f167mr647114386d6.14.1777261382999; Sun, 26 Apr 2026
 20:43:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427001602.38353-1-dwindsor@gmail.com> <20260427001602.38353-2-dwindsor@gmail.com>
 <CAP01T74iuSDJeL6g=5yLdYGb-VcESK1SYY3R1S1r-CtQEsW+oQ@mail.gmail.com>
 <CAEXv5_heSFK5rZYtaJG70Xgv92Um6Dbq8b95PtnpKy7XFwpKUw@mail.gmail.com> <CAP01T74WBjcMXbWYeaWB-oTk-bUzoxi_EEALDpT1hFUEOovnpw@mail.gmail.com>
In-Reply-To: <CAP01T74WBjcMXbWYeaWB-oTk-bUzoxi_EEALDpT1hFUEOovnpw@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Sun, 26 Apr 2026 23:42:52 -0400
X-Gm-Features: AVHnY4Lv_udS1YjhPNVYhT9R-oIUIcO_YCQ6gEoTqdWddJ4UBJuMugcb2-0tXIc
Message-ID: <CAEXv5_geng=0cNdC99b_p=9GV65wv73npAWBtooVRzXN5xVhnQ@mail.gmail.com>
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

On Sun, Apr 26, 2026 at 11:33=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Mon, 27 Apr 2026 at 05:24, David Windsor <dwindsor@gmail.com> wrote:
> >
> > On Sun, Apr 26, 2026 at 10:57=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Mon, 27 Apr 2026 at 02:16, David Windsor <dwindsor@gmail.com> wrot=
e:
> > > >
> > > > Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically=
 set
> > > > xattrs via inode_init_security hook using lsm_get_xattr_slot().
> > > >
> > > > lsm_get_xattr_slot() claims a slot by writing to xattr_count, which=
 BPF
> > > > programs cannot do: hook arguments are not directly writable from B=
PF.
> > > > To hide this, the BPF-facing API is just bpf_init_inode_xattr(name,
> > > > value), and the verifier transparently rewrites each call into
> > > > bpf_init_inode_xattr_impl(xattrs, xattr_count, name, value). xattrs=
 and
> > > > xattr_count are extracted from the hook context, which the verifier
> > > > spills to the stack at program entry since R1 is clobbered during n=
ormal
> > > > execution.
> > > >
> > > > A previous attempt [1] required a kmalloc string output protocol fo=
r
> > > > the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all LSM=
s to
> > > > provide xattrs for inode_init_security hook") [2], the xattr name i=
s no
> > > > longer allocated; it is a static constant. We take advantage of thi=
s by
> > > > passing the name directly. Because we rely on the hook-specific ctx
> > > > layout, the kfunc is restricted to lsm/inode_init_security.
> > > >
> > > > Link: https://kernsec.org/pipermail/linux-security-module-archive/2=
022-October/034878.html [1]
> > > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git/commit/?id=3D6bcdfd2cac55 [2]
> > > > Suggested-by: Song Liu <song@kernel.org>
> > > > Signed-off-by: David Windsor <dwindsor@gmail.com>
> > > > ---
> > >
> > > The explanation and code make no sense to me. Why not pass xattrs and
> > > xattr_count directly as arguments, even if you choose to restrict the
> > > kfunc to a specific hook? Why does the verifier core need the hack to
> > > spill the context and extract the two arguments?
> > >
> >
> > xattr_count is an output parameter; we cannot currently write to it in
> > bpf as there is no verifier support for writing to int *.  xattrs and
> > xattr_count can be fixed up by the verifier, so we only require the
> > user to pass the name and value.
>
> Sure, but the kfunc can. Did you try passing them in directly?
> If that doesn't work for some reason, we should fix it instead.
>

Aha yes, I did try that and I believe the verifier rejected it because
btf_ctx_access converts the pointer to a scalar. Will confirm the
exact error tomorrow.

> >
> > > pw-bot: cr
> > >
> > > >  [...]
