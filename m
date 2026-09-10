Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD08F3DB983
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 21:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789075275; cv=pass; b=d8kKRpYe3riev3Y4l56UIvSjFfSvtD5JkOv2eSgpkuR1sw85tfF35X3ocZagg1eA2tH4znjKztjyXr1yKqpnWzwG0N/JMecS0diEjvv14rmU5Dk7MQGeB2Q9mr7Nr2m1Cm0LYea+i+ddhWn2GHHPa5C1nkUQUPUVeofUYIR2Kck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789075275; c=relaxed/simple;
	bh=jqpEM70tSpG5MtmfDeF0hUyCwBgmAiAYkWcb+f353io=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kMIBiAjAPoo8Tee2lokKoO3Xf75Ye9bKAANcldDejLrXd8TFvJFNgGMpRDSGRTV9a9kdBqa8FeSXEsRHvbc3Icl7uc/j1bubqnVp+EbHRgHYkA5IPLQyy4EVwDOGUVkfWlBVnUNwcKGJga3chhSoChkvI6oYG3rlDLf3/hwEglU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mwFm3ZYY; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mwFm3ZYY"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-53012819c04so33481cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 14:21:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789075269; cv=none;
        d=google.com; s=arc-20260327;
        b=mIiw8S27nQRzfbmgsPC7w6oTDHrV3FRgBqmr9tAW44zjOylCikBijCJsbHdhaIXRf6
         twIcfXm1ym3ajguddor9TuXrj3ojegO49vOhJn1J1RMPhXWclZgnPz0LZoTM5bHtRuGg
         3uT4Hkqa1DxiIMjzqpXDh26IEEcZWF3EpmJr1VGEaJNI4S7Xcp07XHIozuXo5DQMfjEZ
         nKjTDgejKfGRP6WFHvD2ncPfgGZWP1VRQoBo/0rdz2DvkPS1o8bH3tKNXhV0Q2taBP5Z
         mIf0hbX3xFuYnfxxI7zw8kS8bIXRPG7tBvq+N675USk8++egJWpBpmvtAOh/nWRs9g3K
         ElfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cPbVFgW9VwbajH9zUlcN4XglfWpRRu+3kWiEh6Msf9M=;
        fh=ZdX0fwkZBMRKAEFNp/5NNFSCDQXwqI67f7d924iaYdE=;
        b=LrjMVTM4h6+Ku3MGkWoRc/q6B6rtmLuPZFcIDxMWvo1MEpq9BKMCYGU2DPfS6AXxZr
         xaW1CoSNpl+tXCdwbM6nKEAd0UwiF/iB6MlHQ4RrB6nAzBXsXOH6YfxuEviAZspMuZaI
         Yqssj/sb5Mu8MhDq8a7iqpUDMHwJRlyyRL8ciI8kPPDvhr+PX/CVJuiwK+i2Zyx7OGbM
         SM+tntyY5sm1f5Mbm+2sLqAzr73UfB2yQdGVQli37a3UBlB3dJI44miHQDOh/1lekG9j
         p3VJqAzl6pLqPFUP9Aqzrql69DPR242PW4FmbzMho+SWUgQP9xaOOpP7dplMkzO2duZw
         Um2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789075269; x=1789680069; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cPbVFgW9VwbajH9zUlcN4XglfWpRRu+3kWiEh6Msf9M=;
        b=mwFm3ZYYq5TrI2SEc4KPg6xFHY+4JXsSUC58CjWGE1Ow6RmUqqYF8jleqAzaXOUc21
         QrGsP5Eo5M1vM7aVngALtdTwcW1HfyvVs0JyYrVcPJiN2NL4votq8nhMdo7ign6sJByR
         HzmceyzaRj8xZaR7qgrPTastny8qa5bP2Dcy5iUlCkssZ4SGeRFUcQmmjNTsya9y9K1+
         UJGWTsFJ2hyjFvt/zgSXHZ60MA4GLkkr4tHamxApl9OA9K/LpSsSxdawtM7yUqMRIizV
         gD+F0MQ2XMqq28r6ckt4HADgV5H+r7x9N8+xOdnbJHNGlObeFBkpSSg30sNkIv6r8IhR
         JSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789075269; x=1789680069;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cPbVFgW9VwbajH9zUlcN4XglfWpRRu+3kWiEh6Msf9M=;
        b=byc6VerZhv5M5SdizkvwSkMSZjcymR52zIg79rzx7gCfvnU7SfVSGwCLMO8UPfrkGG
         5sctotu/R/dCDrxDLPfedaXWTbUsyPPhZe1Wmry8Ue6YxKV52vD+v9qXG2njzlA4oI2q
         r5ENdccpImZwsZ3YjTnb0sU7WZj1O93PU31cgUozWw7QSyNDqOpMTRHv9urBA7xIyAcG
         A+yCalhp4JajS29Vx9Ikb1VbTf9i33dSRbRd3Gn0FFqEUR36Ce9/pn2xOLiiW7fdEh58
         iwiwJuCxV0G21QTMYyIXPCM/WhPX17ED+4JTdn06Ig30XxYFe130b3k9yMxOFEG/Uj8e
         IYwg==
