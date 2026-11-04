Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793777149;
	b=HE8H9a3KDvRxNKKQH3wFalxseSa8pxkBe3cbMcuftkk1sh34x07tsmCKjW0Ys0pDpvwy
	 jGJf5ibxvm8Uu9valO6feMI4IxvG0DLMRySZpI7FdWJSPFRpjaOduR9v3yQxSEi8DJ3lC
	 fWLadAfyiKOaAyM0wNVpDYThM/2/bxoMU937xV61tCGnjixt+9bYsThRaxUyf5xM+MOtQ
	 gX/nBzygdumvNbLwc+a5lhN8E9DVOY+NlPx0xcWcgG0gKBZVesGIBCSJ3qbcIHgfeEtau
	 kBTLLJ+0toRcMAEtMxiy830QlEgiD3uw9RzZsKRQbOtGUWSdIKox/nGqBP0GLfII+DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793777149;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=HGf7LW+11fFCmkfZDnBYSiu7NHiZ1J+7B7vrKk2MO+o=;
	b=x4DPofVGgwPShc5ubGWF2E5Q3kqCZo+QFDLgBx4d9xj+YmyhZYJpfP/QQuNH2fVxFcNk
	 q39N5BPFUY844z8hWoCMgbLe4vOZ/0KmDU4cADYWT7M67eZ93X1cSfrC2dGH3HwtyJHf0
	 aCz72hah42n+p6t5m5GEJKrrrxM4l4wMtO1U42C+7rFFmiomCbbWgCh/ABvt+axeSEXwn
	 3DoIRWDFS+Aq3MVyHuAJvf56uJhC6gGIAZ7Iga7k56+lTvnK+JDDsv/Ac3j8ElreOSoTx
	 q2l8cGtwaw5qNAoXwM42EP//KWTw5zXjPhm3Wc40TyqNMO08SoDjVsePYQC4DS6zgZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=osandov.com;
	spf=none smtp.mailfrom=osandov.com;
	dkim=pass header.d=osandov-com.20260707.gappssmtp.com header.i=@osandov-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VRgHZidZ;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99493606A328
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 07:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99493606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osandov-com.20260707.gappssmtp.com header.i=@osandov-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VRgHZidZ
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ac6008c914so59675a91.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 23:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20260707.gappssmtp.com; s=20260707; t=1793777148; x=1794381948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HGf7LW+11fFCmkfZDnBYSiu7NHiZ1J+7B7vrKk2MO+o=;
        b=VRgHZidZURljCrK0HH3V2vKy9f31BQ0iYTP43G6ikNvBR4QjOxKvexYUY5uUu+JitD
         T9TOLxU3AuwSiEfvs+OeG0AzPdwnVqjedfkdmdtpWZVvyj1FCA9sCGyKG3IfgqeMduF7
         tADytHQvwR9g70pEF30quutiy5cwA5plryhJHjdgJ/FA7lKi9UOpU0Hi2aHxpB9zmmLz
         p7lB/1HmvqOF5+WzgD1Xyuwg3Sd7aC8aoth5hS9HATjN45F4AIk9OThyjOW0PZmMn8Gb
         PyeFm2ozp72iY7GtQJs9SMMvKa8+VY3YqslwzoN50PyVfinzUal3mgUUKUFwvo9oFTcD
         Kj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793777148; x=1794381948;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HGf7LW+11fFCmkfZDnBYSiu7NHiZ1J+7B7vrKk2MO+o=;
        b=Vj+fcTwjJmtbjd6ahEwoA7PAuAmNmzZEJoBCP093Om2ul+sJe6zZdhv+HI05iKnDng
         x7N9w8k0EF+n9nqNA4VzJ9FYqP+3c8XYt/XSom94xUOwT24IOxG8ehwueiSwuipeRYlE
         lvTm/QqLnbGq2buBWKJgDaBg1bLWbgxENbJlvjdCxf1Hp7YzCpNv0lPlrP7eYc8cS/Zy
         qoyFwLVzbLcqu08uPvW5SyrS7aphxedcQXEAXD29/035eryLrHKX1bB3xMPDDEz4diY9
         EdwZurryniEjQyAsBelvo5R8T0tVRsVjRpNWzEFSzHynlv/pfr+/fk+aEsBFZlMooUxh
         U+Rw==
X-Forwarded-Encrypted: i=1; AKwUvBy0taMcu95LvGkr9bFCyTAsyumdz9JgQHAn8E9rIDpM94ClveJ7V773caXN2nacuO6IeKKeLYuUw2SXLBNF@vger.kernel.org
X-Gm-Message-State: APuU4Z/uukTHIeMhndBxaoP5c/sPDtQByOfrZTTQorIMU3pYFKQ3kvFc
	PwCCRq2ru/LlB2R8/e21vifAufosQUqTKZbScyhs6c7WDkocLG3wbKS2dlyITfgJGBk=
