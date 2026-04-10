Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EBD3E3D88
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 18:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775844740; cv=pass; b=R/J/L4WAsyH68rIyxqOfzKiPy+i+euR0A2DiNOl4+BSk2KQJTiTyd2wD8G/MhLPdtUn26/RvGZxd/mKmrhz3GjfmZEJOmsTztXA8qiGxVDJ8PVzMUZk0C2o7TBZGz+AozlSPbzos7wjyjquS/Z5DtBsq4H3ibAwBiI/dEjKJsPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775844740; c=relaxed/simple;
	bh=PA5zTQMyHZQ1NmMD6YmECLuqq66PS9pN4nB6JaBqVNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1MUEzjkCKvvy8OBNa8QWTP6fUGmTsebun9nEVsgi+UpDWC6qz/lZM3NdyOxOY3K6Tgm6zdBTLxFxuvS1YODyb1Yx6RcDt2WjfyOVcgYvktGjtYOpYkwuxOB/RI2tfNJhbcnFTmHOUHVxUOG4VaIjjH3JF8tFWjRvNDzWKiOKjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuRVXsRi; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuRVXsRi"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b9c62fc8debso374843966b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 11:12:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775844738; cv=none;
        d=google.com; s=arc-20240605;
        b=fOOMEyRXE7HdhAGGj73QWCZOanXp5JPDl9Df9sZg6CjMIvlCy3daU8JhD60XE9Fghn
         Qcfh5A5/CYSmEmndB6P4tvDedIW+8u1ttBqZiVRe0vKST+5CZe4TNIDL6rrOsvz2zM2J
         OijgXR9kWSwpWjQj6TZyF5D6wD98Cqv7GKrusE4E8ARNEfDRzGJ0RyRI0I4F/j64tffR
         fpgZeyGITf/H36fK77vOkNTsTnnQgDn1mkkFOQGkDRnidpyvoTWEtWRAfg1cFUsOqAVX
         2eUWZS6Owhv5CnNIzttmYmUeev1Mw1kHzhqvJHIt1WDzMLUDjBqU8iYwM6lIwOgmO6F4
         RTGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UFiNFpFbfy0GjElN2Nmo5DJvPhQRgD96BASohru05w4=;
        fh=Ab9oeLisT6RvSodLLP62OTJghGgBf46YnNNMuMzrpHY=;
        b=ln0OaUNVuUSinMPM16rukAgYdgh0C/8/IAK0Jm8phyA/orX9zjTmSzzSBUwyBDjUwR
         oLKdzpyhehN7Q0kApp4nymjOvfJsIMexIk9yt+CA6zOflH1/BfWQTyIgQCtaDXfNY1Fs
         hqDl1v/TM/E1am1GmFlUJxNNDPuGDK+ZSgYdfDbWzIN9M7B+KRzEVxiiFcHUN5ZgAgpy
         cIu7guiXX6rEU7heXy00SkGZelo5H0/yP9/k38h/axugEhPuoGrj1Yr3YGlKvN3bC19q
         OmK7+siaf6Q89BPVPSlQ93u6SEw0Es64nVevzi5DVXl1o0PmpvTF7V0OMw3lZsJSMC21
         ilFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775844738; x=1776449538; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UFiNFpFbfy0GjElN2Nmo5DJvPhQRgD96BASohru05w4=;
        b=KuRVXsRiQY/zEfevkMel8Z0cpLUqOsZ5qWcbYTJ8DB4sm8JGkhJ6GuWGeuq0Buhl0A
         EkdWM1lag/20Tub3lkqVs2qCdVm1iVRs4WzpilRlDV3LWeDRiIPNKsD21L7rBbv1KXpT
         44UQn36/l5Adyd8vSogrSKbN4kUZ2wmEZr8IVPdsoSjdUj1S9l1UbyfYasEVRPLj3BTU
         xyBvmJbaFO9FoTsCt1QI3FO4c8MLAyVc6IdcWu2nPj38Q9JVhrE14w/dcpsENAItC8ks
         elE+x/Qtz/WtqDBg8Qqpzzo80oT8tvWG4tEzYMvzOuTRsaWfC2XLDw8Q+QediGJGT4NJ
         EWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775844738; x=1776449538;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFiNFpFbfy0GjElN2Nmo5DJvPhQRgD96BASohru05w4=;
        b=tYvhp5++uztEbyZ5/Xa/do12xi82ozOP7A/VlQacgaTA+Qepyb9Wmz7RG5wQg6jFdo
         ypRHChP0mOcJm+GTNOgvaP+Y5YS6cGdK3V4/dCYw0cOzhio3Of+1U530j10Zkxq/T9x1
         P2KlnNq8HUDtIAXNtsdU4JWp8rMZa6BazttFzrB4hJ3Pb36Nm4m6jxQTYANdnR5x0G7T
         /RXRA3K0u6iQmpYbE/faktlyoN0G2jQEsXCcVhmQorZ67Ui32nPknXJKfSKBomlhci+g
         tTrYzO5YHOsERUGduG8XZp8YMrdz47ubf8AVr01fm2ubj+rvkD2dNhfN8sbcHbgSKu+P
         14sg==
