Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793221754;
	b=b+OLF3HiQfJ9nrOwnB5+u2azYH2HbHiTBksa2+EcnnnVPciy/JZfZIdZ+o4ZiVjm73ao
	 lwlrqgphOYiFJga5RoENhseKjup1xI6F66VYmphp6+xdT/P1t5KF3ly78hY3WnFSXhG08
	 82TU2VPMWqwhPTIBYdkxFdKKr+8VppSn+MbVy1+1OVCuHJzPHxhhBW+Vg8v4kmZ1joIB4
	 xFY7be2h06cNP1uPZWlS9z2kHgrUJu8Ci4JZMs0Bc7vAfTiuUFDKgb2nC7UszpxuIHOsc
	 1l3230Ugx29eKEUG1Xe7K6uFL+5C24z5j40HjG37UQ5DDSVenPyx4qypQChN5NwgerQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793221754;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=b9Ue7Amy9dAWOngMe9Pw0Kk0KAocM2Q9voQibH/OirU=;
	b=bPN0iGBFBsvEIK3N8JnlvG2dYTmxNNPL8HAZgTY5aE6qDmneGuVY2MxvCVQZBUVYIVmw
	 XUY62TuAhbPhaYKO5UdoNerdK2YcPg8gxSVD4UEQ4vPdZHwyEAGI2Z3NWaYpUqoUrppcW
	 yIRQVsjFvHaqFnwjEctIelpX5NKu7hA9crgZD8ZZBoqKGOe+LykX4hDEJ0t7kgMp6pLWS
	 Nuob7JyYfJXyndM0uqPPKnSgNSCkMfKWNbRYSvVpoQzriK10xVNfKVOJuDdjw9kt6i6Tv
	 qOb9DakSoA7E9WTucl2pW4yn03Kbklhg33emTfQD4hNYhCaEYyfRGJx64ZiR0NTXrHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lYpPdQMK;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B13606A322
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 21:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88B13606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lYpPdQMK
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a2d6cf958bso8585585e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 14:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793221753; x=1793826553; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b9Ue7Amy9dAWOngMe9Pw0Kk0KAocM2Q9voQibH/OirU=;
        b=lYpPdQMKb567K7Gcw8lAVZu0HbfmVC9X/z1iRKMq1P1CbFM1/B9/PYj70+JtzadMVC
         7yKjRdneV3HesBPbPtayTidUfKDRj8zK/78nrBfD3dKsaMZjIT/1DQSpIWw7S/w1MQD5
         VdhxflrOnAtV+3nZybKuumlrxFIQWiXyFzXNmLfgd9QLtlpnlnvTQrfDzAORBh4UCQ6c
         I/QrPcCBFIoPijM5QjZlw72+qdNiLjjg1ZsJiJmRne+Gy3orRQFo5gdRr2JC3NatTnyG
         f376m6J2Cq9qIGSEmgBkmM9RzAva2Uv+2O4yO3s1ord3aGepQOBRO1jtCUVSEYqrZMJN
         AqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793221753; x=1793826553;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b9Ue7Amy9dAWOngMe9Pw0Kk0KAocM2Q9voQibH/OirU=;
        b=VSuoUj7FVWRGpj8DL5E1n4p0AfRe00v5Aq/gYd/p6t+Zhsk5lEyYGYlStyYVP5ijL9
         2z0icFy6Zbn4MhiEnvVFXwKjbDE9T037EEXue+tu6URtveP1RNPPSGMPK5exVRGSljr7
         eZfyxQpRVj1OecSu51XOjDHoOZryRwdGL1DugjIMH5lI2AqBcE9CU1n5UzPqo2sbIpsj
         4WOiUBkFyhsish7ZiPcuq7MNJV6AtQpOGw6CyOyegZqm1/qEW30iZWwcA0GMwKSVNGAu
         YXdjdA+Hk/LI8q209BJXPiNklnOQmltN5ISJdUQDX5VtUwHr+NKsNS/Cu3aN5C1emcHq
         pjDg==
