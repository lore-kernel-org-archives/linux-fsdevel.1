Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218F03AA1B2
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 16:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780675396; cv=none; b=ogs4ZT0zgyVA2tXGCFpTQ+B8aeikHkABN3lPoRTm9E3kMwaU6tK/no/zcJI2HyO6ihlk2Wx9IjDVCUj/dNshy+LQLCt8P3LUAZhktcNLGHtscu5skCKaJC+Xak0gJMyYUGytjj3Ga014axw05GG8qTSWoB/6XUeXPG4h72000d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780675396; c=relaxed/simple;
	bh=3Jk2TzG5gR2RH4+LwM3XSlFeV25EIj3RoPOfWA1O8Gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A3mPMnJdoYEjUYgj+tkCo9q6TFAtyKb5BCLIGvCTLs0k4qxeCvxyc5+1GYySbKvSgTQUWSaTuUFsT3kDCXd9GsKQkMXSrTD0SmMckkhxWE/UILue/YR2USSHwTvyMYi2GhYZkXnfrXBbgugJskOM/RVxNQTTpcq1Bz3bc93cx8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LKCDeuie; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LKCDeuie"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bebc80100efso233400666b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 09:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780675394; x=1781280194; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y6UQFMgxs4xPTWbEaYQXP4WreuO3V04h3DiBWisQT8s=;
        b=LKCDeuieL34iF/vivq2FQy9ACSF+2vYt0RnI+XNP3s/XmhFSy+xXbrIUCXewGgygNf
         6lnZJ8JRj6FZz3LqwnpS/bWiroFRpmivunV6W5FmTCcqVustSLeLUf2fjBoehH/XYzvg
         C5z18LwCUy5KDdIKePdRRsRh8t1rTXPyfcPPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780675394; x=1781280194;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6UQFMgxs4xPTWbEaYQXP4WreuO3V04h3DiBWisQT8s=;
        b=D0WPuRDeSxcybUdfO9xWrflz+qC2tXTKq57gGe7zuYCsojG4J3HrY98Dw1n7Hz5zMY
         a8zqf5Y1ior0JIK46L635T7AnKedWOKHrCeMDqOO8M+zMT8wze3UWyozaH3ek5UdWm3P
         PJXBLW+Dq9AZRPVNIJKOvbMzE2X2kukuaVEqlACPvHAMvtd6cmYw/AVVXa875vEkF3pc
         iWuivAaXbyFcnfmC2WeLBT26kuoKpVCEokrFnx3qpdL3jJoTbXreSnEyRvFSLUW7s4cy
         mTWmwaOqWsIPDXBWeGTN7q1QihIa4ZhBqE6YmTtfCfpff11qkD/OdA/BiB2rMDcyN8LS
         q/iA==
X-Forwarded-Encrypted: i=1; AFNElJ+fenlmSatn+6PMWDB7qrI31NTwuyXPSQcJN/iB0x60aCF4atw1FxVI5AWNIZJvawltObP15E3Nlc2geZWn@vger.kernel.org
X-Gm-Message-State: AOJu0YysKG17wSh4rmjsPsl8lyJ0XPWjShfm9xf37xaAZ5o+zllpXHtP
	5mjz9iQ/Qi9U+a8Wp9WVcmTQPHnp9pcTmvJz/qYmONWSI2DBAGnv5gTqRTGH78hoYchuNn5dSBJ
	7rvWMU6ayqw==
