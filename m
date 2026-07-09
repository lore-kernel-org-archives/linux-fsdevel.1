Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3898A3AFAF4
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 06:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783577493; cv=pass; b=JXFhIljsPJcgAZmZx/hrsyTMFqT/csZMves8WDXUgy+ovTmRnDHoq46JOby04pQFNOJJdAR8W81b1EiUTp6mtfvHYMAviFdgpiLoZGawjgdwysOKv+s4XdyoDsaH/h/l7nIt53uDqruShA5JfNSF3tnpXXrdl5/IkWBXam+dIG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783577493; c=relaxed/simple;
	bh=9b1pHcb4tDFl3SXA5D25rB9XkxaOPF8WHE8yxdA4mAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sg+MWjAtGTN+ib9+w+qD8uSeN8WHql1c9gIb+UciOV3JHyBk6tCJFGH1kpWnrB/WybhIwqptvFsaUolxDr67KILq3A+EhpevrcGOKzyhOsFADxoPurPVP/kCbbu1AtcP4Tg34LAXjZcSknNtctqMAXTHfxiDjScZxFeVQ6ztR+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=NFAqoqmz; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="NFAqoqmz"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c0ecfaee7so8577941cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 23:11:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783577490; cv=none;
        d=google.com; s=arc-20260327;
        b=ZIuWswpm6NaxJMCFNKJkC0psjAsT6irUu3U6SJTEErKdWx62QF1O8gFuMnzcS05yZl
         db1WyuJIoLxDCmhrYC4+aIMk/8JqL7/YiHbtGbQa97DzjdUMDfDyHcIjkTpIR8G1/ZMh
         /NVLui+TWGYnzUUI6HhC5x94a0p2jpSXekeiWpeb55SNEafggNhLO/XX2NBIIF4VE0m1
         6dliJIl9jh8bsLCsp0jN58t2Puiuoa2YuXH7TCDZ80qDW5TzSMIGgxXvi0YpOM4OghHt
         Jtv8O6NmNmO7reCMzjnE0OTnJ0gM8RgHYhEi8OYk6EDhanIMBaGYyYKJ8YlqKA0D4kmB
         iHwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dQTwiRoPjnPhFOLmv3RgpTRjzP1fhVs+pKfZMaiYyTw=;
        fh=eh+v7IaNqXLzDKzr+kVipQqdlOVQLJbIwkj5SdIvcL4=;
        b=OqYOv+OM0vddIX4IF+B2jLn0aIGCfIhMhZDQsA/oiEBgaS+eo9C/1pIrMEHUp1fqEt
         hJ8/nWAv23mnn+EBMmWref46jt0zWVpUPBYBMfGaHKGYSvtRPLjiu9ja6A41UsLv/qTa
         rIgNaRC/XTqyRqpDW0QSOiHI4zjfZl742WHGQC8y7UpFeA5hlntbtu1ndQM80ILWEtFq
         ngeEcAT4HM/xp6U8DbamWsDvbuR2ix0k6vNAydvzMAuXLDKv1DR6Z3SIA7vK6b6cYzhs
         aTOzAh21fWJ2fPAhKjNCUdj1Bo2SPRuJrfO2jhZPc6hpf6geiremdRa/hpCBtEyuEers
         YE8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1783577490; x=1784182290; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dQTwiRoPjnPhFOLmv3RgpTRjzP1fhVs+pKfZMaiYyTw=;
        b=NFAqoqmzRE+v4seoIqH9pEOna0l9VfjuaIKSQx/vXdYmNcQjtGl9v5loyKJWQtQjOg
         YI9YzoSz6bD7CRsfmfRXInTQ9QcnPVcbUGLg0/1eJ/zdUm7vHyrHNTglOBqZo36HrWUk
         orSqDqWGcruhNcI0qT2gS+OzJRTG33wCbHxy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783577490; x=1784182290;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dQTwiRoPjnPhFOLmv3RgpTRjzP1fhVs+pKfZMaiYyTw=;
        b=CwVwif7u+aeBpflrrajwQXm/vtcBam1zKsDXcuJzYvNum04UM2cQCUsaDamHG0QOVG
         eE6cZr4EVyE9RnlVfhRDTLAbUXTemrXGNP/JtszDOzmr406iYNdUPtIXhjHqDBgQK90R
         P1OPkxHwfNCDTKOcKoDoXRCHmeGoj6ZxjmQPAtJDzVoIDDSayrwvmmlI7E/Lh6oMOY8P
         La56QHfgAtx63vsRwZ9V7RoWD9zYKC1y3RYAiTRAhjfwnN+gf8qKRrChskoWzzfpKrX4
         tY9F73Tj7PZrZVFqQ0MHDefBUD3ok1FU7yvgiUPzHe0pa8Q3p24uyGxy7aOXMPCHuqLe
         hsCA==
