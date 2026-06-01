Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019933D969D
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 15:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780328445; cv=pass; b=STV1vkVZcOvzQ6rPVlK1SOnCys6cT2HRF6d7r0PLpAIiDgC91t8J1vjHcX3HwCns16aOe9nMbkFGjQDawR+pBdds5pmzjGrHA2QOutqTVSNfcx70wrHz0A7PjtUy2qIwjk97Z2m5JcsSFqm7lwUJvkZQ8vgCYb950/vsO7pQX3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780328445; c=relaxed/simple;
	bh=pIbEQSPiN+T+sdtWaSsbUFVX5LVpswc5ZlaCYoLxmhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e6x5sBHpSVH0PljwhKsWRAMyHLUGioxjRMiOtC7K2cXudOBLfwyQ84Gj9QGy+hdX6AhHiS5nb4VWmNXikLh817Qwk3vMI0TiP6mRl7LXOZRdTRsXwCbIRNKUnyvxF0fI5nYlQMmklVkZbP044GW9xbjtSYmEyLX1N5gGdXwjjmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DraYZfhC; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DraYZfhC"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-68d23430690so2761981a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2026 08:40:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780328440; cv=none;
        d=google.com; s=arc-20240605;
        b=I5opLX7+LQlA0lt11gWkkAsIBo9+EK7VX+SBIcuhlq8PE6GVHznfk2K2W0S9DV+9JP
         /wJO8JO7WYDheV6tZQBvGl/afmTLRj2UFleVskFV0ysx1NDcDBt+XtEYNxL5kFgR52w9
         AIehiyeR9Mb4AeRzBIyVnKxOeSxNGdvFCdxaY+jJ/6DOq9m5AUOUpwerW/xvVCHjN27O
         K8wWO8yfr3lR4G8ncAlklzJzrsKbs2iYHar/RtLiwQof9WOkh6SvK8W/tlbX7LQabeAU
         D8pPTmzrubQ95T/+YdWvxf1zaSb6xbDwtXV2rF2U48ovTQXZlvMF4JgYBxka2EFkvIJW
         pjpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yGitNDR3suWUnLziWsrEM4RRTJi0DQuBElG4O41DuOM=;
        fh=FhJssAAC0oUfHV8Jexp98JBLLvlfkZjvPVCfqQQeX58=;
        b=C39nOUPVkaEH8BReFu+Pe2M0HPH6OwCMORk+idJOwuG7WfUTVabQ+DNxqJqziga7Y0
         S/zqZa/5TOpBrxx+EX0g3AMz2qC8ZQRaxzJfWF2bMpRD4MYbKveiKDQ5OBblkRSOeG4s
         l0ETAYrEZhi4Q1YxagKRh5HzGPrrhAN85fXEfWTHCxbHYIBOwR2ZBLbZwyvd1dd0S+6D
         hc4U89dtyfjJzAl4nfAVgDFUObparubqFNBgeHRoYkJ6D89+j23d1Qlk1rArZnIkaVtv
         XdBT/X344T3WeE7EeiIRsaS2dWqUB28/3+ehgNRBLwAozdIjeWRfRBczO7OGmo9Rsxum
         yLtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780328440; x=1780933240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGitNDR3suWUnLziWsrEM4RRTJi0DQuBElG4O41DuOM=;
        b=DraYZfhCA0PpJQK7pSZiD+8CaqMiZNo3o/AWCF98lv8ONrEvsxAnjnWYEVaMhnTi9J
         ALMoCYAz9bpGWDLNiMvgYYtq2/S85UZR63g9v2lQcNQq75D2rCFZFaboACWCHObyKDzH
         erfxDKdCr/WAaIb7RDYpLGTMCVCQqHNKiBdgdJ4gIS0a/766j2hTmDVL8g9/r+MHPu44
         yZElLbrA3S8ekKtRoKURXPGaW4sidLBRqduSg1vy0M3gtGWk8/x5urgmIf8fQPrunbwh
         iPxQY16HsdOPAFl7JYTmfH+17PU9cR0TwZZEmBHTSYMLW93zso8ECm7TV5/ujYOwlQ2V
         6o+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780328440; x=1780933240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yGitNDR3suWUnLziWsrEM4RRTJi0DQuBElG4O41DuOM=;
        b=VJrMcEg1pQZjIGeYpLLCLeKEvqGEMnW+hKZPFnMTW2fHOFWybXqSKSBWWrkAZS4cK6
         danj3u1JtoPuIKtFWZgteTUvJLlQxklJR4eyG8hROs6m7OTkyz85YBoWRvrYTVYfnLqs
         EpY4Rh1rPsfUpRprd3FPsCyO8H04AvjiXpX5nemXXJKTkPPtlgICFm1DlZt3rQhC40G/
         a6NGbdv2LUznWCPph28Caw+w1QlOjiZxIoNBbpsoXgzJkjNyci1KKNB4Fb+R41XRdGeF
         UY1DycmJp1hiSuWf1KVbVxG47+ejT1DA6XNxMDIShAWFFLhtwcTuRD9NTFS791hoCOZS
         sZ/Q==
