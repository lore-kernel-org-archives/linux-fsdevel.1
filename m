Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794870890;
	b=xI+wxwrZ2KS7WrPDn6t6JIuns5wM+r4AqlUsMEs8ZLkAajOUOK5jDNPRX0puQHPIxpK+
	 NLA74rDZeXzEbjtqh03OEPPigkKUtfFrGPbhNfB0RqjWjZqUjPP3WwueagJqYTXqicRRU
	 zOt3zUe0v9hAEiPYrbOkcMK4x6qnrClxb4iwUxEys+dW98o0Dp5zKjefrAgpcXrbmd0tE
	 ceaxKrc5hJe8tfQhI829c0KBGVNNnmtctDsosklVY3lInznI/TaDe8SplolPgLOW1+uA0
	 8B/dNa+MfMFbnk68Gd7rn2Y4CnhYnSw65VibXw65r4IGovC7nNlb6vlCh9WioNmIugg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794870890;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=IBaXENMZ5iJzgPOhruOKYZkY/jWJHWgOsTH8WaEBqtw=;
	b=rhqUWu+NMwIY35sZme4FPOAXKkun9r3DctuS50Bk8yH6+7T7rWGG2MQQNE65YfCwQZyI
	 Cho5vafTg+eqHSpHfC7P5scQjgOCmIJMJjEvvnfANXtlFHm/SdLfzhTnl75Yk3BcwXNJ2
	 81S05RuUcEskz17CB15RTYXb8Tt1/nqJxpjvfsd5+2uePTXwbYLzXfLHxUxE3HOqu4kcu
	 caOhVZr6b3qGHchDVqTgEC8SKhGFCljjjfzFZieMvkeUkwr8fLTwY/C/4YYRXiR5LH7wR
	 dP+o01gw/kF7ZwOfgjTGl4vPgnRzAFIcAnNf5aoN+NHzNbGJf3HDO2NGZ3S9AFVM6oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b="Qvu/LNvz";
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=pCDz93to;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D57606A31C
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 23:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26D57606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=Qvu/LNvz;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=pCDz93to
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGLYkBS237730
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 18:14:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=IBaX
	ENMZ5iJzgPOhruOKYZkY/jWJHWgOsTH8WaEBqtw=; b=Qvu/LNvzQdlVIXStaq4d
	19eskLdatEfmi5pLGxcKnYo8l5kOsaQaX2JUwjTB0BZ8OpyfjV28Aue1w7kUDboz
	zI4ShmiWepAsmKYnQOrkRRYqoxkMwgLRQO/aZX2MJXGT3XkbowQcPPjYt9Dm6tUZ
	cbApTydUQZt6ExO1EPrsezc6g40V0InjycEB2XsxZP6V3LNBKQZ5zihIRsW1U0MM
	XKrAuVyIP/HnnuhfBpwPIZc5kWgDYbYCa/J0LjtKmbcJVHTdEMpwzFcNGF/yPVmB
	xD0K4Zs8sQEjDMSW91uOLpo5S7ih9FjJJECeBAlwp9zuK7JdKlyexuPqqCdkNOEX
	wQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j059dktuc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 18:14:48 -0500 (EST)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5364f562140so6958461cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 15:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794870888; x=1795475688; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IBaXENMZ5iJzgPOhruOKYZkY/jWJHWgOsTH8WaEBqtw=;
        b=pCDz93to1q/C40mfWRjKHhQ/GO+oSEPp77VsZqxR1p+ozVJwR+eHIUIMiAo+ybDqte
         raOljD/8fQcb6SgkuSoE/kCB+jkI3Pt0noM5IOVFx8UKyEZ7tcdK66qd6I6kiKNUiOPr
         Ec9aMjjskXCDR5vFSgNhHFwpGfv/YxgUuN0DWFRtkei3ec7m8yj0ApCzKN3MlSpDnhwO
         1h+15WTgvNNnshmwQduNAqGoZnMPuAMtFnN2Xx/yTkVMjsigojWnBHXQZdvS4L+KMspY
         wlwTBVXM4QVTIJzWRTIKedRhrEPI1CRf94VnT/XoKvVPL/vxmqSgFdma9+Ck+t6efXtH
         v3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870888; x=1795475688;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IBaXENMZ5iJzgPOhruOKYZkY/jWJHWgOsTH8WaEBqtw=;
        b=L33xVS0b+57E9FhHw9fomWxO8CpsiD2SUHZ9dydO/7QnACxRiLZRuekovYQVF96Chs
         +7svUcOepdakNfKb0B+3xeD9j1EFw4HJC5CCbW+fQ/l5M1+OPjqlKCg4duyIe1D/sdkm
         FYeq5VcIKpr689KJSFShRUOykl3720zgPg8X391UbbsfSvkMStuC4YU6UoXHsPKtXhWP
         4aga+TupqGAGC0AA7duQQMBRf3D5QwYn3RSkmDeJ3dyHOaHZ34y3mPCsZ/lvtK+vuhNz
         5HUL08iFIDERhqpWJ59W+QzUOEjmfz7udxdWtbqpNwyCy+vvPIYd89z+vxPROysXBZZS
         X1xA==
