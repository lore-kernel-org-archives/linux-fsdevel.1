Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E19052FE55
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788868094; cv=none; b=PIwGV774eT7vNszNh/+eiH+usFSMdTXOrbMEbBw6RwvM21+EHmNCQJJ/ncbUVz7FTSCK5JGONp0P30I32hMpj5WHMU7vrBpJaK/qGLFHeBWXCGRtYeA7y6CP99SloqQefsRjVmz8Zn2UIMAHuBurTR+R6dhcMA+Hvj7g4JmSHew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788868094; c=relaxed/simple;
	bh=CbC0+8uE1OCrfARV8oiwlbKpRtyXFAAlksVshEy5apw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CyGXBHJS26xz7Wjk4zw5/dUE54tG/BcdZJ2Hl7Nym7mWjg64O8jX8gGCC2liNAFnD1jbFftQ0V8NA6i0PkIwwa37OjCxFTNap1VWbfzYNgTErhTXQetQJMIlj6nXWioNwPGvTFosjeyBBMAxGn61fm3LhKBQ9e+OOuTC1bOylRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5eGbNc8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5eGbNc8"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49cca4ffdcfso37200485e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2026 04:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788868085; x=1789472885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JBTbkbKWNVRl47tMAjR1GYFqBM0RP6XFGBtroaym4bw=;
        b=j5eGbNc8SHT821Oei3cTsGx+FmvTyiIflUEX4oF/CXt+xrqkoGrABoAYiHcZY4D6j9
         EghEC/zxEORtAKxw2l1C5A35gHlGuuUKzrG+8dvwiaylxo6CBqqb6teUbMvpWQ1SXUtO
         aU6pZNxGz3RPcFc2zmuasQF3nnmmrW32wBLc3b6JN89prRUhvs75niC6/IsiiX4vWX7x
         ehq2qBysoDeA32TmyF0Swla59pWjbRM8uoTq5v+tYxYFnblnyorbzcbPZ6j8UbceQ1pr
         3NHYst0pOKVpzudxB7vdatnphP8ru5QZm+yQ8vwL5XVfYAN9QlZ2MzsRZXtODYBNW7JK
         j/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788868085; x=1789472885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JBTbkbKWNVRl47tMAjR1GYFqBM0RP6XFGBtroaym4bw=;
        b=TWc/7fajxsx+EtrIv3zB59CywusFzGDlnsfCl1ckU7e/WPRuxcXrMlnfLYFZDLgyKR
         sv5/q07BPTLy9UuSbU7YJBNSkYxHKyHH8+DdXVfA5UM6UDyYCoBrl0UbcPGIpUHMbdxc
         Em+mtbz/uE23Jq7aQppyIigFJAXW443s746gSyzVOpMS6ALYOhtEV7Vpne2UvyZ+aolJ
         b6YzEUmm9+TEVlSdm4S5RMBQOQFlNZ6axK6fFPztn1YaFfizS4e3wwHuYlTB50g+Ikmr
         UKGuKtuIl9JfTFQ4UT/2Gtp9JPe9RvE7FXwK7eH/cl0MaABlwUow4uV10j7KdVgphFnL
         SwFg==
X-Forwarded-Encrypted: i=1; AKwUvBwcMrnFkixVvT/P9fv4mrqQre3rrFwW5tJCUn8aK4EpfinpqURFJ8ZFd5eeUE47ZL7BJNAM+ydrLE1FkvSm@vger.kernel.org
X-Gm-Message-State: AFuF++kaOX8NBChOgM8jJRqaErKcsCavpnPTZcpvD+N7F4Jq4ayMm0vB
	bCH2hY1Fmj3cIKPeczaUE/3jlVt0kG6CopuZBbviIHstIZXEXf4RahSL