X-Forwarded-Encrypted: i=1; AHgh+RqzDimk4Gwae5rxy36zAVp0IaIDcm/UGKofCKaVD/oN0V8h0UXPL3q2PfNo0GF6XKtnbBs+Z7k8qZArmWEp@vger.kernel.org
X-Gm-Message-State: AOJu0YyiuNJTTDwnn08w2gQFfNcqRPPqQyoaMHufLZdxqIk8+WZLlme6
	A9jtH3x/R2F0h2ABN99YLAc2iA9C/D5M5TeLnCfuitaZlvHAyeTa4kRs9fB7NAy986EHKx7dvff
	v3ZP+6FXlaaKacjHPaksnc3kndTRXtkr4G+7Eo9paxVMzIKbGOdS5
X-Gm-Gg: AfdE7cn7P+pUwuM9rwzHUtyiMh6tQaJyJp3lxGOKjiOJ7Pjd8WzMiJ5czwfaUyw9fLt
	1v34Z9PRb+VvfqexoXRweViV3jIHiWKjT2M/OxCpBfezAoRHcO46cNIXIcSOQfGGMdCgv7ltufY
	o5Pg7qzmHIHUwKKJILgS3sh0AU+A/yeBpD4Z3bUBZO+C9fhoaMs5mDbLsQ0APVJ6PNDcsDDyIDb
	Jhenvi/otUyAo1f/tCnYe5TUQxug7/qL9QoMTHktUeNgsmTRVWisAwqa01lzZb+EVquEPAAiczN
	qMjBKumouqwspaf814G3SmuPkKA=
X-Received: by 2002:a05:622a:2cd:b0:51a:126c:c6d9 with SMTP id
 d75a77b69052e-51c8b431bf6mr60467911cf.26.1783577489970; Wed, 08 Jul 2026
 23:11:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708095831.3381978-1-gscrivan@redhat.com> <CAJfpegsJON=1_84PCGMjASYPFL=Wqsz7dnTAbO3Tdz5DfRQU+g@mail.gmail.com>
 <878q7l8y4y.fsf@redhat.com> <CAJfpegvQ06=2E0V_ADgxwmo7e5weTfOMozmBB-QVNLLWYAm8WQ@mail.gmail.com>
 <87wlv57dt1.fsf@redhat.com> <CAJfpegtTixwWSh9M-9NbwP0nUbJJ9rh0rxqO7BzgK7Su_RpM+A@mail.gmail.com>
 <87o6gh79yi.fsf@redhat.com> <CAJfpegvUEEbFnCa1N9k3gMXpw46YFpWuta=G6brON1=xU36bgw@mail.gmail.com>
 <87fr1t6wyt.fsf@redhat.com>
In-Reply-To: <87fr1t6wyt.fsf@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 9 Jul 2026 08:11:17 +0200
X-Gm-Features: AVVi8CcVEq2J0Va4XFUVsVlovcTwuzY96sGW-KM_Jfd0atcnoi0NWAC1g8xQ0Hc
Message-ID: <CAJfpeguPzVqm7JqJhe2CpfHMcAiETGT4_e84cFBEWESr5RpEGg@mail.gmail.com>
Subject: Re: [PATCH] ovl: add ioctls to retrieve layer file descriptors
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Jul 2026 at 22:35, Giuseppe Scrivano <gscrivan@redhat.com> wrote:

> Would you be OK with the ioctl as a solution that works today, and
> duplicate it when an alternative API materializes?

Let me have a go at the pseudo fs interface first.  I can probably do
a quick 'n dirty prototype within a couple of days and see what
reaction it gets...

Thanks,
Miklos
