Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794868038;
	b=kneN9QSYVTqxfz5yUfIzgJfPZVruw/SCqbHX4Q2SqjFkEZXy5u8/zKz+Ojre+zZlLRiY
	 JN8cHEEkfWF9HZ2hA/C2AVG3CN07Dq17NHmihJPIsOJ62GyPjdHBLybXFoN8zT9BlG22b
	 FrVS9rAJKImP82dgBzai91f+Xmnh++uiULqUsoaag+q4+2dZCQ/PV/RRI4OiSZldW0SyU
	 +EpL3LCcZNoc3Aoj0DR+M2QVUSBBPdYEv3AVcMmtv6rb7lNFoTxt0GYEdDdXGN93pUXpZ
	 oXqEIytfKDPzOWGxPQyJO2kkPpZcwc0l64EOyVQoLj2YJ+mqYucoEAyC85kxpx0SdLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794868038;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=4vyYjn5UPo/7vDc4ZQ9k3Cq0mbqo2jzpmjoiYSVxIwk=;
	b=1y7VHbhxDOhqzY6TNwkmMLLJ5wswsWcvrngbLQRw2xXtY7SkDvanBaP7dyYCbD8QUYV4
	 lVlSU+qwSBDbOjyAKNDLV8aLXhF6SVCTEu1NQ9DQ/gol/ilbGkjnryT9wcmKEQRNxtrvr
	 DKffnYDgIxuqVhZtwMqhrivKpfhXHY1zhggO+7y/IRvhrH3kysomPB/Foiyd9wTc4mdpa
	 rACYd3NiGR7XXGMmtfEMG2reJOYLNlC5jAh+Sf6iIkZFz98zPCgTKwQwHbW04FpA8E1pv
	 ssHtD5rJp3LTmBRbcTW2Gjhq008HqI411WQ2QrJigSVwPYSgtSi9rii0XjKtwKE2NqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=X90VZJBR;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=OqjQShhK;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C8D606A896
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 22:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5C8D606A896
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=X90VZJBR;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=OqjQShhK
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGLYgxg4118750
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 17:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=4vyY
	jn5UPo/7vDc4ZQ9k3Cq0mbqo2jzpmjoiYSVxIwk=; b=X90VZJBRvXvcQtWvtSML
	cYnBp83zg3R4X+C8UXFrR/0ste+aFkHEr5U77ylXLx4BUEcLYtTW6B1yLY5tikag
	7hbIrco84ujOdJmB2/epEniEGsLrXYXe1ogsWavEfw24C3fPqOCdzA4WKEAhAoyl
	W+BiUtmuvDa6x3vhdpUGfQ5zewpasoXg2DTVzpK9IPd5mjYO/hG+kBfhrQrDAV0h
	TUtAwtC3EWjhSAGNAofYPlS0P3Hgb+oa8+ffNiiYvUKtYpZ8PZri4s2OAy1x1STh
	BOsI2Jk34RJ5O2MDTpfuwmsMD70Zy63yJ+SR5N0pc/kQZMhE9m5dnWGWEc5XOo47
	cw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j0598ufmh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 17:27:16 -0500 (EST)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91f1b3070f2so33598976d6.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 14:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794868036; x=1795472836; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4vyYjn5UPo/7vDc4ZQ9k3Cq0mbqo2jzpmjoiYSVxIwk=;
        b=OqjQShhKdsOzCEp9sDHRO07pMjPNWkhEsx5D9hKW4kZheIOMb36jRTMc0L6Bqe//Ix
         iftZ7ACLorkN1cC+x3lModR96EeXDIMQmNlssDAivIm7xwEBJRBakvSxealfGnpLw8yA
         jpC/fUhORfKNP5xoxMVYgTjOZLcMGEqNvHSb09jtOP3J367nOTh8rVAT+/ggq0642FSb
         Tg+VZvLepva5YrgLaXV/zDo2CURzn3tBpMki+mjgjQxqkRRj5XT9zYQBCBr4DCmr2I4f
         rnEclJLdHDRCXy2OxQtXvH8bW2+p4neBZc2SIFa/BN5OS9ElMNZLdlIKoXBSlHk10bKF
         0Niw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794868036; x=1795472836;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4vyYjn5UPo/7vDc4ZQ9k3Cq0mbqo2jzpmjoiYSVxIwk=;
        b=p49AZQW1541E38dPaxXBSDXW4rA6QNXn1/NkfyVnPaDHJHW25yV2p35SKarOjMxssU
         9rlx7r5RphCghbpcCwuoPI+A4oDrnPSJ5ZJ+Vp0XR6uUajvBgf1N54ozlKfBMXZjIqXk
         RndUfKh5LabsvPa60+xIAhQvZvFovPkIn0fRGSemi8RtvP0qoMtci9JiPRX+HOgGLmXI
         O8ZSkY6yO6ktjRzV9f7k1296YzGGFRY6zLm+4Ne9oIRdEXEHU+tAULvKUHaKEiSk3k0i
         s6j8wii0d/ZxOUjS5Xwi7LEapXrDkZOtGpGP7t+8otfEs13yDAEC1Ion46qQiOPzPeoB
         AXvA==
