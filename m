Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794858160;
	b=MAyFQ6ywK+15b195ytVPxBDpKYU4zEj1IG3ncKAjXHjJ9Ig0OedaMaEFlwNk31mPJb4K
	 Jeh52z2zMqQ90VtnafepRmU4KbhEWD7m4uHUIkCC3Uj+ibFkDkwgQFM7LQfmF4dlms0yN
	 OKh0OhGqsHURX8EVSx/0KR95U+BfIIvmMSKOxWFBC5j5A8YtexV2fwT+U5VOkWLBF4bre
	 7VDWMrFjRZ+ZCdMn1uD9EqznVbOes388ZiPO2AUndYH6mi74W6AHg9V0Kz2lqZ0BJt2dj
	 My7HMB3qpXegC5YjIYcadz05oTP5nz0FGl2z+Xndlf9KSgDo2jc+sZrOqHfXzEXDSFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858160;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=rsV5fz/GetvcK4qfUxJCgNAEtXbvKRxmLJMOtlw7few=;
	b=l+3RleuN7rDW4H28rAVSQclIfe/GAev1Z0kJYVg8GBTHKQqgAFPP5bRkNKYV5uugpD7z
	 jri7dqVx99h5kmJMDRdLBaGoz+BRguEkBpLszJC4O5JD5fh3aTfeL4dqdmVGu+AIqhNZN
	 UEcQ6simbJNm3ObbcVxc4dEeKqM9QDj74Rr/ZdZC1x1CA8MFLdLKZgXKdVxlenkfM2i7y
	 MlEOmCMX5eiPNXiNRonGOUZXPsYDbASRGhlTajdxqzsgB5HgA0KNuZyvu8OW8QZUozRVa
	 qN1R1HQiRmg9NbiA7bbLErd09NEk9ZVKueFiMzwfkScrDPTkKAs2pXTC0MQa8NUuF3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=eQYdpnhS;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=skdAqn6+;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0916606A335
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 19:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0916606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=eQYdpnhS;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=skdAqn6+
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGJXJ8X3631365
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 14:42:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=rsV5
	fz/GetvcK4qfUxJCgNAEtXbvKRxmLJMOtlw7few=; b=eQYdpnhStgsz1ZARwYMw
	SZWyfH21wyxWchOhNuaMT/qOqp8F0Sq7t8jp/0r9X7F3mRHMF+0MVkFz746vxSXx
	PQmB/g95c/MwKXZVcERW2Ybproa6R2b4vCyPIIXNVljQvMytOl6A8DqWTrqe/+c/
	n8Ff5v9HqrDSXmN3eaRr3Tx6UqpMRKu66pJrFj6GiHOZb5PYMux9dkYdkprCQvbR
	4Nj15DuO+H5ZTUschfW84UQCrh7xYhDlZxqic+Opf/dS+q4kNZrn7Pgyn3nwQUBt
	pgg6Xke2UK/hPbEDGSNDCgzH+w6q0PGkq6ji/1Z809wtugK+T5lsOiURv6bB/Nyh
	Zw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j059aswbt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 14:42:32 -0500 (EST)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-94975041698so48542785a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 11:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794858152; x=1795462952; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rsV5fz/GetvcK4qfUxJCgNAEtXbvKRxmLJMOtlw7few=;
        b=skdAqn6+lVdny994UpQiVpqzjf46sIrloRidKaSfY86WwJraoAuq3yCE9DNIFbHzzL
         8qqJAjwFxerZQ06F8pLh1zG8K3RJ8RFmYaS0YLq5YLYW2Y9Uz22PpXUGYJzc8e9r69U+
         r45m7NvnTXv1j5C8yZWfW+1+Mb6IALpJdSuhjvRXRoTw7y7jHxm1p7V+J4p4ICoTvWtC
         En+F4kdSzz1LSQJz1VHTacgjJ4a8eGLy343Pfs06YMXatu0eoSrMUJH2PXXyOwZivlMa
         dhMJIxXKzYDJwLtW8EBFl0kdPmHCMecFwrQVrfkKRqM/sz6ECh5Y/h/xTrmTnMi++5d+
         t+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794858152; x=1795462952;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rsV5fz/GetvcK4qfUxJCgNAEtXbvKRxmLJMOtlw7few=;
        b=ruhjWVaESxuPobjTx9UdOZBRlaA7ayiDveEcsI/2i35gu1CABbY8+Xj7/FqEbQhwXq
         dTihsnL7Xtgw1H+HxBbvFZZM2JPaOmuc3Q5fxfiAaPne1K7DxGCIqvcDOTV1D014g8Ok
         /24ohbmqtxl2LNHJV05XOWflBu3/8vIYfIKmPhMWM4Wa+LFeZjLs3915wxLpNhHBLI5I
         fe5oM9Yt/rvXq+bzJX/PhUro2hsd/Xrc6tsGx4ic2zpirGPx2l99b4gippdosEXk8ztL
         Qn+sblnvc65GithTuWKiPEwGete9C1M5zXfp9wFunZ3tm20hjXQoXVGiqRfN9A7XCDUj
         g/Dg==
