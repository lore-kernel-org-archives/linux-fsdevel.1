Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAFD476CE1
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 13:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787059280; cv=pass; b=gFamQhZBxn2d8ZYjuuKIX1/LbSmZRLdxV8yAnkEIRVV+ORVOekrgBZiEFsJxXh+V/pU0R9t7iephkU467Xv9b0r+f31XqVZXATYoVBJV42iSONkX5+K7kLDaRd1HHILCFE6glXz6LqeAIx022jW1jn7UuHR5/v3oLYFpnAd0Rsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787059280; c=relaxed/simple;
	bh=/VGZXZCepoNJgIgzmkwudDmncCfY9xJyxQCJ2G13L/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XDE5KwTkgXtdq3SkLUeV51Wy/C/nrbfzgViAiXl3AvEggrTvkdCZdGddTHsBMUsmn0g/tn242OwWIs6TY+8Sh9Gs1/jDwHACKbVw6SVJ1emIXnnt1+wF8oNTWt6hj1sCOxoKSBBx9PzBaiEfnw3/bcw5kt/iDzsg64xj2OQWFNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=cqKztS73; arc=pass smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="cqKztS73"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-936c02e58dfso296407885a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 06:21:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787059278; cv=none;
        d=google.com; s=arc-20260327;
        b=jTj+SvXNlhBlk3jDXbEfv27JIStKwmr2u6vcxFSA35ndphBaIy/hOAQG8pgTnDA/6S
         SnwC852Onn6ZVzK9W4BG15EiXbcilPPebFyehuTyIrjrylCdc5Fulr22NJfa5oeSTzX3
         OaOuKO+XdUErLuW1ksa5oYcIyGsdG4WOyk9QQ44DfQ4pxs116J/zd5WHPCcXXk8UMWm5
         vgpjdQNFzz0RBAXH/zBW7LkN17aSeOUgbhCHgrdiMH9cU/aX5y3+W1Kfpga+xl9tqU+K
         jY+AJQmorzbROm08xbolQZQeHpDaSv/au//xm8x3cPXTcgDeHZw5HNRwn7CxicObRu5j
         hBiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/VGZXZCepoNJgIgzmkwudDmncCfY9xJyxQCJ2G13L/U=;
        fh=ueVkTc5wF9iuVVhf6LzmeRebNQjq2uYmGVPDHJDuxuw=;
        b=UUPZESHhBoOXYm0wL0yKKlc/mdWQUXRdJ0RyWZB3qMic2m+EaDNXjJO4X3V5aanUJd
         EoHLpITWszh/PKAdL/3L2F6P7Kp3HwvLfqIecY8lF/kWygNH+1dNFTQKVgxnD/dImSnM
         06pw3xqqzIMRX6Ig/N8JyZUJuSqI3q9eBxjpGDeL70bkDy4S46vSkPF6u24/YWBEs9E/
         oarXyr2RaXrPSSUtJWFrlm6xA+SSGV9572wMtdwr+b3KBlJpfK9QTyn9kSdfbqsJ9fZP
         ZeduAoQ8vxatQXEoQaeemXmC9sHitgpvs13A0w49HD+Sn8yPLezFH0Vfg+2EkVP8BD0K
         pB2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787059278; x=1787664078; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/VGZXZCepoNJgIgzmkwudDmncCfY9xJyxQCJ2G13L/U=;
        b=cqKztS73MNeX7Hq65HM1KAtlufQkRNSmuHbiZM0sACXpBMdntfi7EDFq4K+Xm352cr
         mvNADnXvA9IdjWX1LuYYP5VwLeybAJ8jgt88G8hf4Rcp2ustw/8T8eAYVblbnFlPu3h5
         7Uh/faE+7l7b93ex0DrprwsQiGVv/81Oah6lU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787059278; x=1787664078;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/VGZXZCepoNJgIgzmkwudDmncCfY9xJyxQCJ2G13L/U=;
        b=c0J+jqYh8JIOfDmpgR+N2nsmcs+4BF3XlL37r8YgPqrFkRSfwCoheSGDTcz8j5tusq
         3NxYGItReikKOZdMbceW6NnRDy9L2y+0TZTuIgMzMmQ3HLD/jwyir6ClpjgJSZKdhbmf
         pNk4hjGXRbJuUmHAtDRv6KwjWgWVtMhI+OXhskQi0b6trKooUOThmmoPe23qxsPRZ0Az
         LTzOFen6+KQhJ5riz0JC1kgSQ35Y465uueNofJUuAebUgnEbqrD1WZuauyF5an6qWz9i
         tFlnNw07gAY6kTGQ1I1rJzkrKeBkq3h+7EEyvvKrmCi+eGGa9n6wpyllwbaidOcsM0Is
         Dj4g==
