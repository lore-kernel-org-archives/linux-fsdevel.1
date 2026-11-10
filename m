Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794289540;
	b=Vp1LMzgs4JE68aB7pmzQqrWIrMQ0G+bL8gSAGz0kw8ISJ4vVxF0XxNS+BEOew3DPQ2Un
	 YZCsqdb0eylzSrAhjG4y9+hw5zv9P5YxhzqC6G9S1PjNSXfkzh7/bRTMq/2XKolScWNRq
	 OVfaX4fOmituP22AY/zTTewnv6wcqZ6N4J+zaTZNNVAeQqEe76y3IXBM55aUtd2LGaejr
	 jeuvBwG7jgsQhN9CnmtDx8557R8okHJ8P/Seu8QzTZ5tP8sZPXAVTWd8NoCGUwRqDpp3Q
	 oi+BX3OT8rsryRdW5w2ehX3OoiYFyYCFXWaKG8kLWS/vTvT3lph7K1HarxaYrWxQzOQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794289540;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+E82dUvkv8bQC8oFlCDIESMAlSG6FiZTUr4W0LfqWTA=;
	b=kC7ioMT9tl28U0/URipZPSA9mX/vtdiW8Fg1He+MG9kJdf5CjPsO98n5Ab5XoqqTXN6W
	 BntGZ8SxbBcZ6LBdM9ZNjsGKRLbytXWXhNOZOrnXsds/AXFF40zhK3fb0szWkNprtNHMo
	 DvaUULU0vr35DpndS+ciX7iWm7uK36UIUoUsdzQKGpx8r5+vhDDh/xzjHia9ecCjSdQc7
	 36EDbjUi5hF+0uBuitn1t+9tTxIFb0itpZ26hR9eEMUrrM7zlu9Eq8b4iw83kztfN8uoF
	 NX1Qqi+16MpfxwkuXAKV1mAPDzBqKgvULBrSeGhCdEU+WD4dnKR8PH2f9yAfPORf+eQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PRfeQd3i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4248606A31C
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 05:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4248606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PRfeQd3i
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4b6266b5bc4so16885e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2026 21:45:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794289538; cv=none;
        d=google.com; s=arc-20260327;
        b=kG8NyjP31+46haD9PFRRQ/Y9a5A285+ShyV62lr9so8uUnzCMhy41goDPNWBLQ+hTA
         2f9y7790moFTwpOsTEocy2L2i3ccPkLlwFdmQXbMdgCgduyd7H53xuL/BEBnW02M48yq
         9FXfkAwGdaXOV4mGuMI2szPtExNKLx5VtEPpHrkboujKjowRtGIA1kLY5anD5dnX1enX
         xZZJVdSf/zazTEgnkkwqDLljXme3oIY3+afykiHDUmeM8eKK8vrydiWPROw9awj+MM8Z
         n0t9uDZ+nALUxzowJfOXnWIkmax9qei2ZmAeQ/xUGwKXlAY2qMkHCJ+b6MTMHSlem9m2
         t/Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+E82dUvkv8bQC8oFlCDIESMAlSG6FiZTUr4W0LfqWTA=;
        fh=DuqSwl+ZyHwiRvr+dGFnX3iOwaA+S9tWryjH81Nrk7w=;
        b=gnvjhx5B5m+PFYZGbFK4Q82jZ+0TX8Yjor+qABh07WUME6+gr64cu4UUVeCC3EjBEA
         GC6JVV19VZzKcB2MqAMI0oLm86/1RRdg7W2u3xU4mb4ai3wGCu5xBc667s6XtYT5LEpu
         2T/ogojgDL32wfnWFqYeZyJXPWpKZbNZEjs/idn/Y3hwMGabnSqHllBW2ZoBZfoIZObM
         oERZsO700t9cfHKYcm9u7CVVh7NcktwuGs8ovz10gb9ivg0pfJBH/hVXEFdQEiVPA544
         4JhEQLcd7xzVpg2Q0bxYIRudjubCHN6PU6NESFQNzFzQ0EnRdlko6zI/A2zQgOEez19E
         6S3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794289538; x=1794894338; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+E82dUvkv8bQC8oFlCDIESMAlSG6FiZTUr4W0LfqWTA=;
        b=PRfeQd3iXtdmzeWbjOJ9ChIu1Y/iGxsUPqBBX5k7SVxZPHBUxnbYwozbMVfy9JaXAO
         ZQkt+1FdPeWGFSb32c2awO6Gj60FbFFCPQ7Iy8uCmB1XQhRjLs/G1+7euqy54NJyt1NJ
         qK733MXDL3JuFDcvFGRvcAqxJvcRmXhzHWFDYyXdDbRCazhQxwMdx4C9FuxY9YPjPNRW
         S8tbiJZ3Y08g0+iFRaw6rnWmylHfBUikd5ELN9dkOkZh+ynVC15seyrZLt1ihw7uGGcc
         sL8Ow8z5gZ8jyJpKXg9YGe83CdZ4IuByvo/VIAim4rrJWryLRw8f5cfRctxc9oV4Jj2N
         DfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794289538; x=1794894338;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+E82dUvkv8bQC8oFlCDIESMAlSG6FiZTUr4W0LfqWTA=;
        b=c8Jm/O/Rg28CzUMf2dNUe+67/FLHLocbzAUymA7YtzccCUgAjPX4azGPP5yVJlItq2
         dsnGqqUqOnrIF+BpOTX5kSo7DStepEUyC/zVrLvbDnBAGVgVjwLmsAB9QwtF20w8TQG4
         6kRagIvaEgLWXnY0MMtqoXAiZbJkQmuUYHy2QhNeVQ6uUIZtkZrjOKvRD9HsP1v97UH7
         p8lMCQLNMbIL+AQcmncGQye9uKHzGTC6iNXVLNZlVPt1T5cniiOlTtmHqaoytgwjCJ2L
         hda5EULAfIxBUE0SGboBpigGPFGAMqDltabwdGB4Bjs9G64Mk2P4vkPdxBM2Jj/nCgbg
         dnbw==
