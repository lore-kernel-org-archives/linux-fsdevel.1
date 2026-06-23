Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A80C37DE89
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 13:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222405; cv=pass; b=E9yMlVR3irH0y6RxNGSPvJbi/0WTvH3uazjMjT6fajxXSaL8y4F7G2PGdVuI0qTx32rv+6Rj78b7KS+RuN1Dskb5I3/TvbZ4hC/jK2U8kMbAlwb8GZk8LW2iOGavNNrTwoIoYaetmuin3bUaFlyODuo4rDi1cMYyrXxhVt/x+cQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222405; c=relaxed/simple;
	bh=naGwHbf/OnobalARAnj+vTp84DxAOFSvrLt6sASGyEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AywefJR+Y3KHhYKm3OS3BhVarTjUv88NSIpP01pmwDsxfFvqgiElAYGhAu/cX8+BrzNdhHHEDgp6TMqGTYD9gUrkIXc2AbPJXrHrkmmWLEcwqOP15vHjBKRb8pF/poa/ugqPaR9UUbZbao2DZDFzFvex3TQuijsXcd4xadxyOKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1a9n67J; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1a9n67J"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7ff05e5d009so49872507b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 06:46:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782222403; cv=none;
        d=google.com; s=arc-20240605;
        b=kXhMmlHb4oOSh2fSMYuFaStjtYw2x2Y/TUttgw9OnrvsS9yMAFahZSD9cARc8Vi60Y
         u9wPWxe5FsSU+B6aSqwa8/00QZmb5+ThLURpNn4hI/wPUjiWBgJENPiPn8DbQByf5thN
         zDWx96ixf8GqK7O3i1Zc1nAVCS3hA2jJvqZKPJDbbNDXRS1OU3FOB280XRXkULVr4Wbg
         0+qZtV6vKveuuCdHJ8xleHpzBxPCk6YzONBsF9yOpAGlxyXxs1RReicWzKp1tyEKj7lA
         1aLtStSRH35ee7YNIIPnC0ayMeGfq2WduTo9LwnGSfbw8bou+1u/1op9UGBGXUavkYIO
         jWaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OVDAhCaa7kVcjIMaILCocP+xEUoBfbfXNIP0jnyxE2Q=;
        fh=YDaE7IXc3nvM1/msWv05k/7A3VYT7Jsk2Zt6A4z0m6k=;
        b=RnjV6+wwv02jUMziZT8dGE4KAbq5VXIoAaK4j1jwUxr0CJ1Difmn/ZpQhRaXSjxq8D
         3/JrbMsohqkuPbdFL7utEautGmV7FEv337C+M9YIZMHYHNom7BFI82i0V1sRRF9ASs4c
         TrEwTNWABZdHSPs19Q9uf+DUycYxlC7pMn/kE9OVR5n06eyWPOJ3hiw+jJsuoqub8Kh3
         DonGl3LLezlEMnBySCDsf1D0ADmc5N4emJjtt4k7fvozNmR/z03ogsji33D2jtoIqt06
         w+wXrH9LL/So6H5I44lBvZ1IQXAK1md9xsWuoc+iTLFcY5OWChP0bb8Z8PUoIu96LD7r
         1fKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782222403; x=1782827203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVDAhCaa7kVcjIMaILCocP+xEUoBfbfXNIP0jnyxE2Q=;
        b=a1a9n67J2YqEfodl+hgpP7MzAeKgIVpfgGp6/VoHkbGrjqxOdcZXfsrbsEkDYQfI+p
         QWOp1mbszOBllLc9/W02H2nACjsGYJgeLA2fsXoil6QyuWno3pk9Oh0cwNedJ5dSx6EI
         SfXLwTGLrQ7KB//eF1ObISogQvNDjTQuRhy6sDSLHct/zGkAp368XwU5eXSh7C8IeVaO
         amHpsayvlubsGovy5OIEEHwBOIhVmWBmviLSX2gO3VzKiaRJL6jf8XVY69vJ4n3mBYtm
         bOB5w73qQBWN15HLqDxiFoH4pCeFzAJIiBYEBePqt39k42m32uusV+2KcvMibfLojREm
         f9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782222403; x=1782827203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OVDAhCaa7kVcjIMaILCocP+xEUoBfbfXNIP0jnyxE2Q=;
        b=NvmUjWhgfsndkTXrg//+5TLe2psH2Cl1KuhKAXUHcU82SVMML4KxuIrR5iXyTXGJVi
         calbvSXe90kCPF+p3TYqigmTcCHo80mec/enDYoN8p+TnhICQ/ttUE/HBjHV6TfABNNi
         1S+O5ZApRsdx75pbdovg8kXIvoRdmezDOLFkO035hpfAbYy2xv/ZAWI2+G2xakuqlHDO
         JHpBSpGpZS6ZfhPbgH4pga4ptIiaX4EpgfKt7J6/TQjns/GyV82Mh2soUeppF9JyhWrD
         w6gPNeMflP2tHy11p0RjowDA1NWT/6V0cV4rJDgOuMzeWAaaoGd8sL/WxtVHW/PN8asl
         LxUA==