X-Forwarded-Encrypted: i=1; AL+hErFMKt9qz2/2B0XJ161VbTXopTbiLRqoxmhTggKPE5xAPJuDOEXK9SIfOAa9OEE7hpmv9RfLxOxX6l8ZKVqq@vger.kernel.org
X-Gm-Message-State: APuU4Z/7f9XXQdHEXw0jHt77tUYlmFsV2RXvQrUSxlCEBE6bkRy5I0Nr
	vtJgDtrNt2UoRK76vaDqFj76hSuo7zfr/6Jd/nMlzgpl36CO+nD4uJWOgqHLlqt9hZKqujswJ2E
	rwe9J6MoL55F4E7ux0TTvLUbeFozAjaHkwrsxuWp8RyvduycVuXB/tLlA6HbGKzE=
X-Gm-Gg: AYBFou1lOKoz+4JTgY0tGNuED2Xc0lQELhJsOM7tLFlLxxsDgONE1+7p6xPrvPj73KX
	T/9EgF9kWLH3W76daKltc1j4PburHX4LksFIZfG0YHqPolC1sYzhqMWsrk/eA6fTAg5yfsJM3/j
	C2j79Poz+ZY5njbI1MSf4af1Scs5AvN1HrOTULmQT+EgtTibMI7NmoRU2BFx5Kqzjliy/r0vYa7
	sfy91YfiMPP+HtEqBlJy/oEKM3FCsvkZ6ARV3t7jZAacJa9HwUfV3Xsrc1ZYs80Au30wyB8qm4k
	pA1aymARuueiVDONBfmadtRGXuwnlDNzzOdEgQCGkOWY1onuteq1B3YDV5AvaZRoXHy4Z3qMeQx
	hVSHcdYvn6PlPUMuL/wyMBjqoaRgr2sXlaw9h+YASilMoWAYrCGpjOrGEW0hodTvb1tstVA5n3m
	cLg7neFUP4lQuq9zZKi1zquYzq
X-Received: by 2002:a05:622a:1aa8:b0:55c:216f:38b7 with SMTP id d75a77b69052e-55d494730b4mr16217821cf.35.1794870888187;
        Mon, 16 Nov 2026 15:14:48 -0800 (PST)
X-Received: by 2002:a05:622a:1aa8:b0:55c:216f:38b7 with SMTP id d75a77b69052e-55d494730b4mr16217361cf.35.1794870887543;
        Mon, 16 Nov 2026 15:14:47 -0800 (PST)
Received: from [10.207.2.125] (nat-128-59-176-174.net.columbia.edu. [128.59.176.174])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad043f2f7sm91128191cf.5.2026.11.16.15.14.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 15:14:47 -0800 (PST)
Message-ID: <6d884706-1e5d-45ba-ae02-60c8067c910e@columbia.edu>
Date: Mon, 16 Nov 2026 18:14:46 -0500
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
Subject: Re: [PATCH v2 9/9] mm/userfaultfd: check hugetlb end alignment in
 UFFDIO_UNREGISTER pre-scan
To: "David Hildenbrand (Arm)" <david@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Balbir Singh <balbirs@nvidia.com>,
        "Liam R. Howlett" <liam@infradead.org>,
        Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Andrei Vagin <avagin@gmail.com>,
        Muhammad Usama Anjum <usama.anjum@arm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang
 <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
        Kiryl Shutsemau <kas@kernel.org>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20261116-uffd-state-fixes-v2-0-4397a0196479@columbia.edu>
 <20261116-uffd-state-fixes-v2-9-4397a0196479@columbia.edu>
 <2837958f-5a9d-46ad-b6ff-5a922b09e81a@kernel.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <2837958f-5a9d-46ad-b6ff-5a922b09e81a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: OumxdKgGYAr5zwU10SZbB1yYmh1QvQTM