X-Forwarded-Encrypted: i=1; AL+hErFpD/zcUA+aGb7AWwBYdX+FWAe8sxjdwHdwkP0BshoLAvZtFdIMUxvIcLQCTymBKIvGNcuJ9X35NhO+Jfmo@vger.kernel.org
X-Gm-Message-State: APuU4Z8hStr0798CIwNu1QvOHzpwKiiD7I0xPojqMvS0gZBDY2pIDrZm
	xQX7k4MlvVVzn0zyHbDGjy7Mm/6CwhPoVlXEHm73uOMnDR5sxLXRzh2/CpfzDoc+gi1+KTqYjH0
	OAFNmE00WlPvg8OCQ6dhL0Xl1qqnOsGfB6SuotGI+kfUK2nazh4rnAO4Q2J3aBZU=
X-Gm-Gg: AYBFou0x+oZdIvN4gpzTaphG9g+fpmeNTRKZTc1XH4Fd9jExh/gFM9jr1g+5sSFNbBQ
	5zuG9rQ6MIHX78YRVCxaq5muQFMF0JZK+M7EEMFEB/GvLQU9pRBByqJdxel0/KK61LyitMHpMh1
	q9iqMenOD4qvAhtSqehpUHGJfs0eTImHP2UrOEzOxBL0plwXBjLPsPe/rFhyAMW/uwVrELHZMPm
	ac6v1zUXRbu4wupW7vy11WNNjNU2JY6bm+QwWF2UwF3a/95OxRCON3DybulKdnT4e+7j8vIclmt
	p2DoVwpC9E4hkAO9gwIy+c6nz0w06PYkkntRk9G1RvrY8OSnJFLcdIBC4LeLefgrKrwdBTCon5X
	0bnRY5VyIK+to6BAviTze1rlU1ZffAPF9sxsMA87xXgWLKE/sKuXVNl4gDjsm0Iqr8fBTnN6Xz2
	Bf1h81QiOLU6/oYi+56p4/YgNV
X-Received: by 2002:a05:620a:8018:b0:93e:5677:317b with SMTP id af79cd13be357-9498b91adc0mr77552585a.25.1794858152271;
        Mon, 16 Nov 2026 11:42:32 -0800 (PST)
X-Received: by 2002:a05:620a:8018:b0:93e:5677:317b with SMTP id af79cd13be357-9498b91adc0mr77547785a.25.1794858151779;
        Mon, 16 Nov 2026 11:42:31 -0800 (PST)
