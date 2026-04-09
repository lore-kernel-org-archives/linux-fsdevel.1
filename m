Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660883AA503
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775726246; cv=pass; b=j24u6rZXV5Qt1umZrfAwFhfvz/AHGcQq06rzJYo4lXf05DQa8k7QnZEX28lzzho8cy19w1gTmQQdW+yydDEd9Ebdi30k1c0HW+wNyHRGuDKIraydRhUhQDruCY0fOsnOTOf3dbx5CIGX8SI2FMuzD83J+7ja63sP1abyF9x0XCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775726246; c=relaxed/simple;
	bh=nI3PY2U+NLmKCLed6WuZA5K6L7ksvUfb+p4DaYOUmTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LpAZ0OEyH9gapd4oLFZ5GPk0Arme6Fq9Rfv+8j7srrkFSj707oyP60ZyOJx3Ov4loUZSRectQnqEntdZfJS5gCUmBQ/ChDMciFpo9QbVZhn6ha0dk52GK6jS8RSEcisRhzxGAA1pz90KtOALx2aRKzjUFOUWsAyonWwxvuVqiJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=btDy54VG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KZphQNOd; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="btDy54VG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KZphQNOd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775726230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WOFN+O8LoAuBnttisvbugWhgm03yTpszy9FkfI9dIFo=;
	b=btDy54VGRevviJiB7e4ptNDeehXNaKtGs2OgBPxBQ65XiGS6E5YfpPrLEYnZCcGV7B1cYK
	edbyrBIVd8srvXMUUYZbByTRs+UIAPnCF0uLgHexWkwgepzCuSCBQJi8KDmaS281QkjR29
	uJ9npUQUtcVvKhHP4ofPx9FF+gOB9/Y=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-8m3aNaFGMZKK9QjcE168EA-1; Thu, 09 Apr 2026 05:17:07 -0400
