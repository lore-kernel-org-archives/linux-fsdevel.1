Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89EE3909AB;
	Wed,  2 Sep 2026 06:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788329748; cv=none; b=swl16xCcZAHcaApIqtYX36HgNvdBg1DVdmaGdNt+RQ0/A0KOwci/tu88o41R9CR6nMEIOhhS6G67X4ioJGtS4pApExlEws1jzPkv9Ot0oCc3qhvetPSibFZ8KuE/4Hh3aXAaLIZL5g4U2ehv8f8Xxm7vq3NxXJg6ENt6v7uWK88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788329748; c=relaxed/simple;
	bh=l6ErtK5n1RkoHlNKk2dyv8TZ6wSIaXf/OtWGVJsnctA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lqZYigiqo+pKMyEngluk2/tXLX0ZaxKx/VaTko+ssVLDNWNLSu8dwHD/72bQCBBAAwS5icCk9Yq9t+dI+e/fHh0FKh3tSozd+hKoG+kbZnZ4DVvgTMSQ7g2pe/216LyT2iEZOPHcXrPepxR9vhrmEAn4APPEhIz1FGtiX20JjAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mkz0Ej3I; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mkz0Ej3I"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681KWTNe2236382;
	Wed, 2 Sep 2026 06:14:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Wy2nNr
	PGbWGo3ADF6c0g7M/9wKsqbVRXkL3EdgLoY5E=; b=Mkz0Ej3IL42re55o5clvci
	m5sLW34Bmyn8MkOM17lS4YlZZzN8N/55iwE64ZL3IOux92zveotmnDaQxRO6+0DY
	ijfFYgKh8rMe5VTIAvWXEv6BYMr/SN6COHTtzk+MTy4phtui3rgzEQsFCrwUq4/F
	4azaFeJFlgep6K/v37YIq/WK6XxbbzXXoBDW3CqdjOuRxkZdHjHKB3v7lYTHS37+
	82VGEIGnwcACNBVxhVgj2o0XDRjF20WY7DxwlIHO1HKtBzfpf+y1zF776niZ7vKk
	m8fNO6vjjOVR2u08YCnGV/nQMJ60FjplzTJThUv2JtflTDwVl7qFuhERwjLhov5Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5mp0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 06:14:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6826BQ5b003789;
	Wed, 2 Sep 2026 06:14:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rqg949-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 06:14:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6826Egd451315162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 06:14:42 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 805CD2004E;
	Wed,  2 Sep 2026 06:14:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A4662004B;
	Wed,  2 Sep 2026 06:14:31 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Sep 2026 06:14:31 +0000 (GMT)
Message-ID: <99b1121d-4277-4764-8c3a-b3f6d9a47ab0@linux.ibm.com>
Date: Wed, 2 Sep 2026 11:44:30 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/17] x86/crash: Use num_possible_cpus() for
 elfcorehdr size
To: Jinjie Ruan <ruanjinjie@huawei.com>, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org,
        kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, tglx@kernel.org,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, akpm@linux-foundation.org, baoquan.he@linux.dev,
        rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org,
        ruirui.yang@linux.dev, kees@kernel.org, thuth@redhat.com,
        gshan@redhat.com, jic23@kernel.org, james.morse@arm.com,
        ardb@kernel.org, leitao@debian.org, yeoreum.yun@arm.com,
        coxu@redhat.com, tangyouling@kylinos.cn, hbathini@linux.ibm.com,
        adityag@linux.ibm.com, ionut.nechita@windriver.com,
        liaoyuanhong@vivo.com, seanjc@google.com, fuqiang.wang@easystack.cn,
        makb@juniper.net, piliu@redhat.com, ebiggers@kernel.org,
        jbouron@amazon.com, mclapinski@google.com, me@linux.beauty,
        graf@amazon.com, bgwin@google.com, robh@kernel.org,
        takahiro.akashi@linaro.org, palmer@rivosinc.com, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, ionut.nechita@windriver.com,
        ionut.nechita@windriver.com
