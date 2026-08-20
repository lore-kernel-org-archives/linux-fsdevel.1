Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8C447A878
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787242316; cv=pass; b=BmnUhAl+p3Mi/PTLwAGz67raV0kRFBIbJ5bGD0TKkZHkG6wH60P8B6PT5bEUc8F8DvLSGQtXMrmO2Cm/ZEiLrX/4ZvSNMxJrKCTmsQJP0jZ+HC6OyWxEqnoaz4LvYGKoLpUsdwx3bd2Ao1GOSsx2YRNqQ1KrC2WhrgB2byVmTO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787242316; c=relaxed/simple;
	bh=wdeJi7X/Q4rgQSfLamGPD1WkYbyFGSOSEOk4sVh7M9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GAt5ByWDwHhppNq7a7u8XMjVrS8ncsXTj/CUUJkq+rSmeXO8YxUsDufFjCpedoLbmgahUlNU9Dt2sEQMS8GWc00CTSWyuIm3994vb3NfhhnzJy9bIIfbiQ2Dj29IZ7CNIFeo/NJ4MY/O9J3ETqQCT7SCRfLb4mVJM8w9B4mGzAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=aa2Zs5vo; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="aa2Zs5vo"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-52d8748cde5so12667291cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 09:11:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787242312; cv=none;
        d=google.com; s=arc-20260327;
        b=THEFIYORQOrE7xNeWCpLptfcTIiq6ZMXG1FSZHT9ZgvLoX1Te3JKcq6Q/Aoa6ugXqC
         Sv3qM/IPXQXHPFYvFatFxGCtfVTCyBFSxRa4r+ludWAcmCeUpUu7rIfa9NqwsFNBLl3r
         aEC8OXZv3XibIFjGEeCenpe43smtPx+F1JL6dq/wh3BIu27ypqb5aGPAoCOEWMmj/W5o
         Ihm9p7DzzdWK3Tg5fnxhMTwfEZqHcECbm+huTPJ0NSF0dMyGsnivBFL6z2EmiO7g6Ku7
         m42Vsg1CgljhLeYjPeYaVa+bbesmLnxmhOYe/gAg4kn4UkXdcpqEw92LqB8HCUU0u4Gt
         aJ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ymkU8qd4K4bZB6E/swdK1MBXnSrS5Bp9t+afR5EeVdo=;
        fh=8n8HjAIXW+/NUprNOQ9sF8BLCVAF6i+DnGR2OAVJ4qo=;
        b=I4EBBX2gOfLHPRxX9NyW8n/TqkD+Huy3n1aLNZrT73c/hohLDRqulL8b2D3MwD4mzu
         Wg355hk4Eq59qMdzkubMcThZJn6v2Cp2x0pI7oeOM09Xb31Fe2ajk4DiyajrGRZmdvYI
         LxhCm5iSCFnZJFWQZ9TPk5tP/ntjs2uWtEZAC06x75yYLuYrrqYw6iBEMxCTr7/cLfk3
         oybf2/RKqrMcCL+fUjnQpGPq8oaIhHNhwLgnYfR2r0/0ipku9xMNivpmhrRm2JEIhlg7
         P+ehHCmSQi6+v8Gxn1dvcJeAFn3BhhDpBlWmHuTC3p7NXIQl2liiQ0Kjh3wANdD9UF2B
         w2Zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787242312; x=1787847112; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ymkU8qd4K4bZB6E/swdK1MBXnSrS5Bp9t+afR5EeVdo=;
        b=aa2Zs5vorUkDfr6BVn/WSzEmp2rvkoSuBGi6wbMXVy1mm7IKXOQ2DefLaLm8O34zyC
         RB5yHv2kK7CP60srWVOMZFKsT7qiQO0y7G/dsWZUp+KhDfNWGuxUedWBzws9Nx/B8nyr
         yzp0V7eXVQbzLVhvUbpXnHliJNccbrTg+ThUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787242312; x=1787847112;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ymkU8qd4K4bZB6E/swdK1MBXnSrS5Bp9t+afR5EeVdo=;
        b=daWctSCQ/SMopfEvuvz3ckxDGeQ3vxRINAlyNK33w/eFjTFH4V+Xt0EfNByo+PVNmh
         of5eTxrQPA25tSIqvUdlPu+PDM27ChDzu5JKJSG37bQtLMal0auUUQ/rxVt2ecJuD7Fp
         ZS6Jh/RXpORyH2z42X7nTyXg0+p+Z0KKIjcXg4LR8/WYVhtYLxQ+4jCXjmx9cHxxcbwe
         RAhsFzO2gBZwU3zgGDxYWHOvniNnZtrUVMOsXhylPVowvmgMAhyArtaaBknCTFrp52tL
         hnM7umtoNeaVw+R112sKmMNppovH17urtJtt7ukf52Jhefm1/eppUVdiQXVmyq6srCF1
         iOjw==