X-Gm-Message-State: AOJu0YzTtNkHC4H9iAkN6JAhx3kcXOtHi7sU3k7S1PODD13r5rmjvA8k
	lotBizp/VDri6lpjKiAP5Fca+cIMlau+YJ/LZQxeT8oU1kXha0M5fK0jlBDFTneIFegQ+XuOJMA
	nmuwq9zZZnr3H1FPh1bhmKFEhvySk4+I=
X-Gm-Gg: AeBDietPoTruYxPCpmypMe7SuqHDbKjInw+it4VM+E1VY2RHyrDJ+IGvyew+FX0KtgJ
	WMKhFqJxkEIvduhEW0DBWgeMjfQEHTNgGDA9axHuQxYuo7cJdxzFu0h0hf8TvpUmLVzMGElg912
	CTbQumrMME6SqexajE5r9bX8TrtVqALAjgN1pmz4VODn7ZqcKc/m14Pdoy1XJwBDnr2jT41CkEj
	+RfQl8hEZEwoJdAaWyksA6J5cW1PsVPcGk/bMp998ZWAbG+xokAS2wYf/8fg1TxaJtWjSZ716tB
	Zuu7lyvQogPualjxHlXw7FVm+FN65qr4TOIYKhmVsvDTlUFsYXJLSbit9btL9mo9BWuGADvfNqx
	lKBT+WD/877eyPDGApCObQA==
X-Received: by 2002:a17:907:94d3:b0:b9d:1adb:fcbf with SMTP id
 a640c23a62f3a-b9d7297e213mr260114566b.33.1775844737599; Fri, 10 Apr 2026
 11:12:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410142403.308108-2-adrianmcmenamin@gmail.com>
 <adkLbCyI7ZnxkSAp@casper.infradead.org> <CACwZE5SctP1QAy_5_sBTC--O8ubGwFpFry0KF+CS72W=EXn7Eg@mail.gmail.com>
 <adk5I8RsBjJY3bRM@casper.infradead.org> <CACwZE5ScnatgFD_VT75m4p4dH=R4biWj2OZKwXkuGrzREi4urg@mail.gmail.com>
In-Reply-To: <CACwZE5ScnatgFD_VT75m4p4dH=R4biWj2OZKwXkuGrzREi4urg@mail.gmail.com>
From: Adrian McMenamin <adrianmcmenamin@gmail.com>
Date: Fri, 10 Apr 2026 19:12:04 +0100
X-Gm-Features: AQROBzAJHuTH5PLhjFG_HaPfoe6IGRF1nRgRF3ZHUICLyH6OMpKIt85jM8w3nck
Message-ID: <CACwZE5TmJKmQVei0xrS3awJurt2Fg2Xq=hbqdCeoPgV2vrafwg@mail.gmail.com>
Subject: Re: [PATCH 02/10] Add support for VMUFAT filesystem
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> On Fri, 10 Apr 2026 at 18:53, Matthew Wilcox <willy@infradead.org> wrote:
>>
>> On Fri, Apr 10, 2026 at 04:37:36PM +0100, Adrian McMenamin wrote:
>> > On Fri, 10 Apr 2026 at 15:38, Matthew Wilcox <willy@infradead.org> wrote:
>>
>> I have to say this patch series is almost impossible to review.  I'm
>> not quite sure what you did, but it feels like you generated these
>> patches manually and then used git send-email to send them.
>>
>
I know it's not great. But there are 101 commits in the changes ( you
can see them all as a git pull request here -
https://github.com/mcmenaminadrian/linux/pull/1/changes ) - as this is
something I've been working on for some time, so I couldn't see a
rational way to use git format-patch. So I ended up using splitdiff on
the full change set as that at least broke the changes up file by
file. I then used git send-email on those. I didn't realise I could
have edited those generated patches statically before using git
send-email unfortunately.
>
>
>
>>
>> What I do is construct a git tree that contains all the patches I want
>> then generate a series like this:
>>
>> git format-patch HEAD~4 -o pgtable-20251113 --to 'Andrew Morton <akpm@linux-foundation.org>' --cc 'David Hildenbrand <david@kernel.org>' --cc 'Vishal Moola <vishal.moola@gmail.com>' --cc linux-mm@kvack.org --cover-letter
>>
>
So, if I understand you correctly I basically should break the change
into a small number (4 or 5?) of logical units and submit them? I
think I can see how that would work and I will give it a go in due
course.
>
>>
>> Then I scp them over to the machine which handles my email and use git
>> send-email on that machine to send the pgtable-20251113 directory full
>> of patches.
>>
>> The other thing that I'd advise you to be careful to do is make sure the
>> patch series is properly bisectable -- for example, you're adding the
>> Kconfig options before the Makefile and the Makefile before the files
>> that it would make.  I'd invert that order; add all the code, then the
>> Makefile, then the documentation.
>
>
Thanks (and apologies if you get this twice as I forgot to turn off
HTML email earlier)
