Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB49413D8C
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 20:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778876275; cv=pass; b=XPtFq+pdafOnfi7VLWr4tlw5fiogKyxX2+S/cHbDss4ggPA/Q+hne6erWfQuBp2v7yd0OSgaXZNaPCSD+I37v8HjYpnjkhrM0HhRpYsSnvuBSxuhs0yYLKzl4x67wjkgD9Ejf8Bj96iHFvspc8GEXqXis6Bp7oMiLoL1zaqn8+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778876275; c=relaxed/simple;
	bh=2DXyIq90HL8JoEt+riYlVe6ELtsC4TBaPi6OOxXk5MY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XzQztrZ47xEyB8j4iPsy4gke+dZOJhJrOUkVIv+9ixllzAel1N/4mHVM8VXI9UkZM9RDdDHwxRZ3aYJqRYLWWc2JdmEtN37gY79U2eAldv0XW3gOayC6tEBDo3vWcS3pUMWG/zrJwqT4MyLd8y1fFvbsaIfh7VIC70YCfLGBqzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqN6K90g; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqN6K90g"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-67bce1840f1so432981a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 13:17:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778876272; cv=none;
        d=google.com; s=arc-20240605;
        b=WpVTRUZf8qqNV1xaAoC0iolfo+8pw89WIoZyu13l9q5kBuyDLCkCmG1HqxoyRRIBt9
         L539ZvJgfC9iQQA0grfq3y8XNwelKBsXALX6dSUOjOoLJCSOQipjpUpKLkILKn958xhu
         dpANO+nHcRLLYl+iJtymbxzw1bsrcvYe3JyEn0Ds+DkhrZ5lwed9VI9x8TBIeS7GA5to
         q2Z37Y3kfn89bqxSpVwvzl12p8kcpuy9PSlWGutvRtm/HC5K9MXZt6vZZIYqyv86Mwkd
         nhTLcr3AlSUCxsDUXawPu8dKcsIwivS0S5molNNOlmuJ9FFsbsAg6j7S0MSSjS+iNZMF
         hwCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2DXyIq90HL8JoEt+riYlVe6ELtsC4TBaPi6OOxXk5MY=;
        fh=oh2mGnPPO8BZhYJfcJDkBnuKFSpEzdc1oB+pNE1ODuE=;
        b=WyJ2IEuHwb/qX7T6pF2wvF8Kr/ejQjW6PQtX554Ds2zXlhXkw8b/ShJ6mePHAGQN2v
         pBXndcvAuYqdSs5YcUH3BYcvDrp3l4haO4qGSYFdQcgtOrFVCZagdby5OWqk29dpdLoQ
         voaqZa0L9Ku15L6vIJpTCvSwTR8GuQ1CPOodldaqxu8AtaEEIyFoPsHq8IQTxaRYZUfD
         saHBlAE9dYcIm5CXgmhSClG7fOiga9dup2PRbMEWhT5mHQ/HP5HMsOcjzeTt13QIKAuk
         tgUXh17s6ipRIDqtpJXoAd2f6r6c6s4zl5tpaoivx9NmzHBPoEcYAHRlo4jUr9nAnDw6
         i+Tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778876272; x=1779481072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2DXyIq90HL8JoEt+riYlVe6ELtsC4TBaPi6OOxXk5MY=;
        b=IqN6K90ghYa4q6UQ6lK+FlK/+BUSI+Ygba/4XuMCTul0iwjK6K6mlaDhg3Pi7F2wfU
         nmsZ02bZM7GthpkooT8c6BjUJTrVcITysMlQv3c8YmzV71H50Qf5VAWCAjRMom0C1WTT
         IDRsZ5SqreUlnChmPtJLnso8m2r3NzLM3XR5+E6fy8nGNP6LUziECypgqon1fOXYhcHr
         bog8AFKIVQkUwUf6Ds9Ar6v70F0bR7lKNgCtfCQ1JfPWJumlqgokYkdol/D5EGrd9iyF
         KrckCg8zBOuGlOZbBv2IEDf2z0dBTAOyAHOSdxgnAk9jdoIl4BGrrGVfqnANicaMOaLD
         ONnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778876272; x=1779481072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2DXyIq90HL8JoEt+riYlVe6ELtsC4TBaPi6OOxXk5MY=;
        b=QEBepDEtRBU4Nr8eix6pEP4ACDDIoKLF8d2hxZ9HM21IXITp4vPUU7Mr4vANRS+Dfj
         0kahwvyXM/uvdl72iUXBad9OngX4JwmsV3oljOv8LRErJx3HoTP82j1xr13V+0Z0/gRP
         TfelH9dJkPqJLLVioL5l1rlCmfYCHw2o9zr3Fb1+gUb09p0mAtLGeVMxnuCFastshGKb
         Jf44soJhResS7D5cHr20a4TRVnlJ7/yKeYxuOnfREhuFSeoOHGLtSvBM3ZPKUkhikqjM
         8mFah4lGT87Ib3cgjbF8+m1eU+sf7/eX4eWH2ooLsaErBLyiBVNgZWPoCJ5gGLay04Ty
         oE4w==
