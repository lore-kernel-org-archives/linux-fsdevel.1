Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031434;
	b=o8mnA3mjXQSdBi/qDqgXM2+epeU+4E+SuocGNSKGa4SuJhQIfhnU8LeJO2mytzcbNR8Q
	 skoWqpvlIeJ+u60EaEmRGIaMpt3Ht0/gDinfc9LrWqpgt6yFYXy5z0oXrm//cHVmAQi2y
	 d9u+fCjhZTzRlYAuGnvk9RpvekLuoxmB06NoFovJA8IlW0wMhF/f9uM/26IYuCiNUlc0c
	 gwUcCsgERFqE53BaCGQxlL5GJe+6L8cdgvDIohiBcozNd5Pc7aGp5fE8oOVSpmfRqtlc3
	 qfEDXn3jq4BxCT3pISl1VRWD3jIA78DM0OyeihjjV18dLkbdQU7fzW7QcqgktP0N3bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031434;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=r7xQEq0S5madAXrgChKTKdPfHb7gKwfhdlAPY6R8vGQ=;
	b=hhKlLyGtXI1rifl6Nt/PeisFkzyWuDoj1wacRkD4cM2YQ/1J+VGjAjTp8x1HkFhpT02z
	 sncq8VHOf7nIHCoC/4iqI8iC66kw+gfSRDZkPzduvP5Uqad6GPtqoSItk4mqgrVZCAO++
	 HBjM1ToDZaAFz+zZlfZcktJs5dPvyNOKbCTVEcF9eLqyeWDevooIAMfj2eA8tcCSo7u92
	 ZtWvQ/9O/x7pBqjasseLVDkLnDdDogcZyYT18qco5P3b1Bw+lo81BS1CxY/cZYIskXqCa
	 EDF1TCNWQwyn/mm4pzQVnCWq90gkGU4ImURZ7VRbGQjSFxcgXlejD1kfL9QRONp48XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=AvcKfCxg;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=YHVVVoWA;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68395606A320
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 19:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68395606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=AvcKfCxg;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=YHVVVoWA
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIJYeHV432335
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 14:50:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=r7xQ
	Eq0S5madAXrgChKTKdPfHb7gKwfhdlAPY6R8vGQ=; b=AvcKfCxgh2FO1dLQ8zx+
	4vXb/ToMs6lkdoSyUzHR7J5mA8oTJ80Evn6C7DQAcQmCKyyCXCcVPXC1AY2BPV+D
	PrxnrOdal+rGAkWkiyrbM+AqOwlZAQ1nJhZU5MP+bzgPUyn08QXjS82Qla/J+pPH
	iCcg3Jt/KcqKZ5SUTzgJwHBANnntnyE+Pl4ScFWubQmhtGSgKuvD11x55l/MrryD
	qpYkODcKqypwoTWy8gK5UZs7YAS4kt/NOgHbNYfZYGtlH43Z2m+cRpG1dhxCVAtF
	QizC4R1HjcRvzV9dgt1KKEHn2w9dfl+PcmY3Jg7zuQba4dl/aGh85fAhkp4sBQiD
	SA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4j1ft3smsc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 14:50:32 -0500 (EST)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5383c05fb2fso34773861cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 11:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1795031431; x=1795636231; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r7xQEq0S5madAXrgChKTKdPfHb7gKwfhdlAPY6R8vGQ=;
        b=YHVVVoWANcVc83FlR+/D5H6u0kCJP7B/v0FdTstDGgjgb0pwh232znaxg7S4pKVFWq
         nJ0Zs8nMR+JMfcLnfTnICG34bvhannwOXI+kHG/izds4p7Mg6WoCoMhSeKa1UMHqGqAO
         BOZkbvRckKzDqyqxLB4IUfOSuCNpX+w/YsUmvSmnrqYiqyn5qs6YqITbcji6w0AtixWi
         kLPS8JKO0pNIzIokc6iGXxUe1JjOsGh14cufcqzZ/l5e1P0+dpuf/3oW1Y1wDxbgF3Hc
         a3IkbkHKTdYYlXlvhmxArcBhbHpQuuPH9bINVI0tpH7x8vZalR4N1k2PE+4zwfwgOK9j
         fbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795031431; x=1795636231;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r7xQEq0S5madAXrgChKTKdPfHb7gKwfhdlAPY6R8vGQ=;
        b=kVvtsgJbZ/tOr1EUlWy8bkxCsR4TwO0sK1EmYo9SL7wuKrIWVrLfJvlBS4MuI7VddX
         DNgpTfS61vIlg6MFW177CdbaXaQE247y8Dh9ooJlN0SD9HP4sbLFRRJ5orMR/ygozjPe
         4sKUJR/8+MNdwMurSpQPZnA2vsh5fs4wf9JH7/kg9X3OdBBPGFpa73dIrTmQJ2DdLmW5
         g1tQWz45fdsbIgbvNcUi3Zuc3P0zwQ3RrgCMM27YK2/IaulA+DmFmroqVImkpSYEVYRU
         z6ak6P9bkh2ds54VxsnbCnOMqIcUpE8MRsBoQeBqHsprIjWzAjp4v69v/kaXCA3jKj/n
         jQQA==