X-Forwarded-Encrypted: i=1; AHgh+Rq26urp67vkkPWIxBX7Rg4YL4/r1H/rePhYZrPgBqWmwnEuMmD8dlHvxQoNXmx6ZNGlBkVwwBMP/jsnUoQG@vger.kernel.org
X-Gm-Message-State: AOJu0YwvjOgPettHEzkKhWczsyOpYW1FiJ6l1Id4JBXi0nwKZnhp+dSQ
	fszimsjio/qf8XRHepSiZTdmArToTBxOoYrReqg9jld8ccuJV36r+3toakwz+w2wwRgN7BB2mrI
	ZVBkJB5phVsS10spE2cw29wr4rOmMKh/jAKAPfpThxA==
X-Gm-Gg: AR+sD13QAdIAwztZlyujfN4HwebMeYF+nRAKWjoGBkKQb7TUJfB7vd/knEEMBvzpTTm
	bfDBwXaiG8I1Ug65PKjLHafRwMNPzP4bukDQv8CcJnXi4W7m2yb2r5FqN64MqIGHDi7N3tGtLj8
	cYfMFvmI6gWnN2MfBZ+mrjY4v5OzWS/D70KlJuYbYMkGCpx1K92plWsu/QSPiLAH2kVXLMYDzRq
	N+I6k7vAvlPgZRi/rAJSzeUjM+LEF2cNsAqB67Xf5zg/JKND+y+WX72acFCWRPTM8dou9UUqxVi
	ikeJohoW+s7XMQqtfg0qz4PwG6bNtO1yI8HNYTb+BhmwQH/l/YBhAk6nnwlCs5F/F+q/Gogm1X7
	k
X-Received: by 2002:a05:620a:8812:b0:936:d2a2:5fe with SMTP id
 af79cd13be357-936d2a24ffemr3460347985a.6.1787059277777; Tue, 18 Aug 2026
 06:21:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260801082451.2770813-1-libaokun@linux.alibaba.com>
In-Reply-To: <20260801082451.2770813-1-libaokun@linux.alibaba.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 18 Aug 2026 15:21:06 +0200
X-Gm-Features: AcwNN1Uq2AZxWWAiZ2GeI7i2pIbWFCmY8WBUYjcETCkru1nzDswcXixjBLbPfCQ
Message-ID: <CAJfpegujSRfGBgVLj3k2Z8uhVYi_mSyZVhSO_9vtOTkyNn49Ew@mail.gmail.com>
Subject: Re: [PATCH] fuse: wake one waiter per freed slot when raising max_background
To: Baokun Li <libaokun@linux.alibaba.com>
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jefflexu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 1 Aug 2026 at 10:25, Baokun Li <libaokun@linux.alibaba.com> wrote:

> Use wake_up_nr() with the number of slots that just became available.
> Since the wakeup is guarded by !fch->blocked, num_background is
> strictly below max_background, so the count is at least 1 and never
> degenerates into wake_up_all().

Applied, thanks.

Miklos