X-Gm-Gg: Acq92OFY35TFPdDplqGyPiyBWJ/M6l+W0CakdthhZq/ShqJEUGMsM/X+V/l6JJqMf1T
	W7VlKMe22aDqnwvRbeLCa11FR+0iEZN3UnAfZmaN+MHdTXvEQ7PA2rbYI4ORHBKstt/PoU/rQ68
	y0pjQhklXTpHsqt+wwlqt/Ejnndloc3BiriydNALzE3+2e82S+0fXfpq499ay9fQUvh/S0ftEjR
	MqkkIzj7mqlRqD3DdtqA1EE/sRRWx61Ewob00WnaYgihVU0fDkGNtMj5KKsFZTCtqUFtGvggs1/
	gKiqcXQ9A77ul/klCSO9QXFAqXV4PUr8CC/+RMyH2eFkmth1B9sZhVR60UGC9y2w2ZuLcX6s8K1
	kXpeEY4+REbIx2eKhxmf63LbpChowIEOBY1ns4wEZbaWySbr6eZc+haYQX5Kh4lXHfFRCgsT99y
	otvvpxVOWEpICYj1TthqN1GgTifFE+B+zXgwKxpoQeJcdKhLgzQOAQmEprSqZFmb4T2cev3+s9k
	PQJfBkiWFI=
X-Received: by 2002:a17:906:8a42:b0:bb8:fdf7:e132 with SMTP id a640c23a62f3a-bf370a673a2mr170707666b.18.1780675393390;
        Fri, 05 Jun 2026 09:03:13 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf05530935csm476587766b.51.2026.06.05.09.03.10
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 09:03:11 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bdb3fd39045so267022766b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 09:03:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9nBkPOiq2fNaYji7Ic2VzD//heuT07tKdogK4CqgsJcUP/Omaw5ta1MTzv/tw91YEOw70/cgdQ4RtBtIBT@vger.kernel.org
X-Received: by 2002:a17:907:9686:b0:bee:323d:1239 with SMTP id
 a640c23a62f3a-bf372e1e4fdmr260752266b.38.1780675389972; Fri, 05 Jun 2026
 09:03:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531010107.1953702-1-safinaskar@gmail.com>
 <20260531010107.1953702-3-safinaskar@gmail.com> <d9806b34-fc73-4878-997a-95c5e8ae4b29@sirena.org.uk>
In-Reply-To: <d9806b34-fc73-4878-997a-95c5e8ae4b29@sirena.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Jun 2026 09:02:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjBZAzPdZgEeHAtSiwJpomt8ZZgKbixuiHfRm09a4=PtA@mail.gmail.com>
X-Gm-Features: AVVi8CdZ5f-_r2ry70kDuq_xsye2rLgypwsymONxqFNfT92KlgrDUIUXs4-jBmo
Message-ID: <CAHk-=wjBZAzPdZgEeHAtSiwJpomt8ZZgKbixuiHfRm09a4=PtA@mail.gmail.com>
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Mark Brown <broonie@kernel.org>
Cc: Askar Safin <safinaskar@gmail.com>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-api@vger.kernel.org, 
	netdev@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, Aiswharya.TCV@arm.com, ltp@lists.linux.it, 
	Miklos Szeredi <miklos@szeredi.hu>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jun 2026 at 04:02, Mark Brown <broonie@kernel.org> wrote:
>
> FWIW this is triggering a failure in the LTP vmsplice01 test case (which
> sends with a vmsplice() and then tries to read that with a splice()) in
> -next:
>
> | tst_tmpdir.c:316: TINFO: Using /tmp/LTP_vmsp3vEmQ as tmpdir (tmpfs filesystem)
> | L4471tst_test.c:2047: TINFO: LTP version: 20260130
> | L4472tst_test.c:2050: TINFO: Tested kernel: 7.1.0-rc6-next-20260604 #1 SMP @1780589917 armv7l
> | L4473tst_kconfig.c:71: TINFO: Couldn't locate kernel config!
> | L4474tst_test.c:1875: TINFO: Overall timeout per run is 0h 00m 30s

I htink this is the same thing that Christian already noted (he said
"reported by David", but I don't know which David ;), where the
vmsplice() writev() emulation was done as a blocking write, even
though vmsplice only blocked at the beginning (ie waiting only for
_initial_ space to write, not then blocking afterwards).

                 Linus
