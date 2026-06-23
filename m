Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701EC37AA99
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 13:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782221989; cv=pass; b=X1KGDwn80k5fw2N7fMHmyOjjQCdxR9lqojtkAemD/gnZI3PP+Xdi0tp2hZtnKpFdYYi9oDsPlt3llI2BpNFLLQsMgQ4x2E/9oDg/pSZ98r13XKf7w2Qfwe1wqaH6XsZNUzkD7aW8VX2D7IPEfRhlVkV2uSVA2gUXO6kqJ/c9/so=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782221989; c=relaxed/simple;
	bh=L4IfkIiw5zh3io2aytdRQLEjDNk9aml8dgDTZJ18U20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjw47Qe88M1+SmHmrwpXarH9eWU9JX8r0KH4h8PETeDhHHAiVp8Do++9UBjpyXm4XvUoBuf7zIR4Z3NA1XDxOyiJfgYTuik4q4J+wSDw4pkQPvx1cNeJpF1UtmrrFXbY8LnPtGaLA3o6lOSmO+R/e+T6ff5JDJDF0TfK6Mz2bdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLIpvkaX; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLIpvkaX"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7dc6fbf3e86so62156257b3.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 06:39:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782221987; cv=none;
        d=google.com; s=arc-20240605;
        b=W32w3/Xy9720AUrbLbJ+n+tQ1q55qmuXNwsFRFBOvDI3BR4yyx59ndizxAO/yC9uyp
         hFp30jNbhI+dNvLWEfJukx8U5mfCkVm7K6ZpvWusY8UK0YUlRIpmATl43u6lj7LMZ8D8
         /fw7Bja23taND/gDegBXMsQv4grH4V0h6jRaLeXJR46+zfqkRZn8etDNskbCRchPSy6e
         ej3NsaOF6iVjGT1r8Sbn11PfoOY37qu/NgaxVUEdfKwpQ6jluAF0pN78XciER7XX366N
         oa6VoHIvopPSwi9DdNpmcV28+6KFQDjhcYG1oihkYY1tXwLpMLOHkOdgalZzQHuBsT6I
         oOvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L4IfkIiw5zh3io2aytdRQLEjDNk9aml8dgDTZJ18U20=;
        fh=9M7VrlgRel0u1MZwn7bRccrZ/bXMH53qm/UT/4YJ4YQ=;
        b=b8hboO59kzugnTCt10ZPKMSGdoyNrfOIuIcxoTxVoaNselomuINH9Q+wp0R3wEMGCN
         KAtzncVfnN8DaOTvapgqNsXyR6yk+FcokNSyqZU1gW7tmHgXrHL01eMpYhAD4+QTN+N/
         HqZwvkem+Io+9ODiYaAKN+BhMVySd5dLY1jJ+qEIwOiHGK6Tl2x7a6etzV8w6/V0+b4W
         keuk8DKkMDCiUk9z5JCwqHl3YJVkVB7f3COQeGG1XFsIFyvUNAsonllJ9M7Z+Bp39YNG
         VroId2MpiWB9AxCckPQAWdd1B98qVOX2RksFIMI+YDVeI70gBcj16AziDuHONlskMzW/
         O2OA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782221987; x=1782826787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4IfkIiw5zh3io2aytdRQLEjDNk9aml8dgDTZJ18U20=;
        b=cLIpvkaXey+ld7qiY/Otj9W2Y6JGbamesKY6QJD25O54KbnUtFDObPUfVDXTaliS12
         spTbl4I7jpT4WwOmZgF72CY0GvJd+19F/g9HQkmlQijP7CmFE/LNtgdq4oVosL21ifND
         UEg6qWkwdy64MJB2xIKxK9SII0EssYRYg38vOZen/VaImTZ8PCowjO8wt5Y9xcZj5nke
         3Lx69A2uum9i9kDx5DOWAYGKvZAEOhYvX2BBYKLUvOW5N9VTGFw6K9IACmbFnvQhtYoz
         sIvZRO6jR/CotskIPlTUjNqW18DPOyrsBotKFsd2LDKNduipAsi52nS8Jm4F32wN6nje
         T7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782221987; x=1782826787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L4IfkIiw5zh3io2aytdRQLEjDNk9aml8dgDTZJ18U20=;
        b=ORfAFva3UbIOV6fetpr6SaaKEqxvoHokUQxWr2fOHBLMEm6EI/23xBqymOa0T+u8bK
         RnvtCQoWk/wXJtxPfkNYZiZqmxGz9X+rZCkivOOPy2DmW0rZVg6nfIOG5UK0z4elXWDp
         K3BAjb8jCvZvGeQYh6npF2h8zxdHqEqxqiEQELT/4US1YqtjJ7Xrke+PEF1wiDqwj5YQ
         gRJyVCpG/67LelrNkx9Bqd4g04p8jDjfQwMyxjZauRyfhQVVSFaTkNAFrhwbdrab7a1y
         wlbbm4AVCgxooIlbMuECGVcSrMG4a8R8jIeaitYi/81xvJzLovoTeel+FtQJotM2/lzT
         VwYw==
