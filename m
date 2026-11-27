Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.167.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795780980;
	b=0ucn9YJs3ETL6bCdXRspS2LUrH2jNYvVCtpA6lulvkBI2Ey0FjP8mXUyzUbf2EF08S4B
	 tL4teA3vK0OsABZUSBkqC37+2e5FNRCnIJ07Wocj4ktFWWPKbvmEvcRh+qQsDMccglxps
	 3VIniX8L/5SXNvyoAtq1Jsc7RGbANNc8Mc4PYQIER7X6AlL5N7xQ6dO6QkLROdHvG/zeL
	 SgIkV7/9hAXYJ86qJscDZERE82uTASiAYRvLpB2vC2WwoB4J72ezaV0zHNOjjCX1eqjzQ
	 HnvHOEHp2FucnVpkBV5uERn6opYm2erM+c6zaQaf50k6gIe+voUx7wfTloM8ZqSYkiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795780980;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=sKBAqoHb6dKCB8lGd+jVvxodjbVVN2AMGRa9Yq/Mby4=;
	b=dGL9Q3Fk8mlCYUC8DSwc518MS3Qe/BgBnL1R9fjRbN2k1P/pm0UZGVjnWK8p0Y2Gu0YJ
	 oXezojorHJBpkSWYUF7OE3Z4vDtGrtYBYTXVkDewJ1ONgPtjZqejU40m1YpUJRVk9zzo2
	 qHsIouCaQnSNsevOFmnlGSCXpYLW3aO/nktq5pq/lRlSFICYLvylPImKUqPB19JJbtDM9
	 25YzJe+xTGbxK+uAz6VYiYjlzGQd98mrAVFJGXmFsd4/pCGbdGs3oiu/u3D4TbpDTHL4e
	 qLocO02NoqjgjLFMf70dVU4Sgk3NPwqOXR+lhW+2h6pA2dE/rq2wtN0EHEVIsErgeAA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SnFA07cx;
	arc=fail smtp.remote-ip=209.85.167.52
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82E9606A323
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 12:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C82E9606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SnFA07cx
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5be53e5fce1so7366708e87.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 04:02:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795780978; cv=none;
        d=google.com; s=arc-20260327;
        b=E8lSY4LL9D5xiw7ftv0M9Og/G1s6EBIsqAUniTIiZ1ptDZ1Pd+kqTOWSexUf1WYgey
         7SwY8aHkfVpfJEJ9Q2g3Q5ezEVTqgHP1Ka/Qt1X15PratGX5yL3+QtzWGXAnpzLmfE8B
         nMxVAnFSwHtAXGSRt1c0Ujz1FZLR9IP5YY7VySSTzSPSGMtXg2WGWDzVIyLjWUAJ8fWd
         CgKJIWvKdNKlGXSwpnXQ/NzNUWAyBVgUENFMu9SbbDfrdxyCkSuYjgLP6J963FEM64Bd
         WykM+sKuyk0JpT82xyUEfd66jfDzbOIY8se/8FibX1iLR/2EHrZMnCtulZBJU1cOKKJQ
         C2fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sKBAqoHb6dKCB8lGd+jVvxodjbVVN2AMGRa9Yq/Mby4=;
        fh=m3cJdtf+Ox+LV6rUYDX0Q6zkenLX6/jGDKEL2+YQM/A=;
        b=qrkQ2dSBJUJ/5PjGJ7sfqiRotsLALZegcSQaa4Ob/zytBX5MJiXG/cGATdXfQfy0gX
         6Qw07orSiGGTJ5ySTlcX68ousurhD9gbwEz9UNwPQFlafYRbQC6r1duo+pNzV7YhKXrf
         KT1bXi9p4sGeC+I4x5Kd46fzjdJbhPYFhc7ZRG3gcT8OJ4KwaIoLlrpzhrl5F/k71ErH
         3WLzvIHZRFbTA1wmYDEZ6jEnd1AJGrWEbIwkYGrMNdbCaOpKqrdDG5KfG5P6RzblxtXS
         SXVv1hI0h5FJIr+KzWdAHAwTx8DXUG6+6SfbqRRpt0b61DWChHt/aFoQGA6D2VooZNyy
         55Dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795780978; x=1796385778; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sKBAqoHb6dKCB8lGd+jVvxodjbVVN2AMGRa9Yq/Mby4=;
        b=SnFA07cxVyuwSSQ2WlqVldYscrENhFj8PVisFe6EUr/u+zjaGcOlyf+NO4/VeKXXX7
         4E5nqOC+Z3I662UCySIHIiaMwrjJK+ZjK9X5FK/V848T+A65ClvPxk5bvJvrsV+MWdo/
         JIM89r7vSI7FFB67/tWpYnfwZs9/cVksgSfXEE4llKDhqleU1ZWfSy+N4AE/zsZMEKkf
         FXtLBubySwAUA91pvO8XAdbubi6E7QFc7BDt/+z27xlpQGmIW0sbpzCnfaiUYkOVUtJK
         S6zwuiZQCA+1rzhAC+jCChTTNWgaEmMmc18deOG2Q+9ze1ubEHLrjAXDP7U1S018fipI
         jn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795780978; x=1796385778;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sKBAqoHb6dKCB8lGd+jVvxodjbVVN2AMGRa9Yq/Mby4=;
        b=tKXCJzt0xP4MwRYG7a1RhipamJpGFtFZuDHKVRr+0Lcg6KQqYj2Tw6zOlUR2BgDlAP
         fF3vMd/JworFb0FnI0SUQNBapnY4MJPPy7LQw0Vz9viJP0KuhD2zH1m1tAXt6le14Zlh
         4jk1KqXUYN6jvKuNvGOLPJxM+0BWvaabafbyNX5nhQDfrPvjuzI9v3KYBEjPyPEY95+E
         q5yMjtiqTRCDc+yDi88tg+HoysKjrBg195ymIa8mLJHxzDUe5AgPDst/vAoqr+k+QMBD
         MFfLSJMm9wQmQH1iiEd1fvod8zTOlU+z+wgnr/h1UFEb9CopWADCbrCRlhVxSJ6AHBv5
         38oA==
