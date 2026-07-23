Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EDF3E1205
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 08:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784794955; cv=pass; b=l4YEEuxilQAOsDdnVihceierGb+egVQVnd8XcEBVKv141IG6RBq1x8tVd2H3IZAYbCcKtYR7oMrKgEa0w72xtuVUZJR/2oaIH/CfQdICqnkKZsIYPvIc+Ko5NFM6qtZIGM4oCMaK8jDdruY1hm5/pmROeCUHLUboJ5JtLuzC1dA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784794955; c=relaxed/simple;
	bh=aLZSqJ0URF4BgPuBzwI7e5ieUH/kEHL0hZuAQkzXJZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T0YQt2tFz3wlMx4OTiZFyibmQtu7d9R10RCqjyt8pDfKhtwL128D2tnU7OgUkG+Rdjpfz6oYa/G+CmFjlr9zr3LviDfsNrHH/0v35rDj7oTKARYkK5OJK9fJ1+/KpfZQyloU0KiH8Cz+0oFTpLsIY9chlZwALcfsadWh2gOurfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=gmooZBEP; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="gmooZBEP"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c04bf4711so4469221cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 01:22:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784794953; cv=none;
        d=google.com; s=arc-20260327;
        b=fz8KyFwqZrwhFM1Y14wq4BawAFhPZV7TRbtQjCtV+PKivTpIZZCDEF/Ww4sTjaD/KR
         8Fah+/FW1blPINbAB0ZKjRw7xMJb1iGCMA5rTFYq7MSFPlmdoXJWJh/UzfV07kXsK13S
         Eilx9zRO+TONjE3E5TjCYZxpfgRmJOZnpxT6F/vKqnajx2SKh4eCBGB84A+QskiZBwfR
         zQI3Tk8kYRIUYpEjVYNwEwt5qqxAeEVEu95YHJ5fSBSBbR2dX1OP7w8kQAYmaZZrFb4k
         q6pqv6SgXUh0KMFQDRfEnFrxIkundXQ9aun4yhZUvtsJknJSoLse43hRzX7zIDB5X+ZJ
         N7jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yrgNUo4LIyDIRSBo4rDxodSFyTnV5NyKbJ74rO2CKL8=;
        fh=KVT8kutN9FsnRaMEXRc4xTQQDJyQKkoXbLzdhZMAWL4=;
        b=i8IYJtE4Tcuc8e14sDwyIKx09dpnL1t9nIqCrigC6IcojiE7y2+oQ4PsX4jzLHme7Y
         9wQ5rLZYzcEjBjQsAWI402Xpfyo/A8LsaiANLuCm4cf+yBLSH//1HCraLaJ94b+AAWwW
         qcQVmhi4WbqCsHDZ4iG9On+SFoQhFRF5/ON+ykWGfDcFyQW8eMFCh83Gb3I98SVLSt/+
         tW+Fb0OA1/tsliXecoX9ikHTgkfcHUyM70BKhSqF+ZE6kLYTx5/Fvh7AIEejkrEslZnS
         83RorX8TUFZZNRdsv3YKvTo4KLmlfPpqV6pp8U4Pomx3Z3e4UmKHZ9QiT6JvY6udoWvV
         oGgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1784794953; x=1785399753; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yrgNUo4LIyDIRSBo4rDxodSFyTnV5NyKbJ74rO2CKL8=;
        b=gmooZBEP6yxzO/jbE04k+td9SkYz+eKuMblMAwvIBzhrnGKY0ZIjzo2c0q/9VDXnD0
         AryreByxDRHFLHtY5UWu3edNIcPikUcl5SBiBdAUu0vVl3eSpKQtPxlL16yEyHF86qnx
         f04ZpSyS2xSBECpFvI/E+iBe52VtrMurWFjMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784794953; x=1785399753;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yrgNUo4LIyDIRSBo4rDxodSFyTnV5NyKbJ74rO2CKL8=;
        b=V/j3SGgfuidiLTga5hoNK+lasuOyAGnIKYY+Vqx/eubSUJlV0k5vVa9Z7l5YWi1D//
         ZtCVYKFnPeE8vsWwZv2/Rg5VyhQpZPaC3GL6Y7IOxTAeF3ZpO/leCrDOneK6lY++U71n
         jZjfFiqGmLG6kRbXEHG79dQxrr1ZsvYZLu1Q4raERCVLiiWMS/s3uJqTRP5wcChviqSb
         MqcRxXJIiHbfDk9N3sQfk1MCkLJqpxB30hui0/RwkxYTRqIPnJYqXIHM4nHn0yxZqrN+
         PEZbShntfzXL68Qc+3AHkA3J40nZYJTvavu/78ujKpNpTUzOWbCPmKeWFT9JV8acIQpz
         O7uA==