X-Forwarded-Encrypted: i=1; AHgh+Rq6Yifi5ZIk3ohnxztLAgS498VZaMUwEkWNQnuZYHWEDOxuClexocn4sLqVXhqjvDY+Tq5U3ZJirFosMNN3@vger.kernel.org
X-Gm-Message-State: AOJu0YymhBecgsUsUNLUbYEsG97ZwF/9XBHBnVPwH57N9K1MvmcE7gl1
	Sn76AOMDHy3IjOcxE8RPPc3AbUu5whyM7rb2emUQ5Ji3GarB92I9YLDWhbQy1JhbsYQBjMo/gr8
	1BLvnbNQZB9DU9IeXymQNqvpV5FJa/gM8c4PtJj/8mA==
X-Gm-Gg: AR+sD11G2ryEvYbLH5RifdYL4KriTZF2De2JMTD+V9V3EEJGx8HDG2Z3kTsBAWtfMXV
	Ui7VppHvryBiq4yhChwqbZhFHS4Hj10ftQ/dzuLQ2L01r2PoaZbkCYSR7gQNfwcbiNuKHFlx5+y
	8JzL66UdefjkLdGixIC0mztjdJhEJCGcI96aHqAgxdzJuCILsfGAGuozIa0jhTFgjn8tDQ43l9L
	qlNqBbLLCXR1H8udyvab2UnhGbqK9lKYZmkiC4dUWpFDJW/IqBCyOccG2pBe0ngrCN1K+Y+NuAN
	9HUqSwC8PQxzy0yoZjIDN2+8QOOQpOtR9hqnbZDN+/y9+8SNdOCcQVPp9KweZFDJxOqgXK3GPE3
	c
X-Received: by 2002:a05:622a:2447:b0:527:43a:2f31 with SMTP id
 d75a77b69052e-52dd58cf89emr139582711cf.15.1787242311914; Thu, 20 Aug 2026
 09:11:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819023542.561653-1-senozhatsky@chromium.org>
 <CAJfpegu2wOG85R6KSvCwHOuxe2fWczA1KbrFcCZz=ofUch4K=w@mail.gmail.com>
 <20260820084933.GA4036497@noisy.programming.kicks-ass.net>
 <aobDGgivy43cz7xQ@google.com> <20260820091018.GA4120091@noisy.programming.kicks-ass.net>
 <aobGRjc7SE1rwIHu@google.com> <20260820093402.GB1837346@noisy.programming.kicks-ass.net>
 <aobKfyGHkdMcleoc@google.com> <20260820104111.GC1837346@noisy.programming.kicks-ass.net>
In-Reply-To: <20260820104111.GC1837346@noisy.programming.kicks-ass.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 20 Aug 2026 18:11:40 +0200
X-Gm-Features: AcwNN1U8VRCnKe90HOpNZaDIfAjWPtm3XBLjBJ7inxfgMD5QyxcpFAhW03fUODU
Message-ID: <CAJfpegsSzOqs1zkhB9GZxsT5HT1zXDbHsZNEbA7P7mxe0w2dng@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: permit freezing while waiting for request answer
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, fuse-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Aug 2026 at 12:41, Peter Zijlstra <peterz@infradead.org> wrote:

> Also, you'd be putting suspend success in the hands of userspace, that
> sounds like a mighty fail right there.

Freeze ordering is also a hard/impossible problem without the help of
userspace.  One obvious heuristic is if task has a /dev/fuse fd open,
it is a server.  This simple ordering between server and non-server
tasks fails if

 - task X is a server of A, while also doing ops on B

 - task X is server, blocked on task Y which is not a server

What about adding a flag to mutex/rwsem that allows making them
freezable at setup time?  Then fuse fs could set that flag for its
locks (including VFS locks).

Thanks,
Miklos