X-MC-Unique: 8m3aNaFGMZKK9QjcE168EA-1
X-Mimecast-MFC-AGG-ID: 8m3aNaFGMZKK9QjcE168EA_1775726226
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2adef9d486bso7130745ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2026 02:17:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775726226; cv=none;
        d=google.com; s=arc-20240605;
        b=e6Hv6sVQebbhpDRxGlwlXXaIjSylcbMerVh4MT2kcNzOPGwDmoWASQ6K7uj/JWBMPX
         DMHFQGVPo1djib5+SVFJFagUwR5r1Ov+bonXLPzNI4TLrkIDSktXp1lIe2Nns7Fok50U
         ycrY8SK0SNm6AZWuwsMnV6F8hi90X7ryuA3QbZiIE/uTqJzNIlb0Z1KRf5RohkxKSvy9
         n3RtQ444XmvAxZn+cri6oHZyD734PyKQmN8XzlpEeI5dxWFIuV3vQ0f2dIg/KxzFmQ6c
         /Gck2iJoj09BS0UUKsLCR6BGmfo1mFIbXXc4VUfCwTl0HuGRFQdW2csjsVTAiNGpixhC
         01OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WOFN+O8LoAuBnttisvbugWhgm03yTpszy9FkfI9dIFo=;
        fh=VahI5N1DEOAqgTW7ghmDgbf6XcI7C3Q+N6PUGPAfQQo=;
        b=af8sL0+L+Bgoj6aryMF3DW9jjI/AtBb0pDtf/Jqyf7Hu2rW0kOZvFk0Wz1Ix+NJKrt
         4J1R2jIV2krkyu7/yMxRzjpSIrZyL1i1zMwASJrM7NTodzjC1rWkYR7aBN7cYaw9LtxV
         qAbZHAfwlQwfj0wX3m0eg/bwb6APL3tnhE7W/N0CqzGjuy2ibDuFOubJy8xtHDJTe+gp
         Bw6T/ZUe3qJ9f4rEX9f/vEFFcR0mldyxWM93NF5AF8aS2rQjV8ynpNR/K9+G9dTam6p6
         l4mhGp2sivuELzYeJ3UvtWBAjjPB5U7bc3ZvXEEtnmFFlDsNdUVU7DILbiOI9p56D9uI
         GltA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775726226; x=1776331026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOFN+O8LoAuBnttisvbugWhgm03yTpszy9FkfI9dIFo=;
        b=KZphQNOd2MZ2lzUFAkV2aEzOyKmZrZUJd68VC1wdhAFgUIDQbHkPSCXjY0fRd6X6Ei
         WjUAyZLtWj0AasPiCdZbyzFk9X2fECwPbzO/SA3mHboti9snTCbPJUVvTOZ2f5SKnTvn
         s6fSidnBE3jhtiiNAC/07ROdlDJUAumsqQIP3lkGvh9SmcRI92hj1o8YDvfNLYF25Gh1
         QqA325yotQTgHqjwDaGJ6C7w4wQPIRc0P5W3ujA63Y76rwPrIpjwaAOcv9xzbXKKh+kQ
         1gAvmm51GiIJjzAF2SLHXbNahx15+yuWDArMlsdej64SkMtWG8rHJznIY6K5ClkSwqR7
         mZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775726226; x=1776331026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WOFN+O8LoAuBnttisvbugWhgm03yTpszy9FkfI9dIFo=;
        b=pxWsmNXbs4qGOWOiOwdIVViTwRkFb0cSVu01VguWYcNkN1jZUkA3PZ9uzpk67mtcZy
         EM4bOy0XLC/oKr1+OIzh98bkcrzXyI87EGua+ZONXSJGHYk1nXVAA7t2PwxNMXBD9lJK
         XjPw0l48YXpiicuNrbqhIXuTjFpp+QrGrRR2AdlrnzlH6kfe0OMEk3uq/rN43lAlcHuW
         6yb19nXe6IpCQAB6kVaIsyw9BDYEbl/KqoZySKor7tW7wAHIgg7GXBb+7VlRI4TK1ASn
         ClxvJWL0XLkDo1qkcIfJluhWQ1zoTat1UEisXtG2MM/44arsVJmADB7uVHtpwLpF8awK
         p2DQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlD/8tb4cuppAzIouxstRsptLxJh9g+ekbP8MvK5N3ebFXq3Gfjfdx7yrKtIQ26J+GB+Wk+vOjTqTBqREv@vger.kernel.org
X-Gm-Message-State: AOJu0YyL/dAAmvTmxrKGlz7T3zs7TYYAdoTi7XyVi3JWF/khfDVeeqZx
	g0W5ZVRHwEbJjTrl3A5YjHfTBKPxZx9/iE3P6E+yVExxV3UliV7IpjfXEyej+r9ZlaNErDPkxTD
	gR9C1DMdLJg/Pwu+eAkHMRhQJiF/XyRWOhrthTUAt65XyE9UmlXLc2uvwoY3nVARbCXupQEuBsB
	Nv3W6ce38v8jwQ5KFmNs6a0u9Q2expTFN6XzQTHXaqlA==
X-Gm-Gg: AeBDiet+PsgWPgGiswCmQ3KYe8XKnD+TgPA/ERKA8/uO1M0qbxKFeO+IWBVoh5ihBEV
	q1pFmtW0JpieCdCYCwTsVnJvbsq7JsjPzqrPQfdhuUnzAZNSkWrBq+Yfjc2ZvglNfEDVVx8/zQ1
	/Hoq7qIDgXUlIhids2fWAUuxpkpj8lpfF3XKCwFnPm7Lk+V9pA2/AUsmL/P/962ikNNvzFUxNoY
	IW9Vg==
X-Received: by 2002:a17:903:4b46:b0:2b0:606b:6fd3 with SMTP id d9443c01a7336-2b2c72d51famr29334115ad.5.1775726225904;
        Thu, 09 Apr 2026 02:17:05 -0700 (PDT)
