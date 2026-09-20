Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289A3175A95;
	Sun, 20 Sep 2026 03:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789876403; cv=none; b=Z0gBXOi+LK25aYSTP4gpwXlBVApMhICtE/IGa5t9VHRPSbCSs8G8kIucN6sLhOBnZyP2mow7VRdbgrKZNf4f2F9LIwLXugqulW6BXuRdlMaWGbp5BsFnwUypBjWazosbp5dsJ0XydY6vbeQLTDIYMqBD2uGTAlVOn9D0VEl2Jes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789876403; c=relaxed/simple;
	bh=k2L4g+5YFCXxxft5ZvUMFRHA8kcSLTON1PROu97WIJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uo82VnhH+Nfgrugm6ptHft2PrtOIjpB0trxzraq1ehFw5alhb+OrQ1JmKnoiE2RE7h87w+oXTsP1OANK/N4fc3ODtmZrtVQb83Q+YgkIuQLXCQ4ThdOU2C+TTGZPSaVVFjffiVmp0Hsm4TTL+eiekmUHMhV2WAK9TEZOU1ureqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=rF0Ks1OV; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="rF0Ks1OV"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=tlRuK8oy4p5tnkX98fUn+MG7+GepzpfRQqepp1VDdiI=;
	b=rF0Ks1OVp5HjgPVdwO3vQJK5rTKW6B2t+TaIafWOspsRr/x2OEimEnA3Y1/krDlFP7+YZPvyG
	wJIUAx17deeeASsWoW/3sf4A4bz6SS6FzoZgdnjTbEsn+xbijr4z/yaIvZIjme1/WUcWKbfgM22
	Tv7akItYW11zMpSyr8HODo4=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4hnXHF4MH5zLlWt;
	Sun, 20 Sep 2026 11:42:17 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B33A40565;
	Sun, 20 Sep 2026 11:53:18 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemk200008.china.huawei.com (7.202.194.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 20 Sep 2026 11:53:16 +0800
Message-ID: <a6772b15-0229-40f3-be55-0d9ed229c0a1@huawei.com>
Date: Sun, 20 Sep 2026 11:53:15 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/17] arm64: crash: Add crash hotplug support
To: <sashiko-reviews@lists.linux.dev>, <tglx@kernel.org>,
	<ritesh.list@gmail.com>, <mark.rutland@arm.com>, <chao.gao@intel.com>,
	<kas@kernel.org>, <linuxppc-dev@lists.ozlabs.org>, <yeoreum.yun@arm.com>,
	<x86@kernel.org>, <baoquan.he@linux.dev>, <hbathini@linux.ibm.com>,
	<sourabhjain@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <jbouron@amazon.com>,
	<dave.hansen@linux.intel.com>, <rafael@kernel.org>, <coxu@redhat.com>,
	<akpm@linux-foundation.org>, <gshan@redhat.com>, <vishal.l.verma@intel.com>,
	<ruirui.yang@linux.dev>, <seanjc@google.com>, <bgwin@google.com>,
	<chenhuacai@kernel.org>, <pasha.tatashin@soleen.com>, <kees@kernel.org>,
	<me@linux.beauty>, <npiggin@gmail.com>, <maddy@linux.ibm.com>,
	<thuth@redhat.com>, <graf@amazon.com>, <palmer@rivosinc.com>,
	<chleroy@kernel.org>, <guodongtai@kylinos.cn>, <zhangtianyang@loongson.cn>,
	<eric.devolder@oracle.com>, <catalin.marinas@arm.com>, <leitao@debian.org>,
	<driver-core@lists.linux.dev>, <piliu@redhat.com>, <kernel@xen0n.name>,
	<dakr@kernel.org>, <pratyush@kernel.org>, <sshegde@linux.ibm.com>,
	<tangyouling@kylinos.cn>, <adityag@linux.ibm.com>, <rppt@kernel.org>,
	<mclapinski@google.com>, <takahiro.akashi@linaro.org>,
	<linux-arm-kernel@lists.infradead.org>, <will@kernel.org>, <ardb@kernel.org>,
	<gregkh@linuxfoundation.org>, <lizhengyu3@huawei.com>, <linux-mm@kvack.org>,
	<james.morse@arm.com>, <linux-fsdevel@vger.kernel.org>, <mpe@ellerman.id.au>,
	<mingo@redhat.com>, <bp@alien8.de>, <blum@kernel.org>, <robh@kernel.org>,
	<hpa@zytor.com>, <liukexin@kylinos.cn>, <maqianga@uniontech.com>