X-Forwarded-Encrypted: i=1; AHgh+Ro+JCNlNLDO+pqK6IKTZveJHsYsKMHbOY8rn1d/pFPTr2zL8ulAZL8m/Ik87F4Vn/g/LZkw9tC/OtDQ++R1@vger.kernel.org
X-Gm-Message-State: AOJu0YxUjtxoiQMPpHizCHauj0dcq0cdF0x0AGbRCvtmgB7iJx4K2wJk
	OyYxQ0rKMl7GY5BUy2b24Y/nnxd1xwxUJp5PBnFCFl/vRGxI0TPhfueZMWO49zSaOSTeyd84eBq
	Gla3/9ilOWBQcepMRapOMwMzaH7H0vhJjew07bsI2jg==
X-Gm-Gg: AR+sD10/cVpRw/zxaUX4hA0X7sAfhpSlB5/KQYjSOnOB2UJpt+Nwt9DtpNc9X2LbtwV
	sd7nWwwrkwM28DHwY9pBpI0yWELFvO4vMKUHaObnZXRNHW9YPqH8XStScyD+uct7dQZ16k3eOrF
	j8Em7PGR3g27T99QguLgn7ufqz98um3GPRIRqX+w4NC2dIUeO1fzLIG/hw5y/275GzwssrepNUz
	R9h5dnJ2odmBWzxqVXYblzQJBQeRNd1DY5i1im3jHDf+nwHK4pu/vfvVi809iybcZiupOgEBkdb
	Kgpft4Rpl44aema8zw==
X-Received: by 2002:a05:622a:14c8:b0:51c:7b12:5fd4 with SMTP id
 d75a77b69052e-5283e012098mr18036511cf.80.1784794952935; Thu, 23 Jul 2026
 01:22:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715101107.973997-1-mszeredi@redhat.com> <20260722-fundort-zogen-kormoran-09fb867f1b59@brauner>
 <CALCETrU9KdLsvZzUE-5sh7KkP5-cPh=hwErGmN=THsDatFJLfA@mail.gmail.com>
In-Reply-To: <CALCETrU9KdLsvZzUE-5sh7KkP5-cPh=hwErGmN=THsDatFJLfA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 23 Jul 2026 10:22:21 +0200
X-Gm-Features: AUfX_mw-0nrqXevHRitoGqWVZtjfkA0y47FHySyo3TiICVfrOazHUs2Vr34P9VI
Message-ID: <CAJfpegupwNTaVNZtdQTmvtz9x=ehH59hzsRT7D0=VbhOZvaqrQ@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: allow opening overlayfs/erofs layers through O_ALT
To: Andy Lutomirski <luto@amacapital.net>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>, 
	Giuseppe Scrivano <gscrivan@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, Amir Goldstein <amir73il@gmail.com>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Jul 2026 at 18:36, Andy Lutomirski <luto@amacapital.net> wrote:

> Other than that question, I think I generally agree with you.  The
> interesting operations here (getting an fd to something that was
> previously inaccessible) are different enough from normal path lookups
> that I think they deserve to be explicit syscalls or syscall modes,
> not magic links.

This is a super specialized use case.

I sort of agree that doing statmount() as a syscall was not a bad
idea.   But new syscall for getting a backing layer, that makes sense
on just a couple of filesystems?

And that leaves us with ioctl.   And ioclt() returning an open fd has
it's own problems, besides ioctl being a generally bad interface.

And we have all these powerful concepts and interfaces for
filesystems, why the big resistance to actually using them?.

Sure, it's easy to misuse, but I don't yet see why this particular
case would be a misuse.  Enlighten me please.

Thanks,
Miklos
