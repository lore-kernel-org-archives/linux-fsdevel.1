Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794609297;
	b=kjoHj7YslHgf8ctt1dXNUPNdwGCg3SG1IUQy2a/re+OjVA4LNcGs6xTZqExtbKzwkgUG
	 pekc0LWO69Jk3MVshiO4hPxmCog6IjPFwJ6a172OHa1JNmAyWFWDX9lYiLYC31WxQ8F29
	 9wuPitDFYoCcrTVmbZEbXdP2NhHYZEOxzoTgj7H7CFhO161Vkw3m/g8TOzYCIfJyHDrdV
	 1aOqQUNGwML5Swb0C1IlWfS+E0C9EUl+QNB4AXVBaIwkgXHQM+ksCKzCZ7TqUqMJTw3dg
	 4JP4DVlAL+3ngXjSSUuhtMoJWNYewxr2UjdM5+ewJmKz4daE0tm+o92wZaywzlNJeOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609297;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=UWyNG9BpS7ZOyZVHydfM4D6T04LeEiI1hXz+sHf1bRw=;
	b=Ox1+n+Y5TST/HHR2jOJPah1L7k9FAvtfwtoLo3EXSapUwt9gxJb2qd97izqaDb6ie26P
	 H2/JwY5TcwarmseTUoSyzSi1QYZyvoqQBrW13QaanFP3V9Fuega+Aeu7FJS2+VudxICgT
	 tCNsEhmigfZcxrnXRCZwmGyU0zMBt6C10mhpqZVu6eDVKNRba3JvBH8CAbXdvUne6frGV
	 uVo2mZtM4TjXFHQCopmyQTbQZLM+mMT4cxT9qhILFK5bINa1YJ5i8wSR9jDZ14/QFNV50
	 aiHKYSDEZN/Q0rSxOOc1p1uO/J6cI51pE+9+vdtDChM5qYtJzkAeOZt2b05BQmwEEIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=hcszHs+g;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=QFCc+BlW;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484E8606A549
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 22:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 484E8606A549
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=hcszHs+g;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=QFCc+BlW
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADLmXu92962893
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 17:34:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=UWyN
	G9BpS7ZOyZVHydfM4D6T04LeEiI1hXz+sHf1bRw=; b=hcszHs+gigNCkk0L8+7v
	gvUdMe6A51CgBWWQSipAmCg1eLbkuEGQdH6VT7puFpqbGPALEWWVgCXjqMX+ftCz
	iDjAAwl/HIb7faTMRqx/jAbK2Y64re3ooOApezscoaiOn4SGDT9Gl4AtN8nazWab
	iKzk+sR4LKDNMKUherMro39r0OTUesQ6YPO3/8HvRySQG1T19C+2RW0dOrgRAwQ4
	BWAPVqORd3MFmshavP10nXp/lab/dYqPAqLHmbdYb4poBp9m6V9af3aOsQNZeDO/
	2uF+uo3RH/5frtrUH/tkWFiMa8oS2qzo82e+tpjMboCKdqqirgpbN4MMRBu9NKi7
	Xg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hxa3u0r3n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 17:34:53 -0500 (EST)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-55bf3e01e65so18699761cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 14:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794609293; x=1795214093; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UWyNG9BpS7ZOyZVHydfM4D6T04LeEiI1hXz+sHf1bRw=;
        b=QFCc+BlWzSf8Gu4XQhpuah0PHcb/DiYwQLbyX1oxV0wf1roIQunDciWVgybGkF+2mJ
         kV3yeSWw3ka+D61erZhfs5nbdpS5fw50TdfAWCyrwHg+V0KgBwkdDEd2GXk2vQ3+6dDi
         XBVovAmdVfG90OhuNH4xjny+O6Z8AZY2BqlWPh03C2MpEaWyhSzUy45Ejb/LXwP6L4hX
         T7b0f1msd7bs7TJJMbOJj1t6MG7sBzU1rHLFW0sjo057YgCHMIQz2Ws4BV7hRtUGJA1H
         Y9GrAMlAhjPZtbzoI/GlAuGyKA+/E0YRbRBEFq/nANLyKtN4J5Tm/03fIA1npFVxkMfn
         aepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794609293; x=1795214093;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UWyNG9BpS7ZOyZVHydfM4D6T04LeEiI1hXz+sHf1bRw=;
        b=MpqGwtqdtl7hRazjS3o1Ng+7zdsAJZNPGnMSYE/EV2R0BseC5JUWOcGoJV4bXWmv6x
         Zl7hQGoyX5YS3SlWT1IfhSGe2YJEEPXGqpS2CRcAcLzMc5g8d+iU7VTqS1bD1zHNB8Lm
         qNbULDiAu0TM4pcnLiVgsb6PTV027jZlunAY8fong6A2RII/KIar9UpH9cXkMSwL40FG
         EJzyXPv1jeC255buttAFkmmGfVJVS1kyg6wEfLePyAzWCrliXBQwvSzFxqT/mPCW1/g6
         avMn89sCAOulgDoYgMVT2Ke5nrujaas/eHVpX2N7vz9aJX0TieQsbXKH4lr92ZTzUrWP
         tpBg==