References: <20260826092541.3905933-1-ruanjinjie@huawei.com>
 <20260826092541.3905933-13-ruanjinjie@huawei.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260826092541.3905933-13-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a97bed8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=i0EeH86SAAAA:8 a=GuF16Tie-v_x1sUWD14A:9 a=QEXdDO2ut3YA:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: -IqDSf4F0FmOcL5Q3XCke1kr2YbwNiU1
X-Proofpoint-ORIG-GUID: KEmbHgCI7d9accZnEU6C4HI8egT2297V
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA1MiBTYWx0ZWRfXz2AuISrj25WT
 313Gdb0AKNnpWXJG+VJ95H+6kugoqcFZFisjytZwvIlWZ4y/Fd0LECR39q8SwiorgwEdibQqAYI
 wha1fu/nY7Cg/2E+X5ZeponvB/5ACF0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA1MiBTYWx0ZWRfXywQtEgYZYNk7
 cAqCvDEwmxa2P2+rYvcX2LG0pVzZzBJixP7ujsGQlTI5b56QNy0fPGFIXZMj+cVXzQG7Txxj1tf
 JPp8WOZ9w+FSiQrwdM7zf1VfRstGyWgKWYR2YfDKwM/n6HHjI8mlm47PH8DAH3oBtlnst4y4EgI
 O2iserNtjKc0LQsu1b+WMjHcVjhP8zbdaOLjWjXP1WEClXE3IiAwoHGMsbCInx3NnX0P4B4fUVo
 Wp/rseWaWYYL+GNuKgYWDo8mENynCYHP2WrKTu0jPKTzj8UWdhrBRrhv7J5H4lBnON9qmao1sD4
 A9USHe9k2hKpbjFcfVBv39HELqFwUfZZCoI0tb/+RLn8KRh9ZcxWC7wNKAkmeDd5w2s50jq6y2k
 bHRHLckUiG6jolF3WbzbH9sgRTtOC+kxTtJnqKEc8VkHs7KeRTij3Mfz+X9Os4dMFuci7HUb9A6
 QIIMpPWSJS9r0ZIR48g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020052

Hello Jinjie,

This patch makes the below patch redundant..
https://lore.kernel.org/all/20260826073527.21487-2-ionut.nechita@windriver.com/

I suggest dropping the first patch from the above series and including
the second patch from that series in this patch series with the updated
comment.

- Sourabh Jain


On 26/08/26 14:55, Jinjie Ruan wrote:
> Use num_possible_cpus() instead of CONFIG_NR_CPUS to calculate the
> elfcorehdr buffer size, matching what crash_prepare_elf64_headers()
> already uses for the actual header content.
>
> This avoids over-allocation when the system has fewer possible CPUs
> than the compile-time limit, and aligns x86 with PowerPC.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>   arch/x86/kernel/crash.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index a3bf786286d4..afe2aea19f47 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -369,9 +369,9 @@ int crash_load_segments(struct kimage *image)
>   	 * maximum CPUs and maximum memory ranges.
>   	 */
>   	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
> -		pnum = 2 + CONFIG_NR_CPUS + CONFIG_CRASH_MAX_MEMORY_RANGES;
> +		pnum = 2 + num_possible_cpus() + CONFIG_CRASH_MAX_MEMORY_RANGES;
>   	else
> -		pnum += 2 + CONFIG_NR_CPUS;
> +		pnum += 2 + num_possible_cpus();
>   
>   	if (pnum < (unsigned long)PN_XNUM) {
>   		kbuf.memsz = elf64_phdr_size(pnum);
> @@ -429,7 +429,7 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
>   	unsigned int sz;
>   
>   	/* kernel_map, VMCOREINFO and maximum CPUs */
> -	sz = 2 + CONFIG_NR_CPUS;
> +	sz = 2 + num_possible_cpus();
>   	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
>   		sz += CONFIG_CRASH_MAX_MEMORY_RANGES;
>   	sz *= sizeof(Elf64_Phdr);

