Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7621360EDE
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 19:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780341958; cv=none; b=TB3JFq84QXfsDK8den8m9UKPiUaeEtPSKSoA7HtyF/9d9MWSHEtAFSWNAfapXkqhXmFFrFm2qFK0svj6V7Sk7RJ/WbwZITfF4kfEZRx8+BCgTzlVJG3xM+x0Ec+zOVrFqZdJUR6gOj7UQrrmUQm8i7oBewvnrF3a+6ZsdT1saps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780341958; c=relaxed/simple;
	bh=OWRuh/RR8NJ5UTF40FybsEdKJgrcmOFPEN3Dxz4VubM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=h6FaiqSEOSQJOBdh8WX4/M8nyF6gTEVpyaPkMb+bKySE7OhUdSlnLMUvga30/hlu1XwvPKOY51IpHPeZQAjUWvs3wm2QqtZFQAikBC7PUIlIm2ia1inM45OcVfIdbc5SL4j2SVbBLlQxi7ZrqzaNt4Jm0mESVO8P6lyrOKLmxRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Com3fMZj; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Com3fMZj"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-43b7987a9d1so6942204fac.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2026 12:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780341956; x=1780946756; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUcR4pbJRw7eHCuwwMVNxCHcKa3q8+6m2Z16fn9DjGg=;
        b=Com3fMZjkuy7lIagmBX8i8vMyu+UXlDiCMaFsfWr+WEHkDso+lNictsXYhHmOEtZr0
         5pq2E7pvU14CuaA/h9bMYSC+g1rNHlkgzmNEH6dBo6GXFvaeZ6q28ZgmSnsmbSXT6TPp
         mViq4QAzNdYjgZFW0NV90y7G70XBMsoI5YJH6DkNkY6cp9ObCkntLzPZw9uKvgVurXH+
         NgvJJL03yr8IBPsijMDmm0GGCiBBhosUthHr5KwNzdDFSuz8CcUMrFrekx1b6FY0hquD
         OiKSJaC5+EDmCQ0VDovBbaBqNw1ZzdnJNZtpip82Sz4kcoKd0Usj5QXpLZkN+1wsF743
         137w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780341956; x=1780946756;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oUcR4pbJRw7eHCuwwMVNxCHcKa3q8+6m2Z16fn9DjGg=;
        b=HHYbPTkNGBtCHqxC61jQTi1ilMgRdpN0tHYbLiJ4lXQYKuzVmHGSNgTnc8FPpBarcX
         A3dVxSw4qn+DDhL2ODgUfCWjmsvKbGV97EwCsBq1kGomoatDStVp0tMZUrToDsE2p3Jp
         Fl7J8pgtPnLOEYzvhlhbC/AHpoS2Eq3Re/+vn0ZeCox45PIpNlR7s3oh0Eegyy3FUXcT
         2G6pJjDj6QlE2FPI21/kWJJUELcsZSIQ8TQeJ+hvYs4ig9w0f5A5C1JZFz7IFehj5KwN
         T2zx3O/V2MGAODzLwLH30Yx87r09SqToM9ofC/83VZglgulpCekaTvFDLnyfZzKAHf0U
         sQFQ==
X-Gm-Message-State: AOJu0Ywz7tGKyGVqEq8ZH5rL8qg5RP1VlnyFG3YjKWk+3bPDYkx/MCWZ
	e/uyil84F5D8VNukCMHG9lOfd4IYxWj7d11HJOhv12Z4PpD+YXd7nmb4