X-Gm-Gg: AYBFou01Y4tUEAeLygprFwnJU6+xClTUTEKehqLXO6ITzvHKNmapFWmRVUOUqJM9zaf
	3vy035S4dhOnYqGQoKVqff1LKA7JSS3i3Ks8181Q7RfC1k14c2Xu2JaP5j4gmzRqP27Vg0NjTLO
	Fn+EnEnoxWdkkHZT0U/ZcAo5npZpq25EEl6Izyk7ta6wHD7o7qkX5aok7xotdeuFLuQ9wRFFcnP
	7STm4AqfIBu0FgffUdyA1qjQo9b3d4oKUQ0+oojTh+OkZc0e+CZfQ/wpXVi6nDr0VGAv69xSqCI
	8HcdhYW0Px2sVLqjWVIt9qJeynznUsbEyjrEcv6CZwFNd66SasA8d5N5HRvbunXdye3k0oLYDRz
	6VqRIXfzbkmO62HwfYmZH2oUuVXeJsJ3E3MD/hp6gvo456U+hRML9InA8BH5eYISWfdhXiEbeJA
	BM9ts4Jhwjw9EvskV3jO6V2DCl4+uqitKWQ8F9FoAdBKrT6PEUdr2ctsALrM0BhTK3skX7L9Eu5
	w==
X-Received: by 2002:a05:600c:b95:b0:49d:174e:2a1e with SMTP id 5b1f17b1804b1-49d174e2a5fmr67747665e9.19.1788868084791;
        Tue, 08 Sep 2026 04:48:04 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5f:900:ef25:2f4:1792:4e6f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d04fe7f9dsm288511555e9.0.2026.09.08.04.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 04:48:04 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: memxor@gmail.com
Cc: akpm@linux-foundation.org,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	daniel@iogearbox.net,
	david@kernel.org,
	eddyz87@gmail.com,
	kpsingh@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	matt@bobrowski.net,
	song@kernel.org,
	sun.jian.kdev@gmail.com,
	tasos.papagiannnis@gmail.com,
	utilityemal77@gmail.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH bpf-next v5 4/7] bpf: Allow reads through trusted-or-null BTF pointers
Date: Tue,  8 Sep 2026 14:47:36 +0300
Message-ID: <20260908114736.5342-1-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <DL9V0Y6BPZSY.3J1EXVDXSHRFO@gmail.com>
References: <DL9V0Y6BPZSY.3J1EXVDXSHRFO@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the review!

> We tried doing this before in
> https://lore.kernel.org/bpf/20241104171959.2938862-2-memxor@gmail.com and it
> got reverted, it broke all sorts of things and made everything more complex.

Out of curiosity, what were the main issues caused by that change?

> I would drop this hack and just fix the program. Given your earlier change to
> annotate the field correctly, I am puzzled why you added this, and there isn't
> any description anywhere explaining why.

Initially, in v1, I only marked linux_binprm->mm as trusted-or-null in [1] where 
I also needed to update a test. But I got an AI review comment in [2] that this
change breaks the BPF load-compatibility guarantee documented in 
Documentation/bpf/bpf_design_QA.rst.

For this reason, I took a simpler approach in [3] where Andrii commented in [4]
that we might want to look into having verifier still allow to dereference
trusted ptr-or-null into untrusted ptr_to_btf_id to help with smooth transitions
like this or just marked linux_binprm->mm as trusted-or-null (ignoring the issue
about breaking the BPF load-compatibility guarantee).

So I tried the more "risky" approach first. This was the full story behind this 
change.

To summarise: are you ok with removing this patch (and the next one with the tests)
and fall back to something like [1]?

[1] https://lore.kernel.org/bpf/20260811112154.94053-1-tasos.papagiannnis@gmail.com/T/#m295ed4ae8a717ac4cdf536585f150590faa2c40c
[2] https://lore.kernel.org/bpf/20260811112154.94053-1-tasos.papagiannnis@gmail.com/T/#mc0865ac61ab3ffb1acb720e42b35ea65469442b5
[3] https://lore.kernel.org/bpf/20260820131801.68759-1-tasos.papagiannnis@gmail.com/
[4] https://lore.kernel.org/bpf/20260820131801.68759-1-tasos.papagiannnis@gmail.com/T/#mf5cd6a81c2e8231999ed2e4b991e060cfc4ca7d9

Thanks,
Anastasios
