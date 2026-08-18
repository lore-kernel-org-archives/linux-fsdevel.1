Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAAC4477F6
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 09:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787043638; cv=pass; b=Y6g9pgOoH6L1kN+20L4hJVc5mc2tnc7xBu9J/B+NNeA9qBPAxieQ1POwmSsvrk9wcoOtZfQCEPLbysIJOO5YQVmBOiKmCzFarihuvGXXVN2sMELczbsAHulDVEmQTk1xk8+KP+/xvkrW1IWGsG3QO449o0Fke/hJeLzAi2UPyA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787043638; c=relaxed/simple;
	bh=PuUsHnkwV+GwukLo/OUOgoL1rvv8d48vU5mVF1rYvcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gj3cgcWt8HLPKqPDl4L28xNcwQxr8eUTQIN5+D0E0MTjej9YMkY28ussEAuJmK8vvHRxrjgh0bJoAjHoeYPD7ktTSkREu+H69k/wxptIIiVBmdE0U/k0kLfcq4K5pCAJ9Ca0otkIGM3m2rm1CiOBlUhyq5/V60FTqB+iwKJlv9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Wd49VFoE; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Wd49VFoE"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51bfad59921so25750891cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 02:00:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787043635; cv=none;
        d=google.com; s=arc-20260327;
        b=OwY2LNJo36OQY6iTlIy5g/gCSx7w1LZDm+hVFQO560epE9GTLrgexrbS7trZd2kRo4
         BdCf/N06q9qJf/+iBgHW9yw6OSJ5MItX7fOL/c3SEUyWbHNQWbCgk+qMCd3K9X/rWQM0
         oOxIcl+pXlO4NpdM4Id899V+vsa8p/nt/g8xRVh7wnOQVGdFIeVcUUVcIIeUkjCdt7RH
         CMej7Xty8FckaHMw6tKy6eqa6jJrrws1Da5GjO+pEyvTzcjSA/Ku9VtS/GRrwqqOIvjj
         xJ+nPc/n7aj0g/Y9X9b9ePFAW0Mu8cZWHQvYJugvDSiHOtd4dPidhYjWEd0SDw7qurr5
         LScw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=R5CidgEMiRl1k9cS1Q9dWntzhCa54VWy2ZOXfNAzMyg=;
        fh=i6bvP7guGi6zeqkd1Q7xBZLUapXQsnPhjIzw2kpC5e8=;
        b=mmm3khgYH3zENGiRBJXyM5A8+1gMB57HX6bDljDStmVhpkI8Y/MCcslfbUZfSEiKGG
         816mmY/UaRhWACM4N4PAiqj7G1zA6grMHhpiNZJ3fTyfcKdTKFqEQ7VN4V6K/rAiUuwx
         MHGqMprdK+7HVZ9s3vo2g8fsiYfo/8nwZDUUvOqYoTZ33ojDnmjHklFykj2itqWf458Q
         k6JqlTXPenIZzlfOJufjz2T+ILTMt85LW/d4EtWhosOcPiOPAyM1fuVV+Hbdmcj2M4vm
         VGIlcqSWdbGnufl+ymEl0j5ek6YhSWwn8BwMQJW4pVUTs7IiBLXP0rCl0xaWKOboBVn7
         2UCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787043635; x=1787648435; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R5CidgEMiRl1k9cS1Q9dWntzhCa54VWy2ZOXfNAzMyg=;
        b=Wd49VFoE8hc9cbGeSLzkQAc78lNJjFtTATpQmdcuEnDm8+dCl7ugD0kricvKuA7di3
         /5+sGA2mDzrAwF4Xn1Y4rz95KMowQ+llQKDBb6zfArPPNEBuJMFAzMHtauToi7fawFws
         kjs468AznsPBIQhL43d7OKAkrbYyO1qDh8qCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787043635; x=1787648435;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R5CidgEMiRl1k9cS1Q9dWntzhCa54VWy2ZOXfNAzMyg=;
        b=D3qrfgutXCTjGyuC4DEHPldEkEWKZGP7oCNHnX9xl2JXs5COWhLXBzJk+xwCdXzerW
         ed2v3SuIUTe+tat/rK8qR6nhr6YKgvtjWIOffeE2Hnv9vLnU/nJYMOntd/UiTVCn7xar
         rwbbTMDPgkiv8d9rqfUHvLAI2HEFvf5hB8I097fRJRSJYnCiVAnurJcjKkAYNdmGP0lZ
         1aSO7Qz1kn/sX4R/XYhJhWnG3G1g7aE2WRdmruZM2IeNgANPXd2I0Qsx2qIhE3pDYCTI
         J4dDN+DyNPuh6lyUCVVoGMLnsl6fAn0qclTbBkcuRidVJuEFGGQ2QGfxPR2kgENs+T7A
         6D3Q==