X-Forwarded-Encrypted: i=1; AL+hErHDGbjDfs6hXKihDt01N8IcXpjPyLyPg8mW8fwMqp4GKnp9dnZ9USlIBw6ClcwpKegl0wVc+mHxBue76V2f@vger.kernel.org
X-Gm-Message-State: APuU4Z9C9MJ6Li5awp/DsFCLCngPdYLX/cxjJMKaD4Hf4tZfHSDXZfIN
	atdf22kq2/m3+7vmfVyiOwM8v2gqO9iQ510I9RwnVsxg70g5xLU4rGxfADcbvQCfW9+b3EIOjq6
	ZYqvw94NyA16mcLMeoiNLi7+0ijadPtumOj8SlIyjQ+NQ4+JW8vFIlqtgODTC7gs=
X-Gm-Gg: AYBFou0b0jrn+57F7DTGGx8VlOR7DbrCSVcEhns43KevhR4+9ExHNZUEKGK5Rbhe69e
	4LCthYUIcp7pjceOKIMWayHIFP3F/EWObMWAFG2SKFVIJPlEeOkaiJv9Xx8YU17rfb95Emsx6DI
	4NQsMZvwrWpRwY2UG1KQr5vwo3Z69XTr9ctJJveEqvms7UHoYnlKto8w14aP9XZBnXnoGis0iSN
	UfeAUemlesp/W+24ZM9GqB7wOoqCsPaTWAr3aSDTeyhMOjOhZM29nILZ07WDslqOx66MbuF+8nV
	UCj7foN4D1muijleAnIUILIPZoH65kvDbpoLbZ5mjQkqlPOFRhj7cJpKZLhsIckwkrOhIBS6F04
	yljSRRZ5C6fbtEwkNUU6SaoGf/yVD0hhYdWxZr4uY93C4vX5rbjd1R8cRDbfzD0FIsdjy/U6KEt
	8F8136/opRIc54l1Hmw4y40rvn
X-Received: by 2002:a05:622a:4188:b0:55d:34d4:12f1 with SMTP id d75a77b69052e-55d34d41f99mr93205881cf.34.1794868036000;
        Mon, 16 Nov 2026 14:27:16 -0800 (PST)
X-Received: by 2002:a05:622a:4188:b0:55d:34d4:12f1 with SMTP id d75a77b69052e-55d34d41f99mr93205151cf.34.1794868035325;
        Mon, 16 Nov 2026 14:27:15 -0800 (PST)
Received: from [10.207.2.125] (nat-128-59-176-174.net.columbia.edu. [128.59.176.174])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55c3b7a4adbsm66513611cf.19.2026.11.16.14.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 14:27:14 -0800 (PST)
Message-ID: <eba4fb71-6baa-455f-8899-87567af898aa@columbia.edu>
Date: Mon, 16 Nov 2026 17:27:13 -0500
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
Subject: Re: [PATCH v2 1/9] userfaultfd: use anonymous memory for
 UFFDIO_ZEROPAGE on private file mappings
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
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
References: <20261116-uffd-state-fixes-v2-0-4397a0196479@columbia.edu>
 <20261116-uffd-state-fixes-v2-1-4397a0196479@columbia.edu>
 <cc865bc8-b96f-4385-97b1-976de4465ca1@kernel.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <cc865bc8-b96f-4385-97b1-976de4465ca1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4OSBTYWx0ZWRfXzGxW/D430FPL
 t0+/Kh5QOSQBDrpjqvM/Jk4B99BdIbVy0FMrKCjeUee4YiC4/6GpyUbTZ/Ej7lpcIDfwAAS9gkc
 0aTbhHbg6zv+Wkq6Hm2xgBAIbdgMINEb2z2ip/9WTBPzwiM0xx1v
X-Proofpoint-ORIG-GUID: OzzshCq0ZOw6Mdn2U8NrH8w2fU2D2i03
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4OSBTYWx0ZWRfXwRHHqA0OpUXO
 +7Syx61WEU/c+pP0sCRbnaTWg/r/Dq4WaVkrpzm0DwayaNGIN+veog+nHjMTJFgVkhqr1pIlzIR
 rYv9kM5CyNbQB5i13yg8kgdjfdqDELUn6ESWek2Y0P6G/tuH8JT2F+5GSwGoTj/7kpVxeuj9oyp
 Cby709NKzySH+sBIUOb9gTc326sNmkfnFL4lD58GmlFEdVd9PLzOxQi6M8cXtAc21mJH2SBb834
 2zJuyQ1Sfdi/IAyzI7pJPqbY1+UESLk0IBkhQ/PUIENpUQuSTu449duaTMLeDArk93AwxUzsFbr
 TgtqT5NdINHKfNfjFa3FJbbmzDhbZEgi9hGXLs6fWhdkumBGCd6nLmekVhykLYFLeys4+zBkt7p
 LVx8Z9/jRfsDxPcjg9kcvN9lya6C0BxWwHjrv6O4xNwFJVo9Dc3DQJMrjEAcluO3McWvAJFROZP
 2fvKOiocZj9+er7KGmQ==