X-Forwarded-Encrypted: i=1; AKwUvBwTCDBdXXH5prpMISFZx79NhxgP+qemeTJ6tVdrpDICnDP4jhnGqfKmPXED0mAwKD/8c+Aq8cr9jv1wVLV5@vger.kernel.org
X-Gm-Message-State: AFuF++lP9rNy1+iY1wza6HuonX3jYlYfNLvnmEWL5aJyKSNQGXebx5QS
	XTPXhaJLmhx9Or4azeJp3g2/DdVZNVaSwG9Iurzbu5X5qhdEENLwq9bPl5i/ESuabh6c7PkFlru
	7tSt6+9OVdGLs5ZuikEpM/XgKUrq0ry+WYbZzDRWX
X-Gm-Gg: AYBFou15+UgJY5PZ+doV9kGFlz+ggGj9njmGTnYClJLOVQWQOfVqEOGh8aF+n7K1yCw
	1pxMUUa5j3QoxSnybN9qpoAH3E3RrIFE4Z0un0i9ks8PPrpzTZNAjYfotH5GAnINBlY/Uj5lBIi
	6OdZj7PKN0HbkL7yE+TDY1A+jqndJymmC5Lf9mDIIoA8f9xefCcX8/ulGyJbeROpvNz+1BxRCVj
	k3V2rlwfKQ6X4leeGNsRKZjDerLuiV9TamtGvaU3zXP3uz4CUsvxoNaB900p9FbcXRUFI5+RiE0
	hm0/2MmXyq40h9PFNUiEJXoszGfb+mOvm+XaDo8z8hr8azwplL2LZRewMKINT9uF+51xRvu+p4Q
	WAwF6XLLhxA==
X-Received: by 2002:a05:622a:2599:b0:52e:8422:a329 with SMTP id
 d75a77b69052e-530c94992bemr6190311cf.6.1789075268693; Thu, 10 Sep 2026
 14:21:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907063918.3432401-1-surenb@google.com> <20260907063918.3432401-5-surenb@google.com>
 <19e428e5-d8bc-4abb-b052-e23442464cba@kernel.org> <CAJuCfpF-xeED3zVL9YyCwrTUxcYXw4s6gVcCYY8p7rx_09mgLg@mail.gmail.com>
 <d24c425e-7913-4f80-987d-7105a8b13432@kernel.org>
In-Reply-To: <d24c425e-7913-4f80-987d-7105a8b13432@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 10 Sep 2026 14:20:57 -0700
X-Gm-Features: AcwNN1VRoq8CDVvkfELfH6Yzm9F4xeICdi1mk_n024FLQWRzxRX3c-6w3l_BjeM
Message-ID: <CAJuCfpF_1XNP87GL+z13OJqMqk7LNpF9yYNSs4qV7N7tGOTCww@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] proc/task_mmu: read proc/pid/smaps_rollup under
 per-vma lock
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, liam@infradead.org, ljs@kernel.org, 
	vbabka@kernel.org, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 12:44=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 9/9/26 19:58, Suren Baghdasaryan wrote:
> > On Wed, Sep 9, 2026 at 10:23=E2=80=AFAM David Hildenbrand (Arm)
> > <david@kernel.org> wrote:
> >>
> >>
> >>> -     vma_start =3D vma->vm_start;
> >>> -     do {
> >>> -             smap_gather_stats(priv, vma, &mss, vma->vm_start);
> >>> -             last_vma_end =3D vma->vm_end;
> >>> +     if (!IS_ERR(vma) && vma !=3D get_gate_vma(lock_ctx->mm))
> >>> +             vma_start =3D vma->vm_start;
> >>> +
> >>> +     while (vma) {
> >>> +             if (IS_ERR(vma)) {
> >>> +                     ret =3D PTR_ERR(vma);
> >>> +                     goto out_unlock;
> >>> +             }
> >>> +
> >>
> >> Can we add a comment whey we break (and not e.g., continue) whenw e hi=
t the gate
> >> VMA?
> >>
> >> (I seriously don't kmow ... should I know? :) )
> >
> > The way m_next() is implemented, the gate VMA always placed at the end
> > of the address space, so the next VMA will be NULL and we can break
> > once we see the gate. But now that I'm looking closer into this code,
> > reading smaps_rollup file does not invoke m_next(), so we should never
> > encounter a gate VMA (it's not in the maple tree, so for_each_vma()
> > should never return it). I think I can remove the special handling for
> > that case.
> >
> > Thanks for the question, David! It made me realize we can simplify this=
 further.
>
> good! :)

Sorry, my conclusion was wrong. The modified loop uses proc_get_vma()
to walk the VMA tree, not for_each_vma(). proc_get_vma() returns gate
VMA at the end of the walk instead of NULL. That's the desired
behavior for when it is used from m_start() and m_next() but not so
much in show_smaps_rollup().
I think the cleanest way is to change proc_get_vma() to return NULL
and move the part that deals with gate_vma directly into
m_start()/mm_next(). I'll post it that way and see what others think.



>
> --
> Cheers,
>
> David