X-Gm-Gg: Acq92OG6HRoTGJcZI+/J9IzwxFYPwM5tb1HHGuECi7C20/vucIh4Gpf+dvhXcOwM0Ui
	VRlaNJ/UNilCrJEB5SVDei5hvLU4YOtKxbq5gzCHwSNMt9Rarkuj7guGsI5GwcLxB3haT+RjNEo
	7ATXA9cmdnb9O5v7tRwdFiQoQgStRAvW3XAz5gxWW/sbg65gQTSRtLN7/mFU9ASaZTZKgwly6Os
	N6baLys24NVQsIdSrIKoACEy671Jg7vRvdtaD6H8u/HJ3QbFAzuO+x7e6Qc+/EyUUM/nHSG4XSc
	BbJ0vKikKAnPLe9nCxrrz+sQtaO5Jmhfh+Fukf3dt/KdnncZtLFqlQ7aMlcVIlNRuWstwC5zQWX
	Zq6nUgCQ19yqemB5bvEuJVGijv6ptDACpFRGqp849uZRMKeNQA3/gI3WUmYR6s2rF+gHv/6sCkH
	+OBFAhWKcRU+zZdSn9g7izbjCjlMcZKD7TYAjo1uMmhs0HxN/Yu80Kow==
X-Received: by 2002:a05:6808:318f:b0:47b:d07b:ec9b with SMTP id 5614622812f47-485fb3a1033mr7732122b6e.24.1780341955751;
        Mon, 01 Jun 2026 12:25:55 -0700 (PDT)
Received: from smtpclient.apple ([38.175.164.190])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4863f0c9848sm374903b6e.14.2026.06.01.12.25.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jun 2026 12:25:55 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.7\))
Subject: Re: [PATCH 1/2] fuse: fix FOPEN_PARALLEL_DIRECT_WRITES being ignored
 for passthrough writes
From: Russ Fellows <russ.fellows@gmail.com>
In-Reply-To: <ah3VCxciXhS0CFdP@amir-ThinkPad-T480>
Date: Mon, 1 Jun 2026 13:25:44 -0600
Cc: linux-fsdevel@vger.kernel.org,
 miklos@szeredi.hu,
 linux-kernel@vger.kernel.org,
 fuse-devel@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <02AD69BF-A91D-4798-A90D-7692D3C1ABD0@gmail.com>
References: <20260529031918.7361-1-russ.fellows@gmail.com>
 <20260529031918.7361-2-russ.fellows@gmail.com>
 <ah3VCxciXhS0CFdP@amir-ThinkPad-T480>
To: Amir Goldstein <amir73il@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51.11.7)

Amir,

I appreciate your feedback.  I will review and revise my proposed =
changes. =20

I will also remove the =E2=80=9Cfix=E2=80=9D tag and mark this as an =
enhancement to FUSE parallel I/O.

As an aside, I have tested the kernel changes quite a bit and have had =
no crashes or corruption, and the write performance is 3x.  But, I will =
use your input to focus these changes more appropriately and eliminate  =
their unintended consequences.

Regards,
=E2=80=94Russ

> On Jun 1, 2026, at 12:52=E2=80=AFPM, Amir Goldstein =
<amir73il@gmail.com> wrote:
>=20
> Removing stable list - this is definetly NOT a bug fix
> Please CC fuse-devel@lists.linux.dev for future fuse patches
>=20
>=20
> Not a fix, because this was very intentional.
> It is a new feature that you are proposing to support parallel
> passthrough dio.
>=20
> Anyway, this patch has many problems
>=20
>>=20
>=20
> You can't just use fuse_dio_lock() like this
> it plays nasty games with the iomode.
> It does not even check for O_DIRECT mode, so this would do
> parallel buffered write (at least until it meets the filesystem lock
> but its not something we would want.
> You should study this code better.
>=20
>> 	ret =3D backing_file_write_iter(backing_file, iter, iocb, =
iocb->ki_flags,
>> 				      &ctx);
>=20
> The problem is that while backing_file_write_iter() does not seem to
> directly require an exclusive lock (apart from maybe =
file_remove_privs)
> the fuse_passthrough_end_write() callback does I think rely on this
> exclusive lock.
>=20
> So proving that this can work will require more research and more =
effort
> and I am not really sure how that is going to work out.
>=20
> Thanks,
> Amir.

