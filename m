Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654F435F170
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 17:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788974015; cv=pass; b=tD9NWhh+cD4UmsVCnoy9fGk1KJBUQQiJdbyez/p0/S6GRE0TZ8vCJRqqjuqcyT1K4Uf3krATXnD1VhxQ2iRBLqmeuN96YEe2SbMBcEI0KJ9nvr7PgeihLh4HW+YQWB7kR0lYVvskzwksSaikyFKP/9KVo4EFILfe/c10QYrsWQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788974015; c=relaxed/simple;
	bh=BoITJbg+tcqR4yAMRl6LbU3qdaLtqDYLmTuTo1MWr54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i94EFiLmaoJVaKmVLziDTiZQdvH1yWi+jeoq3kUL4zrL/QpJl6AJDRwgqX6wkRcpN2jlJ5rFK7dnmdHruQlMpHJL4wgspGThCYIx+hmuJzWqyEnzclQbhCE//0hIiNIznx2WQlZNMk79+zq5I6Pb9jjqZYB3UCQvX47F4y3wMsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lMOncLJx; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lMOncLJx"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-5306706e89dso328931cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 10:13:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788974012; cv=none;
        d=google.com; s=arc-20260327;
        b=aKn2IwQcNlZW3S4Tp98tBHcvNuLfWbJXdZlOsfxK5VZcxmiN7YMMXT+HJI7+zthtH6
         GtgeJTuwOPgWZBild4EkVuFxTKgZ8+AC6WXVDj6B8yTXBHXf6S96STaD0e8uPYKitzIn
         Q4t3EcC3oRlkJZTzETSz0kUin0XcCNYbTsLVDQkHyT+T/k2w5FFG/Pk/HYBCJjhcZVn6
         5Vz12PbWpf4saY5SfjNyCJtSgGcJCfXIbN3Ox8EBx/yVkKnoS0vHp7Xc92vj9BbAOEFN
         jWqONCMTJdjd++GCUJX4QgUQqZhmiQ48Gl+r/xUDCiGjpxlua5+pUdmAL4lJ5/0d24U0
         hVHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BoITJbg+tcqR4yAMRl6LbU3qdaLtqDYLmTuTo1MWr54=;
        fh=Fqd2Dz6NbCot8coxlWwn/78QpijCKwFvRThlmhwVBOY=;
        b=Ya1i1e19ptAd9K9HSp4Xv9AYN02/tpvkWfuabhUn85s8jtxGfoW6xBHEpC9IbRTzKx
         lAoTzayyqK/qWdoiVKuuTErrKPKfLmA27mzTnKF2e2d+uJybrko98ziGSR8I1RYxO5lG
         1REf2rf0L9xjLTQiLGQiYEIR3PfComZveaWcWBzg6C6T5PFXsdxjvsGlB9Bdk8sFQIP/
         fu53tlXuG0RVLSngG//BWJeIx001OvG2nFbrQrhK4oaO5U/pNFTgNTOa+czyANIFpovs
         G19IcAHuAGsvzRNscdb08MhoYie66UJ1NOmztYVWJB8HTeNiCtH8ivDhyQvMvw6+kfvY
         IZpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788974012; x=1789578812; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BoITJbg+tcqR4yAMRl6LbU3qdaLtqDYLmTuTo1MWr54=;
        b=lMOncLJxINj9R9tafp9eA1n6M4h6oqObsKm3SmUuE9xfP3sFsYnDChggvPHMbofq5Y
         CzdDiGscEfJCquZ5DWLuCnUBkLB3B6moWZblGJOJ64SRU7ji3vuqaAkAhFL8veHSi5uP
         VGR3VL10GfW5ERdyu9jKjOXC1RENAeS8YNdhro4Cv6iL7IwTEMeGdlmOIDtgvpRxl9tJ
         9UzH32aTScoi+WpPHZJUSl+JyfoyZWGl3Y36000Fut03vjZHiLFQ8b/noZ9AR4k6Yz7g
         DEWE8XQ7FxhfQ/6iOVixakzGF0SyaCZGXD8OgKG9+Mr3+qG+zD+UWheCKEHzB9DfLmdJ
         H4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788974012; x=1789578812;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BoITJbg+tcqR4yAMRl6LbU3qdaLtqDYLmTuTo1MWr54=;
        b=TsaCPNVzeH/I1FO0DB+8Z0UFWgf8gYrsJmcmdmzGJUHLx3+bWdsyOq0upftmTxprAQ
         u5jMLN79ndKC2YEGsCih+gznow0YHnzYT+ycSPBqba/xnlbaGodckKR7/V2z4+GOlgai
         9DF/KQI3WeEK2MkstTfFxqoTj5W/lNpXh/MBgumrzY4i4UIR/MchoIhhY2mjvVSdHRz5
         b8syJKBTKyDDIx1jtxFUyK3hQ5H6yIlFtpQyM52u1tybebdBrlkYooSg8RxW3zAgaVE6
         0ViEHPluiP/EtCZWIw3mW7UeUPhvJ63P429qiAuw5eSxd+tMxDUBEFeksfwA5hLdP+pU
         dPog==