X-Gm-Gg: AYBFou1DLnGipf9L9r87PnckFD9qUxDFUnklB+VZxSVCd7ePyG9I9UDa9HU4geX/MaZ
	aiApklfs93muyBw7ls6oupQlrKEuvY7DRy3bAxJrN4eLXNBmrSssDfg/5wGGQuCa8ztcUd+mJF9
	drRX65W3mnycEHBFwrsTxJidE+CVqnsyxlmZ8wgrJXuZwt7G4ibP0AF3c4fYWcZ0vyTNlDxucmK
	+HEQObf+f/xnpf5/q8v33SXbtLwwKqe4WqhzNiiNE5LBmufo2IFLtCUd3WHNQ+T5d2e9q7Cz4aL
	aSqzU9RoZl/t4YlmlSt/wXP+M34BsFH9ZXRbeh1YXkFduWBdDinynaM4V82/IIx3c2H03nBHxf8
	4BFRT2/s41FXAWSQjmBpaJLLMeh3dcRcmtzwWJadtYFyOLvlF/otW2aFaebx0jQgaLNuWmU/GzJ
	pTGCCJYmedqCCq0HkWIDZn7w2ZFXxQ00HLvBslpOnhQqQCNyR/kpBTPWW/zIleDQtIHG/ldoEKv
	oEia0m+cSqR9WEMGPGTWOAakSBg4XgadMj0ut6gKalzcjr6sFoxoMQmlf+jtP4H6gwoc4uDljvq
	jKsufORUc5+lJS5X569U5CtWKlJNWrNs1/LhUTjsCbIQvYpc+jt3K0j1jQyouMIHHUK+22sCnNI
	oVSD158vHlOPQmMem+8f8R3oPQTSnre89yWpJGyc0utWYTxbj/+vYSOy5
X-Received: by 2002:a17:90b:4488:b0:3b0:9a3e:bf8b with SMTP id 98e67ed59e1d1-3b09a3ec031mr1494219a91.6.1793777147801;
        Tue, 03 Nov 2026 23:25:47 -0800 (PST)
Received: from os-N5J97HY9XQ.tail2dda0.ts.net (c-67-185-21-237.hsd1.wa.comcast.net. [67.185.21.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b09311866fsm2861006a91.17.2026.11.03.23.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 23:25:47 -0800 (PST)
Date: Tue, 3 Nov 2026 23:25:46 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-debuggers@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] proc/kcore: Allow disabling /proc/kcore at boot
Message-ID: <aurd-kCBE7ebENUl@os-N5J97HY9XQ.tail2dda0.ts.net>
References: <auAmuqZyUodq3iqk@chrisdown.name>
 <auKKisespDm1xLLg@os-N5J97HY9XQ>
 <auOEhTNaKzu8dgEy@chrisdown.name>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auOEhTNaKzu8dgEy@chrisdown.name>

On Fri, Oct 30, 2026 at 01:38:13AM +0800, Chris Down wrote:
> Hi Omar,
> 
> Thanks for taking a look!
> 
> Omar Sandoval writes:
> > The code looks correct, but is there a reason that /proc/kcore
> > (CAP_SYS_RAWIO) is any more concerning than other ways to read kernel
> > memory (e.g., CAP_BPF + CAP_PERFMON)?
> 
> Not in terms of what it can read, indeed. I would say the distinction is
> more about who needs each capability and what we can remove.
> 
> Abstractly speaking CAP_SYS_RAWIO may be needed for hardware access without
> necessarily wanting to grant general RAM access. STRICT_DEVMEM already makes
> that possible for /dev/mem, but /proc/kcore gives the same capability to do
> general purpose RAM reading anyway.
> 
> In our case in particular, a process with CAP_SYS_RAWIO doesn't necessarily
> have CAP_BPF and CAP_PERFMON, so keeping BPF available doesn't make removing
> kcore redundant.  On the hosts in question, BPF tracing and BPF LSM are part
> of the monitoring and sandboxing we rely on, so we can't remove it from the
> kernel entirely, but we nevertheless keep CAP_BPF and CAP_PERFMON away from
> guest facing processes. Nothing on those host uses /proc/kcore, so we remove
> it as one more gap to close.
> 
> For that reason those hosts already run with CONFIG_PROC_KCORE=n, while
> other hosts keep kcore to aid debugging, since they have a different threat
> model.  This patch, then, lets us preserve those choices while using the
> same kernel image.
> 
> In retrospect I should have explained that better in the commit message :-)
> I can update it for v2. Does that make more sense? Let me know if I can
> clarify further.
> 
> Thanks!

Yeah, with a bit more justification in the commit message I'm fine with
this.

Thanks,
Omar
