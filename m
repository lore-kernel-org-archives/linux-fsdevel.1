Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793231509;
	b=YBDcRHRHyUeprzIt5F2b/PS//AJQ0xlpEVQjcO2GMEccV3WzCuc+QLPq2mb6oKFV7yzO
	 p2NJUoHYv1t4p/SASwJcdrs2I+lI4wdPeix9zkLYm8Sb+jdll7QNdaOfWg53hdbsy1uxu
	 IFk8l3bGFJpdEGzpZyOCjxZaiWvfu/lacVIh/gDj0Bw7hjrDJEurHfiHgkHXuJ6z3pgdb
	 WW55562lzQ9gbS33pVHSHMCNCb3QjbCppaGOHHjdvOSl9dHkhAJ6B7rvoubOMkmTMLYsb
	 dtl83LDmvyBohYwmR7ymZZWQu99T5askzj+d/0MoOS+30OClvr6J2egYweULJ6taSQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793231509;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=9aqlUca5Z2Dix4R9/uyjhIevl9A0MEDe7rswOfSHfFU=;
	b=UZhBut2K+BOqk3VfI8XkbykR2JYqT0eMU+JD6JB1B2DGLZQaMOxpE9KYp86Km22JWkZR
	 R5wA9aHJr2V3Ygd8sLVfc6UCHjlDJerKbVh9+BWmphWKmSCpMiqAZLe+pj1ljH3FgPhLf
	 47CRxIm33Adpu2VC+rS8Ya9SmDgh43ja1ljKDypI2URVga6YHKsiOMiUnlW5TaL8Ted/3
	 quiF3KYL04BZ7zNfVWw9mlL4ZyPXrb2UQ3JJxU60ChN3yg5uV64Z3eWB7EgoVlO5/8h2H
	 BBK93rJZbF31vLpO+ZK0baofuAlTeH0BSgkEHA548xDcQgtmN3JPW4lqq5bEN1p0G4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=osandov.com;
	spf=none smtp.mailfrom=osandov.com;
	arc=none smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6F1606A31A
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 23:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC6F1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-70e06680fd8so76971eaf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 16:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20260707.gappssmtp.com; s=20260707; t=1793231502; x=1793836302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9aqlUca5Z2Dix4R9/uyjhIevl9A0MEDe7rswOfSHfFU=;
        b=C6y1l2pry9W5jC8gMQqyEXs572O1glS7gJwNi5E5Pev3o3fsisHScTM0QjjoEJ4UIc
         q+dXK/EnfJdMD0KGixsCI/tc7DwWwOrMLeB5IWNAEUum9mqVmBb2EQUvqu+GHhNisDP4
         wTJGdbOSOfv10TFbp69zQ+kzsjpMSfaFK6hliupd/RXptVPOclpIHN4ON1CBiGwmfbIV
         eMLIK/GJdvW4bfnY6+m1YuwbTDajAVyLr10mfZv5eV0OhzlsBqN2Qh44Dr/gdhsP5k+Y
         TkXVulmHTkhXdURBZwGvOu9avbrR08xNr2xqvRmt0v/7YkMLxpGq9en9VU0BeDn/wCf1
         JJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793231502; x=1793836302;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9aqlUca5Z2Dix4R9/uyjhIevl9A0MEDe7rswOfSHfFU=;
        b=GVAllYCebrFYLzh4FJYOisHMwSeZFyfo9Cpi1q+cPE5thREctSBsXQl51pgnkvs6ec
         gxHrZf4Ey0w9MFnE+8INJpj2z0fGQcdrmqrpRnZ20UEvJjpctXoDj24e4BNnSX1AnABB
         aTa2PaQt9O2WFVIGdCO038kN6rZFHzza2qKzdXHHNNwgsdi1KWB+5yMg3Iy1jA9jJ7YI
         KCJcEbHQgaorXIAeM+215snqQw1UaVLbmj0wq4P7GoEgFubDW4qvF2nHwa3TexRBTHjN
         R+cuwQTjAcyD9IJx78hIcRUq6ZB1fk+0CTwF7Dl4B8cotn/GiqjiwgYAyPVAyQUjU0do
         v1jw==