X-Forwarded-Encrypted: i=1; AL+hErEC23yai78ghyUuNCo52VvSoAO8oSLKDskAjRxYsnADrF8YvdDSWtQWM5A1lcrJKotJE7CQffnqEmsCQeQL@vger.kernel.org
X-Gm-Message-State: APuU4Z8th/mpvMqKXZMHBr4gGsTblkVSPsAF0OSn/5v9iouwWZTcgB4c
	MR1tTox7Qb4zEu0zz2D00ANKI4nufZisMpFbwP5PWbqEvFgtLsZVYPHdGOHVLYzD2Q+cSvld8RC
	K72JSC0iYvhOS58+3tuVzBoY7yOlfT6UlBOYj/3fiO4IAuZ1jqTRqgLDOKg1LZr8=
X-Gm-Gg: AYBFou0saUjYHtuSYcUKfkOejz8qWHNUZKzb1Ez6y3B/5sJGVxsylzQZhKTw1qpN+JP
	vRTerWNAGZQ0twZqepg7LZSl551xr+K6GwUG/aVR4YqWXGVdJ/F9KdoYWZrmQINgoxmtW9gfFXf
	9tDPQ8JuqnVMllAl8mHFnzLBbwBfoPBahGnriHw1seKz2v5c3c6C/6etnYrdAM2YvD/D4LWw0Lh
	m+skvpZIbq5HKrloWDraTajnnLs2Kk9Ld3qPAgUxQmNppaDarpa3ajRRhbmiihtJ34wYPqVdxVA
	jGOPxGqo0aB19SJrXdLc7NhfQ588o32VWBE2/EUiUUsaYTxtsG6OLnaF08iWM7i9c9GV5vwFnx5
	Bi+O3O0iRZb/SbjmFPDwlF5q0ZNQnRhOrMVnIMWfqkS9sKAthv+QVZM9yU0fWbE0g9T9WPM5eTG
	XeJBoZfIkAEMspTDN7L1AP/g==
X-Received: by 2002:a05:622a:5807:b0:536:252a:dbf8 with SMTP id d75a77b69052e-55d5a537991mr56617641cf.14.1795031431421;
        Wed, 18 Nov 2026 11:50:31 -0800 (PST)
X-Received: by 2002:a05:622a:5807:b0:536:252a:dbf8 with SMTP id d75a77b69052e-55d5a537991mr56616931cf.14.1795031430933;
        Wed, 18 Nov 2026 11:50:30 -0800 (PST)