X-Forwarded-Encrypted: i=1; AL+hErGPrUBj2gm2xxfHqNf49ZCHBc9tafVwk19b0ENkkW0IVTa5DI/M+ExEJDkmuTT/kZoeq5TOxrzF/2MZmIq9@vger.kernel.org
X-Gm-Message-State: APuU4Z+CJoji8XnFRaadyYR04v5NsZEaQD5hId3BtfsqrP1t5xuZQiiO
	TaT/5Nv3BGNWBZ50TAcK6tjQ4BQarByI+j61nCxvjpdeKy7/RMP7RFZmHms04Be9OOl3R0W0yxD
	+X7W3uLC+gZegya5LtE0CDXtZ3ATiG+s=
X-Gm-Gg: AZFdTZemQ22cjdZ6SCDDkY5ZwH8TmmuXp/4zVExzT20aq+e7PuhM5sBWipMPqXJ491t
	sZZ3iPqOdXQm3uFIF9eCzeJj3m6wZyltOlDKM3AKpQ5HG2FMv21iEtAX8jdRd275IpMT9TcbsC3
	JSlcJBW6vS7w8qBF7nx9ZlESbJ/imAM1+FyF3GkvN/nSiVm5CJ+2lH10EWFsefyCDT4akmtxqUF
	RBTWWJ01AErWcIkVgbJipgMY11EOE4rlxr1Av+p2d5b55xCMJyuBzlkoqAVz6Zs4ZmazLq8yuHe
	VpLKFcVFBVumHn9CI/uvsdDOSMWOY1PRywLrGT31py75HPLa49SYUkHc3oNc1S3oz3zb0k3i7Nx
	vdNDOhy2rRPWczNZhxRytw4bfQt/zjlBaI8DPCKfjVc2odfk57BDknujrTRF5gZVwQshZmg==
X-Received: by 2002:a05:6512:1148:b0:5bc:cc46:1849 with SMTP id
 2adb3069b0e04-5c1bc874b3cmr6981033e87.54.1795780976912; Fri, 27 Nov 2026
 04:02:56 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261126163114.403846-1-koray.fra@gmail.com> <20261126163114.403846-3-koray.fra@gmail.com>
 <CAOQ4uxjGLfuZMFABCwMvdXwnU+P24G_aTJLudWbjeSmWwyDF6Q@mail.gmail.com> <DN5YPR39J7QI.1S1LCFLNUCZNL@gmail.com>
