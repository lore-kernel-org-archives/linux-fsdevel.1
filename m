Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DB4406807
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 12:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781094172; cv=pass; b=d+GyLHeJpWeTPryrATKPkDQ8V7MxpOFuggVjJ5fXQCzgbWQu3VKhLLzsNQDBvRsO4ATabasJyxrY+j96XLOueDZnM7d/vpC+bXYkeZOXtYKCYrECCcgziTmrtvTB37rB7TO6mzblij/dcETZXZT39zA/5iaTZ9UswI+Nr7qnmuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781094172; c=relaxed/simple;
	bh=zwTvTQRiuDnTHNrVN5t6ylNbG/tB4D/O7pmKvhbpJn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INZ7tTnYOeep0pthCvskMAdw9NIR6uaEyo5Y1GlTGcI4qdYVsZnp5sA10PxvfSOh8scZGgJLlK/Xp6eJmxb698oos2PnDjEqSskynmSdb8nq6lZNKIbJcOunD5kMTQUjfsocpv9ugjxgNGguOwFtt1KtyLTQK1PKJdkwLdEYgu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Bg38By5N; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Bg38By5N"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5176a2fd597so55494831cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 05:22:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781094170; cv=none;
        d=google.com; s=arc-20240605;
        b=UV2fWl5F5okl0qntupsuYpUCaiNa2YzbJryLc7fdkEdLgqgaUQUv/v/kVRsiAKVVIE
         MNVIKP8r2fyXFmuL8rS3osDD1v5Q2kffa9Em5KeuPjs0Wz69AK9tZqLnb733uBScuKcF
         zWBl+K8g/PD18MulhT6RlWY5ZL3RUgkBs5vNQ5WJQSVEU0VWECWpAeST31qhKBfg+6oa
         yMpdhZCEjZ5up/tBdyOPwddPR774mkxGWkyPYnBSJ+7rTAt1Q2Df+yHRnBQxr6EMwiNC
         vXVqtd1y8VsUVDpdm86JLUgj1zh5z1LP+tM/8Ul4DkRHQFOfDh0m7f4dV4kWJbj3E9F/
         v9Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zqhfenRJHrw6tZtdmFjoGbNaAzBmEpcWmIpswbZ9dgE=;
        fh=GZF6VPu0CSvlBKesZFszZaBagTXCe3NKBxIJ22UaXqk=;
        b=VRPdrRdkLaOrP8utom7egu838sQEdW73JVRzZ5CMS54E0yHyHNF7AR2w8IAe1rUwNH
         kXkEpgFbO9P0adsYjgOunl5kpVAFpMQE1/gGt5TaeCdCkjL6LUkYqD/GI2GM6semMlRr
         EWsIEKWp5hLHR8lUkBUkYnPTsliqlKtFW23ugLRSYXjXFnCFUl6M75DXuVXV5zgY7x3+
         XJl3XdeEIYBo2KG+zp6BGiYdD0wyemAgBSu0b8BCtTEFTPh07XC1DqAht8NvKf08M1bm
         zfNV7zL6uYfaOLBAfd7LZo1HEhVeJxddsfV6il9D4BZdHclJdmdGK4bFviVgR13jlFCG
         sjSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1781094170; x=1781698970; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zqhfenRJHrw6tZtdmFjoGbNaAzBmEpcWmIpswbZ9dgE=;
        b=Bg38By5Nu9u16/+LgN8VwYilA7ylHDYtALegh391WQtY7fIIKHWSykacesRPpqkfx/
         pUZFVRK0uC7hHwssNnLZEEQ8ubJTcu82MFaQ82Nb6y/n3C3WSB1lki1DB4xELLYG2x5O
         0htblUIAoxVbp1O33r9RcWOwqYn9jb3J/AJ68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781094170; x=1781698970;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqhfenRJHrw6tZtdmFjoGbNaAzBmEpcWmIpswbZ9dgE=;
        b=ccduY+u9z9IekAnq8PVGWqIj1ngG+92WCSkGDna9sPlB6fiWsei8VDA7hKCkbqkG3n
         em9bRJ6cGT9r2FlWR2RNAdXXbaGj4rXmeXCEO1pEtaenZIsuMDjLDs9w/HyfB7aR9KOv
         ecCdEcUzWpLQQJQ64J3jZxo2w3S6AFkuNexVd5aK1O2xjDPagI6vEjVqnZFzuGiJceOm
         Zs+MoxXJdAyFtpy68viVDT60p+C28bLsjUyy0GNeerXQvs+rps0TU9zIqDV94wyJFmOC
         ONWxbPWB59Ax8Jy9Pt0XE2MJRkRoKv7fYLrC8bWkCnpVa9QgXRfDUC/mO4Nc3YsMzvQU
         DmxA==