X-Forwarded-Encrypted: i=1; AHgh+RrJeUPE2A/LfafJe6shEemiOm4sMJLQJRRRyq5qXWVmp6vzP75Y10yUeyv8vLhgW3XenwEdq3TJT2wRY7i4@vger.kernel.org
X-Gm-Message-State: AOJu0YzPXa5mM5Fhrp/djUH0PgwaoVevsGmuTFnZqwh/iGotA1we3bIL
	iQKvS4guH3RfqKebw5O14oPPkGmSrhHbTtDyXJwYC2jCzTTw032rE0+7vfRcVuw4c1zTcQpEKpk
	xK4XK+wHBvBJj+mC/JCQ9EKAVoxk6SGE=
X-Gm-Gg: AfdE7cnnjwT6Eo04PxgIKuU0q2+RUrHXD0/dj1Bpeuwv97Ws/htBmtZnzWsOqty/YcP
	R54IS8oBG8lViJ/bq3NSQAqZNfKFHogxthjDbs7pAumBlWU+i9Q7tFO5ss6D1btW0gTbMovn/J2
	5aJ0W6L8HsQVHv2DK+i9E5Yp1OeAjjRAdff633S9cPdKQH12nemYbb95KIkeXkiz3KCZ7K6uTzl
	2B/tTnzrSCtfxj0FXE/iHOhJOITUnTI65FoqOk1ock321V/I4KOAr+CjB7BnSgFeXaCMWKflapD
	RsUDZmRGK11dt09CNMpki11YvYHLzQ==
X-Received: by 2002:a05:690c:4d41:b0:7f5:b3bf:88e with SMTP id
 00721157ae682-806be6eb1b7mr29713817b3.0.1782221987298; Tue, 23 Jun 2026
 06:39:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623084337.54344-1-laoar.shao@gmail.com> <7c986c19-75d5-4092-a08a-4f865947e7ca@linux.alibaba.com>
 <CALOAHbCEgWi2MjFRO7o9mDtho5TnkLvruK8VgOE=zKdEB42AdA@mail.gmail.com>
 <80869b29-0791-4f63-8fa4-24bc039ce701@linux.alibaba.com> <CALOAHbAKVF7bLcT_RA8xP8djkSFBXfQiw8h=jCs_-jknnqHioQ@mail.gmail.com>
 <7f9e379c-186d-41de-926d-bfc020e6c87c@linux.alibaba.com> <CALOAHbAY-3GAd=7DsA74W4ax7aPdXC7ecYt6b+tHoxFu754ZjA@mail.gmail.com>
 <bfdf1d1e-2313-46e7-8567-da2a363d6b3d@linux.alibaba.com> <CALOAHbAShZ-xYWw5yObqea4hB-4=NmTz1HiKQrApZpxsHvG_wg@mail.gmail.com>
 <ac56e537-d095-487b-8272-726d6739d0af@linux.alibaba.com> <CALOAHbCBo2eB0xVoSv8Vi+r3DwbwTticismFSL3EXyYuwFkEzA@mail.gmail.com>
 <13bb8cba-c82e-4a41-aff1-0a6418873bf1@linux.alibaba.com> <CALOAHbCkbSBVqUStUbWB=4vUUOEyB63yMsXvS_cZUZOwr-nmew@mail.gmail.com>
 <a5a1b56f-0b1a-473d-8fc9-8cbfba85813e@linux.alibaba.com> <CALOAHbCrvbvT04O3v+p-CmdqVN2BGJYKj6F7we70kPwbs-hmRw@mail.gmail.com>
 <b4d43064-7a7d-4d65-b65c-56e80d47ed17@linux.alibaba.com>