X-Forwarded-Encrypted: i=1; AL+hErEYRGEoFH6gRhHoB2ZaN/afPDQZNAMu+ZSkB98VGWtg+jrvifaiU61IlSd4UP5aiHgWAFbWrE8dAsg8EmF7@vger.kernel.org
X-Gm-Message-State: APuU4Z/3D8Xez9jMzPESIjCnrxQdk7eb8+9qvoNEF5QascdpKwmYmP0V
	qhOl9dZb5xN3XV1iEYEhENCb6G1LQ3PAW4kQIwMtCZ3FNP0SeljjZHMD8nnbWJ7gFw1IrRTFa+B
	InFekskobQ9ZZgJV7gkjlkk5sUqmX0CqldSjOb2da
X-Gm-Gg: AYBFou1/LEn82+kJVzXKa/fUxSOJYSbsWM0Ui/WDx9+3fa+SdFkqc5G4MtALV5nBwmO
	MET/oEZKs4oy092wYVL2j1Deg9uDNvz75fQ1gk+2l02yRJVNOuit3ZJKdmD9rYgYDQFjldWvYnz
	JEUzDPEW8FT8tQ2RqzeB4Gwg/1eMYBc7oUXAr5W3P5sRFRNCsWzImjsbstfByUaRqNxEY2zx4l/
	LUoY5CYZMyYbR8gmwU9POTSFz+d7Tguu0ehCQTIVWC4mLU6ju9N/EVS/dGVn8/rQIZ0xY+YLeUG
	tG0nZnEk5Kg2RWBc4nLmiG/x/Wu4IS9V4fqzNWWtmJ8ZsJnEMobnOMY3PrB2kSyydl3nFQsH/Mc
	ybMpYmZIfT9GvWpTxfQC7F1zncZDobta5WKb2HHoOPE4ajQzGkuZoj7OUJ3jDzxRtG7lA
X-Received: by 2002:a05:600d:6445:10b0:4ae:4442:ac17 with SMTP id
 5b1f17b1804b1-4ba0236623amr435715e9.6.1794289537823; Mon, 09 Nov 2026
 21:45:37 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260203192352.2674184-1-jiaqiyan@google.com> <ahXI0cK9fsOByvKy@lucifer>
In-Reply-To: <ahXI0cK9fsOByvKy@lucifer>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Mon, 9 Nov 2026 21:45:24 -0800
X-Gm-Features: AclHuK8JoFravzJWRGELAyfLQvRrdOszwg_B9l1wvjwh5zE1CbS-L9cnu-hn2ZA
Message-ID: <CACw3F51Q9TkMWr4WbnN07q60L6vj72-hFWwpqf0n6rf+drfb0A@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] memfd-based Userspace MFR Policy for HugeTLB
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: linmiaohe@huawei.com, william.roche@oracle.com, harry.yoo@oracle.com, 
	jane.chu@oracle.com, nao.horiguchi@gmail.com, tony.luck@intel.com, 
	wangkefeng.wang@huawei.com, willy@infradead.org, akpm@linux-foundation.org, 
	osalvador@suse.de, rientjes@google.com, duenwen@google.com, 
	jthoughton@google.com, jgg@nvidia.com, ankita@nvidia.com, peterx@redhat.com, 
	sidhartha.kumar@oracle.com, ziy@nvidia.com, david@redhat.com, 
	dave.hansen@linux.intel.com, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 9:23=E2=80=AFAM Lorenzo Stoakes <ljs@kernel.org> wr=
ote:
>
> Hi Jiaqi,
>
> It seems this series got stalled on review, wondered if you planned to
> respin it at all?

Hi Lorenzo,

Sorry for the late reply.

Yeah, I was stuck on the issue Miaohe pointed out for quite a long time...

In offline chat with William <william.roche@oracle.com> he expressed
interests in taking over this patch series. However, he seemed busy
with something else and couldn't get to it.

Fortunately we have more powerful AI now than we did six months ago.
While I worked on [1] with an AI assistant since 2 weeks ago, I worked
out a solution to the issue Miaohe raised [2] with the help from AI,
and now a working draft patch series. I think by the end of this
weekend, I can send out a v4 built on [1], the patch series I just
posted for freeing high-order folio that has HWPoison subpages.

[1] https://lore.kernel.org/linux-mm/20261110053331.2708996-1-jiaqiyan@goog=
le.com
[2] https://lore.kernel.org/linux-mm/5e0fc743-eb44-b69f-01a2-da7b6f2eca8d@h=
uawei.com/#t

>
> Thanks, Lorenzo