X-Forwarded-Encrypted: i=1; AKwUvBzY8p/4YLMqpJrgOo/jMfs/B4GOIqV6MFRlBNn1Cx2X582es8ME70TD5hBLQlZBbx8jerUZToOkjey6unlS@vger.kernel.org
X-Gm-Message-State: AFuF++m5rY25aPFiJKj/5usvda8kWtxi3olUwxKJREiaDAOi7mFTVKit
	WXZ5bNQLpvwRiHPxwfyBqmORx9PXF6Z6OXQJMpVYsCnBdegL5/N0aMuCLJpVCMn2pJDcrcjqJLv
	XZSyrlzlHfbsf8J+4MpGUpA18HK77AB9tQTQ0d2KD
X-Gm-Gg: AYBFou3awNMOPqqwUNK5MYrUfmNOE6HwaX/nVChGdOhC2Rl/jqmKqD4tAqfPlNXUQan
	2nAoNhAuBOykkMqTuXXfoIZNigfK9DQ9AsiqzFZK2l+g9c12NWJK/e151KVbBZla52jiBLOrP3v
	CfhZ7aoasToYXlpebyP7HeAfgEH13bX779DsijSSnj4Q1Byefi7AVgK0XlJQVLzkEdHIMqnAR7/
	Tugiu+7OVE+GFPQbHBBXP1Ns+h0HfYsiaFBxVOWbq3Ay4XF6Hn+okq56W+nvodn4KZREOgw13Mu
	dcgfeQ33xazXeoApZU9Y0Tozmrs6IqjYj2AypSjuxImSgomRg7yG4XulUg==
X-Received: by 2002:a05:622a:400d:b0:50f:b69a:f4a8 with SMTP id
 d75a77b69052e-530a5f013ddmr15911cf.7.1788974010867; Wed, 09 Sep 2026 10:13:30
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907063918.3432401-1-surenb@google.com> <20260907063918.3432401-2-surenb@google.com>
 <1d5011f8-26a1-41e1-bb9d-8d72c08b8fe9@kernel.org>
In-Reply-To: <1d5011f8-26a1-41e1-bb9d-8d72c08b8fe9@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 9 Sep 2026 10:13:18 -0700
X-Gm-Features: AcwNN1VviiL9YOndRTSyFCutgcsYgAZMb28lE2qZmCuqHAyOyXU8c5SOoH4lvoQ
Message-ID: <CAJuCfpH25ML1+hdhTtZUoSjgrNcGv9HbQD8o5UErmAdW-7C8Bg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] proc/task_mmu: remove unnecessary helpers
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, liam@infradead.org, ljs@kernel.org, 
	vbabka@kernel.org, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 10:06=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 9/7/26 08:39, Suren Baghdasaryan wrote:
> > When per-vma locks were behind a config option, a number of helper
> > functions were needed to simplify the locking code. Now that these
> > locks are universally available, we can do a little cleanup.
> > Remove lock_vma_range(), unlock_vma_range(), query_vma_setup(),
> > query_vma_teardown() helpers.
> >
> > No functional change intended.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
>
> As Usama says, this could get picked up early independent of the rest (ma=
ybe
> even as part of the other patch set)

I can post the 3 cleanup patches separately from the one that switches
to using per-VMA locks if that's preferable. One downside: I'll have
to wait until the cleanups are picked up before posting the last
patch, as it depends on these cleanups. Please let me know if I should
split them anyway; otherwise, will keep v3 as a single patchset.

>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks!

>
> --
> Cheers,
>
> David
>
