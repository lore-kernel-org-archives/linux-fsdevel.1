Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6811AA797
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 02:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778205701; cv=pass; b=Z8PcCORp6goxpaKDAwnTycLj/gZp6/jUh9tUJrf+ThZORXlRyROB3b8pHBeLDesO6ilVBDg0iQ583OLoFykVXBQzsF+rsvVsLcCcQQF5QASU2s5l4CDgsJDDG+fpXkSd4XjC2CHdqG/oPSqg9CM5Gm0WfeBKdz4NRpJAhfW+v2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778205701; c=relaxed/simple;
	bh=1qH18qdpYxAFdRK8nMmKj+a4ErONg5k6uU1EBZJbI9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ipzgf+ISbs54DQGmcfYx/6ptfio+m4m8vhQgzHEouhBaLcFBK5PUU/32h+BTyrOfM8ddNA2PbxiZGrubdHxEM1lScNCEoVOwsiHE4EkEDhMzMSrLdF6oR441ix9rcKajYlDBkBEvO6utfViEn8UwWcztywA+nxhYuP8CSMq3fhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QHNxT+sw; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QHNxT+sw"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-126ea4e9697so3568c88.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2026 19:01:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778205700; cv=none;
        d=google.com; s=arc-20240605;
        b=A5Zbgys4QMiswShQSonOzNs1NT4S4+vFcaAQVTPLUCJivmcYeP9K+ls2gM1ax+DIJ0
         Vr7zPlLY5JSHav/cqnRzQn9/pc0f/ERqwSBBOwC4Itr+DWBR/9JEqjpW8X0rBw3Wz3bo
         2O4Cg8lj2VMWi47n+q6NhNocSP6cwvJpW60bccuagYTQ+kqrGiaE9YEpXjMu9cDyGmHV
         5IZHVxoDh15UZa4C3pKbS5HlwfjW1aFD53/nxP3pEJkbtJiZYjpo+Q8aOfh94ItwiZ09
         MM13IYroxWSzZvOO8SwJ8KYDwFA8XXvn5GP7v0ARL9JzycwUz0KD+EXfi8IqLfCbJppN
         Nk7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6jsJtIabJmDpsyQAeEg05bOKsXfq/l+0TOvsDmHecoE=;
        fh=LY5GC2Imbr8OSOSl9RfEn0KXypbcWfprp+POGOCXlaw=;
        b=PUZjYnTzGd0lc+SMdsuybKXRsuaQHK5D19lp0XGXth2RR+reIO1UVjnQ7uii2hJIev
         icH0ncmkliCtO6QyY/UEGBMDGS82VWkSXjtJSk6QmVCAMlVtvqV+qiHC+1/M72bkaTDa
         FwgHvKlIgwJxqX1s6iGrb0xbnp+ebAYYvwERdxUd3NCw5bNTdH6WDTL98KdZDSiqXOwj
         wZgK3l5e8XiY3E2+Zm8CNJyE806nFSV67a1P+ITwcL2krcTWEtWr1b6Tjx1TQrKf2GuV
         OeShitv0Ymx4elIYIhQrKYzi4qXN8GNkm9s5DCITB71dt1ip7jWxRLveuEfxEGVLu+mO
         Mo8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778205700; x=1778810500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jsJtIabJmDpsyQAeEg05bOKsXfq/l+0TOvsDmHecoE=;
        b=QHNxT+swISpkBYz3xKHb+VF5WA951AH/HrmJ4qasEhJTxyUoqD24EzBjb9tDP2XcIA
         RcErwmz7kihV4kC69FMqmg3OgZdPJa0n/aU+jaVJ6X5tOMS0//g5fBgdaQik8ory4byd
         NBAm9IhORi5caUR3thLPBw1tsXc2nSo1vvXzXm8uFGM756S+pFg5lkdpGp+QondHvkEb
         f93VNTBeQrNrVQcAlEm4fTtAqr7PaBKmmuG8ifbOS2eCNOTNburdmg9WfLVmsBqNkdXn
         yARdHhFZbdw3Suz+B2FfkUfQ4wN2D02T+7sWBDmSA8uzKelIrxKdhSXxKV0Sq8FW/EZV
         d5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778205700; x=1778810500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6jsJtIabJmDpsyQAeEg05bOKsXfq/l+0TOvsDmHecoE=;
        b=ZIWMABFW3v5hXgT0C4jIwb6fVOBR5uWvDeBTHf2qm6XWkj76k3bqqwTPcWPbk4Mvs4
         xH6POBlCYd5adc9tuZmvtj9bbhD7wyoEUN27wnc/sU7xEPkcjSIk+5pVPdKiLS+V7ZXG
         MFRGG/mgX4XLctNtYYDSxtBvmcJjWuzqB7EFw6+ec253AwpyF4Xl5lyvCEwlJHMaXyOI
         B/FoiW3NFhIXSrNs99Ylm35YhmQqE0ZUI7mQSIxSBD1Xc00Sa3lyt/0rrp4IN+xO3kv3
         sw0aKSKF8zidHfmL6cRCIVnhuzTWn42w/PNuRIYfQTeEFhBJ/c5x01WWtqUdG5L5yD4w
         +DeA==
