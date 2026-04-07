Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83D6271471
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 18:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775586938; cv=none; b=TZjLxMQvTIEv797yLHFJsomWvhRPE+dBzrB7qrhwmt1ASzFbjYsMCbEIyQuf6zGNMrXLhc+leN7grBgUwwZ35IQAU/tLxoV44ri0LEdR9wWo585XzEygqzdYLMLrYwr1REuV5fn7PeJBMuF191mDT3Ccmp4vbswKgTqrJNTxEXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775586938; c=relaxed/simple;
	bh=RcSfW7BVL553lKbTf3prH24yb+XiZUw0mmz0Q+5e4Os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRvsWgLF5grILOmrkzrdZhRa14zVdhW6vVu5iQN7ZuzaZ9B8+DRSbqOlG4ZHERcJk8bb2qD9qrEo7p+bp08wI8U3giPTJb5jTceZkr6cf3STKmBktP3CcYIL1AL/BzZD+E10enJcMzsj8c2Q8+8p30EhFWthz/OfHa04r8rOQkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=SumApEDL; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="SumApEDL"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2c156c4a9efso7019395eec.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2026 11:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1775586937; x=1776191737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eessS45c4d7a04OGsZRQetM2uu75g94y42hxsune8NQ=;
        b=SumApEDLqjM5oO+lZBfylVEo/xrFEJRxBukM94PfdKAw3xlu4lsPjIkko7r5vHQ2gq
         dovPz98PvB+1bC6E9oHpc9l6H1GcHxqmk8/QrZv6jf6QUPEV1qHRjd7yRNqCY+9vTifY
         m79Zleht9Sk2r5nAZLXxzyGtlqs7ENmw6PCVHYO5uQQSBH4iA+SsEfGaPlGN/urIXwv9
         U5A8bPU3oC13bX8ILhr8Rkk2+/FXYIVEtQU96FSr2tBLB5T3TO12pOxLdR0OLqvVyMeR
         DBkF+JNvrapyfUyPToSBdI2VyPlHq3YdQ+rhH3DGy+S2BSvPVwxyIPEyMzDCUu0Q0jDd
         6tOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775586937; x=1776191737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eessS45c4d7a04OGsZRQetM2uu75g94y42hxsune8NQ=;
        b=q2hMkJzyhOdIKGUw2rIkKm9xWe6w402r8AyJmwThuvLUChnjaPkF+ESprEXiIADFdP
         cHlkYf17NY0dQAAQuxOA94Zgwqgqz05d+EnKtRqrG+Tow/X6CQxp1ERmm0cyiR1XKlOu
         ggrbtOMMjayBeg+NS2dpr2w6JaLzGcaQXqCWlKcDSbm9apoXLRASbgfNHEPKmjZk844J
         nChJSecxpYR7deJz+rWo/nodEbYFDx+9w0RrlZcPvHXz8iyB0GeKg6DLqObsu2fzp8W3
         bT7Op9pDlHkmsWB1o3tMtycIoS844+nO6IJaK7H8rEp5Bjh4oIBM+OGb8FfKMO5OmXim
         /VFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTs3CruKkxtoKr33eqd4CCFws4u0AEHFKBvT8XjDyeuh2FJGrG/wYAYcBE3TAZSh0xv8/UGecRLa7Jqxzy@vger.kernel.org
X-Gm-Message-State: AOJu0YzXW3+1xuc2YQ+NJw1dSe3hURoCW1Vp3uldc7hj2u0ZM/BouVGv
	77OP27hANqbnanCPxeW16Cm8F7kfxzNpky6B9y7zfMAa3SKon5++cPB0k42vltF8D14=
X-Gm-Gg: AeBDiesmA+VuMtFBe/LjtEi4bd07hKNkeyf2QZzPxXpmzc/pZoi/XugNGlmohun/AZi
	O1gpnkAI2CPFtIUUqcXddR+N3q1MBuEQJ8jOT+Kil6BjD0mZRVyppIlsH2QInrmlHqs50rZfMJN
	8xq9jDRLthmxvG2VBy4jDL/vwhEY1UELiY3gkw3bQsO5EaryVadkuuNdxzS9FCWqUy5Wm9ROwGd
	XPTx8KO91+DFptHUQ0a6wI97+qo6IDr8n0IrzPes3yJefKXE5GYXZt13z3MxxuhObWwLE4KA4Fp
	5EojznMK9SYZp5CXGfzj5s6TlHbdRw809Zki0ypxtTz9lh15WHOQS52mjgRQyXObphMCkEKSus4
	4d4pIVwwCuirDrjaeU+y5BW7sLXZc1uezUzsXdJyg1jh0Ld8/aum9Wy7VIyFpCvYFYUjdLT1LeH
	8Vi88mXreEO1jGhIElS6+AG53JTg==
X-Received: by 2002:a05:7300:bc97:b0:2c3:b172:83c2 with SMTP id 5a478bee46e88-2cbfb995295mr8671700eec.20.1775586936793;
        Tue, 07 Apr 2026 11:35:36 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:412a:9f09:7acb:b69f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cba5df5c24sm15982022eec.27.2026.04.07.11.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 11:35:36 -0700 (PDT)
Date: Tue, 7 Apr 2026 11:35:33 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [patch 00/12] hrtimers: Prevent hrtimer interrupt starvation
Message-ID: <adVOdTnyIbKz2F91@mozart.vkv.me>
References: <20260407083219.478203185@kernel.org>
 <adVA_uv1srA_bsKj@mozart.vkv.me>
 <87ika24phf.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ika24phf.ffs@tglx>

On Tuesday 04/07 at 20:03 +0200, Thomas Gleixner wrote:
> On Tue, Apr 07 2026 at 10:38, Calvin Owens wrote:
> > On Tuesday 04/07 at 10:54 +0200, Thomas Gleixner wrote:
> >> He provided a reproducer, which sets up a timerfd based timer and then
> >> rearms it in a loop with an absolute expiry time of 1ns.
> >
> > The original AMD machines survive the reproducer with this series.
> >
> > Tested-by: Calvin Owens <calvin@wbinvd.org>
> >
> > I'm happy to test subsets of it and stable backports too, if that's
> > helpful, just let me know.
> 
> We'll only backport the first patch, so confirming that it still
> prevents the issue would be nice. The rest is slated for upstream only.

Confirmed, [1/12] alone passes.

Thanks,
Calvin
