Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507323F20FC
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 10:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781088952; cv=pass; b=QUSySmuhdSu5Hfjr37oqTZrId+UtuqZAoCxs2nid5QKyMLir3gf7Zk8+jQjHXMBgNijYHpQb6mFzIQgyTkIMcn9MjggHKdapAY+JCJvJmq/aQrbhtr6F+YorFq+A4Cua573QWyuCFUeHAHJb6+S3ySwe2hhl2DE+yFTCKCoXPD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781088952; c=relaxed/simple;
	bh=balBQhwV1EGCbvl87hsSo2ulvC47dMdAgNuyPlq0C74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hukJABSj5JBL3ScY4XMkc2rRC3uy0qI0WQvRG3OFv3Z2WscPJrggJDqHJb0AJKAMIi1tva986d0BOhoj9OEnUBZ9oTpIEob6IDTnibm1SCujZPi14ByC+vQxwnjt4svNaDauSSEomG+AKtGvta3cORG5avpeda6S3I9Z/O2yASI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bi35xJp2; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bi35xJp2"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bdb3fd39045so981711166b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 03:55:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781088948; cv=none;
        d=google.com; s=arc-20240605;
        b=CUQhAG2A7WPobYixH/0sKL3x51ArWalg8oR0I3arJnY9GrmBx+fPckTk44fClIt/6A
         xcNhh0LCka5ADFf54QNHUOdJ0u7QGcDIICAiKF8VEawtc9swKWrYsaDxsvbj+ew+3StO
         ucGfzE0g7VCoYR3QLsxYz+Sxw1MWV77/H/YOi6aVN3ZYyA4Juu1UkcebiVFHxoaBBAEr
         VBQDHXZDnS4tBw2V2H7OiaiJzuNypnWzDQV5ADPADn39OObt6Q2IQQoliNG6/uYlGgB1
         GCm8qMn0vChXOqMFN6QKBPU994aarYoAE9QA+ylSf3FdQPlqHPTzNfiRhn9hcH/bKJjR
         A7Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zaMAn+lh6tbK16TDCN4EIvEe4G90xqJy2GOUfUQ3neo=;
        fh=911YVroLA/3QQ9iVu7qrDecdWr+KjwbZDzbZmll0OwA=;
        b=fs/U1KB+RgkobcDTXV/YPKnVpnt/olm2crozpjAIKRnVZM7uagjHM/rDX8yA5yOodA
         MJazZ8GHMTD441vFTZxE7jr1jt2MiqsYvr8ZfCPrYe8hjNuLxgFjXXCWdi7LBw00eypf
         8mhuVPRBKqyPZyG+wjEt/t6OQSubp6i55OrvcLHBPMxj8TVlZxCl1oKQai2hw1/HBtX3
         U1OrpR/L3rRrmqvXMZKfszhQL7QqbmjeVsDdBG+k6R/Qv2+W+Gs+TDlx74PziAgGWtij
         jIKkx0R3gQJnJf3huOD3ItuQBlU3AtlaDIR4KZq8EsNqkyt5Oifr78B8QTrpLDIdTGNo
         jtWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781088948; x=1781693748; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zaMAn+lh6tbK16TDCN4EIvEe4G90xqJy2GOUfUQ3neo=;
        b=Bi35xJp2nhFy4kZ+yNYaBKew6lXyUxnW9JuMTMYyjScfaEuKSzyDwdUyBB/ACOeEZc
         8BU7mVEpR+xD6l60eKSVsoWcbSvGb97hbqqPPWqM+rOZ3EORq3KiaYqsdPQ0JgWFGOOV
         aFklA4pH15PYs3WofzY7fXDyp7n+JTGjroPUWDvvjxa9lcRtlb5jTcN0LssZ/CqO/uXY
         jPagwmumasHS21Jsniwb3AdW/uvqSpEMBkN2dPlHWob9NtbX7/HngE2GFcsE5zYPvmub
         DxICEPg5KMiIBVIrKziWj9ql9FQQ/pDaBrNJ9lWq8IbVLMvbhY2Bp6Ji55y0PGRLZcxy
         EXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781088948; x=1781693748;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zaMAn+lh6tbK16TDCN4EIvEe4G90xqJy2GOUfUQ3neo=;
        b=DZhJQHl5B4VpF2SApgc5gLvUGYG2ffI6HLzafAhGxM4wYQE/+UFa0gTQfNmcriTDuD
         xeHcgui7yyOgSD45QOle5zIjvcbZeuOAbOQzH/mVRfBvgyBQ592nOraHmdhXZBt9EIeU
         iJ/ez8T9vyYg3si/9thBJWApFIdXu7YgaFSlTy0dGb9S9Atw0+2sjmRfCxuKrdpT10Wi
         57hhrgxRs6mWPgRLart2U93pdwCkUoHTTnL9Hxu03+w4m7wlGvgWyBUs3wXwj8W57Fqf
         bwEOX3sq+Nd70SIeM+O3weMe1DgYZt5gVzZGKALseuZc3a2Yt6FpfI1sf2TP+o8lVP2h
         D3hw==