X-Forwarded-Encrypted: i=1; AKwUvBxm/DIKrWRrAlR6NFIUmvRPG4SzviiG4bXoed5bdGptfKs54T1mYF8nYI+n2TslSn4QbXykQ+nN1DlVNncW@vger.kernel.org
X-Gm-Message-State: AFq9FYLYsGf4CrbPyA7/pOTCPxDxBR621MvoRkzxvdG9Vo72APrcimWu
	blSsvs+2MP2qrHDqoDZ2crE053o9v9hBbHhJG9ZwRMac+mHREVHkXTRe
X-Gm-Gg: AYBFou12OFxjh9H2beSrfBqvIV3/RjKSOBvIgHc5se0rwx8bG2pHUdTmin7ZTLm587/
	EpdZImwLZ2q5WaNyZUndpV/Ds88ftYnTosnsOAZM384i2tknVcXAdsKumKmYWXbyICKDUBokIN5
	WVafY5gqtgs3OiNRnH0WWOS2HMGELe9qFxHfwnTwcqKNI0vaAGj0f6iTiuOZCjGRs+DNBvrZeJO
	7H9XJhxbj4EZE2cnM4pJnJhwIgLfxSv12z7TAfzsE0+LSnlCmHz2ZFsBRpIjfOACZ4rWw7Nhdg/
	gdIOqQIv0RaQ4YO45nP398KtVsrr5dpIMNZdK9I1J1vMorCrFQMVjwV0ai1AMFgEDaCu1wHJ4lv
	fzC1dpC0qTkST9LzGY8RSC6xscVsIcdgMVdY6Bn/uOOQCbsr/wldxVjuP58gw1syaUvG3n7Wecf
	ovwoXrDBUV46O1U7XtQ/DoJE6tL9UWQ/lmUTio2F0HEQSu35NMFxovJtfOFQFvH2PqGS6HI5Qlj
	Hhx/F8C1y6ZxQJCTmQfCZkja0beWYhOBSxU5mFzHpsUkASZy8Omk03Oa/Mmx83YIKtDKgvAgRJq
	PrVQiJOoemayV5PCRzUHpFPhPpFo8oq2o+/xZD2ILO7QtDWtusp/rlAjc48sTdLwQg==
X-Received: by 2002:a05:600c:524c:b0:4a4:7a8d:c736 with SMTP id 5b1f17b1804b1-4a9661ab662mr83304295e9.9.1793221752843;
        Wed, 28 Oct 2026 14:09:12 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f7f52e2sm20027845e9.9.2026.10.28.14.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 14:09:12 -0700 (PDT)
Date: Wed, 28 Oct 2026 21:09:11 +0000
From: David Laight <david.laight.linux@gmail.com>
To: wen.yang@linux.dev
Cc: Joel Granados <joel.granados@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 01/39] sysctl: replace overloaded extra pointers
 with typed bounds and context
Message-ID: <20261028210911.30a8100d@pumpkin>
In-Reply-To: <fec089bb7a3ea62a5e2006cf578b1efec2df4aff.1793204511.git.wen.yang@linux.dev>
References: <cover.1793204511.git.wen.yang@linux.dev>
	<fec089bb7a3ea62a5e2006cf578b1efec2df4aff.1793204511.git.wen.yang@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Oct 2026 00:34:40 +0800
wen.yang@linux.dev wrote:

