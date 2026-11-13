Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607185;
	b=ARMAGLlqdyHuCraH+uIU4cMOvTtkYSNdUGOuC+YwX7FFTYASH9dJm4V9T9gnTFR1BpCg
	 g/N4g+b962lUSXSPYvCu1xQGpgPxXfdyfDnvsAD+ZQLCdzHnYfx6dOe5c9RqH3wD9BFyf
	 Q7dLz8xVX+1f71aW2uO/DOJn1G0EEcQjkCTZnMnIW4QRaSEjhMWrF+jiPKs1eMlhLRQB1
	 lULya+wITDBB8mBgbx+6jH+cnBsEWCt2UmdsKAOCFEw8TiPGDh0upU+u+uRDeAlQfORYw
	 9KB8Fhj6AzZKLpJ95tg1c3+LS4eV32zI76qRd9YlJIuF0KDUAffY6K6le8NvbGciTJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607185;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=dbo0hvja/aQWVjypyvF7vodG/IYlp4ZZrmUDCCImAe0=;
	b=DQa8/oVx/A/2idhnyM85ehEIFijUFHqmRO/N86yhspwXCpjzoloeHGJQzcxJBJBZFWfh
	 JhOEtMRJ0kVpkBJ4594OiEWt938hEMbf9MrEaYC/dkl2Ghsz1/Z0WKcW3XSGfj8jNQl9g
	 OF50gQm4anB/oC+4ctnvDNNLov2wKFSBpP2kxhizBUtd68a7eB0NVoGFyacEh0he21jRc
	 q9oFlaehgUoda4KIuAU68X2jhwVXnKLc0XYpIH+ncnylLuin5cb/Sam4QLUTClDPZJYeE
	 nERKzDZSzJzZ6kuVCxU38rfPaGiZxrsizNXSRRMaEwhmAyJEs8c6HdKT1ZzJf54RgXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=AWcWc5su;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=p6gIdPI6;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37C1606A331
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 21:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B37C1606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=AWcWc5su;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=p6gIdPI6
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADLmPAB2962795
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 16:59:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=dbo0
	hvja/aQWVjypyvF7vodG/IYlp4ZZrmUDCCImAe0=; b=AWcWc5suKvE+5jF4Ct2F
	KN/NQ8H6uhdtkzfRMt1aeDZ1Kbb6WkjZ0z3ztHveHd1WMEmT78SquUVjxk3qDyCV
	et+DSTVGOC9hXNruQWV2/b8LIFTQdGpRsejNtuMWpXbSzqZ/RVVrMZspm3KFuSra
	HqKrI2ig9KnxVo0yrRhff6K7A0p2cyou+AI6LSrvoEhVBWejxK9PqupbzzCB14h3
	XwbJQp0H0e9PG95H0whPUfF5xEyriwpgYhol3QdBhKSqAJ4KfbH2+qT8tB+Re7cY
	S9+kKdh9GYKxNfbRbabFAhJsm0ps4wl10oCaJ6oAYtVYoBCgOjoVKRaZemTpj4Dr
	0g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hxa3u0f02-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 16:59:43 -0500 (EST)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-535252004e9so30506721cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 13:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794607183; x=1795211983; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dbo0hvja/aQWVjypyvF7vodG/IYlp4ZZrmUDCCImAe0=;
        b=p6gIdPI6ibz1xOIbisZVMk1ImMkxme7hlW3xWuvmrZ2oOVMpAAGo7djWDFxVroYvEP
         lIGRdWE/pfkuuHZfF9fUQaaypaBWO4a/jmwzwaBLacTZ/UfGyk2NB9XtlrwLPI0oDU8m
         mU/nxBiRVdU4S+HusyUk1KJw3XuAjHLvmg8+n3xZjjcMcpoeta/zBxUCbSCj2eh+HA1Z
         1qSse3W9a20SgIlDTaqePLM6f5u2Ytz1ZrUMuKxssBJXHNc2Xw+b7LO1IpefIdCywbWN
         rrZJ3MXh0G1u4opbxq1ki6zBwAQScEDBjbzVN5Ol6i4WC7biHt3GrAmAOej4sx4SiZOZ
         D3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794607183; x=1795211983;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dbo0hvja/aQWVjypyvF7vodG/IYlp4ZZrmUDCCImAe0=;
        b=ADqhsmChnExT0agGIeXc8yuyX0oJksWAlKoEXjSPqatGETDWpVCNkJqEvXzFt8FBp+
         2lddQzUXm3j2ZpWtsRXEsHVW44byRyaOH5CHCugqS6T+h3lA275b9ScLEz5XU3uWJ/ql
         ppnrJAkSvqh3dhy7tSZGZ8FqjZoa5we63L/v5Yb+Pf5cOKLyu6MkKMWLScloBDJrKqvU
         wTewrQvJ344sg1whI+FuDOqTrd3A405Jrexol6qlF7BdQaZWH1a0LbJKIaVYVU962h5g
         CoVks46NkltilT8MSlhpWePH+M5GOkunIjulQuTtkdor+Jy6CM7h+UYesGSW0dOoDVBK
         D5Fw==