In-Reply-To: <b4d43064-7a7d-4d65-b65c-56e80d47ed17@linux.alibaba.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 23 Jun 2026 21:39:10 +0800
X-Gm-Features: AVVi8CeK8zXAwIHu1NY7tOKvjHMtQPkwav3by9RB0Oiklh2Gjak-msamIZ_aVLk
Message-ID: <CALOAHbBGvTNFC=ScHWVG-MLqsKM0P6oqYpbA_Ls2G5g3kSWAkQ@mail.gmail.com>
Subject: Re: [PATCH] ovl: Allow changing default fsync_mode
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: miklos@szeredi.hu, amir73il@gmail.com, linux-unionfs@vger.kernel.org, 
	fuweid89@gmail.com, Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Jan Kara <jack@suse.cz>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 9:35=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
>
>
> On 2026/6/23 21:19, Yafang Shao wrote:
> > On Tue, Jun 23, 2026 at 9:11=E2=80=AFPM Gao Xiang <hsiangkao@linux.alib=
aba.com> wrote:
> >>
> >>
> >> (+try to cc more FS people for visibility.)
> >>
> >> On 2026/6/23 20:47, Yafang Shao wrote:
> >>> On Tue, Jun 23, 2026 at 7:59=E2=80=AFPM Gao Xiang <hsiangkao@linux.al=
ibaba.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 2026/6/23 19:38, Yafang Shao wrote:
> >>>>> On Tue, Jun 23, 2026 at 6:25=E2=80=AFPM Gao Xiang <hsiangkao@linux.=
alibaba.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 2026/6/23 18:18, Yafang Shao wrote:
> >>>>>>> On Tue, Jun 23, 2026 at 6:12=E2=80=AFPM Gao Xiang <hsiangkao@linu=
x.alibaba.com> wrote:
> >>>>>>>>
> >>>>>>
> >>>>>> ...
> >>>>>>
> >>>>>>>>
> >>>>>>>> Again, I don't want such customized messy breaks userspace
> >>>>>>>> again; with that patch, container runtime needs to consider
> >>>>>>>> if `volatile` is the default which just breaks the existing
> >>>>>>>> containerd versions.
> >>>>>>>
> >>>>>>> I'll leave this debate to the overlayfs maintainers ;)
> >>>>>>
> >>>>>> On my own perspective and be responsible for common users
> >>>>>> (and as a containerd maintainer [1]),
> >>>>>
> >>>>> No wonder containerd is getting harder and harder to use ;)
> >>>>
> >>>> What do you mean, can you explain exactly?
> >>>>
> >>>> You're just adding a new way to break the existing
> >>>> applications, no? You just breaks previous shipped
> >>>> containerd.
> >>>
> >>> It's your responsibility to handle the cases where "strict" is
> >>> explicitly required. Please do your homework. It is not the kernel's
> >>> fault.
> >>
> >> How do you modify the existing applications and scripts
> >> to adapt your incompatible new Kconfig?
> >
> > Why do you still insist it's "incompatible"? As far as I can see,
> > mounting on the same directory is a very rare case, especially in
> > production environments. If your use case relies on "strict", then
> > simply don't turn it on. Everything across our large fleet of servers
> > works perfectly well with it.
>
> I've listed my reasons since this patch is really a red
> line for me (otherwise I won't comment your patch, it's
> none of my business.) and I've said enough, and the
> upstream kernel + overlayfs does not work only for your
> company:
>
> You should first ask and gather how many existing
> applications which can mount overlayfs will deal with
> your new Kconfig; if not, what is the target audience
> of your opt-in Kconfig other than your company as a way
> to workaround "docker" upgrade.
>
> Or if you'd like to introduce a new incompatible "overlayfs"
> (an overlayfs cannot mount again by design + volatile by
> default), I think we should name it as another fstype in
> order to avoid breaking existing applications.

I'm exhausted. We will keep this feature within our local kernel.

--=20
Regards
Yafang