X-Forwarded-Encrypted: i=1; AHgh+Ropds/QI/1sO7NlqUPQWoNzE22YM6Du/k1nAJDuH2fd9bSk36soePDsiPkKJapA//Txlyt947Pot/xMJxeg@vger.kernel.org
X-Gm-Message-State: AOJu0YweDiHeWKCmzQnnqxrSw32+jBEEarW5wa9mQYcZYM8WtFQvKPbs
	mNoHVgYXOZ2JZgzHZcvHMJAqpXZF33e9cxSk5exTeMQEoG4bWINTt8MMOrvXwb8DYUdbI8R4W6o
	ojD8pxI4O92oKjcswcOPJhS3LHe3VTPw=
X-Gm-Gg: AfdE7cmo8hrmUuphWDfzI5EZ1Ycdzu6Od2YF/A85v02zCm1F9tfuYtwWTyZAu5IoD/4
	SNCPWZTbSVd9eBeKnxkTk9ABv4uIbNi3+PDD45lBdnJ8fwn1XyOvyJr4uCfbM/1q4Q03rWh4YhC
	fYf7lFPRlGAlly5Yc58NZGSayTui3xXuHk5IHhO4wAJWNzAtIoai0mJaTY58sEqNqYzYYBGJBxW
	t0ThqOi4Gn9RPnrZcJtjTYrWB4guUW4k2VZ1oLW1D6EOwbs5c+fYDUXsjUb6k7WnoybhZJwNhYh
	OxlSRId5MwEUNg+cvWVM7qspqYF1wg==
X-Received: by 2002:a05:690c:ec6:b0:7dd:3463:6872 with SMTP id
 00721157ae682-806c43f4cf1mr29454637b3.41.1782222403602; Tue, 23 Jun 2026
 06:46:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALOAHbAY-3GAd=7DsA74W4ax7aPdXC7ecYt6b+tHoxFu754ZjA@mail.gmail.com>
 <bfdf1d1e-2313-46e7-8567-da2a363d6b3d@linux.alibaba.com> <CALOAHbAShZ-xYWw5yObqea4hB-4=NmTz1HiKQrApZpxsHvG_wg@mail.gmail.com>
 <ac56e537-d095-487b-8272-726d6739d0af@linux.alibaba.com> <CALOAHbCBo2eB0xVoSv8Vi+r3DwbwTticismFSL3EXyYuwFkEzA@mail.gmail.com>
 <13bb8cba-c82e-4a41-aff1-0a6418873bf1@linux.alibaba.com> <CALOAHbCkbSBVqUStUbWB=4vUUOEyB63yMsXvS_cZUZOwr-nmew@mail.gmail.com>
 <a5a1b56f-0b1a-473d-8fc9-8cbfba85813e@linux.alibaba.com> <CALOAHbCrvbvT04O3v+p-CmdqVN2BGJYKj6F7we70kPwbs-hmRw@mail.gmail.com>
 <b4d43064-7a7d-4d65-b65c-56e80d47ed17@linux.alibaba.com> <20260623134240.GA7980@lst.de>
In-Reply-To: <20260623134240.GA7980@lst.de>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 23 Jun 2026 21:46:07 +0800
X-Gm-Features: AVVi8CejP5RTOJCGiaz8VdxrRrJhsIxtNpWREFVOphTzfzYmjTnmZ8-fngNkRF4
Message-ID: <CALOAHbBA0i7pX-rbtvu0krN+5BwJ7hTvBo_tmOLTYOOqT6fsMQ@mail.gmail.com>
Subject: Re: [PATCH] ovl: Allow changing default fsync_mode
To: Christoph Hellwig <hch@lst.de>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, miklos@szeredi.hu, amir73il@gmail.com, 
	linux-unionfs@vger.kernel.org, fuweid89@gmail.com, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 9:42=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> I have no idea where this coming from as I can't find an earlier
> version in the fsdevel archives.  But changing user visible mount
> options through konfig options is simply bonkers.
>
> I'd also like to not that the submitter does have a history of crazy
> patches including those to support proprietary modules and then
> attacking people criticizing those patches, so I can only suggest to
> every maintainer to ignore them for their own sanity.
>

Honestly surprised you haven't made it to my spam list ;)

--=20
Regards
Yafang
