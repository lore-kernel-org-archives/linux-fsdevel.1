Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793635206;
	b=3+SYj6WRQsKoYQ9aASQ33Fym4/s82QcrjUsrAYimsB2rZ+Ozk7GYQ1TpFRTv2bRUFMbQ
	 bHjuqg/weVorGPqjDJOpkYlYMN9M+3VeVLfJhirn7PsLjnMzOYZpUZgzOvbE16BiWujcQ
	 PHmw67kZwV9DO9vhuHw304gDOG6zQoiHKgUu1dalDfkCicZ9DbPNlTM2vzLcYeVP2T37q
	 dw7nZKsaM+oGbu48Jl/pErLrTeaXOq9PnYpEhj9HCe5srtkQj4vXBPzSdCmqcUJL5vmcR
	 QCBls4Rnv3GIfY3vdn0qo/fbXKrhFZ2LRjCtvUy4hPj1jKahiGgJrFBcZB3b5ECkN2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793635206;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=q1PFYcNh+ALcjEaWQ1I52rEchwgKWiSa+Wd1iC2vUUU=;
	b=zRbclkp+82FmGJGjOVinkRMw5OpcyUI2dchYh7EZEq9mNZj+IlPKe+UmPLfcWRxBJVBj
	 RG0v54vD8UdwCjnAoCr9zfNiIoUdcln8E69GR77HRFJotQRyiCa+cenpTVi9kjsz/3Izd
	 MO7UTQaiv4Sdp2Q+Gg2bRMuwORssAwrZqp/3CoucFL3uoPwUMntiu4Tg7bDEKqJQekwy7
	 sHPpm2OpfWNRwSrnNhOttpdSqz+ayTOj62WFSWd5yaNjK90CGC0DrjGhRY9XEHh1Y0hob
	 iJNeh12W8jOxBLqM0AND4LWc2+hVjH4fV5O5yUHyy/kHRvOyvQOjmMPP9n72vP1oNZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UnqrwGlI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877786075A48
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 16:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 877786075A48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UnqrwGlI
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5383c97c8cfso442601cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 08:00:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793635205; cv=none;
        d=google.com; s=arc-20260327;
        b=E4TAvyi95x5J5M+K22U7SlOAyAMMMnkNK2MA/Cs0nkdVcE0BW3/rIdIoeT39Y+P3Py
         SkTwu/3/4FX9/82qilSYZ3Tfq3OCVSCraz0MCk6VwuAv9uRupnVV9871EB9teMxnEChu
         Nzp2LdklIpqUVX3IC+tk2XKy3LShdVgDB5xxXTNIOKWcoemL54Da+o0bi857cSkguGSg
         TH7aRB5cJsECCs+vvkOIMrkMgHukh+3SGN13Bwkv/s8dZiukdY4uQmbuAzk4OGFpemUN
         GO5ChvyF4Vme67TeI7oqxw5/mVgR1OE49+mAB3/uz3lZaiVQULkzrW8VFjpO8pPWt3wP
         /7CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q1PFYcNh+ALcjEaWQ1I52rEchwgKWiSa+Wd1iC2vUUU=;
        fh=Hpn88oD0iL5f70OEg6wUH7SbEv0dDp4V6KYNOgeDMlk=;
        b=dQypM4+7h3bLniRMDTa+0alOVjphDQq025QNiEsBnn0btsCbv02Olqd9nyVzwDuyyq
         61lgLoRc+OluI+ECp4fMpSwlodE45Xhduv1wxVy66OxoJ1fiuD+mH/yJtXMuiaS4VM3K
         48wodxc1LCqtsQw4lwNW+UJ8Dh++Lngn69HYg0PdvMpDnwbjcB2elq+Ryli7ivp6/Yo/
         VXO/NFxDpsRSwRq7raEEcyWZ8mELcDOWeoRXlGdcGdDpEr4d6mZ47o7fC6G9YoO3qr0V
         Ixn2wpbsb0GKDsKx5Zz9DyUpKGIku+LUZMHRnPoCPiBe7NE0p65eUDLExiJti4XJ0tWL
         IClQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793635205; x=1794240005; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q1PFYcNh+ALcjEaWQ1I52rEchwgKWiSa+Wd1iC2vUUU=;
        b=UnqrwGlIFFgsUvYnNj2zvDtkyBQ5jAcUU0RuqXandS12fSr6+pnsADsXdINiz3xY3R
         k/1fSW+/uvd65O9PPAQRdXb0AyHnVIQzD3WrxoElEPCU5eRcrIk2PdyGHvVTtEIcBOJo
         HPB6oKwAOWZ5smEdE2uo3fZJKCM+xroy0CWvh+iy/Gd2E+7pVGY48n1QwhoekUyGhF+t
         wmI/rff4Tr/e3kguX+q5sHEv4DqLMm6ILoCQGsTHEXLzqXkbyqLhf7ba/CZP8rNYFNfJ
         zvbnY12QELh5J06ldbFoIakjsxASsEAiuO65V9V1dsD07LvrzFk+83uSViYKwjL9GDmJ
         YYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793635205; x=1794240005;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q1PFYcNh+ALcjEaWQ1I52rEchwgKWiSa+Wd1iC2vUUU=;
        b=oC5zwzo60GrLq/fgyBETBs1mjDFFsWDiiYBVhSvn/ySQf8WddvhC8J1GzfQLU53fSf
         up8fYzGPFIJgO/6oaof+1iT5b9MYL10y4WGGxPSSRBtv4h93F0ti7PmoAsNaQSnTyZ+7
         YhqLb6yTm1IC5q5vS7ykm3VxPU1Z93VpvhtqVaZhyQp9SZGgs70rACbp8mGwgwSdUwIW
         VxVJGo1Dt4UNpJo7qcaHezkXHdVcEVnsKVIpkAM4dOwk62D76VcqcS7sklmWFLQfG4vW
         PhgCusDRDQruZTOfnYiEK8J9r1MyraBMygcO7s4CjSQJrQTS+hXrsqOcVcClBik4LjS8
         Jhew==