Received: from [10.207.2.125] (nat-128-59-176-174.net.columbia.edu. [128.59.176.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c608c5debsm23147293f8f.42.2026.11.16.11.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 11:42:30 -0800 (PST)
Message-ID: <c2f81bbb-ea3e-46d9-9c07-6786bd186797@columbia.edu>
Date: Mon, 16 Nov 2026 14:42:25 -0500
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
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, leitao@debian.org
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
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
 <20261111-uffd-state-fixes-v1-4-00713d368976@columbia.edu>
 <avYG7CtQ52v3I8tF@gremlin>
 <f28dc841-f664-4f97-9dd7-bffd2825115e@columbia.edu>
 <avsV68cP0rp5mWSf@gremlin>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <avsV68cP0rp5mWSf@gremlin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: RNzrPXhqMyfrVNiDETSMov_ucxCKnQLL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA3NyBTYWx0ZWRfX2G/09B9Y3Dko
 pHVOCdljLSJG3i4tXUJtn91TK2TlsT5EppLlBT008hqcnDLGf3QpJdUCy4pSIHA6VocRZid2oyx
 o//jochftj8w5yLmJ2RVQ8ARonyT2k2TVI5ldzXbXCbQdMsFPfiR
X-Authority-Analysis: v=2.4 cv=Ta0DJhQh c=1 sm=1 tr=0 ts=6afb5ca8 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=KPY1cyGZ6h6m4ASiENTC8Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=eaRlbwK1kuk26zd7Q68A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA3NyBTYWx0ZWRfX2NR3O5AMLFmm
 ubTweOrT/nRMH4wwA+jqUHQgOaeLPM+yVO7G//J4j6OuXvsL2QHZrwNjpiEasAFW6OCbBaorXXS
 JT9/kLd82TF/2EA/8aZ9bZkgc/zCIT7Vu/fC32kaazLGrftUfLe8aHbuVWozfC3EcuU2U1J5sl7
 /82npYW2qlTBLEIaw1BhTbDFQaFf114LKayilJYDA9p1e07pn03qfYxNnrrjY/7Pu3zzG/PgZwx
 ALiAtoC6RcktpCOAsdFSR4MUg6Dzg5Pv47rBAWQ9sMv2ObXIt0WQqx7r6+15VZzUT8hKEeQeK31
 KSs8ijFWrwQv6cteexu9U6tF24gxGPO2QMyG71m7VQSeOyJswHDIBcF4bc8FsR8Ip9bvdgOK+Uu
 AAPHUfLO9JWiMjVPunreAYAtcvkR4KNch3in6pNixbiKe04DlxOGoXRtbFuhnpUlQLIrScTvDDJ
 zxQor49C5KEcRhWlzVQ==
X-Proofpoint-GUID: RNzrPXhqMyfrVNiDETSMov_ucxCKnQLL
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11968
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1015 impostorscore=10
 phishscore=0 priorityscore=1501 bulkscore=10 lowpriorityscore=10 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160077

On 11/16/26 9:41 AM, Lorenzo Stoakes (ARM) wrote:
> On Fri, Nov 13, 2026 at 04:59:39PM -0500, Tal Zussman wrote:
>> On 11/12/26 1:44 PM, Lorenzo Stoakes (ARM) wrote:
>> > On Wed, Nov 11, 2026 at 12:55:12PM -0500, Tal Zussman wrote:
>> >> remove_migration_pte() makes the restored PTE writable for a writable
>> >> migration entry, and only looks at the uffd bit of the entry otherwise.
>> >> A writable migration entry that has the uffd bit set is therefore
>> >> restored as a writable PTE without the uffd bit, and the page is no
>> >> longer write-protected.
>> >
>> > The UFFD WP bit is such a terrible, invasive, broken piece
>> > of... engineering :)
>> >
>> > Notice, again, the hallmark of an utterly broken abstraction - every user
>> > just has to happen to know to handle each of your weird edge cases every
>> > single time they happen to interact with anything that touches it.
>> >
>> > I do hope we never merge something as bad as this again.
>> >
>> >>
>> >> An entry with the uffd bit set must be restored write-protected, whether
>> >> the entry is writable or not. remove_migration_pmd() gets this right: it
>> >
>> > Sigh :)
>> >
>> >> makes the PMD writable and sets the uffd bit as two independent steps,
>> >> and pmd_mkuffd() write-protects the result. To fix it, do the same at
>> >> the PTE level, where pte_mkuffd() write-protects the PTE as well.
>> >>
>> >> The only known path that created such entries is PAGEMAP_SCAN. Now that
>> >
>> > Wait what? :)
>> >
>> > How does a read-only scan of entries create softleaf entries?
>> >
>> > I think this should be explained in the commit message :)
>> >
>>
>> Will add a sentence... unfortunately not a read-only scan...
> 
> Thanks! Yeah I realised later the true horrors of what PAGEMAP_SCAN can do
> with uffd flags (ugh).
> 
>>
>> >> PAGEMAP_SCAN downgrades them like change_protection() does, we should no
>> >> longer see them, so this change alone should not be visible to
>> >> userspace. If another path ever creates a writable migration entry with
>> >> the uffd bit set, the page now stays write-protected instead of losing
>> >> the uffd bit.
>> >>
>> >> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
>> >
>> > This seems like a super-weird fixes target.
>> >
>>
>> So this piece of code was added in f45ec5ff16a7, but the issue derives
>> from PAGEMAP_SCAN, which is the commit above. I think 52526ca7fdb9 is
>> the right target, but can change it.
>>
>> > BTW I've noticed you've not been cc'ing stable, is that on purpose? No
>> > autosel in mm so we do need to do that on stuff intended to get backported.
>> > :)
>> >
>>
>> I added stable for patches 1 and 2, but for this one and the previous patch
>> the impact is PAGEMAP_SCAN reporting a page as written when it wasn't, which
>> over-reports but doesn't lose anything, so I left it off. Maybe I'm being
>> too conservative though.
> 
> No that's fine, if it's sensible not to then let's not.
> 
> Was just checking to make sure it was intentional ;)
> 

Looks like Breno hit the warning fixed by patch 3:

https://lore.kernel.org/linux-mm/avNEgmvYdoukt6MS@gmail.com/

So I think Cc stable it is.

>>
>> >> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
>> >
>> > The change itself seems reasonable, as cursed as the reason for it is, so
>> > with the fixes target confirmed + commit message updated:
>> >
>> > Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>> >
>> >> ---
>> >>  mm/migrate.c | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/mm/migrate.c b/mm/migrate.c
>> >> index 28a8d7734735..d200f64b5f98 100644
>> >> --- a/mm/migrate.c
>> >> +++ b/mm/migrate.c
>> >> @@ -399,7 +399,7 @@ static bool remove_migration_pte(struct folio *folio,
>> >>
>> >>  		if (softleaf_is_migration_write(entry))
>> >>  			pte = pte_mkwrite(pte, vma);
>> >> -		else if (pte_swp_uffd(old_pte))
>> >> +		if (pte_swp_uffd(old_pte))
>> >>  			pte = pte_mkuffd(pte);
>> >>
>> >>  		/* See do_swap_page(): restore PAGE_NONE for RWP */
>> >>
>> >> --
>> >> 2.39.5
>> >>
>> >
>> > --
>> > Cheers, Lorenzo
>> >
>>
> 
> --
> Cheers, Lorenzo
> 