X-Forwarded-Encrypted: i=1; AFNElJ83oxxMmihB+GTApNg+bBq5L4JOxTr/1eWw1HKTyjO1OB+Ewz7Jp/m2AWzIaOVNoMpbZ8lJB1+av1P0VRJw@vger.kernel.org
X-Gm-Message-State: AOJu0YzC26lATAlxs6wvAAmysOO2eHbTRa9DqFTiR7Ma5jT0YvNq2zxs
	zR0vYdYouIIUXGbDm+3W+iZi5EQ5ey1qhFYJmpQQK5SfiaauD7IS9gJlureR30EmvVRU7+u28eP
	n4tqdss67SWohfZdliVuPhIsnGAzfsF5+uXMuzdXw
X-Gm-Gg: AeBDiet4xZtVrfMJLV4mUC4u6ys1sjEeWOSDAtIl1V7yzi40kJ6Gu+eTmDs/ebuxiKj
	NMgEvR+Hln0jBnu+epOp4FKANXdSAM755n1wpR22Nzii/5euhQDJSAzlVsK/ysKd5vYjHKiTzcL
	8jBwvc1wkofDFY9VQIRbCZ3g5nCBiWmzZyhUjqiuWuO3JU0jMMb8bk4rLkQdyYhEXH7pJS3Vsr9
	8+y2gyDGaGXNc9YxOqTtzgkOR04RS8n3paZYBbUJjPlK+OcvmvZQ4ElHAPN7rjvbODCtdwHVTyj
	nhxCYNSLYJmmzb9/iak=
X-Received: by 2002:a05:7022:6706:b0:130:c9cc:2919 with SMTP id
 a92af1059eb24-1326f5e59aamr47946c88.19.1778205698960; Thu, 07 May 2026
 19:01:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260501011908.3630802-1-fmayle@google.com> <20260501061146.6e61392d125cf1847d7cc181@linux-foundation.org>
In-Reply-To: <20260501061146.6e61392d125cf1847d7cc181@linux-foundation.org>
From: Frederick Mayle <fmayle@google.com>
Date: Thu, 7 May 2026 19:01:27 -0700
X-Gm-Features: AVHnY4Lka4VCHovYje-DOBwkYGJx5QVAilqV-2NuomKV-25k6NdoK_k5CuukxfE
Message-ID: <CAHCxdc5Kug-o8ubLmZgeQdcFmhvAMmAtNUc95t1kx3Wjggbnvw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/readahead: simplify page_cache_ra_unbounded loop
 counter reset
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, android-mm@google.com, kernel-team@android.com, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 1, 2026 at 6:11=E2=80=AFAM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Thu, 30 Apr 2026 18:19:07 -0700 Frederick Mayle <fmayle@google.com> wr=
ote:
>
> > Minor cleanup, no behavior change intended.
> >
> > `read_pages` ensures that `ractl->_nr_pages` is zero before it returns,
>
> So it seems, but depending upon this might be a bit fragile?
>
> It would be better to make this a more explicit/formal part of the
> read_pages() contract.  kerneldocifying read_pages() would be a
> suitable way.

I agree. I've sent the following patch to document the invariant
https://lore.kernel.org/r/20260508015402.735441-1-fmayle@google.com/