X-Forwarded-Encrypted: i=1; AFNElJ/NYKtyxWXAiPdlsJJt22zLF4fRzSJnvuRhEpvIIGv7KwbygnlZ5CadZUB1+4qLH4zlV2IkEOH8OS5doSm5@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh2zhPSmeUZai9f6B/odSGQ5+JgCQxrLYekF6ApPZ1YoIgHzEe
	YgOTm7q1vsFMsjsOvw/tGEdhG1Ty5lLo01bRxYdh3fOZYkRNuylm3jVBPzkPFx3Wzy+Qeb1tKBR
	N9UYT/i6mNxM5A5VT+5l7751v32PxmRqg0ijB
X-Gm-Gg: Acq92OEssIEKrbrB+OQI22vUqPAjvEqLAn+AVqeWypQBrmzfk7GFxeSadV1YAt+j8qi
	A8BGPv640IBTs6RHLJsubFLs7Hm4CzpbXNlpBwbssU+QK1FahWOMtKR3/pwlNrK3HgbhN1O1Z19
	DpnxWAa/buh1ptgx0cH31y5Xxe4UxJFdFAFP2jJcUoQAtW8RN73693FBst79/OtLsnsEITc4G7/
	BEWVa3M6nj9B/u14qTDrkFqw4CWS6s2Bej9bioNcQqK3gkBuJsCU59PVnH8DszpMOblLZl/hCzJ
	8lKrFZXEr22vPxJgB5DN
X-Received: by 2002:a17:907:7f89:b0:bec:7ab2:9128 with SMTP id
 a640c23a62f3a-bf36fd9c7f4mr1158412666b.8.1781088948284; Wed, 10 Jun 2026
 03:55:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606105420.26641-1-technoboy85@gmail.com> <87qzmehpnf.fsf@mail.parknet.co.jp>
In-Reply-To: <87qzmehpnf.fsf@mail.parknet.co.jp>
From: Matteo Croce <technoboy85@gmail.com>
Date: Wed, 10 Jun 2026 12:55:12 +0200
X-Gm-Features: AVVi8CdGDDOFjwiCJX358CMpDpAbE9uc9xx5WKyBdjfmP3vXEfBPYc4wLk_Aslo
Message-ID: <CAFnufp3Oc94pVenk7pcbSgOUvnXhZMSXj4+ydW9+Cb2Z7-rHYA@mail.gmail.com>
Subject: Re: [PATCH v2] fat: stop reading directory entries past the
 end-of-directory marker
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Timothy Redaelli <tredaelli@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matteo Croce <teknoraver@meta.com>
Content-Type: text/plain; charset="UTF-8"

Il giorno mer 10 giu 2026 alle ore 08:32 OGAWA Hirofumi
<hirofumi@mail.parknet.co.jp> ha scritto:
> Although this doesn't catch all cases, if it found the corruption, maybe
> we should make FS read-only (fat_fs_error()), and return -EIO error? Is
> there the reason to allow continue to write?
>

Makes sense. The most common use case right now is to mount Lenovo
BIOS update images, which is perfectly fine to have mounted RO anyway.

Regards,
-- 
Matteo Croce

perl -e 'for($t=0;;$t++){print chr($t*($t>>8|$t>>13)&255)}' |aplay