CC: <kexec@lists.infradead.org>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-18-ruanjinjie@huawei.com>
 <20260918103657.0CC341F000FF@smtp.kernel.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260918103657.0CC341F000FF@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk200008.china.huawei.com (7.202.194.74)



在 2026/9/18 18:36, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] kexec: arch_crash_get_elfcorehdr_size() exports undersized buffer when MEMORY_HOTPLUG is disabled
> --
> 
> commit fd293f9cfd1a12554d9352f4ad58fc9f85721fa3
> Author: Jinjie Ruan <ruanjinjie@huawei.com>
> arm64: crash: Add crash hotplug support
> 
> This commit introduces kernel mechanisms to update only the elfcorehdr
> on memory hotplug events for arm64. It adds ARCH_SUPPORTS_CRASH_HOTPLUG 
> and implements arch-specific functions to handle memory hotplug, avoiding
> full kdump image reloads from userspace.
> 
> Link: https://lore.kernel.org/all/20240529133446.28446-1-Jonathan.Cameron@huawei.com/
> 
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index b5a51b0ef9440..96de2660b1cbb 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -1720,6 +1720,9 @@ config ARCH_DEFAULT_CRASH_DUMP
>>  config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
>>  	def_bool CRASH_RESERVE
>>  
>> +config ARCH_SUPPORTS_CRASH_HOTPLUG
>> +	def_bool y
>> +
> 
> [Severity: High]
> Does unconditionally enabling ARCH_SUPPORTS_CRASH_HOTPLUG here expose an
> undersized buffer to userspace when CONFIG_MEMORY_HOTPLUG is disabled?
> 
> Since CONFIG_HOTPLUG_CPU natively selects CONFIG_CRASH_HOTPLUG on
> architectures that support it, having this default to 'y' allows
> CRASH_HOTPLUG to be active even without MEMORY_HOTPLUG. This leads to the
> size calculation issue below.
> 
> [ ... ]
>> diff --git a/arch/arm64/kernel/crash.c b/arch/arm64/kernel/crash.c
>> new file mode 100644
>> index 0000000000000..08dc9b952498e
>> --- /dev/null
>> +++ b/arch/arm64/kernel/crash.c
> [ ... ]
>> +unsigned int arch_crash_get_elfcorehdr_size(void)
>> +{
>> +	unsigned long phdr_cnt;
>> +
>> +	/* A program header for possible CPUs, vmcoreinfo and kernel_map */
>> +	phdr_cnt = 2 + num_possible_cpus();
>> +	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
>> +		phdr_cnt += CONFIG_CRASH_MAX_MEMORY_RANGES;
>> +
> 
> [Severity: High]
> Is this calculation missing the static memory ranges when
> CONFIG_MEMORY_HOTPLUG is disabled?
> 
> If compiled with CONFIG_HOTPLUG_CPU=y (which natively selects
> CONFIG_CRASH_HOTPLUG) and CONFIG_MEMORY_HOTPLUG=n, phdr_cnt is computed as
> exactly 2 + num_possible_cpus(). This does not account for the mandatory
> memblock ranges from arch_get_system_nr_ranges(). 

Will fix it in v6.

> 
> Unlike x86 or powerpc which might survive this due to heavily padded
> CONFIG_NR_CPUS_DEFAULT values, arm64's precise num_possible_cpus() leaves
> zero headroom. As a result, the exported maximum elfcorehdr size is strictly
> smaller than the required size to hold static memory ranges, and any attempt
> to arm kdump (kexec -p) will fail because kexec-tools cannot load the crash
> kernel into the undersized segment.
> 

-- 
Best regards,
Jinjie