X-Proofpoint-GUID: OzzshCq0ZOw6Mdn2U8NrH8w2fU2D2i03
X-Authority-Analysis: v=2.4 cv=R/aWitRX c=1 sm=1 tr=0 ts=6afb8344 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=KPY1cyGZ6h6m4ASiENTC8Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=VwQbUJbxAAAA:8 a=U30RilsMMHCo0eZBjZ0A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11968
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 clxscore=1015 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=10 malwarescore=0 spamscore=0
 lowpriorityscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160089

On 11/16/26 3:16 PM, David Hildenbrand (Arm) wrote:
> On 11/16/26 21:02, Tal Zussman wrote:
>> If the mm cannot map the shared zero page, UFFDIO_ZEROPAGE falls back to
>> mfill_atomic_pte_zeroed_folio(), which allocates a zeroed folio and
>> installs it through vma_uffd_ops(), no matter what kind of mapping it
>> is. An s390 KVM guest with storage keys or protected virtualization is
>> such an mm.
>> 
>> For a MAP_PRIVATE shmem mapping, that adds the zeroed folio to the page
>> cache of the file. That is wrong: a private mapping must never modify
>> the file it maps, and the file might even be mapped from a read-only fd.
>> 
>> The ioctl can also fail where it should succeed. A missing fault is only
>> delivered for a hole in the file, but UFFDIO_ZEROPAGE can be called on
>> an address that did not fault, or can race with a write to the file. If
>> the file has a page at that offset by then, inserting the zeroed folio
>> fails and the ioctl returns -EEXIST although nothing is mapped at the
>> destination address.
>> 
>> What we want is what UFFDIO_ZEROPAGE does on a private mapping when the
>> shared zero page can be used, and what UFFDIO_COPY does: only check that
>> nothing is mapped at the destination address, map zeroed memory there,
>> and leave the page cache alone. The zeroed folio path did that before it
>> was moved to vm_uffd_ops.
>> 
>> To fix it, pick the ops in the common folio path, as
>> mfill_atomic_pte_copy() did for UFFDIO_COPY: anon_uffd_ops for a private
>> mapping, the ops of the VMA otherwise. That makes
>> mfill_atomic_pte_copy() and mfill_atomic_pte_zeroed_folio() redundant,
>> so remove them and rename __mfill_atomic_pte() to
>> mfill_atomic_pte_folio().
>> 
>> UFFDIO_ZEROPAGE no longer modifies the file, and only fails with -EEXIST
>> if something is already mapped at the destination address.
>> 
>> Fixes: f74991b4e383 ("shmem, userfaultfd: implement shmem uffd operations using vm_uffd_ops")
>> Cc: stable@vger.kernel.org
>> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
>> ---
>>  mm/userfaultfd.c | 46 ++++++++++++++++------------------------------
>>  1 file changed, 16 insertions(+), 30 deletions(-)
>> 
>> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
>> index d65184d9a480..61a712e1f9f5 100644
>> --- a/mm/userfaultfd.c
>> +++ b/mm/userfaultfd.c
>> @@ -531,15 +531,27 @@ static int mfill_copy_folio_retry(struct mfill_state *mfill_state,
>>  	return 0;
>>  }
>>  
>> -static int __mfill_atomic_pte(struct mfill_state *state,
>> -			      const struct vm_uffd_ops *ops)
>> +static int mfill_atomic_pte_folio(struct mfill_state *state)
>>  {
>> +	const struct vm_uffd_ops *ops = vma_uffd_ops(state->vma);
>>  	unsigned long dst_addr = state->dst_addr;
>>  	unsigned long src_addr = state->src_addr;
>>  	uffd_flags_t flags = state->flags;
>>  	struct folio *folio;
>>  	int ret;
>>  
>> +	/*
>> +	 * The normal page fault path for a MAP_PRIVATE mapping in a
>> +	 * file-backed VMA will invoke the fault, fill the hole in the file and
>> +	 * COW it right away. The result generates plain anonymous memory.
>> +	 * So when we are asked to fill a hole in a MAP_PRIVATE mapping, we'll
>> +	 * generate anonymous memory directly without actually filling the
>> +	 * hole. For the MAP_PRIVATE case the robustness check only happens in
>> +	 * the pagetable (to verify it's still none) and not in the page cache.
>> +	 */
>> +	if (!(state->vma->vm_flags & VM_SHARED))
>> +		ops = &anon_uffd_ops;
> 
> Oh, but one comment: why not check for actual cow mappings?
> 
> 	vma_is_cow_mapping()
> 
> is your friend :)
> 

Probably because I didn't know about it :)

This is already equivalent since uffd registration rejects VMAs without
VM_MAYWRITE, but I can switch it over for consistency.

> -- 
> Cheers,
> 
> David
> 

