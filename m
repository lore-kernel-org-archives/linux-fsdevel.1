Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794608201;
	b=qS/MfjSiOvPs3F7oDzRYUMd7I7Bt3Ik7sPpQWIvxNzQelUSLljS07Bj8hA84FbNAgBO6
	 icM1w5MmyIEq8tdL2mrLLk/uhuMQ6rrp5DMybpipZW6QPat8m+m3b5WT808j3qGbwwf+V
	 KVH0y3ZtN5+uwmk3YM40b34ajxrQQOvyC/7PKoYUvdiVRD5G3+wlcf9tlaCLRps0EsiN5
	 s1mraabat0Nbt+rvcKkE9QY0xUMcNzMURPPRDvi0YDLc8TIKPbEzB6aQYMz0OWfpVRH1Q
	 XjodSNQ1iGjr1ERjSe9hEi+C8OId8ZJxAg5cI9DidmjRVXiz03DPiPW36osz8IBNTLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608201;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=07ep7E3t/zTIZImeWja6Vo87wy8J7vuG0Sw0cdppt+o=;
	b=5g6p8Bn0ZpsB4uOaBsg5X+fixbZVOOl72YQ6h19eScpzHYmG+hvhy0qmkHFQUzaDZfGE
	 C4LslwKKNNtSEMeo40cNbFCMLtDUK3DtgCQf7llTchTwlFP6Azr6rWlDU5tRXpmQtZ2X4
	 8QswB9gHl+RdlvF2pGQRYgTv/odIwx8qW/Try1pz9CaDLn2bfYCPt3maNyLvyWja15Max
	 7Rbcx5faRem8gE183sT0pvrhABL1FPf2Z7U4mb0irMZon5iYO8DCBTEBupI0gh60tbrSg
	 2IWnqX1qxhY1oURwsFKJ/o/4BpPBk6KgJ+Xv+MBQWEN+lowDl3MuwKWDtzUO+XoPRcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b="F7rT//sb";
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=JKWePy5e;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863EC606A32D
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 22:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 863EC606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=F7rT//sb;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=JKWePy5e
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADLrm0C3418410
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 17:16:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=07ep
	7E3t/zTIZImeWja6Vo87wy8J7vuG0Sw0cdppt+o=; b=F7rT//sbLAORqUQMxmvB
	TBuGYuf+zUKrcS6K52tTE3r2XHyb0xxQwQhjqHHiIfZog4E9g7ZQl8gRVBLITHke
	AJuoWCYAKLFwmmsl6r2G0UOexNc5IMsTwMhQwRQpRYWnkouAgzBxOsMCRSgLJ0PH
	+I/o4OlJNXt264o2Y6Z+FE51htktnBsDGQ5JDmpgJvSbGzFj+7q0r9hVTl988kEd
	DdtigUo+10bJC85i/nXj3mPuKV6sGN1ORlboO4SZBhOFPb89FUGhIAnj9qTKcUua
	bYYCZccQFhTxhS058qTuLaKUTY46uh0yNXPSsw8/BGcjycKQjdLgJnxF+xNckdWx
	dA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hx8sj9emm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 17:16:38 -0500 (EST)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cb7f9bb86so363789985a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 14:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794608198; x=1795212998; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=07ep7E3t/zTIZImeWja6Vo87wy8J7vuG0Sw0cdppt+o=;
        b=JKWePy5eKMKhf+qkki66IyDGaXCdQBZBJT/hY7Urb/SXsOTmcMRKldNxgil+ESFVVD
         irlAiOluEiJk+OVF1ESqeErT1Yz2ZkrXL5nJjuEs2z9NNQA/crrP51Vvb5QnBXLKDCBY
         h1urXU7yPlLqOMMMYYmeGm42d7X4EbzS5h8rX3Vgh4o41h7jHKBE0UwaHmdp+T0fDunx
         tr276Ut5zH+wGbjs4+h23PvBMyqbznesCobdgv/ebkAh77UU/7pwcEl5gYIX0cEufnzC
         wRjoSHC5vsNwbdG5ReqEoTvsTiaRBd+kqMRj8mvqFi4Hd8Ybf4zMkgGSKU6sI3KC7Bqg
         5s3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794608198; x=1795212998;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=07ep7E3t/zTIZImeWja6Vo87wy8J7vuG0Sw0cdppt+o=;
        b=BzmOcvBBjnK7Te5zSdu5+GIu4BeseHhEbxuqkdGIv8ngQjUmq3ENybX4PwuL0/lWsF
         z8QGEJng5KOB4bFlLR0QUQjeHdUvIVXkhF33C84Dj9RXxpBrgKD5LAQ6QHJjpYNtuElq
         tybof7/Od+mDk+hjWAsx5q5S8NPXI2eiPNWXK0y9HnxOjLtlljwIpllEpbKM9I9Wn+QJ
         ngSXeyfZicM85ArfHYQLkkJqrc9/F4lCVRhoFW/s2Jb9yRlQ5rI/1FFMfOEbYahu8XL8
         wx5BHaTB8IlputUxZJ9hiX6Gg4kRp6EkGQGvN8oSFIfLv5rGeycPIkHGk3toF0aDe/fn
         XCCQ==
