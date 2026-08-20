Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DCC3BB9FD
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 19:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787254590; cv=none; b=ZMHVFyG2GEEWbnYLzscpjbpmOtuS0sWstI205cCSPfwiEWjPuRBFd+AHLb4xTjwEUXoOc+WrIESyMV3lE7gp0BAeoZBQfKNi3AgWBfy929xPlsja4KJWIswlnMY9CwZsrAzBGcvS2mpWiCHHJW5LYD3mqE6TL78kdGRx7vaRE/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787254590; c=relaxed/simple;
	bh=NqtCt7tTXkI7IiVJN5UO1oCrux3916VNVcmvRkYd6IA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EHMlyJpwHfsYN9i9YvIkZmoEpd3v/rRlja0w8spgB07AKU+QrJrdA60SyPKflQBwJOuH2kaPowwWqTT7146RSm3SykashchKtdEe4WYM+yBdm1gVsO4yaO2jXavs53gvCyYT6C5Yd4hUgMJ4YY8J7Qc7uMfS7GYaQqqxgwdr20U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=buA1sM7D; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="buA1sM7D"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-698ae09e356so542949a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 12:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1787254586; x=1787859386; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dwKU+8hQ/jzVRueQ7P7JAPyUHB9wlZKPojFGbqXXjhk=;
        b=buA1sM7Dy2lBlTJr1/ETCW0Kt7qDbt6HBwrGJMri8rNIH1pbnBYaRpL9MPuia1VitN
         mWWv7KT3WfEoh+xaKEGBSER2Xizo8mA289w+QgFWlOJZ7ws+3VSoTsLvZRPSdNrjVXPC
         KFkOfQAT7hZtiBGUa1vWNaFrtlek3V1W8ZK30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787254586; x=1787859386;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dwKU+8hQ/jzVRueQ7P7JAPyUHB9wlZKPojFGbqXXjhk=;
        b=OuUnrfOZ8te8wFhv25DaiSb1nlOpnofaje3JGP0sP4hw2YBy0ze6AwEpmdNSrAA8EZ
         TvsW8i2EmiMc6RfP8zhTKdoyStumbB3232q7jg+WaDxOftbL6kFK9weArRxR6Ptp6BRI
         Q/MxRuDb8ajC68UDrp/V05idAhO6CsGRmiJpGadp+Z0iCGi4GzLfWBXySgitcCZEbl5F
         2/zILdMhEt6AbOtQ87QkuXEVkCU8xtGhwYf+EE2ftwZeWLz4SIe4nDah7Aubmhme/fU4
         LmPNkmoh2UQ+D6wjcvlM1xn/YxXx61ajnmqATjmccHE4638ikafGgDjJfbSfJX16d9p1
         Zouw==
X-Forwarded-Encrypted: i=1; AHgh+Rq5A0gN6FDb9EJgf/qBybdHdV9qXwW5/3P1lj5owUoKsPRckBIUb+ZByVSRZvLEa1V8jml7Zz3RQ//svNR+@vger.kernel.org
X-Gm-Message-State: AFuF++k6+QcJQR9ee5fTcM6KLDBzNr+lZa875j512WjPpukgjZQeFzzx
	ESalLdFxwrW71kVFC2qVXO6vh3BuSh++852fOtYjQ3zo3r7QIQyXF/eQjI4Tt1I8JlK2zX5QiGC
	gSHKGR2M=
X-Gm-Gg: AR+sD116vL5chhXHuUL0dwAD1mWUKhcgO1KQAh6R/QR+/L1QMqWSodZyYPeK2rYlo4G
	t+chJgcm3YG5YnUJdZfTJJMQ62o3YPzHZxyHiljLvKkMhOTyeBlCSvr2na43FtRCinIRArJPHFV
	2Ag7j8SekTVmCWwukfLDCWxuBFnXiHLnSGW5YfUotfbaNLhP9Ui5S6ctcPbjhUKieTDkE20McZ/
	YzINa9SFN7s+sTfieAc0lvHI4Lvj6058rJgbT+Lzs2FWGwddeaQfTBbzTJePBy0vV4kixeC6eYq
	/ORYzd5svZ8W3nzimC8b1R8Mndm67CuT/P1NCyCyNRO5Mms4spBLOsVMgCWpGg3I2yMJ56dVfgk
	cSS2gOmPp1KUu0oyt6ZPmAz5K6l+WMrGDmrwJzfWCYOeco7F2RewDd/od7rg/KDxDx5P18q4VCv
	X2++qnKt9/DPkPttOEnEEQ47D+igi8Ri232Ox2GsbBi2gABGY4kEUcKShYDwrr4ZZ887a1vMv46
	2WZOUmh+/NQjR16gy2jt4RZVL9tU3svc8bLeA0=
X-Received: by 2002:a05:6402:190b:b0:6a3:fdb6:9db2 with SMTP id 4fb4d7f45d1cf-6a42f14dee5mr864742a12.3.1787254585923;
        Thu, 20 Aug 2026 12:36:25 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff16c3bbsm2553099a12.24.2026.08.20.12.36.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 12:36:23 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c20e70a0962so34424766b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 12:36:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RogvYAh5ni7HRk7lnuOnbQI+K5/NQVHenHjsnDoMUKTqhZmV6qd3BFycS4Z7H8hReYc1SqCzGMvZYn8PF5s@vger.kernel.org
X-Received: by 2002:a17:907:3d0a:b0:c20:74db:50c7 with SMTP id
 a640c23a62f3a-c246a697ac4mr83093666b.13.1787254582846; Thu, 20 Aug 2026
 12:36:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818122105.24094-1-almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20260818122105.24094-1-almaz.alexandrovich@paragon-software.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 20 Aug 2026 12:36:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgjN68GNSK+Pz4ZPSYHhcQjURkoOZ+4ndiamnGSbptocQ@mail.gmail.com>
X-Gm-Features: AcwNN1XcPmEshjPw9BTcH6FCDKMwwlDL0rRFFQfx65fk1d7wMtPMsWnz4a9Gvho
Message-ID: <CAHk-=wgjN68GNSK+Pz4ZPSYHhcQjURkoOZ+4ndiamnGSbptocQ@mail.gmail.com>
Subject: Re: [GIT PULL] ntfs3: changes for 7.3
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =?UTF-8?B?SEUgV0VJ77yI44Ku44Kr44Kv77yJ?= <skyexpoc@gmail.com>, 
	Kyle Zeng <kylebot@openai.com>, Ruoyu Wang <ruoyuw560@gmail.com>, Samuel Page <sam@bynar.io>, 
	Senjin <senjin@hatchling.org>, Weiming Shi <bestswngs@gmail.com>, 
	Weiming Wu <weiming3@asu.edu>, Xiang Mei <xmei5@asu.edu>, 
	Zhan Xusheng <zhanxusheng1024@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Aug 2026 at 05:21, Konstantin Komarov
<almaz.alexandrovich@paragon-software.com> wrote:
>
> Added:
>     load ATTR_BITMAP run extents from $MFT extension records
 [..]

Please try to write some overview summary of that the noticeable
issues are. This "just list the commits" isn't useful for outsiders.

I've taken it as-is, but I'd really like these merges to have some
useful "these are the bigger issues" explanations for people who don't
know the code intimately (ie me, but pretty much everybody else too)

            Linus