X-Forwarded-Encrypted: i=1; AFNElJ+eDCvohBBUdwCfIS/jCrkPjV+C6yTf7bEPB6rjZueWiZOuF5vurRyywa2ZCQH/IbTbRFRFqat960KJIBqR@vger.kernel.org
X-Gm-Message-State: AOJu0YyvQQFTpxRDvPiWB4nCdwm5ZY9M02SQhw+7HsMFfOgtUjt6PGTc
	6pYtxw5pvAyjEzHMuSASedG+1xQvuzSHuI3pQ91Dx8s7hQnvpt1fjO5F/7Tz3Egd2VR+CKMtUIY
	5I8awanHooSS029Qo1oIT25PAnMBXKncbR3BiIvc4zQ==
X-Gm-Gg: Acq92OFK7+K5ny/xeqO9Reee8WrLWf2nzA52VDYFDCwsEywPiJL/S6yqAmkgqdTixdN
	bRFK5EL/qyHU2z6imXmHbX7bxYS0MJs4eO2Ueqq8ApIgBCiaJQ1oA4UliylpnUb+ofFs/I1C9EB
	qOsnHfl0Q9bhwU1iU76rIsxHap9cCmUyG8695EaBiIe2k0CAJ5y+NcPRLRZt6NdhvkEGFcrS+V6
	5gxLJsWFaWghvzkzYnYfaIS+YOeibfo1SSvZwx9ZGU5WLAzWTAe7PQ7tzPIuIBSV1qsaIm+7+Un
	yXo5i8rv6q7JmvJSngZind527iP88jFYQ/uGrpkw4IIMgvzyA/E=
X-Received: by 2002:a05:622a:1388:b0:516:dcbd:aab9 with SMTP id
 d75a77b69052e-517959fb37dmr332271721cf.16.1781094170420; Wed, 10 Jun 2026
 05:22:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519004746.3203156-1-mochs@nvidia.com> <CAJfpegsTsKqq+QQKyBexQFP1=EGd8YiMT=rbaCOPeTBvLsY_JQ@mail.gmail.com>
 <F3BA075C-8E63-4077-B701-63269703155E@nvidia.com> <CAJfpegsJ+ZQW_WteMypErq31hggYsMMkBOPd0o+vifhAS6dPvQ@mail.gmail.com>
 <3447B6B6-7D86-4058-ABCF-B093BEB5D391@nvidia.com>
In-Reply-To: <3447B6B6-7D86-4058-ABCF-B093BEB5D391@nvidia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 10 Jun 2026 14:22:38 +0200
X-Gm-Features: AVVi8CcVXj4gxUuROX-jbgt6uRYIDQLJQTdoVkfD0EszQov5tcLIrs147vwAkgU
Message-ID: <CAJfpegsoZ4eKo0hf_AH4MVSh0b9j0b-UD9kL3uxMLxk+PJZC5Q@mail.gmail.com>
Subject: Re: [PATCH v3] fuse: back uncached readdir buffers with pages
To: Matt Ochs <mochs@nvidia.com>
Cc: Bernd Schubert <bschubert@ddn.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 May 2026 at 03:32, Matt Ochs <mochs@nvidia.com> wrote:

> For the remaining virtiofsd issue, does capping the local READDIR response
> size in virtiofsd sound like the right direction? READDIR can return less
> than requested, so treating MAX_BUFFER_SIZE as the maximum chunk to produce
> seems preferable to rejecting an otherwise valid request.

Right.  The server has every right to return a short count on a
READDIR request, so capping it at MAX_BUFFER_SIZE is fine.

Thanks,
Miklos