X-Forwarded-Encrypted: i=1; AL+hErFZkl/q3+AIOBqnmAds53xqVnLPa1eATf+CX+0sV9n5QaI/P+crPKZ7w5Yd58yQ39IWDINdOsTFLDbXcuxB@vger.kernel.org
X-Gm-Message-State: APuU4Z8IBGfOBRwt+btYv4M2tqPc5zQHu8A/fRyd5NrhDR5FPN1bkiqx
	HX7PGebtqSt0/f8H3f1qMSP9f4vVc79DlMkBC7KVbRrnAIjAG3FsXSiKJrQRVxnL23A39QOziyp
	XPbKSBPyF1EJRSSLE2h1l7c2Db6VvwAx9BrbHG/zpaEHXD+A2CG+pxWHRJghaKA4=
X-Gm-Gg: AYBFou2l9spqr4kRTJx8cPa97Um7e9BofEAVDj8nabV3inynWrhVH2L7daGEJW3x1iZ
	KI4mUYnH4ztXQSXCraIgts8DUHRKmsmSwa/YtoDZmlC3y0R0DOG4FLgdEW6cwzK0M1yb7fUdx1j
	dLi3tVYpnJuD96UZK7xRHTt64CSjSdhokPprSWWj+VK+wLNeWcSytHVgqvFGOp5xMFyweu+zD+x
	16AVm3JfHuUNK4kMXmLaGhDKPzZZrdUDk1qXSTQ98EOe2TKNkc5hcCuMTn7hA9Pt5ywxXgmTLjw
	DiTWRyq5uPq2Kef86hy5LtRW+QtJwA5vOf3KMqkI0ukzfE+iyxPFTLZD5TyG6kn9Ewbggy1Tjoq
	10bGM4gZWnJvrKt4iN/g7OdEsYJJL5xyRIwzdMPJVNiMJGK2eFnKDHj2JzEFj+Z/qN0h88WVU94
	M4Wm/4Uue60MIuoPDeSUjBNaOCww4=
X-Received: by 2002:a05:620a:628f:b0:946:44bf:9169 with SMTP id af79cd13be357-9494ba7e00fmr662821185a.17.1794608198221;
        Fri, 13 Nov 2026 14:16:38 -0800 (PST)
X-Received: by 2002:a05:620a:628f:b0:946:44bf:9169 with SMTP id af79cd13be357-9494ba7e00fmr662808985a.17.1794608196819;
        Fri, 13 Nov 2026 14:16:36 -0800 (PST)