X-Forwarded-Encrypted: i=1; AFNElJ8ku1Y2kVhgT/JQM/4O83cWTLHtnGr3jG7e4M5sEiSuM53qGG4xhlIiKpR91wc1P0DlJb4cxOMJFqcexJfv@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd7/zz9L0fJ9kRBju8rl7X/KJCafF49/TC0YoZVPY4ytRkcbSJ
	WdUNfXs1dPz4v212wjnUX7Vq7YWx6cqWc7uEQqKUAtyEwcfMb9wpYVHvKnuf6wULdCCOxNapatz
	dYdmj+HpC6t4Im/2EF8+WqNZvtUTWWO4=
X-Gm-Gg: Acq92OFafXkmfyWSV+xZv5sQbPEIIFKIlfHg5ryP5EjqYM4waQQsQ1+iyiIh6J9GcK8
	LfO6Uqo8/cutgy4mEumfYgWTwG+jwyR4KilyhdvYY6x3G7PH0zAVcwll7vTrO6J/8Y2Ap+rgM0T
	pjQSTy706IBqqkXvlwZkmZ3TNZIJiJ21InKrzfHWnhycgDmDsdfZopLYQRlkSQepvvvQKcsG165
	uFzWWKm5bI0F+oXW6NuenkiHjWs8WkAssuV+E0VntOizKzqgH8BBu48OLqqEv8MtrL3D7rmri/Y
	2SxPrgcD6rltN7lsNeVztvbPDs3FWF/3rkdHPNta+g==
X-Received: by 2002:a05:6402:a553:20b0:671:ab62:765b with SMTP id
 4fb4d7f45d1cf-683bd78c127mr2156886a12.20.1778876272200; Fri, 15 May 2026
 13:17:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429102058.1362965-1-mszeredi@redhat.com> <CAJnrk1Z_JWtuA3UjucF9=YH63AH_-J_0hzr9jbY99Hx3O8YrAw@mail.gmail.com>
 <CAJfpegspraqMp1Z3mi_csiw6haawZPa4zWheSUN7MhBy47aYKQ@mail.gmail.com>
 <CAOQ4uxgV4_Pet0w3f+Sq4kLkvgKM6FyJwZ4AQsnvctC3w=dP6g@mail.gmail.com>
 <CAJnrk1ZvB-R3Szn-VxOZvPRgX_dXwMLouBphnT9_URCE8SxTvQ@mail.gmail.com>
 <CAOQ4uxidwSn69A08Urue7S7n8wrGQcyGuvRL387pD+rpSFP-Ew@mail.gmail.com> <CAJnrk1ZJ1pVWn21HZATRes55RJD0F0+6SHbq-8FojPutQTiW6Q@mail.gmail.com>
In-Reply-To: <CAJnrk1ZJ1pVWn21HZATRes55RJD0F0+6SHbq-8FojPutQTiW6Q@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 15 May 2026 22:17:40 +0200
X-Gm-Features: AVHnY4I2LLv-HfpohghtdvVbqkqJkNUSgOrPr2eYGxJXSVJpcLIcLIkS7YOTO2s
Message-ID: <CAOQ4uxgDGuFq=Szw8G1BMuhuBhZ029kf+FrVq6y2Oq+gaQ78sA@mail.gmail.com>
Subject: Re: [PATCH] fuse: add fusex filesystem
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 1:24=E2=80=AFAM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
...
> > Cool. Let's get this rolling.
> > I need to get my test setup back in shape.
>
> What is the test setup you are using? fstests with passthrough_hp or

Yes. *was* using while I developed the passthrough patches.
Didn't run it for a while.

> are there other tests in addition to that? If there's other tests
> you'd like me to run besides fstests, please let me know and I'd be
> happy to do that.

Nothing beyond the libfuse test_passthrough_hp sanity test and
fstests with passthough_hp.

>
> When I ran fstests yesterday with passthrough_hp, I saw generic 683,
> 684, and 685 (dropping suid/sgid on fallocate, fpunch, and fzero)
> start passing, but beyond that I didn't see any improvements (or
> regressions).

That's the last report I have on record:
https://lore.kernel.org/linux-fsdevel/CAOQ4uxh=3DcLySge6htd+DnJrqAKF=3DC_oJ=
YfVrbpvQGik0wR-+iw@mail.gmail.com/

It speaks of some tests that are
"failing because of missing mtime/atime/ctime updates" and of
"failure to strip suid/sgid bits in some cases"

I had imagined that the passthrough of GETATTR would fix some of those
failing tests and to some extent, this is in line with your report.

Attribute cache and passthrough is an unfinished business.
If we could force passthrough of GETATTR when inode is
in passthrough iomode, I wouldn't mind.

Thanks,
Amir.
