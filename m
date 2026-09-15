Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F974CC262
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 19:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789499360; cv=none; b=RHcsyJSw9rSly07KTcXw0bS/fvwQWIaslbioMgUD8GLBuY/J7krZgyn6sm93qrbLScZRfulUpPgIcfnwj79g0e3sqhfix1XEAPPSNZcMTt+7b4VFCMJo7bJwT0vW/YAqD4TzHmrt1I4LluiLgT//Tgd5bzVL3DelaVA01/sYX1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789499360; c=relaxed/simple;
	bh=AGk4y8oFpNibhByHKIxcRS7KnQx6z20Q8VC6dFl1tNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hnIAgyP1zJWwMh+oASX7eBNLG2/uXWWdbsJ3eWkPmftfkCcgZ2LdPrlJ+L63lYr/96dpt5Ap2H1iwqcqmox3XRJ2x17anLsmoaQadw2fIafBZ9aAdqAuedwbPFSqMa/FDibQka4yomUPIKUwHGnqbNivGhuHVozmesnQbGJsH7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=baTWZZT4; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="baTWZZT4"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a99c5de614so228798a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 12:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789499356; x=1790104156; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XFFk9jJtDswBQpA8QWIooO6lLG4HdlvPT/LqykRjG+U=;
        b=baTWZZT41Mv8fDUUIY4M4JQ+wtO0Rab8v2A0NMhMTLiJ4v6n/hoXUwlpLEMx0TDvb6
         Bt+bbrXfbbYG9SMuWIH2KBKPQvqc5jGOvVog52rTdBAdksZR8BAcUhDfKTgECzvoeNaL
         JEcnR4jlud/KFQ6Todj+LBBhx6jDH35va1Njg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789499356; x=1790104156;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XFFk9jJtDswBQpA8QWIooO6lLG4HdlvPT/LqykRjG+U=;
        b=oAJx5kFTum1aHjLTZGqbKp226WR8PkchkWYb3hHAQW1HNC+L+5opm4Fnd5Xl0DPpDc
         jugA285tKAjXsO7JKtQMzxKOwaEEynnOyNtRcOuJhU0EPU0CYkq2pidaRZbsdNrAtmgs
         LLs1PGCX3DiBS8b6VbtdizZYtFaVk3HSatGvZPkJYDg+Rp//YZmHaplNCUhBuyMggB7W
         4vqnCHYeIGBq+qb56/8gLU92bxcJizLJUJjYOlr/C1hiJ4cDsS9yZnvOD2IKHFZwn9R0
         PWVFrfG13y/02IZeHTEQguZfHr8+N7IN2WOxzMjVMrwmI3onRj+1BoFLHqA8v/ZlqrCd
         bRsw==
X-Forwarded-Encrypted: i=1; AKwUvBxJLaQR3MECoLFJnL0Jx9P3dOrlITEssNjLl/P6v/CQQ48do80TY7tqBsm6gU5bOa9SPgwaxk0d196BwImK@vger.kernel.org
X-Gm-Message-State: AFuF++lIwLLJ3M5m8k8d2lARlhNJETY+NW0dwTsG1Efad+hNm+VVlPrS
	HqhhccJVSAUNgRs1ULaJZ24S40E8irBUwfeB9RDzb/TLpU65+fAXz+/uPCjqDprlkZ1Bc8DhvHX
	jXqXaU1M=
X-Gm-Gg: AYBFou27ZhdP2ems5x0KPvgaxW+4ltmHdcMeY6MStK416YwnHDHNfImVEnldh+u8+1D
	zks+9Fx5cgNl7pzrqKwQlR66wQhZtefzaHcppFIClyosj0WioMpTqwhje0krsYHMLNcW+1VQKUB
	6R1Q2OCuFttP5VCiyvtPtqkZXVNBmkNLZWuKegd6CRJ4SMcYYwfjSdRFvKbuEnXO0KmJ0+1KSMH
	5wfL2FxkVA0LoGgbsCSDjmmIhQqAB6rRZLOI5umOxd44Ht9tdrwhgu1KrXv8i9qFeVM2ckojuxY
	Fni90OPNbaLnC1eYZ7/87m3COjlyW4qQ1LvYuqCLZBZMylDsqFAQU1+/M4W+HsTxFGAJN8MQ3Sa
	PfMskvNE903lMD0leuzCZeUzDkGukDgV8r1YNFQpjPU49M+W5qf4zngFVwWROeAF2ewde4tmqf+
	cc7GyjEmTbBr26WfMxQTxJaRp254od9gdh9JBpmkxWmFiO/RWWa+fCKPLNzj8Q7MdaqdgZnCZDP
	y5B1o1CV11hl/zO9i69SIVLFVdIIPhi5/Qos2veEY6GRA+X+A==
X-Received: by 2002:a05:6402:21c7:b0:69a:b38d:403c with SMTP id 4fb4d7f45d1cf-6a9f61f87aamr11698667a12.7.1789499356004;
        Tue, 15 Sep 2026 12:09:16 -0700 (PDT)
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com. [74.125.228.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa1cfe07e4sm157962a12.2.2026.09.15.12.09.15
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 12:09:15 -0700 (PDT)
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa663c2so22197566b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 12:09:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy4i3riVKR7HYt9Pg3C6uECQwRBO8eCI7PVHYcRh2s3t0rdCSd12Iy95ER1zsGswWoKvEf7BiWlXs6afbDl@vger.kernel.org
X-Received: by 2002:a17:906:7309:b0:c25:47a4:fedc with SMTP id
 a640c23a62f3a-c29b839a057mr1176039766b.2.1789499355710; Tue, 15 Sep 2026
 12:09:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
In-Reply-To: <CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 12:08:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi3Kkqgfg6zUTHpQoZNL2VOB4vYqpi6RX0WNO++29UtyQ@mail.gmail.com>
X-Gm-Features: AcwNN1VCm0LMG7z3Jned014oJh6WBcf4uOx0OBk98_hrtHKbrhcQiMMJ_A-fmB0
Message-ID: <CAHk-=wi3Kkqgfg6zUTHpQoZNL2VOB4vYqpi6RX0WNO++29UtyQ@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, 
	David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Sept 2026 at 10:52, Jann Horn <jannh@google.com> wrote:
>
> Is this mainly about stuff like "we installed a file descriptor and
> then the following put_user() failed"? Because if so, I think a nicer
> fix would be to have a policy of "if userspace provides unwritable
> memory to a syscall, just keep going and pretend the access worked",
> and maybe have a sysctl that kills the process when this happens to
> emphasize that userspace should not be doing this.

We've done that before, where we just ignore put_user() errors and the
user gets whatever the user gets.

It is maybe not optimal, but it's fine. You can find quite a lot of
unchecked put_user() calls with a pattern like

        git grep '^[[:space:]]*put_user(.*);'

and some of them are in core code - see the two in kernel/fork.c, for example.

One of them says "if userspace has not set up a proper pointer then
tough luck". The other one doesn't even bother with a comment.

The scheduler has two cases too, although one of them is admittedly
for another error case.

So yes, saying "if you pass bogus arguments, you get what you get" is
a valid model. It's perhaps not the *preferred* model, but it's not
wrong.

It *would* be wrong to take code that already has error handling and
remove the error handling, though.

                  Linus