Received: from [10.207.116.169] (nat-128-59-178-153.net.columbia.edu. [128.59.178.153])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c836b60sm281564785a.17.2026.11.13.14.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 14:16:35 -0800 (PST)
Message-ID: <e4b60f0b-ccb4-4a7e-83e0-81fa1fd0c88d@columbia.edu>
Date: Fri, 13 Nov 2026 17:16:32 -0500
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
Subject: Re: [PATCH 05/12] fs/proc/task_mmu: write-protect device-private THPs
 in PAGEMAP_SCAN
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
 <20261111-uffd-state-fixes-v1-5-00713d368976@columbia.edu>
 <avYQteUm963AKJQ7@gremlin>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <avYQteUm963AKJQ7@gremlin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Y/JtIReN c=1 sm=1 tr=0 ts=6af78c46 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=Y+j3KQtDOE8TDC6EXH/Ajw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=jLqENXc96tZTD5fVGMQA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA4OCBTYWx0ZWRfX2uO5tsKxgUow
 yX/3P5YYduf7PQAnR84OeQ33Iu+jf4jKlVjhGupDPxa7zWBVx27YBqNz0nkFuLvt0iNtPAdchZi
 iOH9PH86n2z1sOU2mGpZub5OidEXrN4EIf/GTX8hLZdO1HGkHx4e/4lMOYBIdD/Mx/zljevC7+e
 B2SW+q0pTSehwQP3bNufiw6dOgvVxJMviaf+vksDiMZx6kt8JQI2xSx+90nuvGqYu0X++LeQQB0
 EARe36JMh+/Qi1SYZuSKjYhp2LuXI3na1EGk5JizRTTNb0p1xc++7wyY7QLgnK/+8jM4Drzz46s
 h5s59cV/khn5DMy9Nb+yTO4gILI+ONnbitgwTt2i74omm1j+Hj06ZL0BI55C+DJkgtJwjY0up5l
 wb+19GEreQ5J3SnocpIRQ4U3faSse1wU2ZjssaF9jdaIfcv9s0acHHvcm1DvaSojtuywv1GmuXm
 1MCy/Qp0cBcxWYwf4gQ==
X-Proofpoint-GUID: x6am8Tu0G26Zg606hOEYWZaeE8vq9QTw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA4OCBTYWx0ZWRfX2yT3rRXtUdb8
 XrijrABbY/+lVOHk7XnSKll9Sho3LAhFnAJZJ/h9dL38FVA1LfknwqkeesPLYgRQRgfRaSIDdVh
 9Tlz1VLZVOPxE6IN2usE4ffuKfdz78CyuPr5PVtAMdaOUG4xzdbD
X-Proofpoint-ORIG-GUID: x6am8Tu0G26Zg606hOEYWZaeE8vq9QTw
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11965
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=10 impostorscore=10 malwarescore=0 spamscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130088

On 11/12/26 2:34 PM, Lorenzo Stoakes (ARM) wrote:
> On Wed, Nov 11, 2026 at 12:55:13PM -0500, Tal Zussman wrote:
>> PAGEMAP_SCAN with PM_SCAN_WP_MATCHING write-protects a huge PMD through
>> make_uffd_wp_pmd(), which handles a present THP and a migration entry
> 
> It's crazy to me that we write-protect page tables through a procfs interface
> like this. But I guess we have to live with it now.
> 
> I suppose that answers my q about this on a previous commit...
> 
>> but does nothing for a device-private THP. The PMD never gets the uffd
>> bit.
> 
> Sigh yeah. Device-private feels like another 'just have to happen to know to
> update X million open-coded parts of the code'.
> 
> We really need to find a way to abstract this stuff.
> 
>>
>> pagemap_thp_category() reports a non-present PMD without the uffd bit as
>> written. A user tracking writes with async uffd-wp therefore sees every
>> page of a device-private THP as written on every scan, whether it was
>> written to or not. This requires a driver that migrates THPs to device
>> memory.
>>
>> A device-private PMD must be write-protected like any other huge PMD. To
>> fix it, pass it to set_uffd_wp_swp_pmd() as well, which downgrades a
>> writable entry and sets the uffd bit. When the THP migrates back,
>> set_pmd_migration_entry() carries the uffd bit over to the migration
>> entry, so the write protection is kept.
>>
>> Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
>> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
>> ---
>>  fs/proc/task_mmu.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index 53780a454432..752f1b13d47a 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -2524,7 +2524,8 @@ static void make_uffd_wp_pmd(struct vm_area_struct *vma,
>>  		old = pmdp_invalidate_ad(vma, addr, pmdp);
>>  		pmd = pmd_mkuffd(old);
>>  		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
>> -	} else if (pmd_is_migration_entry(pmd)) {
>> +	} else if (pmd_is_migration_entry(pmd) ||
>> +		   pmd_is_device_private_entry(pmd)) {
> 
> Could this not just be !pmd_none() + cover all softleaf entries? Or is that not
> valid?
> 
> It seems completely insane to have to specifically spell out all the
> possibilities, open-coded, everywhere.
> 

So we actually have a helper for exactly this that I didn't notice before...
pmd_is_valid_softleaf() is equivalent. !pmd_none() should work but I think
the existing helper is better.

>>  		pmd = set_uffd_wp_swp_pmd(pmd);
>>  		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
>>  	}
>>
>> --
>> 2.39.5
>>
> 
> --
> Cheers, Lorenzo
> 