X-Forwarded-Encrypted: i=1; AKwUvBxWOH37DDCOvQpBDs73tjOtEF8muxiIHmxNoESKY9hIOjO0U6V7liB4ReVM9XdqlUf0WkxQvswz/zPOqiVq@vger.kernel.org
X-Gm-Message-State: AFq9FYJTnsBPsidopwHbpbHsm2PR2PghvkhyB79OOIfgmWPlGWynsGTf
	AooTdgswOEwk+znN28f2vi2aXNTOa3qnOT+TjkH7HqAx2A/Mh9eqeRfPWh72O4ho8j4=
X-Gm-Gg: AYBFou3r9cf2N3W4gBpOQ0oP2MxJ2jvIMk67sZyZ4xTNdz3fYx9l6XxxFx4DRrWSBTC
	Hgt6LLPgbO2ZA+9ivYRxBwl5fREYZP1xxsU1A+N5fdC//uI9pMb+jUilAmzz3Wd0aiyRd8CFrou
	yj3rUJO2BR3NowyymD4OM6FgCnNplsWuRbe54YnP0tAVPDAjYd9f0NpTNmioDbFO4fe8//Hbcv+
	NnkgJ0oCijf6c5xu2IHRhbuBUUQQXOrzL0nQEwUtUkt4GaOvIVOW0RAMaLzrhurXQSbWkvI04ID
	3jExSO+NgH0UjjZEuaXi4DOIdeiFYW6QvcNATTP3kT+yrqoKTtOb/JrxxzfCETZFsKU/BLGpBuy
	5U7mwBEg14i4r9xD9Cc0ag+f1bzyn0CXPNds5QmAo2thMTMW8VPh5aNijnKoTawx1r070NLqBY0
	KsRfG5GZUUxvnYfjIjfgr2UG2jiue9pyrFr9lK8HQB8ge69/J1NDSV5lzBad/rwKwHZnMWOChg3
	dMB/opbJ+2gcXVmnVqYGQN68TR4s6aIVkCYuHqq5PPVmyB4V+Jj0Fbz8JildM5+NoyYMkarLBLv
	FndBZd2umR7eDmfgAZXtNb0eO7tE+5PCuRgIfTTfbF9i10BVKQdftWJ0VwiP7xxDS7tvkHVwxdU
	a0xg=
X-Received: by 2002:a05:6820:6204:b0:6f6:5595:915e with SMTP id 006d021491bc7-713ee85fbbemr3135112eaf.1.1793231502506;
        Wed, 28 Oct 2026 16:51:42 -0700 (PDT)
Received: from os-N5J97HY9XQ ([208.184.142.138])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71426f16f66sm2615609eaf.0.2026.10.28.16.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 16:51:41 -0700 (PDT)
Date: Wed, 28 Oct 2026 16:51:38 -0700
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
Message-ID: <auKKisespDm1xLLg@os-N5J97HY9XQ>
References: <auAmuqZyUodq3iqk@chrisdown.name>
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
In-Reply-To: <auAmuqZyUodq3iqk@chrisdown.name>

On Tue, Oct 27, 2026 at 12:21:14PM +0800, Chris Down wrote:
> /proc/kcore lets any process with CAP_SYS_RAWIO read all of kernel
> memory. That's a pretty large read primitive for anyone who obtains
> CAP_SYS_RAWIO (and it also gives away the KASLR layout).
> 
> For this reason on some hosts we want to turn /proc/kcore off. However,
> on a kernel built with CONFIG_PROC_KCORE=y the only ways to block it
> today are lockdown=confidentiality (which also disables many other
> things we perhaps don't want to disable), or LSM. That's annoying,
> because on the majority of hosts we do want it on for things like
> drgn/crash, so today we build two separate kernels.
> 
> Let's add a "kcore=" boot parameter so that this can be disabled at
> boot.
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>

Hey, Chris,

The code looks correct, but is there a reason that /proc/kcore
(CAP_SYS_RAWIO) is any more concerning than other ways to read kernel
memory (e.g., CAP_BPF + CAP_PERFMON)?

Thanks,
Omar
