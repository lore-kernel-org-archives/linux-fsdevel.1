Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC2B370D54
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 13:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778245293; cv=pass; b=BEOw3G4u3yLFRx4gwxk+6zzsyPbnUliUUI+X6uT3xY2ICYNZ+9zkaR3mTHTVe14KhOXK6dvd7d8ARngw/j9nycusvNojhBVgaeofjiAoaolC9+fMKJX/QQGRSHaZBdtOq/KVkVxLrX6r6C5DqYkM/L6kAuIjBD6xo6V+KNoQkbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778245293; c=relaxed/simple;
	bh=UEqXicTfnM6HdHxwrNeRDh2kHHPbf0wyeUC9LcwMo5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o89CiD6HWSmrbFvG+NdC7dTppmgIpJ6RlidSqir6GF0FKRfKmVrpYEWw0hVpXwgINY4AtRd0D8b34bCb/zBwsvHEKhcLkaIN9XGta16ywy4aomSRmFFReUyj727xhn6KF81/mp/auHgkhkhQyRx9hX704sTMZwmQFDDfF4Za1GE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLNIOxz3; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLNIOxz3"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-67b8d9c26bbso3438486a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 May 2026 06:01:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778245290; cv=none;
        d=google.com; s=arc-20240605;
        b=OBdBLcOPCnJeaFCOhqj/mb2lJW9cB4yuZTV9GBhurpm4EPyDdU5mtYt7um6IUmKCgL
         /E0TGs18vjYGHCJYuzviGPotMW+ctjpghioKcg3eDcZs9rssgy6h6nv1ubkA7e7WxRug
         wqwMrj9ZyipcvX9QM8jtl1BJ+6HOfQtob5EIoYEAJh8PE3gyQhqDRMiEa1GqeZq0F6DN
         2q8CLzSIhKV1nPUbDIJwIx0jPGp5w0SAtkqThDBHfQAVgXSO3Z5WQ4aqfbSS0JY07wU5
         25kJpxpNCDM6cnVU51H5qXBKsT315pcJNTdbQqhsjh6FtwebTNFVWeepoJe827JP/k7c
         nybg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eheK66B8cRyIDoMQkUeVVcUOm8ou8dWbCp5qpckbR9A=;
        fh=0HKCtmjOdyu/gAkiGTRrLFPZ04dVCqkqwZ1GOF0Fdr4=;
        b=esee+9LwNr7ysWFRlcNnCCdFFmCU0Iqy+FPr6ywO/u2zNypGROrZij3ghQ+fODTnCo
         M2gWcGYdlTOMwh/N3U8xLcs14UXsEzbyU4C7d5T6+TnThVBnR4maCkh66UDPKpWpKWAW
         siXhQe3itOgagZuZ/yQOlEwDakm5VKtspyKdER17bYnPdtlw0Dttg2AmJc2uiWl3ISjm
         r6q667XPBLU1XRlE/bSHsTs4LN0xB2cpKNuoG3coNIfa9QOFwO3TqYt8hoawKmrCJe1G
         hpDaxzO2pTTftTocjY8slc118U+QRELYbmnOZ2TtZV6YBioeRtX8Aq8FBaZvla1x4Sc2
         kJnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778245290; x=1778850090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eheK66B8cRyIDoMQkUeVVcUOm8ou8dWbCp5qpckbR9A=;
        b=QLNIOxz3Wz9ArprLItrB49FsCcL7HVGe1Z1nd//UQyiKkw5KVEejTK9QFrYxGum3g7
         khYkbd2DLTIiTBYXm+7Oh/TefGipDvDB6BqzP92eko2YBNi6mUWImMhoDXc9qSHbpHy7
         4sb8WorKN9nylnnGBs51GCvG3mjx/1JlAbR6ZlRferljS2r10F7irfc8UMJs0/AXwpdU
         dRdBHdNrYDB0rTgRGvoROAPK+sOnxkhY58qUDdWsmUTwAX0R4R7tzpdn3UMp2qvKZSTh
         nlrMennXjnyBQIm12ztBLSuE5ebzuIRarB+BnRcLzS4LzwczdQLG+jbrM3dIFKG1WLbF
         CAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778245290; x=1778850090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eheK66B8cRyIDoMQkUeVVcUOm8ou8dWbCp5qpckbR9A=;
        b=APYU3nqUq9nBxFAYJR1ryyo5wmDD4UW3kiWgyJoorK+i6aSpaZCPwEkZV/ZOncDIif
         w3ou8qdwYdkW2vc4a99MtsyvGnW6GJqHjmqRwMVUF9nxv++1CA3sHrcMRrXWEkqmcQOc
         M+pCZKFcbV/TUAY/TTPRxkMGBFLf3aLdNLKu2g2GKy+2mtFesTPcba1e0ZekGs9dnTug
         w3q3WtWE0csl6qURX/2jNbnqmX47qeVOLdmsBGX+ruKbcMeENuSSO23EearEaeybXDUi
         e2RKwps1D5e55L1WCefuZzKw1E9XGoKD7g1Xfk3RyAcVUXfhwWPGYCbDq+MQPdq1TqpL
         SQuw==
