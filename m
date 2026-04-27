Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0C2329E55
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 03:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777260807; cv=pass; b=MQHjR1m3SQ7/5Zc5LHZ0ctL/KXImjiL6rwHr6XMFAErBrkjIWBXTnV1045EWjIS6VNGQ2iJnG/Vud71Asfs1jkjroLq3egXlhsFaNPem6IXGtC4hfNnn7fprxegai7+d4VOfmnRbU6uM9K9tuPSHqmT9IeDmfWkYoq7YP6xm5Z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777260807; c=relaxed/simple;
	bh=FlRySTzL7yR9u6SjPj5k70NdbvHE2bc1gU3Eq2AkLA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZEPUwxX6MCeSlkNG4rz63wQ0nnO5W9xe+x0FJLgj7xj6cci3NreHxiRSqqrrCoP86Nn8oFI3KzzFGOaMRkZ5j1DtMBT5BAZh/mlzx43KNXvp5GpqDl7UHK8+UeyEqCWwasvAkL4M/0Rr7Sc8RTiCkGv9uOpxQ6cFaKCloG1kJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLEOZyKX; arc=pass smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLEOZyKX"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-43d70b3e159so5080981f8f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2026 20:33:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777260804; cv=none;
        d=google.com; s=arc-20240605;
        b=Okh4ap+zncxPDYTZ+BOS7XzSj9zOxntjXeVJ2h0qeTPv4GksAYqubVDH+CaY3kzU4L
         sqjWEAyQsWkxiUQPJizHzar3ric/2cMHbaUZeNyGFG8uy4mfATKAbDryAOKZ8Npc0zXL
         4L+7Un5W9XTGmS8ArGFpYH4OQTWC7mWCi8qp6fwE5QyRWevCSGBlUttkWsHdtzr9tOLM
         VuyB6cOfFmTU05WJD/ERGmKPzubbbhBC8oxd1aRyzPrAc3/75PcTGA5OuxNPIAFDn7hs
         avXOshazLO2LVibY7pxVPftNaZ4SS/QegqCYeP5Sm3OCbcHxeggI66CFerTPn1CZIn9I
         TvcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FMeRQIgABI0rxTD3+7gFqkezgpUe1NFoTAQ8q5oe/AQ=;
        fh=q8HI9gF+5ZjFJRXBxTdJkPCZUFIBicgl5BBo8o13tg4=;
        b=HsWLT+owYJJmaFw43x3w5W2oQcxeybX+xC0GaHeLAbqVSYaOW4boBV7mAP4bS2aO9S
         495iWGfvOILieSQFi1u93f+iG3fNKIEKTYQtN5FGGezAGmZIKWB+x2NUj7NbMF9Z68sx
         BpWLS02KXM9AFBp9TeYkf7+KOGJ3IY6mV3EidG8sHiKqJQKlgXVO/TWHLn/w5Irel7qh
         Mljaa0Sy0e+8xDvKSYoRNuOX7iB92jfc+mVS92hSksWKv24tkepIFLAUZjXBpZA4ehGd
         U5m/hOJiJpZBxNcDYCTByJ32R8PnJWn9M5AH0ELGlZhWvdePEzt9D7ShAPYvITNdf+6z
         pbeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777260804; x=1777865604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMeRQIgABI0rxTD3+7gFqkezgpUe1NFoTAQ8q5oe/AQ=;
        b=mLEOZyKXnYS+/AXRTj6N1BZ0VGl4Ed/G7TH285S63iUPgPatg3vhCvbz0aN7hxLud0
         Ma7q4vzRFUKNk6su9OsN/BPXTaFyyYUL4Gy5KTgHSS5efyg10XtBkgh6nlbjyuwm2M6r
         Dv0boad/PpGbwRO+nqBaYXv+JxiMdWuGgGh2/TFP4lgkS+yz0zEzM2MAHRs1dito9ilE
         8LPgcOpGWijtUyQJM1XCdZVMc+g3+Spv0jMaYBJyYduMrIsFCNnmaet9QGX3tntsK+Bq
         xJ7qUX/WaYAKexaR92dbqjoMwr99FHKuzsL2dPyhzAw19gB+gUOWnbEIRRniA53D3U4K
         qFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777260804; x=1777865604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FMeRQIgABI0rxTD3+7gFqkezgpUe1NFoTAQ8q5oe/AQ=;
        b=oBy0XjyB5z4BReakl5TSBYu5Z1VK0ATGlH41dSsDMjEhcOkpMJ1knw8bq+0S3LeKRi
         E+aQLw1IcKytxIWyZWv8ihHqz1wCsLVOayuQcu9+XX9858f8P3Ew9m0YXdcN8/lttRy5
         EJnLQsE+RYSbvsqn0TXrEn8hDo9bVYpBTDuCTKoo7JB0MyZUmDbjxQCRnfSDUAeErA8y
         eMscCdvJmoZbKWgSps+7B+wgCssdmMyKtAaPDKKrOv8zAF4uVK79OoSsTDdLFCYEjbs3
         ADn6CZ1xGpdFh+gMWVsecCLsC676wqiyQOLLJdovoaKef3Zcnjts3mKHfiVNoh1xWPTt
         UOpg==
