Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD563203B4;
	Wed,  2 Sep 2026 01:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788311978; cv=none; b=hs+G3w2LEWkmoWrU0saKfRN1Pt8xGIhqJSkfaLg+hr/36GshyfdMsJkgf80BySvSsraZn4mXQgILTqySKSJtgPlqckmSiKWggJCsm/a3BNirpZ32hFV5jtOKxAUDRMkdQu88wmgH9KjTp5xoHufrgjYBIMOPCbAuQnlYDk30WAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788311978; c=relaxed/simple;
	bh=f5REgvRgB104gi7Q/Ht1y8hYSaZQqWvQDTdb/bNo3qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eCMHR59hkCu1KoXVyqXMpwZI2wKAQBUiNZM1RFffU0RDB4bwAbr4qSpjfIUfr8jox4x9KLK3DZIMY9+uxFgwMj8NvC4k4WGECm0b1pBQlU/bcn2jIeEUACjwIg4NkEuRNHZWa7iDNstZy79IgLvKPSOLa1z0+mVcAZkbm4v0JwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=JSc/QrUE; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="JSc/QrUE"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=t9UK13JKhSsPM/Vc9steoJSl+OnutIzRnlZukeamK+o=;
	b=JSc/QrUEAnbPE7s6EK6aHXX4FMrI/ak+7N46GxWAYjo+hv4+e8IRFqw3R57vf10ZXvwgmTnw1
	5LsKKvi+A3v/zJR4bWOVaYI3bbjz5k4AHVvkI67n+bm/COW12+QwJBDOanQFb2mbBv/tq3BctvX
	qaDBA0HnMSM+ut7AmVDhzas=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hZPjt2PDTznTVd;
	Wed,  2 Sep 2026 09:08:18 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id B4C9C40565;
	Wed,  2 Sep 2026 09:19:31 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Sep 2026 09:19:29 +0800
Message-ID: <96ba8924-b857-4dbc-9161-4c464901f974@huawei.com>
Date: Wed, 2 Sep 2026 09:19:28 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/17] crash: Simplify CRASH_MAX_MEMORY_RANGES handling
To: Mike Rapoport <rppt@kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<baoquan.he@linux.dev>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<ruirui.yang@linux.dev>, <kees@kernel.org>, <thuth@redhat.com>,
	<gshan@redhat.com>, <jic23@kernel.org>, <james.morse@arm.com>,
	<ardb@kernel.org>, <leitao@debian.org>, <yeoreum.yun@arm.com>,
	<sourabhjain@linux.ibm.com>, <coxu@redhat.com>, <tangyouling@kylinos.cn>,
	<hbathini@linux.ibm.com>, <adityag@linux.ibm.com>,
	<ionut.nechita@windriver.com>, <liaoyuanhong@vivo.com>, <seanjc@google.com>,
	<fuqiang.wang@easystack.cn>, <makb@juniper.net>, <piliu@redhat.com>,
	<ebiggers@kernel.org>, <jbouron@amazon.com>, <mclapinski@google.com>,
	<me@linux.beauty>, <graf@amazon.com>, <bgwin@google.com>, <robh@kernel.org>,
	<takahiro.akashi@linaro.org>, <palmer@rivosinc.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<kexec@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>
References: <20260826092541.3905933-1-ruanjinjie@huawei.com>
 <20260826092541.3905933-16-ruanjinjie@huawei.com>
 <178829364021.3691424.12328056849597833403.b4-review@b4>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <178829364021.3691424.12328056849597833403.b4-review@b4>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)



在 2026/9/2 4:14, Mike Rapoport 写道:
> Hi,
> 
>> Set CRASH_MAX_MEMORY_RANGES to 0 when MEMORY_HOTPLUG is disabled, then
>> remove the now unnecessary IS_ENABLED(CONFIG_MEMORY_HOTPLUG) checks in
>> powerpc and x86 arch_crash_get_elfcorehdr_size().
>>
>> No functional change intended.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>>
>> diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
>> index fc0105c7af4c3..c47e3f867ea1f 100644
>> --- a/arch/powerpc/kexec/crash.c
>> +++ b/arch/powerpc/kexec/crash.c
>> @@ -474,9 +474,7 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
>>  	unsigned long phdr_cnt;
>>  
>>  	/* A program header for possible CPUs + vmcoreinfo */
>> -	phdr_cnt = num_possible_cpus() + 1;
>> -	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
>> -		phdr_cnt += CONFIG_CRASH_MAX_MEMORY_RANGES;
>> +	phdr_cnt = num_possible_cpus() + 1 + CONFIG_CRASH_MAX_MEMORY_RANGES;
>>  
>>  	return elf64_phdr_size(phdr_cnt);
>>  }
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index 99eb8583d9321..116410ac90fb4 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -407,9 +407,7 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
>>  	unsigned int sz;
>>  
>>  	/* kernel_map, VMCOREINFO and maximum CPUs */
>> -	sz = 2 + num_possible_cpus();
>> -	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
>> -		sz += CONFIG_CRASH_MAX_MEMORY_RANGES;
>> +	sz = 2 + num_possible_cpus() + CONFIG_CRASH_MAX_MEMORY_RANGES;
>>  	sz *= sizeof(Elf64_Phdr);
>>  	return sz;
>>  }
>> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
>> index a97ed9605602f..e6251dfe451a8 100644
>> --- a/kernel/Kconfig.kexec
>> +++ b/kernel/Kconfig.kexec
>> @@ -160,7 +160,8 @@ config CRASH_HOTPLUG
>>  
>>  config CRASH_MAX_MEMORY_RANGES
>>  	int "Specify the maximum number of memory regions for the elfcorehdr"
>> -	default 8192
>> +	default 8192 if MEMORY_HOTPLUG
>> +	default 0 if !MEMORY_HOTPLUG
> 
> This only sets the default, but a user can change the value explicitly.

You're right. Let me drop this patch for now. Thanks for the review!

> 