X-Forwarded-Encrypted: i=1; AKwUvBxxOfjRAHti/aW1OjA4fSqBJeEKTt34WAd/psThrmtXgGTDLAtErsSA77SR7+Vw3xZrPTmN9dE3+x6h3cJo@vger.kernel.org
X-Gm-Message-State: APuU4Z8F7HHIMnh/oSZixirw17JCa8yCPJo/abm1EU3yR6TrC6IJwnER
	WlvMsXc/6E1KDhhKjoJPoxn+eKeYoIwUjeU+WRDYzlixCEnEW+MRdC+etrtCwaAkR+yOTnhZyXZ
	e3yMHdi23YIsU1qwgH526h6xF/NApHVW06U0RiGC+
X-Gm-Gg: AYBFou1UsTO+9yRDu7FqG6hWzQ09l2my9dZgcccPH99VuRV7FGwftJvfET7zYnqhda/
	uStSuHXhpnkSMiodvo9BD8FJ3IB40DH9MGQIrYYOiK3QOIX6uOZkVjw65B8yfkIgl4QCt4KsIv3
	+vG9jO0izi2lN+VVHKMskEgOUGHtDpXZ4HemS4lPZs8e6/yj4Eq07wiYHwPcIRV+LU9HbXJ/JSj
	gY4/3jnwFMqWuXnPti5yRQGN1xk3NjrTv77iKID9OP5WciCZmPMET+LC45WLjFMGErIutyDrVA+
	xj553rZ4VkqPSr6VAplb6O0GD7VzNzIokfTS6+6glp5R7a5TjkvyvlwDO+nODm5v8PA3Z0KR1Kc
	04zQztuLsug5fdlxhZ/tIyWrqtpvySDViYm7W
X-Received: by 2002:a05:622a:400d:b0:536:35e0:4f97 with SMTP id
 d75a77b69052e-5414e8ec151mr81444421cf.11.1793635204453; Mon, 02 Nov 2026
 08:00:04 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101154503.3203036-1-surenb@google.com> <auiMK6ynztyF1-MM@pedro-suse.tail5790ac.ts.net>
In-Reply-To: <auiMK6ynztyF1-MM@pedro-suse.tail5790ac.ts.net>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 2 Nov 2026 07:59:51 -0800
X-Gm-Features: AclHuK_cZDbtd_0ueJf6rRfK2iXBf9dKhq_tkrnJpLDfq54hZvQR7vC1PP9A1x8
Message-ID: <CAJuCfpEbhjE2V57ekoFfOjoDf5j6LvtcsrzneGCAWy2d+pQW5w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] selftests/proc: use RSS in /proc/pid/smaps_rollup
 tearing tests
To: Pedro Falcato <pfalcato@suse.de>
Cc: akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	jannh@google.com, liam@infradead.org, willy@infradead.org, paulmck@kernel.org, 
	usama.arif@linux.dev, vbabka@kernel.org, linux-fsdevel@vger.kernel.org, 
	yi1.lai@intel.com, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 5:26=E2=80=AFAM Pedro Falcato <pfalcato@suse.de> wro=
te:
>
> On Sun, Nov 01, 2026 at 07:45:03AM -0800, Suren Baghdasaryan wrote:
> > Pss metrics can be affected by map count even if VMA tree stays unchang=
ed,
> > therefore tests checking VMA tree integrity can't use them. Use Rss ins=
tead
> > and pre-populate the VMAs so that Rss changes if a VMA gets skipped or
> > double-counted.
> >
> > To ensure all test VMAs are populated with anonymous pages, remain
> > mergeable across VMA operations, and do not have their Rss changed by
> > memory reclaim:
> > - Toggle PROT_EXEC instead of PROT_WRITE between adjacent test VMAs so
> >   all test VMAs remain writable and MAP_POPULATE faults in anonymous pa=
ges
> >   (rather than the shared zero page, which is not accounted in Rss).
> > - Use mprotect() instead of mmap(..., MAP_FIXED) in split_vma() and
> >   merge_vma() so the first page of the split VMA stays resident.
> >   mprotect(..., PROT_NONE) splits the VMA without unmapping the first p=
age
> >   (pte_present() remains true for PAGE_NONE PTEs), and
> >   mprotect(..., self->mod_info->prot) merges it back. Both parts of the
> >   split VMA retain their non-zero Rss.
> > - Lock all present pages in the child with mlockall(MCL_CURRENT |
> >   MCL_FUTURE | MCL_ONFAULT) so memory pressure cannot reclaim pages and
> >   alter Rss during the test.
>
> FWIW, I was wondering if it would remain constant in face of compaction (=
page
> migration). It seems so, from looking at the code the migration entry sho=
uld
> make it count the RSS. But is it always the case? I'm not super familiar =
with
> the migration logic.

I'll double-check, but it seems logical to me that page migration
should not affect RSS.

>
> --
> Pedro