X-Forwarded-Encrypted: i=1; AFNElJ9///YndG29iePlGKuoWrIjlFIzc2Xe2Ils2/I97ndh+zcNi9Lz39vJOVdSdWJzjq5KsU2i9kcqIrHEWmF0@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj9mxy88Ax6wmbj1C5YTmq3FgpO7b6BloEAXNLKfpLjzevT7yE
	inpQ2VqcpQNLTAdALNWIKZBhFZ4eQ2aae1iGyfLcBTMFiYuGXAoQpeaYeqqDFPpDoeuTqQ9gO7y
	aEuQurcV0mAZq9TpCPf5iyAeChFYuuVg=
X-Gm-Gg: AeBDievrsP1nLX9O7NOL/329kSIwlJ7KfAd3Syru84zn+IgmcqzdYf/9zRY39E4kWIt
	iVcQ3wg6Uc9ZliLTm8tTn0t8/mqk72HkOiHvaB9BXSWJsB2RfgDRmR6wV3h05b4WNjz0eD6qw3p
	s3G1M+nxWxU4EhhFC1g2Ge2/+TeiXZxu4exaoWGZhv6jHe1mm+gQs86dcm/Q5lKHJtZ1D9wtWrO
	iSmA7uXHblA9BEhyuVGRoueppxV6At4ALv33wHHgPIbvIPdDhtTepFaROqCyslrM7gQl0TpEey7
	fmS2zS2ph3kxJrvWw21UVfKR/owYgLtY6rRcsm6aVbULDnwEZzAJUhTs+pG5ua4Jw7dkeG8+tbc
	zmvr/TAf7hHde/7R8rE6iMwgI/MMRNvK4Bq8dYwsscbx/GWT0701p843kIqZjKN8T1oCH
X-Received: by 2002:a05:6000:40ca:b0:43d:70de:1c62 with SMTP id
 ffacd0b85a97d-43fe3e120c6mr64592007f8f.45.1777260803470; Sun, 26 Apr 2026
 20:33:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427001602.38353-1-dwindsor@gmail.com> <20260427001602.38353-2-dwindsor@gmail.com>
 <CAP01T74iuSDJeL6g=5yLdYGb-VcESK1SYY3R1S1r-CtQEsW+oQ@mail.gmail.com> <CAEXv5_heSFK5rZYtaJG70Xgv92Um6Dbq8b95PtnpKy7XFwpKUw@mail.gmail.com>
In-Reply-To: <CAEXv5_heSFK5rZYtaJG70Xgv92Um6Dbq8b95PtnpKy7XFwpKUw@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 27 Apr 2026 05:32:47 +0200
X-Gm-Features: AVHnY4IWx2cxeZrRnlqhjZ1wcwst3yduTrI_1755npZU2JYycYn4il-T3V10fRY
Message-ID: <CAP01T74WBjcMXbWYeaWB-oTk-bUzoxi_EEALDpT1hFUEOovnpw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: David Windsor <dwindsor@gmail.com>
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

On Mon, 27 Apr 2026 at 05:24, David Windsor <dwindsor@gmail.com> wrote:
>
> On Sun, Apr 26, 2026 at 10:57=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Mon, 27 Apr 2026 at 02:16, David Windsor <dwindsor@gmail.com> wrote:
> > >
> > > Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically s=
et
> > > xattrs via inode_init_security hook using lsm_get_xattr_slot().
> > >
> > > lsm_get_xattr_slot() claims a slot by writing to xattr_count, which B=
PF
> > > programs cannot do: hook arguments are not directly writable from BPF=
.
> > > To hide this, the BPF-facing API is just bpf_init_inode_xattr(name,
> > > value), and the verifier transparently rewrites each call into
> > > bpf_init_inode_xattr_impl(xattrs, xattr_count, name, value). xattrs a=
nd
> > > xattr_count are extracted from the hook context, which the verifier
> > > spills to the stack at program entry since R1 is clobbered during nor=
mal
> > > execution.
> > >
> > > A previous attempt [1] required a kmalloc string output protocol for
> > > the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all LSMs =
to
> > > provide xattrs for inode_init_security hook") [2], the xattr name is =
no
> > > longer allocated; it is a static constant. We take advantage of this =
by
> > > passing the name directly. Because we rely on the hook-specific ctx
> > > layout, the kfunc is restricted to lsm/inode_init_security.
> > >
> > > Link: https://kernsec.org/pipermail/linux-security-module-archive/202=
2-October/034878.html [1]
> > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/commit/?id=3D6bcdfd2cac55 [2]
> > > Suggested-by: Song Liu <song@kernel.org>
> > > Signed-off-by: David Windsor <dwindsor@gmail.com>
> > > ---
> >
> > The explanation and code make no sense to me. Why not pass xattrs and
> > xattr_count directly as arguments, even if you choose to restrict the
> > kfunc to a specific hook? Why does the verifier core need the hack to
> > spill the context and extract the two arguments?
> >
>
> xattr_count is an output parameter; we cannot currently write to it in
> bpf as there is no verifier support for writing to int *.  xattrs and
> xattr_count can be fixed up by the verifier, so we only require the
> user to pass the name and value.

Sure, but the kfunc can. Did you try passing them in directly?
If that doesn't work for some reason, we should fix it instead.

>
> > pw-bot: cr
> >
> > >  [...]
