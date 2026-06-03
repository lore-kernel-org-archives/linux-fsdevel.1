Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB0644D693
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 10:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484307; cv=pass; b=Oojvt91M/BQktQ39ympeyTkra4fJti0qe8PTQRPxifvi8L4+eDGQRUF/XDaO2Gd+sDP3Q7TcYN/0rPUYPn7/bWRJT6l31nWCCFWE/0uE7wAvNzikCsyStBIS2h4o57Urj5kmHQJnJ9TspQC24NguR/HysMHIYXRUuoMbV5Cmgfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484307; c=relaxed/simple;
	bh=1FLvXjYGNQG/8RrWajopN/MbkEeGxy8r0AENNQRpwXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UBAVOAkDyZa0fFTJsVlKRwWeeZXblj3kxv+FXIwJJt9aYtN33yEV5ylL+BHnOn0JyjqIYAhAT8e3j7vh2Y1sB4dTaxZwBkwk4V9D0sPq3SG+avnrtKNTwXMSYQG3C7TqJ6aAgdzBup5+p8ywV/CNUjXO3YZWvM9bop6VJSFHAOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRpRrkAI; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRpRrkAI"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bdb3fd39045so1874295766b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 03:58:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780484302; cv=none;
        d=google.com; s=arc-20240605;
        b=kSFaRd/mKSGki0O3jkWpmj5I8ry3hAm4OBn3CvOAADSLm/oOJ9QXLM2EomwJ6IfUsz
         FfhvIuSc2wqt7QMYBLXih8/cF3Vy72Q4ncZ29iNCRXFTDgkIwuYkXmHOB4zelN8GsGm+
         mNEYXZS4UqLEl1ukMpSF0L8OCIJxAIcR657vYTIDCSLkXivqGtvjrc8Z68EGIGptUpA4
         QJCqK6p35pATpkxfvsnvPXuQo9xIsJT7UtMbhZW9nOzrQw4/fZIe2VwDIchNznt7h1Y2
         MOj6wSF1kalNqvO4cNj6xPWaRb2MzfTtsxVT93jSr5E+9fBryO9ISZSxbI7841jROnCt
         TSYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1FLvXjYGNQG/8RrWajopN/MbkEeGxy8r0AENNQRpwXA=;
        fh=7fxWvI1tmNCw50kBY8Hqs8VUnac3MXTDrw61ar+iXos=;
        b=FCfK1a93nLpQL3IvZqXUBVVww32hc/7Y9dyla0wxnuIX8kxOujkGMmYAdbSTs1eqE1
         Z9jSlgqutFQvZ3Gs2U7YgKdZ84OSbRZQXBR3cmpAXrfhEMON5rA+iaGRAg66ZMKcNe5p
         9kXVe92z3Bwjjd+vguWO/TCifmdyXPnIevGILbep+qGcyNgFXhLEGCIqHb1KoPq44h2V
         GDOW6TYJYqey2DQCtKMcP0Ros9nO8U/D67lJfM8w9FmPQQTBikr7eJbP+238i8OQfmnv
         p1KL2VvgwFOX0D7z18aS9jBs7PJggrVX9Om7/45UkPRPp2QdGgaEw+5DX+taWGtyEe9g
         5Mlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780484302; x=1781089102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FLvXjYGNQG/8RrWajopN/MbkEeGxy8r0AENNQRpwXA=;
        b=YRpRrkAIIPqdTYCHE190Youj2fUMQ36IzRh5/UqGqKOu7H7GdZcKFu8Wk2AZTeccEW
         rKOQnpljT90X5VdkSyQ7HCbUCTe0kOp5BC9oaFKKtTOrJbYmts69jpee61j0E0BqHhD7
         GBBO+Eulax3W7aiY9CfjzlRG/Ou3ZuTlakrikscSs1hv3/n9R5ZoKWPWYqiUuAvHT+sU
         VpYpaadIcYBjHIBGZpjndrhdlm9lkRQsropS0XkruRoQ6hFf4MGgul1Lt59UMm7hwmaL
         VDd28FVYGVAgU6ZJV/Pn9r3KNPkOuIBETZkjN/PBc1xQw0DmM7q5FV23Top01KbFDMKF
         f+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780484302; x=1781089102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1FLvXjYGNQG/8RrWajopN/MbkEeGxy8r0AENNQRpwXA=;
        b=OuIxrU1sFPXi15MwQsuwfG6FFLW4N3GH5dCdycI50jqsCML3yJQfFsjdYPSPX0P+uy
         jfpKWx/hauKy5rd4sPU6aYZigps+2z9Uzd7CfBOXDq7HfjwIfwTcxxAC6e1pZAc+dq/c
         ezNfQx+K0RCyEAUSqPCoHN98mj4EyisO+CXIKcGSFTZEzRlUx3WdgUTos1c4Q1Iuo/2Y
         9+WCMFBGiMKAt3UgIXcmEooHLR/VELzLv3D1gxdelYMEoPd4xcqQkiXsi58QEU0e6SdU
         rcsK6WR8CM6/Lmo2aZ+Px1TkkihNQkFkMs5Amcx5vl5M0xgXO+K2FFzX/RZVWBgN0wcu
         uTog==
