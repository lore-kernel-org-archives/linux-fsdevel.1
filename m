Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5CC31F99C
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2026 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780413082; cv=none; b=OtWbS6z3PTen7rvvABrPcvXHD+b+JlrJwvSIPqvrIF0dFn9qeqJw6nTk+WGhSb3CwijKd3pu5KKL8sbXzGUhPJ/kiMEeR+2ejGrp1/4p7dQsKUdqzs7EKrhUxWdgdd6BYDzDVzTzDjHH6sBqZVe5lozd08f3HhZ//5GM0VN36Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780413082; c=relaxed/simple;
	bh=29/9dBUcmqr9O5d6ERPIiYr4LHxA0CXjMOtvNyFeH4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yo9Bmn40+0au4T7YpL3hXXabITpJrGlsR5RqqJOb1xub7hWOM9aOV2La9I8r+cYjt+/c+7Z7EGVbjRtCycoLH3TWZR1Cw/VFK93O3go3RD5cnpKF0NIDdNL6wbob/onLLhBpw1GHUisqEoFj5pTCxsDCjoB7iYb6FobBFURMgOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5kUCT4o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5kUCT4o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686B61F00893
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2026 15:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780413081;
	bh=29/9dBUcmqr9O5d6ERPIiYr4LHxA0CXjMOtvNyFeH4s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=H5kUCT4oRxpk5FWTnkfqRm+9xiu/VU5YiQCbNRg6syleRGfsie5zqOIXMNHcjlR/0
	 4QFoQoSsoDQVrT9vdMyMYsBzH97sp0zUUlKAIrgxoyM+rvwQ3BFfAGN0Q2tGraJfgL
	 o0mYDS2tTPMYq0JbfykjrN7+NLyvMTDnLntrP8HaQCC8jnXsGAyYTmypPvTQ7/gHJ5
	 mO8Q583wYPfiwiIBOnefkSxln2E7HMEYHdvlo+Fe2Edc1HGl5+4YL4gD920jz3eVps
	 zteGwJWWZ0hJd/WGFSH4HGscLMziWWPef+h25GYMi2D8fb3Ysoxa5S4wwQV+DvLfx4
	 GmU2grSjdd/hA==
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7ea16f090b4so806717b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jun 2026 08:11:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8AoR8OrBfK2/jNGFlqut7MZB9Y/64ULL8v8NALvlkI6fhTbWgMEJAu2NrEIt7aeUUnBX54rYn9G7tL4MjM@vger.kernel.org
X-Gm-Message-State: AOJu0YxoRgp+CV18zOSf5Dud9ddoPYetsy1fb05wjNX7veFOiGwuWKIe
	7Bdl830bvgVhLe8NwmfFIf3lOpo2esDESxXJOy61AuTyUiYB9XVebWGr8WJMM91ixnUCps6B2SJ
	R27TeWHmFiRSsofQH6St6SFEB6bLZHmw=
X-Received: by 2002:a05:690c:dc2:b0:7dc:a5a8:8b9 with SMTP id
 00721157ae682-7e058d3094amr151623627b3.10.1780413080807; Tue, 02 Jun 2026
 08:11:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20260602141434eucas1p15746f013244db658407ada4f3cea7b89@eucas1p1.samsung.com>
 <20260602141427.2301354-1-m.szyprowski@samsung.com> <CAKYAXd87d8pycHVc7GLu5jTemowzRaLOSVfHLaBXYkUtetUN9A@mail.gmail.com>
 <CANFS6batPUtAt5dPhLYVgceKFODCXpfNOuWhVSHKeSFoMO4umw@mail.gmail.com>
In-Reply-To: <CANFS6batPUtAt5dPhLYVgceKFODCXpfNOuWhVSHKeSFoMO4umw@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 3 Jun 2026 00:11:06 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-iA_X=iW_xWwhae9NnWmVgPWD1LkLLfq5CGpZPgO2jKA@mail.gmail.com>
X-Gm-Features: AVHnY4Jm6sGdgQ7OrNd6IncFd3UTWhAEK8f24qHpdBLD3wi9GBDMp2IOQ9-BkYk
Message-ID: <CAKYAXd-iA_X=iW_xWwhae9NnWmVgPWD1LkLLfq5CGpZPgO2jKA@mail.gmail.com>
Subject: Re: [PATCH] ntfs: fix missing alloc_workqueue() flag
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 11:51=E2=80=AFPM Hyunchul Lee <hyc.lee@gmail.com> wr=
ote:
>
> 2026=EB=85=84 6=EC=9B=94 2=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 11:38,=
 Namjae Jeon <linkinjeon@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > On Tue, Jun 2, 2026 at 11:14=E2=80=AFPM Marek Szyprowski
> > <m.szyprowski@samsung.com> wrote:
> > >
> > > Commit 21c05ca88a54 ("workqueue: Add warnings and ensure one among
> > > WQ_PERCPU or WQ_UNBOUND is present") added a check for the proper
> > > workqueue flags (WQ_PERCPU or WQ_UNBOUND). NTFS driver lacks them,
> > > what triggers the following warning:
> > >
> > > WARNING: kernel/workqueue.c:5855 at __alloc_workqueue+0x688/0x70c, CP=
U#0: swapper/0/1
> > > workqueue: ntfs-bg-io is using neither WQ_PERCPU or WQ_UNBOUND. Setti=
ng WQ_PERCPU.
> > >
> > > Fix this by explicitely requesting WQ_PERCPU workqueue.
> > >
> > > Fixes: 6251f0b0de7d ("ntfs: update super block operations")
> > > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Applied it to #ntfs-next.
> > Thanks!
>
> There is a patch that was sent earlier.
> https://lore.kernel.org/all/20260514135408.297659-1-marco.crivellari@suse=
.com/
I missed the earlier patch. My apologies. I will apply the previous one.
Thanks!