X-Received: by 2002:a17:903:4b46:b0:2b0:606b:6fd3 with SMTP id
 d9443c01a7336-2b2c72d51famr29333645ad.5.1775726225399; Thu, 09 Apr 2026
 02:17:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403030848.731867-5-paul@paul-moore.com> <20260403030848.731867-8-paul@paul-moore.com>
 <CAEjxPJ4nqeuPhve3Fe-tFuNW9R5grnWwfYJv7q2cRu+UPQ5c4A@mail.gmail.com>
 <CAHC9VhQnA38-9wDeVmOMxAFPHnd9y6x5LXtD3cSquGiL_MDDpA@mail.gmail.com>
 <CAEjxPJ62=0v9QYJ6s0DrwRp4WZna8f9wnuM_DUUNrcz2dd_kog@mail.gmail.com> <CAHC9VhQ5PH99EQBuYq4c7Jf82UXiDfC7qzM2kvnZuyH6yFPL_Q@mail.gmail.com>
In-Reply-To: <CAHC9VhQ5PH99EQBuYq4c7Jf82UXiDfC7qzM2kvnZuyH6yFPL_Q@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Thu, 9 Apr 2026 11:16:53 +0200
X-Gm-Features: AQROBzC2DVx5qKVA4ihG0eixfkIbnn_9pZw2Pb18PXvqySFVij5lkBTtbkuLvjk
Message-ID: <CAFqZXNu3t2G6rUDToAH5CCRkHj-n_RVF4L51cmg0J+4W6T4D6Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] selinux: fix overlayfs mmap() and mprotect()
 access checks
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	Amir Goldstein <amir73il@gmail.com>, Gao Xiang <xiang@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 10:21=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Apr 7, 2026 at 3:20=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Tue, Apr 7, 2026 at 10:35=E2=80=AFAM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Tue, Apr 7, 2026 at 8:14=E2=80=AFAM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > > On Thu, Apr 2, 2026 at 11:09=E2=80=AFPM Paul Moore <paul@paul-moore=
.com> wrote:
> > > > >
> > > > > The existing SELinux security model for overlayfs is to allow acc=
ess if
> > > > > the current task is able to access the top level file (the "user"=
 file)
> > > > > and the mounter's credentials are sufficient to access the lower
> > > > > level file (the "backing" file).  Unfortunately, the current code=
 does
> > > > > not properly enforce these access controls for both mmap() and mp=
rotect()
> > > > > operations on overlayfs filesystems.
> > > > >
> > > > > This patch makes use of the newly created security_mmap_backing_f=
ile()
> > > > > LSM hook to provide the missing backing file enforcement for mmap=
()
> > > > > operations, and leverages the backing file API and new LSM blob t=
o
> > > > > provide the necessary information to properly enforce the mprotec=
t()
> > > > > access controls.
> > > > >
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > >
> > > > Do you have tests for these changes showing the before and after (i=
.e.
> > > > failing without your patches, passing with them)? I tried running a=
n
> > > > earlier set from Ondrej but they failed.
> > >
> > > A few months ago I sent you and Ondrej some feedback on those early
> > > tests from Ondrej, but yes, I also had problems with Ondrej's tests.
> > > I've been using a hacked up combination of the existing tests, some o=
f
> > > Ondrej's additions, and an additional debug/test patch to ensure the
> > > labeling is correct.  It's far from ideal, but I didn't invest time i=
n
> > > test development as I assumed Ondrej would continue his efforts there
> > > (unfortunately it doesn't appear that he has?), and I wanted to focus
> > > on getting a solution as soon as possible for obvious reasons.
> >
> > Ok, I'm happy to look at even unpolished tests - just want something I
> > can use to exercise the before and after states.
>
> Hopefully Ondrej can provide an updated patch.

Sorry for the radio silence... I just posted the fixed patch to the list.

I also pushed a more targeted standalone TMT/beakerlib test here,
which also tests the dynamic transition situation:
https://src.fedoraproject.org/fork/omos/tests/selinux/blob/overlayfs-mmap-b=
ugs/f/kernel/overlayfs-mmap-bugs

To run it on Fedora, it should be enough to `dnf install -y beakerlib
selinux-policy-devel gcc` and run the runtest.sh script directly.

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