X-Forwarded-Encrypted: i=1; AFNElJ+97W//RtJ24qGwxFUSbRg15sh/NC7Ymx9oMduv6UBFXe5o03KT3iDFQgNP24GV+3wT3n2UZfApMw7bEqy8@vger.kernel.org
X-Gm-Message-State: AOJu0YwrC/MEX/wr1G/24UOD8RNR+S7UFNGKC8HFojva7ydLxenxzj6X
	NRC8FFMetyzbM7tgOte/75OODW0MTXH66Jr4dlkNl15VRlxgkM+WFotbhifEw19FMe6eqV1Klmu
	fvL69J/eiWhJ9RyS3gAwbmH0m/Y/OFnM=
X-Gm-Gg: Acq92OGaPGkrbSbMRwGmbm95WrvBRqYltpD/GaNCKghkA54Rc9PA5jj2ykIFLT5P2iS
	8zHiTzngohrtA1JXgtUQAP7qFhPt+DhPRSd2YG0ZsBkc5P+nOIHbN22Vu0mBwCfhMp+YGS4OK4a
	OCbQlBEABMBSB/kmlC6A+8gTqI8BAqvYL0a32NxUTDex4Sm86A/33KM3fP2zKhW9GsElIbOJacx
	DpiOaex12cdZCsEX3DntcpL3I9OpDyY6fDbJiNGXssF0EIvYbYs8H6qW4YfecGwQTrqZdjEJH0/
	w15PfeieOMy9q8HlewtLKFJbZktNgZEhx9Yo+p62zxXyhdL3gU2B4Z+98iet5zw=
X-Received: by 2002:a17:907:7216:b0:bec:de7b:163c with SMTP id
 a640c23a62f3a-bf0aecfcbfemr123931066b.35.1780484301371; Wed, 03 Jun 2026
 03:58:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603001516.26234-3-anonymemeow@gmail.com> <20260603031117.20950-1-anonymemeow@gmail.com>
 <CAOQ4uxgudh_W2Gcs5qqGce8yO6503yjrGzEwbjTKkT+DLAqufA@mail.gmail.com> <20260603-schindel-drehzahl-planlos-e334e6899cd5@brauner>
In-Reply-To: <20260603-schindel-drehzahl-planlos-e334e6899cd5@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 3 Jun 2026 12:58:09 +0200
X-Gm-Features: AVHnY4JUh3H5il_Rwwy4b8kYHMWJsSyfdj4H63JpPTcbKlUBN5JxM3a9YfxTeeA
Message-ID: <CAOQ4uxgEnD6aN4HTh14=SPzU25_2xOXxfnY+60udOqNp3nnm4w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] fanotify: allow reporting pidfds for reaped tasks
To: Christian Brauner <brauner@kernel.org>
Cc: AnonymeMeow <anonymemeow@gmail.com>, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 12:28=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Wed, Jun 03, 2026 at 12:00:42PM +0200, Amir Goldstein wrote:
> > On Wed, Jun 3, 2026 at 5:11=E2=80=AFAM AnonymeMeow <anonymemeow@gmail.c=
om> wrote:
> > >
> > > Sashiko said that pidfs_register_pid() can fail under memory pressure=
,
> > > since it allocates memory using GFP_KERNEL without a way to pass in
> > > __GFP_NOFAIL. This can cause fanotify_alloc_event() to silently drop
> > > the event even when the group has an unlimited queue length.
> > >
> > > Should we make pidfs registration best-effort instead and still retur=
n
> > > the allocated event if pidfs_register_pid() fails? But IMO this will
> > > make the API semantically ambiguous. If the kernel guarantees that th=
e
> > > event pid is registered with pidfs when pidfd reporting is requested,
> > > then a later FAN_NOPIDFD or -ESRCH can only be caused by the task bei=
ng
> > > invisible within the reader's pid namespace. But if we allow best-eff=
ort
> > > registration, the event may still carry a pinned struct pid, but pidf=
s
> > > registration may have failed due to memory pressure. If userspace rea=
ds
> > > the event after the task has been reaped, it still gets a FAN_NOPIDFD
> > > or -ESRCH due to failed pidfs registration caused by memory pressure,
> > > IMO this should be reported as a -ENOMEM instead of -ESRCH. But
> > > currently it seems we don't have a good way to register the pid with
> > > __GFP_NOFAIL or __GFP_RETRY_MAYFAIL, so what would be the preferred
> > > approach to handle this situation?
> >
> > Thanks for noticing the oddity and explaining the options.
> >
> > We could fail the event in case on ENOMEM because the system
> > is likely is a bad shape anyway and other events are likely to fail
> > allocation themselves, so I am not objecting to your patch as is,
> >
> > but I am slightly leaning towards the semantically ambiguous API.
>
> As usual, I think a semantically ambiguous api should be avoided.
>
> > I don't think that we are going to change the man page to say that
> > FAN_REPORT_PIDFD is guaranteed to return a pidfd, maybe we just
> > add a NOTE about increased likelihood of getting a pidfd since kernel X=
XX
> > and mention the known cases of pid namespace and ENOMEM.
>
> The pid namespace shouldn't matter.

DO you mean that the event reader inside a pidns always gets a pidfd but
it will not be able to query the pid of the process outside the pidns
or do you mean something else?

Thanks,
Amir.
