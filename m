Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFE53BB68F
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781170166; cv=pass; b=rNymZGXzL/mNwluUnfzTGCPu0f4VwjdAKC4oVX23OB7LcKF7dUhfmZlcXh+zlGEKg3tiKH9BKa46MY5MZg71Bvsris+rYznFOYbwptCY63H+FicZHPoSu/bsZYwAHxdQpG/om0W4HR2kRYUJRazVb6UGU8O3ztyYPAmZRewmelM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781170166; c=relaxed/simple;
	bh=fgIN2i8cK5yBqIrKoTv7yZ634l42ulLRdn9aAMoBcT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q4Wx9A7PC4ICW0mGCGmOqaONjl9xMa0b3kQiCqbzkN7CedjhXwaaKYRPVxHs6SG7pFwCBOQcKfDgQ6XEjqdkdbM715CnZtu4ex5Fs9l8b3NP3bARg47zX9prvIO9634bmarl6ix0VrFaIbgmkVyMKxL+n59hGRv6fWihrGK/3kU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=OT4YvEtc; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="OT4YvEtc"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5178a42caa3so7803601cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 02:29:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781170164; cv=none;
        d=google.com; s=arc-20240605;
        b=UdKmVGjGSwZj3eHV0zAfoi0wAYT4s7HL6ZOhrxz+pufMnZy/4vQuQyHumfdSBkUck3
         fsRfpIC5ynIeToO1MZVX4nBpBTa/O2Jg1Ciu/jtFDyEMQTpH9DnIQbNnp/k0mxzxpZKu
         ASrUiMlGsrMrvcWBRLO0nt12li3NjJi9gtRFNOgibp9ABbaYhkfGG4hWzTIMRWE088go
         mDmx3wduVGzUL4fPsA5W4wD1hxNjiaZPoIO1JoP7wr56yQZNgXKiFsS+kz6pgBnnlBiG
         qT3udi5W6V4WlDBfMDERXWBDuQhRr320qPisGPgA/+ZJOVArW1c4XHYtsrPqknuUuUm3
         fF/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fgIN2i8cK5yBqIrKoTv7yZ634l42ulLRdn9aAMoBcT0=;
        fh=4/NqO5DhF5+Esgba4R51aTNnlvY1XqCMMCYyL1IeIss=;
        b=AVJOYZFD8cQ6ZhVwrJUEDCs4ad+bLrn0RDZUpXjihN4LGz88r20UOhzir9QElMoRNp
         hnPlKcidH2hSi7x5XVlLAWr1pM8ztB81KsXPyUY2vSJEg4HCslzCu3wViYOeDcTwFPSD
         /ljA4SNywqFMQNpc6yL/p5CVo/yVHdxVOFfJxEgoM/4nKDJyzXtS3ijHnkk0EgdSd6Qn
         4hX8FTHD844AzyCQWzkrkPl+MOcjjMDA0b/kJHoUvVbm7OpoaBjyE27MlLA0cUe1XXa3
         IV+vVqhra78NYUZibZ70YWkohT4DTw+MXxX0iZChRxNicVSnevJ948pCfh7ZQCWEcymB
         TiTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1781170164; x=1781774964; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fgIN2i8cK5yBqIrKoTv7yZ634l42ulLRdn9aAMoBcT0=;
        b=OT4YvEtc6SmkUIOeLybINA5B4ZIRBJYewFBYzRKb6MS+77AhagLNQd3Ujpab6wVvGh
         EwsBGtaUmd1WMTPHF0+EAQxUViruXG8YiMm+FUPBuLMw+BEYZAxXG+LisNRgb6YcXTXS
         gGArzOWcAmgU7pPbWXrNSJPyy300vIbJ91iZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781170164; x=1781774964;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgIN2i8cK5yBqIrKoTv7yZ634l42ulLRdn9aAMoBcT0=;
        b=M7nVcSR1CrWQp0MOL79OzerJTo3cLXfL3RCSf58cC7vPbl/t3debf6s/gtBivk4E30
         9yI7sCy/cArym8yq8UxtwOhqTfsvv8+9pBljFEffeBRO/ghEIVFJKIKooyvrKZG1SQOD
         CIMfc3HFMLM7ZgOLl/Nw/ltBMi/8U0QIaGdFGFQxD9VF1o8hOccqxRpZ+X1rIbMDkXcg
         x8nIanc4747z5z54xaCwXhS+HiNpXbB5ZOPbtZ1Q8V5Z2+KK6XbsVsmXphbZrdAIwfW4
         BhcLMZ0pToRxU2Vjcjkbb307eWsOKKGzxxecO+RFxIL7RAA3tY3a40Hcr79aj20JClln
         YXgw==
X-Forwarded-Encrypted: i=1; AFNElJ+Lh7lIVW8AxT9S57J8rBLs2kaq0KbwyzIEQ3+kjYkXcCNetwcaPo1aGnSmpY99nzXinlwBzcXNcTsNsNhT@vger.kernel.org
X-Gm-Message-State: AOJu0YzuBrw2o8d6xGAB9g3/yJew88+KUDiP0K0hSO3OWaYG6nldq5ka
	e+bqRmeSqkJn6B/w00C2cKb5hyR0Uu2f0rEZHrOmwlMeswvVvyrNvm1S0c+IKd/MGkiry0Wt43J
	qps22uKRty3ZkK2cmCa59A/NSTKIl41zOQc4sj9xMmNS8CKcvamTnh9o=
X-Gm-Gg: Acq92OH/yFQBDALjNi9iZ6PN20PZ7Sc3EHcjFK5APD8gWFLj8TOf0pJUrpLqGFC4dvJ
	K8V63ovgwWofAFHyhyrzAJQPzCLGXD1E3avtSnsEkeqv7YJIjcZvMR+D+Zk1ffUjV1bu6xBUipN
	Qlr3uabeqv0ZNriHenI48AUlhoQhpjwTG5GFS34b/u24kiL9NqRzxIRsZo5mVmQ00OLTGE5mGPG
	w9VP1QqE2jm7ONhSpnKyaarCvQAJ2ZAnInL8VpB/yrSCojlftADq5vz3zqqBzhqzZBkg+6KhFbQ
	1g4v+arEf8AHUJ+7IP8+oH7fh0YHiwO/ysdYM/RuQTcO0vk7aH8=
X-Received: by 2002:a05:622a:2513:b0:516:ca56:a44d with SMTP id
 d75a77b69052e-517eefade6fmr19793901cf.6.1781170163781; Thu, 11 Jun 2026
 02:29:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402104407.11495-1-liwang@kylinos.cn>
In-Reply-To: <20260402104407.11495-1-liwang@kylinos.cn>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 11 Jun 2026 11:29:12 +0200
X-Gm-Features: AVVi8Cen8jzh4k-FyeRSFJBfNV9EUv7MDTwdvrFmM1KWWYcpiJldXe6uBNuaZ6A
Message-ID: <CAJfpegs8v6a9D1zWsNY7pX_Zx1wgjGvoEFS6hkk+qE2iDQptZw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] virtiofs: hiprio FORGET robustness and no-reply
 request completion
To: Li Wang <liwang@kylinos.cn>
Cc: German Maglione <gmaglione@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Apr 2026 at 12:45, Li Wang <liwang@kylinos.cn> wrote:
>
> This series fixes virtiofs completion for FUSE requests that do not use a
> reply descriptor, tightens hiprio FORGET handling when virtqueue submission
> fails transiently, and prevents the hiprio worker from stalling when one
> FORGET must be dropped after an unrecoverable error.

Can someone from the virtiofs team please review this?

Thanks,
Miklos