> To: Joel Granados <joel.granados@kernel.org>
> Cc: Wen Yang <wen.yang@linux.dev>,  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
> Subject: [RFC PATCH 01/39] sysctl: replace overloaded extra pointers with typed bounds and context
> Date: Thu, 29 Oct 2026 00:34:40 +0800
> 
> From: Wen Yang <wen.yang@linux.dev>
> 
> struct ctl_table has two untyped misc pointers, extra1 and extra2, whose
> meaning depends on the handler that reads them. In-tree use has grown to
> cover at least seven unrelated jobs: a fixed bound, a bound read through a
> pointer on every call, an object or namespace pointer, a small integer
> cookie encoded into the pointer, a lock signal, NULL standing for "no
> bound", and a value the core itself casts to unsigned int while validating
> a u8 range. Nothing in the entry says which job applies, so readers and
> writers have to infer it from the handler, and the core itself gets it
> wrong where it treats extra1 as an unsigned int.
> 
> The overloading is also a memory-safety hazard. An entry that stores
> handler context in data cannot be handed to a standard handler without
> first restoring the real storage, because proc_dointvec() writes through
> data. Every call site has to remember the restore, and one that forgets
> turns a user-supplied integer into a write over a kernel pointer. nf_log
> reaches the same problem from the other side: it replaces data with a
> local buffer inside a single handler, so data means two things within one
> function.
> 
> Replace both jobs with two fields that cannot be confused:
> 
>   - min/max hold numeric bounds by value. Signed handlers read them as
>     signed longs; an absent endpoint is the type limit, not NULL, so zero
>     stays a real bound. A range that changes at run time is refreshed
>     before every call instead of being snapshotted at registration.
> 
>   - priv holds handler context. The core never reads it, standard handlers
>     never touch it, and registration rejects it on a standard handler so
>     context cannot be silently ignored. data and maxlen keep the meaning
>     their handler gives them, including proc_dostring() name lengths and
>     proc_do_large_bitmap() bit counts.
> 
> The range converters read min/max whenever extra1 and extra2 are both
> clear, and keep reading the pointers while they are set. That lets callers
> migrate one subsystem at a time without renaming handlers or adding a
> parallel API: the existing proc_*_minmax entry points keep their names and
> gain numeric semantics as entries drop their extras. Entries that already
> relied on NULL meaning "no bound" now state their type limits explicitly,
> so their behaviour does not change and the meaning of zero stays
> unambiguous.
> 
> This patch is the refactor itself. The next patch converts the debug test
> module to numeric bounds as the first user, and the KUnit suite after it
> makes the contract executable; everything after those is migration of
> existing users and adds no new semantics: fixed bounds become numeric
> values, run-time bounds are refreshed per call, context moves off data, and
> the extra pointers and the compatibility read are removed once the last
> user is gone. Owners that can still be recovered from data keep using
> container_of(); priv is only for entries where no derivation exists.
> 
> Replacing the two pointers with unsigned long min/max follows Eric
> Biederman's suggestion; priv is added here because the same pair of fields
> also carries handler context, which a numeric bound cannot express.
> 
> Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
> Suggested-by: Joel Granados <joel.granados@kernel.org>
> Signed-off-by: Wen Yang <wen.yang@linux.dev>
...
> 
> diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
> index b5c2abd12432..294897f3fbb5 100644
> --- a/arch/powerpc/platforms/pseries/mobility.c
> +++ b/arch/powerpc/platforms/pseries/mobility.c
> @@ -10,6 +10,7 @@
>  #define pr_fmt(fmt) "mobility: " fmt
>  
>  #include <linux/cpu.h>
> +#include <linux/limits.h>
>  #include <linux/kernel.h>
>  #include <linux/kobject.h>
>  #include <linux/nmi.h>
> @@ -61,6 +62,8 @@ static const struct ctl_table nmi_wd_lpm_factor_ctl_table[] = {
>  		.maxlen		= sizeof(int),
>  		.mode		= 0644,
>  		.proc_handler	= proc_douintvec_minmax,
> +		.min		= 0,
> +		.max		= UINT_MAX,
>  	},

You could save a lot of churn by not adding the '.min = 0' line
and making the function treat the 'silly' case where both min and max
are zero as meaning 'no upper bound'.

As well as saving a lot of diffs, it will be less error prone.

David