X-Authority-Analysis: v=2.4 cv=Utf2pOwB c=1 sm=1 tr=0 ts=6afb8e68 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=KPY1cyGZ6h6m4ASiENTC8Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=DH_EvkwUbuc_xQPnRhkA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MiBTYWx0ZWRfX0F1zmMaSCsSA
 k2VXwgx10c4IHEIiIEbZCoboYIKea5Fb+pUTdSNlJ0n0JJRNgjHDyi1fGq45jikw72G6Lq67ZAl
 REh4B7PEKD1una3GSpzV7ALYbnWZi7Y0rVMY1nNjoATB/AncJYklSDK5h42pVAPOAZ8xuNczAUJ
 dVz+4yViyZbaq4o8BlfiK2aMzp52ig790Ur3yC71ROXISWJqC4ArBvuH0prXY4bF0w4tshf5v3a
 s3FdS1xNUpU3qeCShPkEhyQ5E/LfFk/hpkVfxVk4ljDe8NhmGAIlq1cF0jzTeZEZnXAXNAyIQgh
 XlQRsO+jvpQ7x5lvyvJI9psKbKpAeV7rA5dfgJV8JHzA5WzuxU3DsCyhG/yd/UJOLs9dqK+drvx
 4CZFAr7nZwRGQxmRq0sOz3jZrjrgGARgLY9HLurSQ9vj7o5jpRZ35KTjG5p0ahpC1GPc0u7CS1c
 Z//65e3lMk/QERPLh2Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MiBTYWx0ZWRfX6FHSOLbho660
 +xnc06OzN6iRyHwRMCu+3rgozIurJJDmP0XJ4aoFQnUNuf8sx4QAmJIOlgxN8RzsVbN0icbIKlU
 eS3lcTiH/o+Hr8VNKod9PqXe6FzWzrboVwqgzfaoaZt3XXa3fYMt
X-Proofpoint-ORIG-GUID: OumxdKgGYAr5zwU10SZbB1yYmh1QvQTM
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11968
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 bulkscore=10 spamscore=0 adultscore=0
 clxscore=1015 impostorscore=10 suspectscore=0 lowpriorityscore=10
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160092

On 11/16/26 3:56 PM, David Hildenbrand (Arm) wrote:
> On 11/16/26 21:02, Tal Zussman wrote:
>> UFFDIO_REGISTER and UFFDIO_UNREGISTER both scan the VMAs of the range
>> before changing anything. For a hugetlb VMA, userfaultfd_register()
>> rejects a range whose start or end is not huge page aligned there.
>> However, userfaultfd_unregister() only checks the start.
>> 
>> An unaligned end only fails later, when vma_modify_flags_uffd() cannot
>> split the VMA there. At that point, userfaultfd_clear_vma() already
>> cleared the WP or RWP protection. The ioctl returns -EINVAL and the VMA
>> stays registered, but accesses to its pages are no longer reported. This
>> requires a caller passing a misaligned range.
>> 
>> To fix it, check the end of a registered VMA in the pre-scan as well.
>> The ioctl still returns -EINVAL, but no longer unregisters the VMAs
>> before the misaligned one first.
>> 
>> Fixes: cab350afcbc9 ("userfaultfd: hugetlbfs: allow registration of ranges containing huge pages")
>> Fixes: f369b07c8614 ("mm/uffd: reset write protection when unregister with wp-mode")
>> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> 
> Okay, I assume it's not a stable kernel, so we can fix this in a cleaner way.
> 

I wasn't sure about mixing fixes and cleanups, but absolutely.

>> ---
>>  mm/userfaultfd.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>> 
>> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
>> index bf42fabb5afd..d8abc24353e1 100644
>> --- a/mm/userfaultfd.c
>> +++ b/mm/userfaultfd.c
>> @@ -3960,6 +3960,8 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>>  	found = false;
>>  	cur = vma;
>>  	do {
>> +		const struct userfaultfd_ctx *vma_ctx = cur->vm_userfaultfd_ctx.ctx;
>> +
>>  		cond_resched();
>>  
>>  		VM_WARN_ON_ONCE(!!cur->vm_userfaultfd_ctx.ctx ^
>> @@ -3983,6 +3985,15 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>>  		if (!vma_can_userfault(cur, cur->vm_flags, wp_async))
>>  			goto out_unlock;
>>  
>> +		/* See the check in userfaultfd_register(). */
>> +		if (vma_ctx && vma_is_hugetlb(cur) &&
> 
> I'm not sure if we really need the vma_ctx. I'd just fail this consistently if
> someone passes hugetlb VMAs, independent of if they are registered or not.
> 
>> +		    end <= cur->vm_end && end > cur->vm_start) {
>> +			const unsigned long vma_hpagesize = vma_kernel_pagesize(cur);
> 
> vma_kernel_pagesize(), yuk. :)
> 
>> +
>> +			if (!IS_ALIGNED(end, vma_hpagesize))
>> +				goto out_unlock;
>> +		}
>> +
>>  		found = true;
>>  	} for_each_vma_range(vmi, cur, end);
>>  	VM_WARN_ON_ONCE(!found);
> 
> 
> Can we clean all this up into something simple like:
> 