X-Forwarded-Encrypted: i=1; AL+hErFOnnAI8nqtHtwjiWnc2qksU+nLRfQEUOeAPttzVM+cX9kVYWUlvV2bSDJbgoR/Vh8XP0c0bsTnvAJ5U6HG@vger.kernel.org
X-Gm-Message-State: APuU4Z8Sx93QQ6jFcpt+gpQj48comAQyqFD4Kq2ene9YUYzEwKNKjmtJ
	/eoiq1zPiXixewy54KzZ4IAQFzLD7wHd0nruLo7Qu2AtbvRw5pL61tC6npqMWnVlzlptDRC0F6T
	LWHWcANjT7vH1zVZhdvGUm4tZ46xReC1bPCMDuPgOjuJBP61z5kGTMpA9NgrxRjI=
X-Gm-Gg: AYBFou2Mz1pMmrJBvEHXZ3C/jcn91yULqJDMzjL3EtdHlvvnp3zX+wKwET3LylELTJP
	rqzt7TA0b98xS/kRna25YiDHCsaQIhB8yPY3UIu7QarCiI93tXfYpCEu5XzUaxgn86IwnDofYV6
	ofpZ9eol9NW6lo5A7iyvTngvRqF8Qy5CRgdQoCXCaQaPmEJZy6IHgq8GHWIK+xHtyR/fytdJTm2
	VRq1ay7E6yfsFXr4IWUCDc2++8DEt+G7Q93wawJ3wLIgIaMJ8KblfknUPOSq8CurGvCdZR/Fpm+
	0+1z0xBKx0qlXqbF8dMal+dByIo27ah655uC5WxqfOpOmDI0vvubpPJ5yXojODI7W+f/Bk0gqXJ
	QHBk91WIsax9jXWmvw2drYRsC1CYhiQMZ3PklOUJvexhJmBZOff3HgPYH/CWBgAZN6E7DeWR/DY
	i7b11oCKfs94J5mu5FzdM8aQ9dASs=
X-Received: by 2002:a05:622a:2b4b:b0:535:a5f8:a5c4 with SMTP id d75a77b69052e-55acaa6abb8mr67025671cf.68.1794607182811;
        Fri, 13 Nov 2026 13:59:42 -0800 (PST)
X-Received: by 2002:a05:622a:2b4b:b0:535:a5f8:a5c4 with SMTP id d75a77b69052e-55acaa6abb8mr67025071cf.68.1794607182155;
        Fri, 13 Nov 2026 13:59:42 -0800 (PST)
Received: from [10.207.116.169] (nat-128-59-178-153.net.columbia.edu. [128.59.178.153])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad13fbdd5sm27462521cf.22.2026.11.13.13.59.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 13:59:41 -0800 (PST)
Message-ID: <f28dc841-f664-4f97-9dd7-bffd2825115e@columbia.edu>
Date: Fri, 13 Nov 2026 16:59:39 -0500
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
Subject: Re: [PATCH 04/12] mm/migrate: keep the uffd bit when restoring a
 writable migration entry
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
 <20261111-uffd-state-fixes-v1-4-00713d368976@columbia.edu>
 <avYG7CtQ52v3I8tF@gremlin>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <avYG7CtQ52v3I8tF@gremlin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: FdfwDqzH1jJ7YLn_cmitX-rGvz8RBjBZ
X-Proofpoint-GUID: FdfwDqzH1jJ7YLn_cmitX-rGvz8RBjBZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA4NiBTYWx0ZWRfX/KisI3vB2HP6
 /lLlfByDsRPcHwY29moWjmZVvWYzLbzd52TetLQJ3ZRBXq43c2hH3172tNBegBJaPJ0j2VcOW/Z
 r/RzCNKzfi4P4EZBnTcEUK5mGAf5ndjo7rFfeER+Daly317LbuiDBUq3KsDveBs78rgXBitPHP5
 J7dfoqNwlbThFpDBfVod2CrHfA4fRRTPcX8urOJlJplB/2wriAvpNGqZlvQ8Sy9T0Q6dlvQqS6Z
 OjQzoZLvHB2s9vvi9Lfxl2v1z2XdxZk2zjFk0Z3cfVx0hcVoBnqxvw44DlC27yWwg2UUwbdQIzG
 JUlkXeJfAT+/bjaEn9hcIWstpN6Jgf5vtsnf7pOS62RvLUeQB+J1xyjkytnKdYAaMgJhcU4Voxo
 3KYYhl1UC9OOPMIwVWtATeAdKvWwCm9oH46vb3JNo5e8crVYmUbScB6+qrx7WR4w59Rxw+n/IIr
 bTfx/PbKEdWjeAZXWag==
