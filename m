Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1BF4921A0
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 08:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778574042; cv=pass; b=CmKRaqeEjd5cQHwUy1DiLSsHCzAOrMjjXlJRtW0BSJ7UDPv7nximFYdticgo8vutOBQa21PjQd3+dt27wCbSqpPRNV2DYzkfjADTw4/26UDRCf5o2qD8kmfJ3iDFmuinmMLqo+WwmCuAOUXoPC5Y8O5wflDeYpqrpgSBR9E+Yls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778574042; c=relaxed/simple;
	bh=fKfMrHD8oyyXlFvPaUSx76chUJT+CgteFg5+VuswYao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uLwKMl0XNH/SJulUHhpeVKVHYZb6NG5CDkXSnIE2wH+4W+kQ5lrubowvtwAHFq7Jk3KyDLz48UGB/x6Ek5tyrbvplsKcHc7qPnPgkZqzy2eTkxKXbTfAyHRVRPFk8cYU+pONwExR5Y1hW4K70TWcKeqMcmWFSsS1XFOu1GqgrGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=q/PcZgsj; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="q/PcZgsj"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8b7105dfb35so52290506d6.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 01:20:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778574039; cv=none;
        d=google.com; s=arc-20240605;
        b=Ey+2wB1veItyQLV0TPt/cMTKl1/zWS2POux2eOTA/BTvFslQpZ+cCJWix5uuaICU7l
         IJpkq1P9vmYctqOl8F6PnwPqdYp/ohW/39ZDAV2+B6jBs7YQ8nvofrt99q9RHCIchsF3
         v6VoYtP648h5V7zfNi8G0BFq+MgYp6IuoE3cWTl1V7hmEbii2KVaKNeB8YqJQR4WtTD/
         Ld9Z76r6C+D0Bsp1HzJyMpUgtHAiPGnPmYE7iv5PCR867vkqfTohDuTViyNbTeTM72DZ
         6Uf8ZL1H/G9teBkdcot3JpxR22jwMJP8lPV/WkXJnlFLP6n/d6RTwlO7/zzpuCljtOl4
         hpIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fKfMrHD8oyyXlFvPaUSx76chUJT+CgteFg5+VuswYao=;
        fh=o+NePRuXRhfVFO7DzZqsFjcTC2iRbfCT6xQ+DDhuiS0=;
        b=e6Pboo3aPu2yFKdaf342cs/txDYz6/9T9SRNgEE+LmXGJvHMgUxqpOYoQFTPe/TGjX
         OB4O6eD6G14su9kANZrW9hqOQSB2CA/1vBsoZ1sFRs/JnkyfuuS2hB4/D3JqkfX89Wlm
         uS4MJSsnb+z+wVxMcjPq8yem+9HMDEww1KaNgExo/O+BuZJ/6xMM1JTuPCuxXcdq/29t
         8wUZKCKIYoRBurFCioJQweNT7PgZXwYaiEW4qiBEncJlWm6Q+2QZhgihEpTNUI48IflN
         mQtN6abfQDuc8VGIgEqGM/Z/QnVa16c4MGemIzwJMKpICOYp6ztUc6C7srDmpPva7Mu0
         Okxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1778574039; x=1779178839; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fKfMrHD8oyyXlFvPaUSx76chUJT+CgteFg5+VuswYao=;
        b=q/PcZgsjiXF/h++K6vBZgAMxmZ3OJSTKP6m14YmECJkwZLzFrPCbRDly3HOVKNsFUe
         fMlIm91ElocU0ln3TnO5J71YhKi57XRZbqNMOXD68hG6lhN6eiNSADZ4cn4huXrnBlrr
         8Bxa1oLFQLuHs4RKFutiVPeJ6k+oaDlVlnohI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778574039; x=1779178839;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKfMrHD8oyyXlFvPaUSx76chUJT+CgteFg5+VuswYao=;
        b=Hwxb4GmlJhXdKJjDMoUc7vqJx2Nrng9toDlZgpIo3E1olAZpblRl133OCw0ZXe1d5R
         jw/xGUk6lFXGtYyw5fo94mISrL4A/P8ipqlltMcH/O/Z5b65TMj51LIFpwiqdUDYEwLb
         9IqqivV1p8mlgcJUvJ910Fxp0opEumTXfroxvG6vXE8j40QwMDqennxVki2LNxvrFM+F
         DemM8GReWIeSaMJAZTM615vNoKzWXd0N4UPNl19QAX7xh5wSsQ/DJgbUckV8Zmth7Zjk
         wVf+0Jl8Gv8/tc9UDyTfZ3dChRYmiI5GapAryNo232eQAPlF8gW/4B9V3J1krbFKayzo
         lXOA==
X-Forwarded-Encrypted: i=1; AFNElJ+IWHT/8E9DLpB+PGwkXYWfj2oWbYHcrn2ZB71m0r/1//NQ37iIJKNnboNs1BbkVtpP3mz6K2TrMXY2bUnm@vger.kernel.org
X-Gm-Message-State: AOJu0YyIE4PmnQ0eaWHt8sqp1K7NgqlptnuqD9CbrqpfWmsPp+dwjHnX
	VTQO0W23RFM65/45BU8JVc5sOrceZLN7qSxqYFN0atfOjZeq22PZmgCkVO2umWf/nqH9C790/Fo
	k2l8qQV+/UUWWE993N67ScUVXlQKaZd/nT1bRm2xswg==
X-Gm-Gg: Acq92OHV2Tr32vO3Q1qb6+8FVXHrjsixN3uj+zNU3jPljzX9oONAkVZUSrQwLWu7b5l
	/EWSd09OCHcmrQLNI2Ziu18m/pq1Z9+qDkklhPbBZU5RdyS3ydd2xJiVCmMc2fHXzlFAXqdo1b3
	3ryYwa80dvAqTacSTe5yaMcoyQ784PzYpAbYrnNWXNjpczTxHEiHywH9veFyv4OpyUBJ3XStng0
	zBHbl0+F7V9Bh9xci9HUIqVmZ8L4ril5le7B01L0cJNeIxDe+SpJdLayedxEJXPqp14M/jyIY+H
	CSP+G3Fva39w+9IjH4CRBHUFnhsrRjJrrYFbak0=
X-Received: by 2002:a05:6214:5d8a:b0:8ac:8cbb:49bd with SMTP id
 6a1803df08f44-8c663f6e991mr29899726d6.38.1778574039379; Tue, 12 May 2026
 01:20:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429102058.1362965-1-mszeredi@redhat.com> <af4clh11ik-DYbiF@fedora.fritz.box>
In-Reply-To: <af4clh11ik-DYbiF@fedora.fritz.box>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 12 May 2026 10:20:28 +0200
X-Gm-Features: AVHnY4I87giYMHcTP9Z_8zJeositYNIniBNdnAIidGjXDSBrpwLz792i0h3gDXw
Message-ID: <CAJfpegtFCjDdPqb0zbPczVBdJvU4n=coVftBqKNbsEPYMSbiHw@mail.gmail.com>
Subject: Re: [PATCH] fuse: add fusex filesystem
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 May 2026 at 19:36, Horst Birthelmer <horst@birthelmer.de> wrote:
> I think you're missing
> #include <uapi/linux/magic.h>
> here for FUSE_SUPER_MAGIC

Okay.

Thanks,
Miklos