X-Forwarded-Encrypted: i=1; AL+hErH0rGBiGLrWCaYuSn1O81Bv96tDlUDfe51lFOpjtbtp0v77wKeNfbTSJPtxp8geiqRCoNTRbTE6uEuDLkPv@vger.kernel.org
X-Gm-Message-State: APuU4Z+gVHEtw20nfi9aDn8Ur7CKagxzshPjQ8nDRCE+MbnI60qeUT03
	++vUx3PhGg6gg6zRXX93H6WTxpgjzbgXnHaODLoOVWppRcV+GRIq7pChvjhLiNOXPF2YFfWbesK
	LUCPKblBNfrLEyTqF3loB4eJnGx6X5MMkF6dYslXGSwQJPoPoEguJ/cLAMpqWSb8=
X-Gm-Gg: AYBFou14clUCo/vk6fiZC9LTyFnzV7+RQe8ZYws92HACv1wO6gyqFR6eqEXx/WextZL
	/+BzqZ27AQ1kegXwKkfqRWZn31chWoX56p69BMtvzQMKOWg5YdMyIJeBsDInc4u4KhwzUT9QBIW
	qhJTV753iM/Uc2gU61oKW49Q4ksql2gQtmfX807KH1zSJjNeWiVlp8fLbPcQ2QxFoWqepCe3fOZ
	xBvVioJE/0BZGzkN11I1YiineldP1M89T+4k6/YCpRffEf601Y3kcR3451XLdG5MMnepDXyv0//
	rRB+GqZJz0mYiUdVTAMAQ5kZsdSpuLNAHf581UqfGmRQPkdkPzjpmnF9vVUiYLo4x52o4vmNtJp
	aGQPGdWaLF1Pj/KboHPkYrn1QxG5JPCY5YI8GPtMG8FQzny6LAwfgNRWZAa8/Oacp65S1iVPY+V
	Eq35fDXq+z8pggp2fLaqdB406+jWc=
X-Received: by 2002:a05:622a:1cca:b0:536:620e:90f7 with SMTP id d75a77b69052e-55ac7b55b72mr63814871cf.39.1794609293332;
        Fri, 13 Nov 2026 14:34:53 -0800 (PST)
X-Received: by 2002:a05:622a:1cca:b0:536:620e:90f7 with SMTP id d75a77b69052e-55ac7b55b72mr63814311cf.39.1794609292887;
        Fri, 13 Nov 2026 14:34:52 -0800 (PST)
Received: from [10.207.116.169] (nat-128-59-178-153.net.columbia.edu. [128.59.178.153])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad1005027sm28221941cf.21.2026.11.13.14.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 14:34:52 -0800 (PST)
Message-ID: <2e812a10-e937-40f2-b250-74ccee5f143e@columbia.edu>
Date: Fri, 13 Nov 2026 17:34:51 -0500
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
Subject: Re: [PATCH 12/12] mm/userfaultfd: check hugetlb end alignment in
 UFFDIO_UNREGISTER pre-scan
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport
 <rppt@kernel.org>, Peter Xu <peterx@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Balbir Singh <balbirs@nvidia.com>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Andrei Vagin <avagin@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
        Muhammad Usama Anjum <usama.anjum@arm.com>,
        David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang
 <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
        Kiryl Shutsemau <kas@kernel.org>, Chris Down <chris@chrisdown.name>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
        Michal Hocko <mhocko@suse.com>, Mike Kravetz <mike.kravetz@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
 <20261111-uffd-state-fixes-v1-12-00713d368976@columbia.edu>
 <avYVPp7fHNg8WSUB@gremlin>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <avYVPp7fHNg8WSUB@gremlin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: qAA7bCusL-EMQfpFFvdrN163rNhahEG0
