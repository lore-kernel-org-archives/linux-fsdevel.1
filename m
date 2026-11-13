Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575453;
	b=2757CVIlHYI0e0CIZJBR2Z93ArfUOGsyp+XQKsdMKtuRvlxyWmzNxXJLbfCFx/+sI5Jm
	 xosig2K6+MhxpYehi2gGUbeIRkMDnDqund0fy3m4lqBh5W053KIus54ws7tpwuPxppu5o
	 gGkkqxhDOyYhT51HtKFkg/kDSSuqOGxAiTnrjOv/FmS5Fsm6qws2jM6OWzGsQRlBJKIla
	 wI9GdXNk5YLKuO/XGqJjI6B2UdxRuNh2GML8+vbeFnx4dQgFpTzJCE77gPo4uL1gf+zzZ
	 Y0mcWzTtyLhYXakCfBciE4IBNo+1foSXFw8ukf9/mEBh/pdslAkYgCrmxbKKynSaM9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575453;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=nyqomyE9IaTnWcHXD7xgVXcroRKHI5LRLGx0VC0Seac=;
	b=4PEfremZSQb+mmm0LNL9ICchaSAbQ5IoO3DaHDV1LfKjV7ibkHRDUsd6d+mUcjZrt3sI
	 Dt0eXUVyTAD05BPn40NwjZX+U88qsumo+KEbXmK4vC2krhTDa1MicYjI69kGwm1xss+hR
	 8m8wxiszFC1aYXG+PkKM3OoGbYN8mxY0r9SZOBuURBWAFomHMwyuNsZqONIneWe3i0ugT
	 4JDrAa5eGRxg1nSwRwtbRRziMO15RVqvw2c66XvnvXunU321K3YRu/0HGtaMwqynEeFt1
	 f0zykKVyU/SjS7Sx1r3LBeYl75MEsgIm/2+d+NVL+Q8jUZI5Ai10JuhsbJNk/dlUgLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=sbTcmsFJ;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BC2606A323;
	Fri, 13 Nov 2026 13:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16BC2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=sbTcmsFJ
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EB7D1476;
	Fri, 13 Nov 2026 05:10:49 -0800 (PST)
Received: from [10.43.20.13] (e126510-lin.lund.arm.com [10.43.20.13])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C06723F85F;
	Fri, 13 Nov 2026 05:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794575452; bh=PxMSWbKumi+5IEd8i1L5GZ4IzKZsJLzAs3xOsqzbfmM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sbTcmsFJMpts29O6tAJPa43dXPd92HoEFcjocaBeUJ7YTVioWzMEw9FWJYoO2/le/
	 XeRfOCHXUtAFFCs0vpWmnW2HDsyrZZMquQDqLss3XpkWsEdmmdhu2eJuROpxV5w95m
	 wBK8xaFMso48fY0jUAcZHqRQcysd6XgoHdyDZ6G8=
Message-ID: <53e509bd-e6ec-4b09-97b7-eaf9aa6b5797@arm.com>
Date: Fri, 13 Nov 2026 14:10:46 +0100
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/proc: proc-empty-vm: handle CPUs without
 protection keys
To: Kurt Lin <lylin1023@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
 Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>,
 linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261109151912.156518-1-lylin1023@gmail.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20261109151912.156518-1-lylin1023@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/11/2026 16:19, Kurt Lin wrote:
> On x86 CPUs without protection keys, pkey_alloc() fails with ENOSPC,
> as documented in pkey_alloc(2). protection_key_support() only expects
> ENOSYS or EINVAL, so the test fails on such machines, e.g. an Intel
> Core i5-7200U:

It would be good to mention that the x86 implementation had a bug where
the first call to pkey_alloc() would return -EINVAL instead of -ENOSPC.
This was recently fixed by commit dee87e09b0dd ("x86/pkeys: Fix
pkey_alloc() return value when pkeys are not supported"); that's
probably why the issue appeared only now.

-EINVAL is technically not an expected error in this situation, but for
backwards-compatibility with older kernels it probably makes sense to
allow it for a little while.

With the commit message expanded:

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

>   protection_key_support: error: rv -1, errno 28
>
> Treat ENOSPC as "no protection key support" as well.
>
> An AI coding assistant (Claude) was used to analyze the failure and to
> draft the fix and this changelog. Tested on v7.4-rc1 on the machine
> above; the test now passes.
>
> Fixes: bf5add391eeb ("proc: test ProtectionKey in proc-empty-vm test")
> Signed-off-by: Kurt Lin <lylin1023@gmail.com>
> ---
>  tools/testing/selftests/proc/proc-empty-vm.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/testing/selftests/proc/proc-empty-vm.c b/tools/testing/selftests/proc/proc-empty-vm.c
> index b3f898aab4ab..a9d3c973a663 100644
> --- a/tools/testing/selftests/proc/proc-empty-vm.c
> +++ b/tools/testing/selftests/proc/proc-empty-vm.c
> @@ -77,6 +77,9 @@ static int protection_key_support(void)
>  	} else if (rv == -1 && errno == EINVAL) {
>  		// ospke=n
>  		return 0;
> +	} else if (rv == -1 && errno == ENOSPC) {
> +		// CPU without protection keys
> +		return 0;
>  	} else {
>  		fprintf(stderr, "%s: error: rv %ld, errno %d\n", __func__, rv, errno);
>  		exit(EXIT_FAILURE);