Received: from [10.207.2.125] (nat-128-59-176-14.net.columbia.edu. [128.59.176.14])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d66c24503sm7189751cf.20.2026.11.18.11.50.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 11:50:30 -0800 (PST)
Message-ID: <9a6599cc-f47a-4a27-ae8e-91c8a1a523b5@columbia.edu>
Date: Wed, 18 Nov 2026 14:50:28 -0500
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
Subject: Re: (subset) [PATCH v3 0/9] userfaultfd: assorted fixes (part 1)
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
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
        Breno Leitao <leitao@debian.org>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20261117-uffd-state-fixes-v3-0-b617009d1a4a@columbia.edu>
 <179501525761.13527.5348420494097607881.b4-ty@b4>
 <d05636be-5a37-46e1-b6d2-30950b7778b5@kernel.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <d05636be-5a37-46e1-b6d2-30950b7778b5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: g5Oo2C8e664TdTshNwvCRc79l6x9TLHD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA3NiBTYWx0ZWRfXxAO94CGchBKY
 CGWn1tXmoDkPfUSHSyg+ms88YUtK1CvZVfVnTdcv688ZQxa2rv7Tx33UQNFa9tnqA1fmW4xzuZr
 Vfd4x1Tc4gT6mS0QFEVPmM/WxAwlVshSysqu5EfJCQnhEbAWGqxtgIkybzqXaINKHZRjBYSgzj0
 hozgdepR5zKg0HESr1MZe+08fVg2VKMyTbHaY8hbwt96A+VSYrVk9/6u233R1Xrtzk12xRaBiEG
 L7pkqolfR8x1UplbRtnpkTCffAxxutTrxrz324oQNnJ8ecu8m1aOgmj+1bm9RJSlk+truHVrb9G
 TWrWWJLDih1vpTT9aGZSQ59R+BPrHxpMvNLZQB5iOQObdRerwoMRCNpCNKd7ubqbYzJbkEXY4Zx
 EblijtRkxM9iFH2GNJRfFbo3SBGtFg60dBE4QOLvl2pxQ/zF1I5ZvtQ10KJbiNj9km+ClCLuKv2
 weTLdpjgbktCThQJI6Q==
X-Authority-Analysis: v=2.4 cv=Dd6COftW c=1 sm=1 tr=0 ts=6afe0188 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=2zM0HjzktFauw5hoOd8SpA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=VwQbUJbxAAAA:8 a=b7hxIIQ5yigvctP09d0A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: g5Oo2C8e664TdTshNwvCRc79l6x9TLHD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA3NiBTYWx0ZWRfX0msaN2XksprU
 PgFK+lW4x/4jn2j2pS8z3QmXfRJN1z/tQrRPI+XxKh2AzBdBs3Z/8EHFQBRhVCNBeLmDmzYUC2/
 IWoiaWDTTWv1RE+wuaFkZ/79bL5ymjKGB8G1Rk9s4UHhyHbWZuwb
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11970
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=10 clxscore=1015 impostorscore=10 malwarescore=0
 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=10
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180076

On 11/18/26 10:37 AM, David Hildenbrand (Arm) wrote:
> On 11/18/26 16:20, David Hildenbrand wrote:
>> On Tue, 17 Nov 2026 23:28:40 -0500, Tal Zussman wrote:
>>> This is a first batch of userfaultfd fixes, with more to come.
>>>
>>> These were found by a mix of regular old LLM review and by having an LLM
>>> write a TLA+ model of uffd interactions with PTE bits and other state
>>> and seeing what issues fell out.
>>>
>>> Most of these fix places where mm code loses uffd-wp or RWP protection
>>> while moving or migrating an entry. Userspace then either misses writes
>>> and accesses, or gets pages reported that nobody touched.
>>> There is also a hang in UFFDIO_MOVE, and UFFDIO_ZEROPAGE modifying a
>>> file through a private mapping.
>>>
>>> [...]
>> 
>> Applied, thanks!
>> 
>> tree: mm/core.git
>> branch: thp-7.5.misc
>> 
>> Applied patches will appear soon in mm-next, followed by linux-next.
>> 
>> Please report any outstanding bugs that were missed during review, so we
>> can either drop the patch series or decide how to fix it up.
>> 
>> It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
>> though the patches have already been applied. If possible, patch trailers
>> will be updated.
>> 
>> Note that commit hashes shown below are subject to change due to rebase,
>> trailer updates or similar. Further, this is not a guarantee that the
>> patches will go upstream. If in doubt, please check the listed branch.
>> 
>> [6/9] mm/huge_memory: build the moved huge zero PMD from the destination VMA
>>       https://git.kernel.org/pub/scm/linux/kernel/git/mm/core.git/commit/?id=ec36bf72
> 
> 
> Aaaaaand undone. :)
> 

Thank you David!!

> -- 
> Cheers,
> 
> David
> 