X-Forwarded-Encrypted: i=1; AFNElJ9Ue50vFBfBiiBIlOaJOZn9JWEH/nce9L49mTEHI/jPKrikS6cir0x6eHMR+4C2rNczwYT+y6PFy5qdct/t@vger.kernel.org
X-Gm-Message-State: AOJu0YztPcCXh3beBRUC3fhAAAuhgEmUNTyekjqHCxjdQm6NHkN7szDn
	9E6uygYIcEC1Fnu0/yLaUvv2boo080lSlvkuabDriwGH2gVhQ7VzApD1D3IX7HNBJxiLOFblgjx
	vgfaxkwAfgXjPzCAr+dikTpZDFZ3Edx4=
X-Gm-Gg: Acq92OGb5uDSq7l6lSTwcnIk1Rm0X9+uZUoA6yaiqPXhrEo5pNWoaaI83Qevrl9ecP1
	j13xCdzX7513gQoMDLRNe1nNX0ZpTKP8caXwH0LpAsjMLf+/Wocw5x5FhuJLrEURpogsyC9H+PY
	4BlqrupzfYpJQQilR7ey8mAu0OTJtAtfNesyIYD3LZT1z+IBTWSDuDbPoXfqC8S/CBXWaFiqJTI
	8JFUY66ZdMZ7MoHK3qxihMbM/T3O6028fvfSZ6ibJ7IneMaBpQ/tAKneflLLOVyo12PjY3SsuUm
	tmDaZvEHy8uJFEpTjpyaHKxa9+9lJ6uKwbvHeBuhqg==
X-Received: by 2002:a05:6402:4348:b0:676:9caa:f070 with SMTP id
 4fb4d7f45d1cf-67d642b23f0mr6835419a12.14.1778245289801; Fri, 08 May 2026
 06:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429102058.1362965-1-mszeredi@redhat.com> <afxK2HSiwY32KaWw@fedora>
In-Reply-To: <afxK2HSiwY32KaWw@fedora>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 8 May 2026 15:01:16 +0200
X-Gm-Features: AVHnY4IXxta-2ngFEGkxy0LC7oZseIvF0NghuKtJ8IJRDq2LCu03iYMcxCxKPsg
Message-ID: <CAOQ4uxg-tgCmJkjFAQ86_xB7dDQKGy=geKAcxT2vB8cUSEKdPQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: add fusex filesystem
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	Horst Birthelmer <horst@birthelmer.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 10:49=E2=80=AFAM Horst Birthelmer <horst@birthelmer.=
de> wrote:
>
> On Wed, Apr 29, 2026 at 12:20:57PM +0200, Miklos Szeredi wrote:
> > This stands for "fuse extended/experimental".
> >
> > The purpose is to provide a clean base for big features like the FUSE_I=
OMAP
> > api.
> >
> > It's also a good way to try new stuff like file handles and compound
> > requests without the risk of breaking something in the large and comple=
x
> > fuse codebase.
> >
> > Whether these features will be migrated back into the main fuse codebas=
e,
> > or fusex is going to end up as a major version update is still up in th=
e
> > air.
> >
> > Major differences from regular fuse:
> >
> >  - local filesystem mode only

What about things like?
FUSE_HANDLE_KILLPRIV | FUSE_HANDLE_KILLPRIV_V2
FUSE_ATOMIC_O_TRUNC

Does local-only mean that all those (and default_permissions)
are handled by the kernel?

> >  - only synchronous FUSE_INIT is supported
> >  - only no-open mode
> >  - new requests:
> >    + FUSE_LOOKUP_ROOT - return nodeid of root
> >    + FUSE_LOOKUPX - FUSE_LOOKUP without the getattr
> >    + FUSE_MKOBJX - merged FUSE_MKNOD, MKDIR, SYMLINK and TMPFILE
> >    + FUSE_SETSTATX - extended version of FUSE_SETATTR
> >
> > Missing features:
> >
> >  - file handles / export ops

Need to sort out this API that grew odd organically over the years:

FUSE_EXPORT_SUPPORT | FUSE_NO_EXPORT_SUPPORT

The problem is that libfuse declares FUSE_EXPORT_SUPPORT
on behalf of high level filesystems which do not really provide thse
persistent NFS file handle guarantees.

I see no reason for fusex to not support lookup by ".", which is
anyway needed for "reconnect", so a fresh FUSEX_NFS_EXPORT opt-in
for "re-export to NFS" may make more sense.

Thanks,
Amir.
