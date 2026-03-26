Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D14F39D6E0
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 17:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547656; cv=pass; b=mf650UeUXqWJIKrn3eMeSP4z2uPC7JbUGGSyUTQDKzLfpcNCuUjoS6O8B79QJ9LnkJftU4qujkn5igzfKCTcxguXvtdtiN6AkyH3JlyNPBerNvej0ToMMvT3Wl/1yYncbYNwkU8ATHTpeBNUQubp2a0VuKeUzdVX18EHveoDlMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547656; c=relaxed/simple;
	bh=b/lB+okYRLSKO8ITUkaPWof/2aQ0JUNVmDThlOHlv0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FlHxklFM4H8XY8P+cW8u25bjjAL3y3Rx5R9q4IvnT+xSGd7HB3zW76nOI7DZZpwHRZYuJqbTQkdDd9za5Rx7fgR+uuqJC2MZT1qE4LdwmbVu8XBco1G6f1feDxEoQaE5+caXFdq37AIdmtocH0NLLU9nX+oPPEtvP2tlIMR+bdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZF0actuj; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZF0actuj"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso10326995e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 10:54:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774547649; cv=none;
        d=google.com; s=arc-20240605;
        b=Z5uXXyae1fzkTuG763vqjStFFeIW3WyWIz9xwLgcNKJAXibaNuSWDbyakgK3RcZQZd
         rDeDk7tz7gyOnvpL2m2BotnOZYI71ICLwqAJg6IiFZ1W3EORhLt85czYLhh0KLxHITI/
         NQSw4g+4krbAo2a44HGwr6cleLjyUEQu46pP5t6dfcMfSK0Qa+E1yIo4DZ/bEJx3Fpcz
         MtJZr6+7lBKDQiDn+QLl3+rRNoFFefdkxJl1SKJyPirHtYzEjm/BKXMNUUwDQ6TySe6E
         2lF0pM6JQ+DQ2pZeR8xS0kb10V8CkAcq2o+iI49iikHYTLJTRx+N9+5SzeTiZHiGpLoj
         WSIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2b1UX5269EiDhfq1pawQFex+1Y1S6Ex1txW/zzYwTBo=;
        fh=zW4uc8Ey3e+o2DoWn6TIdXG2UJhbTEFrdTpRjk/Zx8I=;
        b=GWS9qLbY5qxB6/80w4E/jxxmivxxa4dJGPFvRyQBeNhjQc4r3tF1yyVJjPqOgGqx6W
         6dqfIfJISlEXoIScfr89KRq8gLoyFUfAYmnLYVcdxatEzIwBVgfuEHokYYJQB7ilR6xI
         e/cayH9xUMSr9rTUGqTC8dpYTRp53jXivgmPw1nBPs2ZZ57MQDIHDJbkGinARQ64zXyL
         QUAxSSuxOzzpiojgFWQSwwUz/HyvMS4eUT180lqASkOiWhwMOOE1VsrcRQ12VD1tOw2V
         RtTPHS+IHRiBFQeOQbFL4UWxEPj1s5E8j+CZNrOOKzQp968Dxg/XUUegKBAmDIxJYA2K
         /F5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774547649; x=1775152449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2b1UX5269EiDhfq1pawQFex+1Y1S6Ex1txW/zzYwTBo=;
        b=ZF0actujmaZGYCtFfNjGWZVznU0cDM+/GxD2nlTFuhQeWzOM3u0prk9EqXKy/jUWRe
         PwC4Zr1UMud9Htg+l8iEEx58DpcxzBigrmqowMrg6DnMshx2NvndGquVe9yROnpe4dA4
         wBGQCggVBgLiguDk8XWj5vPPADhNqjpeOM9iHquNSRP6lfZNFMvF5Ws/h8ZXLQ+kzo5C
         IM7kRHrk335zuPXs50+lRb14wQKiBl8VphYOWYhNplZn9tdVO9iy5O5oNjIqh9cfmRmW
         jo3Ygu/jmXfDV0JEqi5pjS7Le0z6k6dr6mhiqHTT40cncwBktpks26T9NLSOBaYYe1f2
         LXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774547649; x=1775152449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2b1UX5269EiDhfq1pawQFex+1Y1S6Ex1txW/zzYwTBo=;
        b=PjeLL37iaq3ooQJt6LnMNmLMPRfT7mdAIQ13E9/tsEvnzGwukzEIw/YQ0DiJOe0Zkl
         Ox2NDMsONYvG6TtTKAc0uftbRl1U0Bppv2lmRog8yU7aqKnKVa6bN9UuXz6rx1VaT/1J
         5BDeN3TCce7lMNFxJwmwNwF0GohRiQMpbHzbJn/PwFTM7GpLyJFwQdsxNWdnNyw3Bg08
         133vozJ566qOWoFVoZ3b1ttKz0YkOt6F23V4egttCUl7B1iYxSnBpEP3JQg2kzVmeqY3
         1kABWDgh4+SARGb6Lnaf0Mo5SZmtjluqMVyk6Y2HgwevTuZ+lvZmwuDTPSpN7E6fZzne
         o6UQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9ptwyzegwljQvNtsGXEcLpzF4816N4kllW94afVT3jw4epP7V1RRltR0qzzhuliUz6jV0v4iwdMhtAvjd@vger.kernel.org
