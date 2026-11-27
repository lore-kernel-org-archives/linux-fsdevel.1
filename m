Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795740641;
	b=j5TTDBTeFhpvuisV0d/rz4p/KoMffZFRBYWKmiELpELRH+8c9nQaO4bFdq+4ygNdkiLW
	 s8w0sCF5rnfCH+cfjqD4XFe0tb2ehQ18T6IT0ZeZe9VFuRsiZn3qu8zioTqs29BgqFF7Y
	 yNAvLs77D54G9UDw/wUI9kiUTnX0pEOdhXAU1gWdH53VtUBFJCSg9S5tPQ9rtngTkK4KJ
	 eGZak3CEe7WxRrx2a87kl0vPUFDoYZNc0JsIohlZa6QzEre22fn7VCerqafQh5MFJahwT
	 mmZWw2WLhGYe5FGMGlpIzMmX7bAAG9AXpqOtUsGvaODJCZFbXWklBDHYUrCRwETOFaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795740641;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:Message-ID:From:
	 To:Cc:Subject:In-Reply-To:References;
	bh=x0Mp5Txn9dhWnd7kNaeyrGhDTXOo7utFqS5hhFOq2io=;
	b=o/+f/ODO1w2IBsvrYZ7oKrR20bgTtRNQ0IYyFoirEVQvMObNZZv3Thf5oOpRoj6oN5yN
	 30/Ktd4kj/DGgsmjr14MrpyxDtp4ieVGHLaohXsdh01jnU+BtbmliJFHeGXotKc/mWbjM
	 vRe1lQUKX0fgQAGXiEvnrCvuyqJkUMAP+CcAqbpTixCEjeopzRYj9slF2vFZ3HquYg2np
	 TzfkVB90E8iZEqeACB0AN4N/FjBM+27NGGwudMmu7VE+D8ZFdA0yEIPSEA5PJhvXWJDD0
	 /O6T24WbsxjOxjfhjqZnGpzANDg0cgpPeB0CjNgZ/8DlyKPAzba/3gK2edQXWF7w7BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K1tEEi0C;
	arc=none smtp.remote-ip=209.85.222.179
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49122606A321
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 00:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49122606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K1tEEi0C
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-9496317b730so863984785a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 16:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795740640; x=1796345440; darn=vger.kernel.org;
        h=references:in-reply-to:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=x0Mp5Txn9dhWnd7kNaeyrGhDTXOo7utFqS5hhFOq2io=;
        b=K1tEEi0CKdL//6rYPHcqQGCm7O0J2ly60eWlW+M9HTfuVDK6FL91RNDcDxOxAxtiTp
         oI7sUzz6QMfcVvFq4csJ6S083G2fdGSO+96r+9wFfux6cu46po3ovanEv6MSYhrNRPuh
         IQRkruV5OXzzvS8TSq91jU/dMUZz4WKqyxCeQSHwpqqP2n004NI2x8HjUvKRpMdohSJp
         LKJFj1bPEwjjKwdlmGJ5cwFR20a2FvFJ29hffy5GBV619FNLpZmc+rU9hunaxkLwu96q
         tJfPopPK/Hbxyq1qO4pmcgcT6uFv67XSRGyn7viNKf9DaddfZHEz+68SomD6h69VsuMX
         axBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795740640; x=1796345440;
        h=references:in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x0Mp5Txn9dhWnd7kNaeyrGhDTXOo7utFqS5hhFOq2io=;
        b=BImrT3QprPUugwcM4BcBXbQbz5gkWvEW37MgubH4zMRrz2/1IgZe7tsJpdBgi9fWdj
         ykO9n/5o6ovSS7tOb9WqwR/yfkfzdiYbtzImy9ZhvGqO2/AcWeV/QkFqBDO6Y+9N6DEp
         twHDiUI8LJ8OhemQ7A73LYoCdW/SL7CbMDEXUzGw/gxnZssXdn8yDj97yXH45gDjXon7
         aPkEAnDz4pRxjFNDvO0LBOonNt5w/5eS9sPt5hCSZOblZb6AT/jg/AFM8S1fCSP8+zdh
         VIKKHLV1sGRsC/6DqRMjVIOi7cbcB4S2o0uJFIDC1oC2eCmMaKBR/c+U2A0ViSP+26r0
         TmVQ==
X-Gm-Message-State: APuU4Z8kijyEb6z2lTaynCHMq8ljikKxfBXSyHTfujX2Re2TAOHsNkke
	mORFbTj8uyvhEEesX6YsxLJLfHHnADlHxBlGJ6N5/S1xnzGu5QAlVNNf6KmK1lP5kBlbGA==
X-Gm-Gg: AZFdTZdJdYupXWlMIaA7yuEVQ8NoNpWNve8Fcd/1tZE3FWAAZDFWHADmMDX+9uZdgnm
	mH50T6pfM3a091/7g/SzfTn29c+RonvvM6SQvZ5Q8lDPghNNkoJC23LEM2+54S6lJLpNJkKcdtR
	6LpIsL2vcY+8Ch2W+Ss2t3Si37LIpND3sMPGytKHfeoZd3FLRhJIjBdE6EcFeR8mLCXSuySVmnK
	NUq5lUSngsIX1RvAPLC4SiHf1XJqcobAnJKh1+EWzATfOd4fLCdVB9JHyENJ2HW8UYy9O2oCQ0K
	gJfIksmRmNcvw2p/0H8ApL4Jk38Fxx5JcUmI8v0kDyGvmWCP8NWFThmnaIhADrb+aEUvkGxcPab
	80/9KcGghOe+YqDL5yTZEHKKic8afMW8ER5dKtoWBVCrRl5fkVt13fhvaEI3bw7/AasxwMTsNSQ
	JiWzOOk7PuP/VMmPf3lB9cMHC56t/UHpxN3yJmjkL2pIGSwv2cA5h8ykO226OqkmAp++XkwRDLu
	xkflI4pdjgbzTcRJAp12f9K+HcrNpNexlmRvqL1xq34U3YPkB60BBAM+/QBBPxYqmcLOmPsFsNx
	DRWrn7Cl/pBiZHqugOIfeglQdQkVLF2qHessTkL1A4wTBrTEjG6IwkGs2VT7gaHGAF5D5QGUmWp
	0xQsx0V1huSEoPx8mjW50/3uZ3w==
X-Received: by 2002:a05:620a:2907:b0:949:72c3:dee6 with SMTP id af79cd13be357-949ba99cbf7mr4043850085a.19.1795740640134;
        Thu, 26 Nov 2026 16:50:40 -0800 (PST)
Received: from localhost ([138.197.109.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb34ac11sm1703987985a.14.2026.11.26.16.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 16:50:39 -0800 (PST)
Date: Fri, 27 Nov 2026 03:50:37 +0300
Message-ID: <a424da14ad9f0fcda6988f558432d10e.ndokutovich@gmail.com>
From: Nikolai Dokutovich <ndokutovich@gmail.com>
To: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 dm-devel@lists.linux.dev
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH] fs: tolerate an unfrozen superblock in the
 block-layer thaw
In-Reply-To: <20261127003902.48-1-ndokutovich@gmail.com>
References: <20261127003902.48-1-ndokutovich@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list

Please disregard this patch.  The same issue is already fixed by the
"super: fixes for freezing, reconfiguration and error reporting" series
([PATCH 09/15] fs: don't keep a device frozen when its freeze is already
gone), which I missed when preparing this.  Sorry for the noise.

Thanks,
Nikolai Dokutovich
