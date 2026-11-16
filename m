Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794870033;
	b=RshW0BB5XdeHjiN6jgRl8mxI6K2Zgu8k+gC3/rDwRx9Aq/i6+UaiUxJL4D4HVh63BZji
	 hAF94UC41YfEWJzHQGRIOY7Dj64I6iee5GhM7apDb4B88Bk6Y352861spkxVMlm4Z8Imn
	 8puNSnyTILauGezlfi5K7oT3FrCzkRZjq0UGrgXu/8Aj8R9kg5JpOvWtejVpvIiPJ5gPK
	 AgGyTyHaoo6tO7zD58RhLj3RjV2nrO3gmlfrDJybAdiAZB0KolTGftga0o9G59TNIEgxL
	 mxUg0Fl8zuo72Jb3m9JI+S2G9CPg0iu3NoRHUn5yw/AjPOaOI5ETuPXgoKmJAXeAEjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794870033;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=DrgpmsI4pZAgdTESjomnSbj/5rvp+0MEGWpwnCYEqBw=;
	b=fi4b1G3tpqHeNFDNd0/pE5mM6VFO08N1jgjthIDr8RzdFei+ZFNS6JtI0b3BXBm/CfAv
	 fBbLqg+hMtFhL8Lh/nTPsrolEXGLfBmzCQ3hJNtEPThYiYYH7wFi/I8CGW6xjhbeZfwgl
	 9cvqF8I47Vh3jHGswENYrj54J1Iu7i77nB4+cVjPABbu9K7GYO1lnsKlPf/0XIC2Mb/ZU
	 QY/SQX18e8glEyYtqNPGJQ6Irs82TC1UYSmFKHxyk8acmdI5HeOkoYXheTv60nwtvc6vm
	 5DvPQsSH90v3Gvmrwe61PwnRMU/iAFiovymW+/98rQ3C8WAL+s9S0I4faSeTkMYgHtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=h8wEBqzH;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=BFjhHK4l;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3BA606A323
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 23:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D3BA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=h8wEBqzH;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=BFjhHK4l
Received: from pps.filterd (m0499199.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGLZ3Gw1764936
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 18:00:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Drgp
	msI4pZAgdTESjomnSbj/5rvp+0MEGWpwnCYEqBw=; b=h8wEBqzH/LUQm2YIPDam
	ND7PzYl7uX5hIzo2H0E8IKDCqczu8OQeKthgNbyHKXTJfqvSE1AtX7AAH2ET3Pu9
	oUi+s/Tw/pGr6XbXNsOFIHyuqVr/eymttT+JD9lfGEIFvEU+t68KaAfZMGuvgZGC
	EPqnwVbxA1e/RV0HrgZFSYEQGufXuJyADNwvF7rXlwqDTv6a9rxCno3HtH35BVqu
	dNoCsC/C52eCB/S5mqu0BE1pEp+1BE45cBw9QnZZM9wJfJxApwozwjL0m2qnxzYi
	h3Bmq/eFSDsyc8J6WMJK8ptkqkrqft3msvZ/6IPtZShkIH+QA63FRoOsRbuLRZ3q
	ng==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4j059hkg59-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 18:00:31 -0500 (EST)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f26dd2165so1210717585a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 15:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794870031; x=1795474831; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DrgpmsI4pZAgdTESjomnSbj/5rvp+0MEGWpwnCYEqBw=;
        b=BFjhHK4ljRVRILIbwHroulBB2Wr9dUUGiqSgPkAFrEvHKoLi9D20Z4F14LpfHNb2+2
         MU5lAddgpnmIy9lgmmLNSgPwZeDsxXpNTLFEP8c+7vt/hAWUtWjgiHTPnZcmcmI7p8kt
         LO0RJ2eRebxQDIGulXlC5d5dXy1xjr/SnJHh6/JYOzxBYeBMvCAUYk+t3Q99Zt5xTgYU
         RLnZnM+8tdJg/VpgDS1BT6YF7skzh5jB7xwAURHM1sfd5u7ZY3UaIHiHrW/Gv3biAp8u
         xNZCtTHVBCNZ90iMncQch0kRoRKTvNksohnWDPjJVcXQv2ss0AJJh6EE2pt6WNx1EH6t
         Sfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870031; x=1795474831;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DrgpmsI4pZAgdTESjomnSbj/5rvp+0MEGWpwnCYEqBw=;
        b=hG6B9HIGuTFev5pxHobUleEZfZIU0uGtThIW9w6eSz4B+fBH7dFvNjJrxNT1Akhlei
         8bInxnPwdf96DgZM6FgQPSJO4csHsxS/I7SvW9/O6d/7X6is7JpShBY+KS/2Lwq0HyUn
         74HnlWnPjwG1JLwCCFFvLnp7TqzufSytKB1I7xG307vbualsSjw2L+tkHwtIY7fEJCVJ
         fJwyvqmKODz/fzqvTOhMdHnxV3hw9cuBy+tP4LaxBUJH/aViyP2TpAXuFRZnWLcxQ/CE
         v1vHxxps0bTtkE8NIw5XWWhjVBzivZJmHXSQeePq5Tl7K4WwYY96hGPN6b+VT2vAymwB
         9Big==
X-Forwarded-Encrypted: i=1; AL+hErFV43Da0atKN7c/KkCLQqL61HO+wuaP/h7vMePUFNwTmQn3M3sefAnoqGIeOzErCA75av5/by1xmFCKT8XK@vger.kernel.org
X-Gm-Message-State: APuU4Z/9K/69wUcI7Hs89MV/PCAsy430l7u41t2houG+1kmEbtDehbqf
	ZG+mWypatYoO3RgsuSUqTXRBdjhjP4lNIlFPZyLwMZdVWHc9X4S/z25WcV4u6z4PYU7ZJYrl7fg
	ipAJVjIXsAy4ufsNCRrGbMVeEjyU6z7HCq08vclsiv3X4st3TuNgFXN5MNez0AR4=
X-Gm-Gg: AYBFou3PJdJY5W0/mxqm/am7p0cxQ5Plhu9jCroHh0peYAq4BiTFDX3+wfrSdPqgl7L
	dQ8qVP2xbmDLvW5XW7JarrsrA3Bp9GVbaFAPkZlx2t99b1GY7xBbGzkz3ddfIBssC3FGY8e6r7K
	28WUrDNLxukJoFQJvnUcx7i7q5Tdk1emzALhIPDrh2idm2E21IDr2Dg7gqRSJWrNJsYutVQ5e5W
	Sv6JPBAgoz7OZ+SFKZqX1boe5j9Yp+4J9g8D+0enF/xarDZeWKM+LMGogHBh7kmtqzO1P7kpoOe
	bzyXpGBx2fEgz/ZlCQydskHlRWNWJP+7RweSe9SWiDtvbEQbn5vuBS1i6GfQnh9n/a99V+mr6uQ
	weFRjEHBVw756WyKtkwjzln2ZRbZLxltz7I/4FayRvNJm7sebu5WdukHkRHvKBXwZi/NpmEr+RX
	GxhiSdkAzOGXWKUePh4AOVp2TX
X-Received: by 2002:a05:620a:2a04:b0:949:733e:dde5 with SMTP id af79cd13be357-949733ee773mr1059319585a.66.1794870030829;
        Mon, 16 Nov 2026 15:00:30 -0800 (PST)
X-Received: by 2002:a05:620a:2a04:b0:949:733e:dde5 with SMTP id af79cd13be357-949733ee773mr1059311385a.66.1794870030135;
        Mon, 16 Nov 2026 15:00:30 -0800 (PST)
Received: from [10.207.2.125] (nat-128-59-176-174.net.columbia.edu. [128.59.176.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c831b7dsm952569585a.20.2026.11.16.15.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 15:00:29 -0800 (PST)
Message-ID: <c9d616f3-d442-4db7-8010-82aa052baaf7@columbia.edu>
Date: Mon, 16 Nov 2026 18:00:28 -0500
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
Subject: Re: [PATCH v2 7/9] mm/mremap: resolve uffd state when the context is
 dropped, not during the move
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
 <20261116-uffd-state-fixes-v2-7-4397a0196479@columbia.edu>
 <20f100af-c831-4e37-8077-50f6366f323a@kernel.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <20f100af-c831-4e37-8077-50f6366f323a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: sGBUWHCoIkYWnufRdgsoSkZRAnVU8M6B
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MSBTYWx0ZWRfXxQtl++K47rDz
 ku43QLa0B1xfWzY8/FQ0t0iooowjXFx+CSUOUpBURwDDujVPUvdu1vIFgxns0qofyJbWdokGh5K
 NLf1hgdzahnXVDqI9LL5SETaRbByF4uLJglwcrtR15Yyter/WMrC
X-Proofpoint-GUID: sGBUWHCoIkYWnufRdgsoSkZRAnVU8M6B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MSBTYWx0ZWRfXxluwWEDNcIvv
 D2phKdFLEL6KBhK7srKoxACTpFtgJ/Lis1I5xVkEop4VKJWh9C/mmXRM0aS4ishxht1/zvQmiPF
 R39Zbecs3eabgKBaifFhYaqDHT88psMJtRzTWGhuOuvBoKtzbRV9Q2g3mBPVwmOvvkqE9D2z12u
 7ZH3D2hvKrlI4MOIgIKVxLRLtVsuENqLUy7DaX6OlBJHvBt1tsPDEHROubt4kLjHQaJ51UTlTtB
 iLnS0pJs44S/9hOTfdR9P4ZbCPB3CfPhKZAEEqoc3A7VKdFdhqWZfKPBcgPV8cSkJjwYBbMAKIJ
 FVs3fFEX96seYPouvEWpi21in485PnIAPP8K4v/JrVP/sZ+Q4eid81LoO2tA4ei5JDRs0AWQyJt
 /ayL5ljNRK+pMKNQYG4TcOImxXBiJiGh+Qn/ZkauqpHS2XlhMWyD2tPAUcdOohOPCmkUhCHrzGs
 T17kJ6CGgWARYpCU8NA==
X-Authority-Analysis: v=2.4 cv=NLlAaE6g c=1 sm=1 tr=0 ts=6afb8b10 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=KPY1cyGZ6h6m4ASiENTC8Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=G--0XuH5328wxK7v7Suf:22
 a=VwQbUJbxAAAA:8 a=tHa68p0SAAAA:8 a=7zGzU32CvNdQK9yYqCEA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=ufIsyHvWW7FwcMbVRpPq:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11968
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=10 clxscore=1015 spamscore=0
 suspectscore=0 bulkscore=10 lowpriorityscore=10 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160091

On 11/16/26 3:41 PM, David Hildenbrand (Arm) wrote:
> On 11/16/26 21:02, Tal Zussman wrote:
>> Without UFFD_FEATURE_EVENT_REMAP, the new VMA of an mremap() is not
>> registered with userfaultfd, so the uffd state of its entries is cleared
>> while they are moved. If the move fails halfway, the entries are moved
>> back into the old VMA, which is still registered, without their uffd
>> state. Writes and accesses to them are then no longer reported.
>> 
>> To fix it, leave the entries alone during the move and clear the uffd
>> state of the new VMA in mremap_userfaultfd_prep(), right before dropping
>> the context, like unregistering does. This walks the page tables of the
>> new VMA a second time.
>> 
>> This is done with userfaultfd_clear_ptes(), which also makes the PTEs
>> writable again where that is safe. That removes a spurious write fault
>> per protected page on private anonymous memory, but adds spurious write
>> faults on shmem and hugetlb, as change_protection() makes writable pages
>> that were never protected read-only. UFFDIO_UNREGISTER and
>> UFFDIO_WRITEPROTECT already behave this way. This will be fixed in
>> change_protection() separately.
>> 
>> The entries no longer need per-entry handling during the move, so drop
>> uffd_supports_page_table_move() and clear_uffd_wp_pmd(). Whole page
>> tables of these VMAs can be moved again.
>> 
>> Fixes: 0cef0bb836e3 ("mm: clear uffd-wp PTE/PMD state on mremap()")
>> Fixes: 763f43865fc4 ("mm: preserve RWP marker across PTE rewrites")
>> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
>> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
>> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
>> ---
> 
> VMAs should be write-locked, so nobody should stumble over it and walk page tables.
> 
> Rmap walkers can stumble over entries, because only the page table locks protect
> us here. With your change, that's now actually consistent while doing the move.
> 
> I assume there is now a short period in time where the PTE bits don't match the
> VMA flags for an RMAP point of view, essentially in-between clearing uffd state
> from the VMA and clearing uffd-wp bits.
> 

Yep, there's a brief window where the VMA is registered but PTEs are clear,
but that's fine. That's the same state as a registered but not-yet-protected
VMA.

> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> 
> -- 
> Cheers,
> 
> David
> 