X-Gm-Message-State: AOJu0YzaaL/8lfXNdmaRm8OeByB+jqqWjwKuJ7cnjYM+ysHdvw+rlU0r
	08XG7u/92c0QYtFms6qplxJCUjlGfiMNAlR+JRGR4DwcAeZJlDL8XlItot3xObx+CDd2ivHmBA4
	Qx81LY3XYkrUpHy5tjQefX/Ab9dKTpQ4=
X-Gm-Gg: ATEYQzxsvhduXXftvkFHBIrn4Rjr+FdSOmjq2Alaw0teRN1mdMK5/X4xNZIk6NxM2ik
	KzcVMK4xTACrnbMWS2M89Mlgw/fgKSykj7xE5LLgbofQ+RW4EB91nkna5/TnyyDuTcrxBsEVMuH
	9kPlZcbP+9xogqSsU1Jv8Fzxg3L0XTT0hzsvQEHvBhjDQGcIm9p8WHAz2R6ZevgBcmsmoHjsvIX
	lDG+fE+rxf+l7L6DCLL21mwAy1yHAOqnvzliWlOpRaHxQfCAZLlIRc6kmMixFBTDH6D8xQuc5pQ
	JCeaEAkw/zg+ZH8M
X-Received: by 2002:a05:600c:528e:b0:485:3fc8:de9c with SMTP id
 5b1f17b1804b1-48715fd4dd8mr131671765e9.12.1774547648461; Thu, 26 Mar 2026
 10:54:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326001337.828947-1-joannelkoong@gmail.com> <acTJLJdrd_T-cOAu@infradead.org>
In-Reply-To: <acTJLJdrd_T-cOAu@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 26 Mar 2026 10:53:57 -0700
X-Gm-Features: AQROBzBk1MK2sKpbF7oHxmG14dUDSRU0L6vuO6VBQC9M1qo-02BtGUnmY2CGWLQ
Message-ID: <CAJnrk1ZTHphV9e=chJD5iHTMDm7F1qqHebn6+Li2cYaggyP6AA@mail.gmail.com>
Subject: Re: [PATCH v1] mm: fix writeback regression for strictlimit BDIs
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, jack@suse.cz, 
	willy@infradead.org, miklos@szeredi.hu, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 10:50=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Wed, Mar 25, 2026 at 05:13:37PM -0700, Joanne Koong wrote:
> > Commit 64dd89ae01f2 ("mm/block/fs: remove laptop_mode") removed this
> > unconditional writeback kick from balance_dirty_pages():
> >
> >        if (unlikely(!writeback_in_progress(wb)))
> >              wb_start_background_writeback(wb);
>
> Yes, that looks like a bug.
>
> > This fixes the issue by kicking off the flusher if wb_dirty exceeds
> > wb_bg_thresh for strictlimit BDIs. This restores performance back to it=
s
> > original baseline.
>
> What speaks against just reinstating the old-code as-is minus the
> misleading latop_mode comment?
>

I thought those two lines were unnecessary for nonstrictlimited bdis
but after reading Jan's feedback, you're right this should just
reinstate the old code as is.

Thanks,
Joanne