X-Forwarded-Encrypted: i=1; AFNElJ8Oibi4UZpb73t3F58JjWt8HFgo+dxQ9mKKiRar6VbkY5Tu/KDcTSEn1uHIsVGle27TqLRU4n2s3Wo/6XA0@vger.kernel.org
X-Gm-Message-State: AOJu0YwxaEVBWNBDJmLQeUqYvOAcdfE98b27j4zES2pVfVlYlweofnz+
	SZ2FtYYORlyDfJofzZVulqmvZYp9EKc/vwW1wA1pB4QF7bi5z7suRq1xf1pPk2BINHV4Lr34PaL
	u36Fes31u+mfWzY0Evlu8BFulVaLsp58=
X-Gm-Gg: Acq92OE8ukC74Gb9NrAO5Y4Cd3JyU+tGxhtUktgWynL6bAbzvHfkHRXQ5p4oJYCylct
	RB5eKfw87B6OExE203g/Pykac+OQKnOXcfzhLpFyz3rVGWj7EW5LIX09SxnejTJDYFb6Z3sSf3v
	bJj8CprZcqhPCL/na28A9fYhhQdcdwZPr0wr/21ieHbvINacWeYHMXzYCTZPRzdQ6WmFlXK5VNK
	nIFjWz91XEKm43Xn/XmmbYBvRpqW4Br70sQ90o/PFc924d/GQpFpb5/Og0/UM4kU3LEVGzNBtAj
	ZjO98O3cXms+wABdSf6x+ZLVvEmCbBmPstmdYSLEyjSb8ls+sw==
X-Received: by 2002:a05:6402:321a:b0:67d:6c95:9c8e with SMTP id
 4fb4d7f45d1cf-68c8a27c185mr6210712a12.14.1780328440036; Mon, 01 Jun 2026
 08:40:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601055704.167436-1-chizhiling@163.com> <20260601055704.167436-4-chizhiling@163.com>
 <ah2HfH3jJZDiNAQc@casper.infradead.org> <rvvwfa4dp2wovn4vlglajxwpumiudvcgbnrj6fwh4dxtxemawh@rbav4cliyraj>
 <ah2hszECv05z_Dt7@casper.infradead.org>
In-Reply-To: <ah2hszECv05z_Dt7@casper.infradead.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 1 Jun 2026 17:40:28 +0200
X-Gm-Features: AVHnY4IAVx_z6D9Ie4Ky2gR3nWAWMzRl5n77v-Nt4Fr4Nr63r96xqtPbPHht5aY
Message-ID: <CAGudoHFcWFcrJ=Q8XhxzmnYhorka8jXJXMX5RthsAz1Kd_jthA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm/shmem: introduce copy_zero_to_iter() for large zeroing
To: Matthew Wilcox <willy@infradead.org>
Cc: Chi Zhiling <chizhiling@163.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chi Zhiling <chizhiling@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 5:14=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Mon, Jun 01, 2026 at 05:02:01PM +0200, Mateusz Guzik wrote:
> > On Mon, Jun 01, 2026 at 02:22:04PM +0100, Matthew Wilcox wrote:
> > On amd64 some archeology shows the following:
> > 1. 0db7058e8e23e6bb ("x86/clear_user: Make it faster")
> >
> > 2022 vintage, replaces thoroughly terrible 8-byte per-iteration write
> > with rep stos usage
>
> That's a good candidate for fixing this problem.  56a8c8eb1eaf is from
> March 2022 and mentions the slowness of clear_user() on x86.  So a
> commit from May 2022 might have fixed the problem without anyone going
> back to measure and remove the workaround.
>

Ok in that case that's basically settled I think.

> I'd be delighted if somebody tested just this patch.  I'm not really set
> up for performance testing here.
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 3b5dc21b323c..112cae9f9e4f 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3427,19 +3427,7 @@ static ssize_t shmem_file_read_iter(struct kiocb *=
iocb, struct iov_iter *to)
>                         else
>                                 ret =3D copy_page_to_iter(page, offset, n=
r, to);
>                         folio_put(folio);
> -               } else if (user_backed_iter(to)) {
> -                       /*
> -                        * Copy to user tends to be so well optimized, bu=
t
> -                        * clear_user() not so much, that it is noticeabl=
y
> -                        * faster to copy the zero page instead of cleari=
ng.
> -                        */
> -                       ret =3D copy_page_to_iter(ZERO_PAGE(0), offset, n=
r, to);
>                 } else {
> -                       /*
> -                        * But submitting the same page twice in a row to
> -                        * splice() - or others? - can result in confusio=
n:
> -                        * so don't attempt that optimization on pipes et=
c.
> -                        */
>                         ret =3D iov_iter_zero(nr, to);
>                 }
>

I'm not in position to test myself at the moment. But should someone
be interested and try this on amd64, either make sure you have FSRS or
in the worst case apply this hack which forces rep stosb:

diff --git a/arch/x86/include/asm/uaccess_64.h
b/arch/x86/include/asm/uaccess_64.h
index 20de34cc9aa6..552d1b883579 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -189,8 +189,7 @@ static __always_inline __must_check unsigned long
__clear_user(void __user *addr
         */
        asm volatile(
                "1:\n\t"
-               ALTERNATIVE("rep stosb",
-                           "call rep_stos_alternative",
ALT_NOT(X86_FEATURE_FSRS))
+               "rep stosb\n"
                "2:\n"
               _ASM_EXTABLE_UA(1b, 2b)
               : "+c" (size), "+D" (addr), ASM_CALL_CONSTRAINT

It is always fine to use it from correctness pov. It would cause a
slowdown for any size on old yellers predating Sandy Bridge (that's 14
years now I think?) or for small sizes on CPUs without FSRS. Given
something like 4K I/O that's not a concern.