Yep, this is much better. I'll mention that this changes the ABI to reject
all hugetlb VMAs in the commit message.

Thanks for all the reviews!

> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -3669,6 +3669,19 @@ static __always_inline int validate_range(struct
> mm_struct *mm,
>   	return validate_unaligned_range(mm, start, len);
>   }
> 
> +static bool vma_uffd_range_aligned(struct vm_area_struct *vma,
> +	unsigned long start, unsigned long end)
> +{
> +	unsigned long size;
> +
> +	if (!vma_is_hugetlb(vma))
> +		return true;
> +
> +	size = huge_page_size(hstate_vma(vma));
> +	return IS_ALIGNED(max(start, vma->vm_start), size) &&
> +	       IS_ALIGNED(min(end, vma->vm_end), size);
> +}
> +
>   static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>   				unsigned long arg)
>   {
> @@ -3747,17 +3760,6 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>   	if (!vma)
>   		goto out_unlock;
> 
> -	/*
> -	 * If the first vma contains huge pages, make sure start address
> -	 * is aligned to huge page size.
> -	 */
> -	if (vma_is_hugetlb(vma)) {
> -		unsigned long vma_hpagesize = vma_kernel_pagesize(vma);
> -
> -		if (start & (vma_hpagesize - 1))
> -			goto out_unlock;
> -	}
> -
>   	/*
>   	 * Search for not compatible vmas.
>   	 */
> @@ -3774,6 +3776,8 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>   		ret = -EINVAL;
>   		if (!vma_can_userfault(cur, vm_flags, wp_async))
>   			goto out_unlock;
> +		if (!vma_uffd_range_aligned(cur, start, end))
> +			goto out_unlock;
> 
>   		/*
>   		 * RWP uses protnone as an access-tracking marker. PROT_NONE
> @@ -3797,20 +3801,6 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>   		ret = -EPERM;
>   		if (unlikely(!(cur->vm_flags & VM_MAYWRITE)))
>   			goto out_unlock;
> -
> -		/*
> -		 * If this vma contains ending address, and huge pages
> -		 * check alignment.
> -		 */
> -		if (vma_is_hugetlb(cur) && end <= cur->vm_end &&
> -		    end > cur->vm_start) {
> -			unsigned long vma_hpagesize = vma_kernel_pagesize(cur);
> -
> -			ret = -EINVAL;
> -
> -			if (end & (vma_hpagesize - 1))
> -				goto out_unlock;
> -		}
>   		if ((vm_flags & VM_UFFD_WP) && !(cur->vm_flags & VM_MAYWRITE))
>   			goto out_unlock;
> 
> @@ -3920,17 +3910,6 @@ static int userfaultfd_unregister(struct userfaultfd_ctx
> *ctx,
>   	if (!vma)
>   		goto out_unlock;
> 
> -	/*
> -	 * If the first vma contains huge pages, make sure start address
> -	 * is aligned to huge page size.
> -	 */
> -	if (vma_is_hugetlb(vma)) {
> -		unsigned long vma_hpagesize = vma_kernel_pagesize(vma);
> -
> -		if (start & (vma_hpagesize - 1))
> -			goto out_unlock;
> -	}
> -
>   	/*
>   	 * Search for not compatible vmas.
>   	 */
> @@ -3959,6 +3938,8 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>   		 */
>   		if (!vma_can_userfault(cur, cur->vm_flags, wp_async))
>   			goto out_unlock;
> +		if (!vma_uffd_range_aligned(cur, start, end))
> +			goto out_unlock;
> 
>   		found = true;
>   	} for_each_vma_range(vmi, cur, end);
> 
> -- 
> Cheers,
> 
> David
> 