X-Authority-Analysis: v=2.4 cv=KPfPn1Fo c=1 sm=1 tr=0 ts=6af7884f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=Y+j3KQtDOE8TDC6EXH/Ajw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=VwQbUJbxAAAA:8 a=yxsk_VAZLwplHE6VWPAA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA4NiBTYWx0ZWRfXz0FrbZ3mYwo7
 k76fNkMp6IESePDHbdXtLq9hxDfDyQQ+1hirLaPS7YWzbVIYTAsnKjMiRel7TlCuu0wy4ZE95FB
 T3hvn8sIOM80+BpTVHUf31om9Mqq9ozmEhUQl0jSR3dgsdMWsWUs
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11965
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 lowpriorityscore=10 bulkscore=10 spamscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611130086

On 11/12/26 1:44 PM, Lorenzo Stoakes (ARM) wrote:
> On Wed, Nov 11, 2026 at 12:55:12PM -0500, Tal Zussman wrote:
>> remove_migration_pte() makes the restored PTE writable for a writable
>> migration entry, and only looks at the uffd bit of the entry otherwise.
>> A writable migration entry that has the uffd bit set is therefore
>> restored as a writable PTE without the uffd bit, and the page is no
>> longer write-protected.
> 
> The UFFD WP bit is such a terrible, invasive, broken piece
> of... engineering :)
> 
> Notice, again, the hallmark of an utterly broken abstraction - every user
> just has to happen to know to handle each of your weird edge cases every
> single time they happen to interact with anything that touches it.
> 
> I do hope we never merge something as bad as this again.
> 
>>
>> An entry with the uffd bit set must be restored write-protected, whether
>> the entry is writable or not. remove_migration_pmd() gets this right: it
> 
> Sigh :)
> 
>> makes the PMD writable and sets the uffd bit as two independent steps,
>> and pmd_mkuffd() write-protects the result. To fix it, do the same at
>> the PTE level, where pte_mkuffd() write-protects the PTE as well.
>>
>> The only known path that created such entries is PAGEMAP_SCAN. Now that
> 
> Wait what? :)
> 
> How does a read-only scan of entries create softleaf entries?
> 
> I think this should be explained in the commit message :)
> 

Will add a sentence... unfortunately not a read-only scan...

>> PAGEMAP_SCAN downgrades them like change_protection() does, we should no
>> longer see them, so this change alone should not be visible to
>> userspace. If another path ever creates a writable migration entry with
>> the uffd bit set, the page now stays write-protected instead of losing
>> the uffd bit.
>>
>> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
> 
> This seems like a super-weird fixes target.
> 

So this piece of code was added in f45ec5ff16a7, but the issue derives
from PAGEMAP_SCAN, which is the commit above. I think 52526ca7fdb9 is
the right target, but can change it.

> BTW I've noticed you've not been cc'ing stable, is that on purpose? No
> autosel in mm so we do need to do that on stuff intended to get backported.
> :)
> 

I added stable for patches 1 and 2, but for this one and the previous patch
the impact is PAGEMAP_SCAN reporting a page as written when it wasn't, which
over-reports but doesn't lose anything, so I left it off. Maybe I'm being
too conservative though.

>> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> 
> The change itself seems reasonable, as cursed as the reason for it is, so
> with the fixes target confirmed + commit message updated:
> 
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> 
>> ---
>>  mm/migrate.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 28a8d7734735..d200f64b5f98 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -399,7 +399,7 @@ static bool remove_migration_pte(struct folio *folio,
>>
>>  		if (softleaf_is_migration_write(entry))
>>  			pte = pte_mkwrite(pte, vma);
>> -		else if (pte_swp_uffd(old_pte))
>> +		if (pte_swp_uffd(old_pte))
>>  			pte = pte_mkuffd(pte);
>>
>>  		/* See do_swap_page(): restore PAGE_NONE for RWP */
>>
>> --
>> 2.39.5
>>
> 
> --
> Cheers, Lorenzo
> 