X-Proofpoint-GUID: qAA7bCusL-EMQfpFFvdrN163rNhahEG0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA5MCBTYWx0ZWRfXy3V1g7UOBRY2
 jb/C7r6IxvkvtDdlp84jBZi8FeZ70oigAmpgFaTtbCCjBjQ8p7IoDmsvLjiJxcwh479M6MBaXiH
 R7jb2W6aLvHdAJQvIlpVP3zWozNvACpOgKiNMbPjOuUK8j1aasaE1iYGa+H5U9UgxaX0Ym1p+7K
 ew89D4kQHadGKhRW+C+sBru/8t63S3fadrLqh5NAIwNq4/laUFLMK+Yok51CEWhAS49cyBwouTo
 CekhzIbUL2yRvjM2maci5J45lYH7rFDV+AQXhnoPv6b6tGPI+P/9DtbWbRfGMdBENvxcBn6zXQv
 ZwvQNGefpwgmEvKDTVIYGFsaKcp0TjrNCmtI/uvba8NK5ZSHnH2AvQGZ4Xzxbx24QjfAuoZ13PC
 3j7T68rVC6pkgvKjq8FTWwhUsAOcEMLcPVusP66sERWtfr26J11HfNnXhnAN2tVXWjZ+Iy/CfUs
 t1OrBPJv+v5rJHx+YHw==
X-Authority-Analysis: v=2.4 cv=KPfPn1Fo c=1 sm=1 tr=0 ts=6af7908e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=Y+j3KQtDOE8TDC6EXH/Ajw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=kZ0dEtpUmc4MoBsJRcYA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA5MCBTYWx0ZWRfX6er+IfJuMZjY
 bsT1MpmCwBysDa3pnv1YPZ0RkcOQaqtY+mMAv1Y6FWT/UdIHp780ZxvqxRsgVGL6l1L9TGNVCFE
 kpcHwAbPAXi2o0zWWTqwBR0piH8q6+OAP4id9Wmmy6DxlWPceiF9
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11965
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 lowpriorityscore=10 bulkscore=10 spamscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611130090

On 11/12/26 2:52 PM, Lorenzo Stoakes (ARM) wrote:
> 
> hugetlb vs userfaultfd is a bit like the alien vs. predator of worst mm features
> of all time (TM)
> 

Alien vs. Predator had a sequel... let's see what the mm version of
that will be :)

> On Wed, Nov 11, 2026 at 12:55:20PM -0500, Tal Zussman wrote:
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
>> ---
>>  mm/userfaultfd.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
>> index bf42fabb5afd..c0076c8b4e9d 100644
>> --- a/mm/userfaultfd.c
>> +++ b/mm/userfaultfd.c
>> @@ -3983,6 +3983,18 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>>  		if (!vma_can_userfault(cur, cur->vm_flags, wp_async))
>>  			goto out_unlock;
>>
>> +		/*
>> +		 * A range ending inside a registered hugetlb vma must end
>> +		 * huge page aligned, as in userfaultfd_register().
>> +		 */
> 
> Hmm I think this is more or less saying what the code is doing :) so I think
> unnecessary. Maybe worth using the words 'cursed' and 'eldrich' here to describe
> what's going on? Or possibly just e.g.:
> 
> 	/* See check in userfaultfd_register(). */
> 

Will cut it down.

>> +		if (cur->vm_userfaultfd_ctx.ctx && vma_is_hugetlb(cur) &&
> 
> This first check is pretty horrid to spell out loud, maybe do something like:
> 
> 	do {
> 		const struct userfaultfd_ctx *vma_ctx = cur->vm_userfaultfd_ctx.ctx;
> 		...
> 		if (vma_ctx && vma_is_hugetlb(cur) && end <= cur->vm_end &&
> 		    end > cur->vm_start) {
> 		    ...
> 		}
> 
>> +		    end <= cur->vm_end && end > cur->vm_start) {
>> +			unsigned long vma_hpagesize = vma_kernel_pagesize(cur);
> 
> Could be const?
> 
> Also is vma_kernel_pagesize() right? If the VMA is hugetlb, then that'll end up
> as hugetlb_vm_op_pagesize() which is huge_page_size(hstate_vma()), but it seems
> userfaultfd is full of this crap and yeah ok. Fine :)
> 
>> +
>> +			if (end & (vma_hpagesize - 1))
> 
> Could do:
> 			if (!IS_ALIGNED(end, vma_hpagesize))
> 
> Instead?
> 
> 

I just took this chunk straight from userfaultfd_register() and added the
ctx check, but I can clean this up while here. userfaultfd_register()
probably deserves a follow-up too.

>> +				goto out_unlock;
>> +		}
>> +
>>  		found = true;
>>  	} for_each_vma_range(vmi, cur, end);
>>  	VM_WARN_ON_ONCE(!found);
>>
>> --
>> 2.39.5
>>
> 
> --
> Cheers, Lorenzo
> 