In-Reply-To: <DN5YPR39J7QI.1S1LCFLNUCZNL@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 27 Nov 2026 13:02:44 +0100
X-Gm-Features: Aa3M54ohq34732gC99y698hjwvA-0NF3EsaW7G0zij4KAugMs04c_-FFLASygdQ
Message-ID: <CAOQ4uxgzmB0dEpQCVGKOc8reJ6OFV=BxDMgRW81aKiCMwDSn_Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] fscrypt: update fscrypt_prepare_setflags() to use xflags
To: koraynilay <koray.fra@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>, 
	Eric Biggers <ebiggers@kernel.org>, "Theodore Y . Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexander Aring <alex.aring@gmail.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Andrey Albershteyn <aalbersh@kernel.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Lauri Gates <lauri.gates@gmail.com>, Christoph Hellwig <hch@infradead.org>, Dave Chinner <dgc@kernel.org>, 
	linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	ntfs@lists.linux.dev, linux-nfs@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 27, 2026 at 12:38=E2=80=AFPM koraynilay <koray.fra@gmail.com> w=
rote:
>
> On Fri Nov 27, 2026 at 12:35 PM CET, Amir Goldstein wrote:
> > On Thu, Nov 26, 2026 at 5:31=E2=80=AFPM koraynilay <koray.fra@gmail.com=
> wrote:
> >>
> >> Update fscrypt_prepare_setflags() to use FS_XFLAG_* xflags instead of
> >> legacy FS_*_FL flags.
> >>
> >> Signed-off-by: koraynilay <koray.fra@gmail.com>
> >> ---
> >>  fs/crypto/hooks.c       | 10 +++++-----
> >>  fs/file_attr.c          |  2 +-
> >>  include/linux/fscrypt.h |  6 +++---
> >>  3 files changed, 9 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
> >> index 149498bdab94..52d6a33fc9e9 100644
> >> --- a/fs/crypto/hooks.c
> >> +++ b/fs/crypto/hooks.c
> >> @@ -182,10 +182,10 @@ int __fscrypt_prepare_setattr(struct dentry *den=
try, struct iattr *attr)
> >>  EXPORT_SYMBOL_GPL(__fscrypt_prepare_setattr);
> >>
> >>  /**
> >> - * fscrypt_prepare_setflags() - prepare to change flags with FS_IOC_S=
ETFLAGS
> >> + * fscrypt_prepare_setflags() - prepare to change xflags
> >
> > prepare to change the file attributes with file_setattr() or one of
> > the legacy ioctls
>
> Ah yes.
>
> >>   * @inode: the inode on which flags are being changed
> >> - * @oldflags: the old flags
> >> - * @flags: the new flags
> >> + * @oldxflags: the old xflags
> >> + * @xflags: the new xflags
> >>   *
> >>   * The caller should be holding i_rwsem for write.
> >>   *
> >> @@ -193,7 +193,7 @@ EXPORT_SYMBOL_GPL(__fscrypt_prepare_setattr);
> >>   *        another error occurs.
> >>   */
> >>  int fscrypt_prepare_setflags(struct inode *inode,
> >> -                            unsigned int oldflags, unsigned int flags=
)
> >> +                            unsigned int oldxflags, unsigned int xfla=
gs)
> >
> > This here is a backporting landmine -
> >
> > Changing the semantics drastically without changing the helper name
> > or signature.
> >
> > Please rename the helper something like fscrypt_prepare_fileattr_set()
> > so that backporting mistakes will be caught at build time.
>
> Yes, though, would it maybe be better to just use xflags_to_flags() in
> the vfs patch instead of changing the fscrypt function at all?

Yes, much better. I agree.

Now looking at the /* initialize missing bits from old_ma */
hunk my reaction is to look away its huge and it should be
using helpers probably called from within fileattr_set_prepare()
itself - because if this is de-facto preparing for a set.

Thanks,
Amir.