X-Forwarded-Encrypted: i=1; AHgh+RoMd3KhoD7v0YQHx5vqqBBEEs7YuQKk/1Nc261T/5aeRTs1zDY5uHdTtj40/yuG+pSUtIuJR3jA0O1GfSQu@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx3vpLCx1jq/wuA6SODGonhrIMW+MPhzPX1Dr83jNFj4Eo/OeQ
	AvqxdN+Tl2Kz1bKNJNph6uu7f23Qom/aSZFw6+dnOha6KKO1XAp0kcbl4Z3gq3jnrke8EnR76vN
	pbvbwecTBJNK2cgSNXdJI3P9zftKhAVgqXmpSZ66MoQ==
X-Gm-Gg: AR+sD11AJzT7bW1w5JrPkmBe9T8smFnfX4cVblKAKB1DMz3omzftfmqglD4/KdlsB1j
	g8tmqIVCRFWNjxTOX+d3d+rG+X+CMaiwFRwJpJOUR4UkJsjkGHMV0Glm7wtFV64rkTlP2mcyIb4
	PGAkBaWKlrf0ikLW01CeTwbtazDjiJ9GP1T0YqEsZ7U6l5L67XwNjCb4GE8AGK8vFNhazGKOhNg
	WqbnhJrOnX7QeMvSXCUZNLMCDcQ43UzAaf386mf9EmlJ7gBVArYwYauxyWE15GvqikNYYbkGyIW
	3MnDS5HqSgbUHcNn/u398Uv59a19Ikay/aILGgsomDDaYnK4eYJKaJzbsx15shWZvVz5QebjjHC
	D
X-Received: by 2002:ac8:5d14:0:b0:52d:a4e5:6b3c with SMTP id
 d75a77b69052e-52dbd638fedmr69294871cf.15.1787043634544; Tue, 18 Aug 2026
 02:00:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811045350.164272-1-libaokun@linux.alibaba.com>
In-Reply-To: <20260811045350.164272-1-libaokun@linux.alibaba.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 18 Aug 2026 11:00:22 +0200
X-Gm-Features: AcwNN1UI4gK_pCbrtgIMokQHxsecaJh6Di9rXH5OahnTepvGPsPL6ngyGsHIPnc
Message-ID: <CAJfpegvVDjK64Yd0A-NHEcX-jCj+eVhKrt6aC7hLu6hHEN2HHA@mail.gmail.com>
Subject: Re: [PATCH] fuse: reject a duplicate fd= mount option
To: Baokun Li <libaokun@linux.alibaba.com>
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jefflexu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Aug 2026 at 06:54, Baokun Li <libaokun@linux.alibaba.com> wrote:
>
> fuse_opt_fd() stored the fuse device in ctx->fud and bumped its refcount
> unconditionally:
>
>         ctx->fud = fuse_dev_grab(file);
>
> If fd= is given twice (two fsconfig FSCONFIG_SET_FD calls), the second
> call overwrites ctx->fud and grabs the new device, while the reference
> taken on the first device is never released - a permanent refcount leak
> that pins the first fuse_dev until reboot.
>
> Reject a second fd= outright.  ctx is zeroed on allocation, so a non-NULL
> ctx->fud reliably means the option was already processed.
>
> Fixes: d42eb23b2ef9 ("fuse: don't require /dev/fuse fd to be kept open during mount")
> Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>

Applied, thanks.

Miklos
