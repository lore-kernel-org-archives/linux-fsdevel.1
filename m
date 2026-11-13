Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794608824;
	b=NwLyaam8QZn7MKXPLhc+JFUkn8XrcMwzD6r1E6UBq5bdzDY59FLrIsEmfjI22n8KwakG
	 Mvi96A0OyEC3XN3Hrr8DPUi7eV+GEX0YqkbFhRJ9XGXH2Gvfpqt/h0F6FMZcksAKgv072
	 bJSDgyLTrTcwRIooPGsL/HMzZ8hxYWgf3jYjm61izX4zbApynCMOWm95knt4HPehjW51Z
	 fR368UPwErpkhWhqPIW5OdfOzzPQ50UVgSyP+XjYlbYMO4FMvpMI+qWEyLi42c6FpiGWl
	 +t3zjw73m2HJNWHNZLEOYOkD9rQ2+9FFCPPe3DdjD10aZIcLZXAG7IQFeJzcVWPGTAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608824;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=d3ajvUnUKvbfDkC0sZyMQAhOCqZi8Pjte/39RE1cKJ8=;
	b=gjLH6IzeD9IR95L7fu8P7dGwtDyZx/QLW/ADTZP5ME8PRxF4/++xtsAs6IFDF2CLoClu
	 VDR5zVeMLLEj+3kX/5MBhobKg3NKQmNlNxhBSOeeN0Lvzpfxxg0wYAr3a8nvL3ft2G/fP
	 wEpU5+sSMfioBfIbSTeHPbeTi4nR0Jz65bS6hcMnijypeZuMbGEbdAIlsTPPjjVufOEIU
	 AaMOeWsCCnaIfTuwvq1HadnD3dmkDOxeQQEXDF0hu1uEx5yeQ1v6aeyLpKYUbEq0p9vcj
	 zi6YdSJmOIyM/o4ewMkoz1MZCQ43P7vqvUwHWEFGkgCVPs8ChCGd/dU68KDuodwn9bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=HGicbANG;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=u0UsTmDL;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1976D606A327
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 22:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1976D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=HGicbANG;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=u0UsTmDL
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADLmR7w1229947
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 17:27:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=d3aj
	vUnUKvbfDkC0sZyMQAhOCqZi8Pjte/39RE1cKJ8=; b=HGicbANGO9fUbtt/aiBn
	O0sACCFk6E8cmIzgCKsA6nhZEdR0F7t9f2sulpxbXAbF/IKZuu/jWZ3k1aHAMYl5
	Gyzsr6ysglkRCuVhPwS0miRm3Jc69PfXSLEEw0dUQD0DyScKj225DNGi7R7gEFH6
	TW9XgQgXErQ+NRu6TcRjYquK5cRK/B656dBLMGr0L3iUfXE3Rt9siZxNJzWSSmBp
	l0DbMRJvG/SyMolN8iAnTNIsXWNZQnRoIU2TYs5MHLlwvvlSyXx58IBELc6AlaZb
	pG1aBzZYZSS7kZrJ6b5exQE9kIATQ80gcBS2/hSSkq+YnAnjo6KL8ZZAHA0U5tVt
	sA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hx56ykm92-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 17:27:03 -0500 (EST)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91f0938c499so23627056d6.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 14:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794608822; x=1795213622; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d3ajvUnUKvbfDkC0sZyMQAhOCqZi8Pjte/39RE1cKJ8=;
        b=u0UsTmDLKYO6k/GFcpFNcNv1WPSYSVTlOm2DbH238vHUR4sYPucywXaRgIJR0uVvP1
         UrzegtEVdrCW2naF1A3u9fWYNl//kQlIJw0z2Tj6MmBUWrqYgWdwxmJW4RM/4liPJl1v
         INQVKg51ZEVQnaQw4sJhfagC/iA54AbyYpS3tebRJqGexBaP5XVHSSli2JQeKesqMxs4
         GcLAiOG5BAGDvjayPf+GBcIIWTnCw9kCnASclf7sz7qm447EzuwqNGWx8I1QNXgR6CHT
         ZCD6ZeWYoLeRg705bJkgqQVkdoXZXkrU/CJXvpRUv6uBAu54DgnGQOse14GXsyU0k7RE
         INtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794608822; x=1795213622;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d3ajvUnUKvbfDkC0sZyMQAhOCqZi8Pjte/39RE1cKJ8=;
        b=0nS0CxE9ugDaA43Cwjlhy4iOBX8gnatVTRZpsge5BVB2bGF6pbiUOa7iUuUr7KgvwZ
         8aFi6dpm0d/QMs8MFneg6gmALCs9aJiCqW1+goXz8flFZDApUaBDmJLkxQX0o8Kh0uAs
         klaLkq08+kyJHwQ9Wu3kglV3NJJgPMtWCO02gHueePf7LL8diLprtY7sfPASST2V71fU
         fLP3l0fdBYffkSITZDjCykRnVOuiY57gshbeju2+WhPrcqqmJKBNRxyFWP0P023QV0HN
         dzd2xXNCiwaY7emFyQag/1C8FkI9/SbMKihDxn8LL/+DL9zBOwj6J63bExCBz3jbbtB/
         JbDA==
X-Forwarded-Encrypted: i=1; AL+hErGJEGnUtCz/h5oSNFSoUbL7v6S15d/QwBExCGH8F6fT0wKrQLYAmKZo+WGzU8Nn754vCr1m7wLgQLtURRoU@vger.kernel.org
X-Gm-Message-State: APuU4Z+O+YISCxF59bXrhxmr3jttbzNpdqA13m74gAB9RwHzgBcsz0zn
	17e4BUyFPByoGCHze6gDaG6y9Pyg1zhKv6CrUZM4nwUKOOOtVlRjnOrKQtoslbz2ClGk35Qxv2+
	dXEHbiAzU7gD99RuOabHsxihQc1NIHmKcJ07H7fbDaSiG2ZfHWLaOJK4JLnYNlDQ=
X-Gm-Gg: AYBFou2qHBfbQIvHd8QXVCV7FXmuYaKNJTeqeUh8q2g43qTa40VmyClloRQVAWDx2LE
	wnvjFrePEI28GJnhzCwVpJUOjb86BejE1fpGJrQTQJbdcjoYjU60nB0q0iyb5KreUpIgRmBtjTU
	jE2Uj8/h0nDvEiJrKYg2+DA/YNiQcKTcJK8VWGrRyIxGiM0SUyg5FIv3v8IHx3ZxQfTcLPZCQXo
	jK3LFNA06kQV0tPVADyrmH0Ui8YWg3gMS318prPk/N4DxQvsc2ck1myhkWAa39mducQ6TGiau5n
	DRa6zaC78sekD0FhZ9wZSzq1g2HeUbf39URM2qCHu1jhxDHYK5DV+ej16xPeP3YWnhH9hfXYdhd
	IrM/mh0qYEJNTemlKOqyRi297TxQ7J8pvzEM5MPEepx5/kIRGlnHV9nRiCzDnNmh6G6VQujrnoL
	NZWQRprFwjG4fMTXO3hUx7wqovmQ8=
X-Received: by 2002:a05:6214:8093:b0:91f:26f7:281b with SMTP id 6a1803df08f44-91f26f72946mr45436826d6.43.1794608822135;
        Fri, 13 Nov 2026 14:27:02 -0800 (PST)
X-Received: by 2002:a05:6214:8093:b0:91f:26f7:281b with SMTP id 6a1803df08f44-91f26f72946mr45436426d6.43.1794608821604;
        Fri, 13 Nov 2026 14:27:01 -0800 (PST)
Received: from [10.207.116.169] (nat-128-59-178-153.net.columbia.edu. [128.59.178.153])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d73258sm30148506d6.24.2026.11.13.14.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 14:27:01 -0800 (PST)
Message-ID: <c3a51a9c-083d-4c76-9a62-b7a6fe69a121@columbia.edu>
Date: Fri, 13 Nov 2026 17:26:59 -0500
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
Subject: Re: [PATCH 08/12] mm/migrate_device: do not migrate a uffd-protected
 zero page
To: "Gregory Price (Meta)" <gourry@gourry.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport
 <rppt@kernel.org>, Peter Xu <peterx@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Balbir Singh <balbirs@nvidia.com>,
        "Liam R. Howlett" <liam@infradead.org>,
        Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?=
 <mirq-linux@rere.qmqm.pl>,
        Andrei Vagin <avagin@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
        Muhammad Usama Anjum <usama.anjum@arm.com>,
        David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>,
        Byungchul Park <byungchul@sk.com>,
        Ying Huang <ying.huang@linux.alibaba.com>,
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
 <20261111-uffd-state-fixes-v1-8-00713d368976@columbia.edu>
 <179454988585.482102.2051616940227067987.b4-reply@b4>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <179454988585.482102.2051616940227067987.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Jo5kP84C c=1 sm=1 tr=0 ts=6af78eb7 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=Y+j3KQtDOE8TDC6EXH/Ajw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=zVEXuFSi5soEGCQpuH4A:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA4OSBTYWx0ZWRfX1vNnOOJ52sVx
 7wRZLGh8cp0k8U8liQ+DvHvkCGdYOlk7cT8KSE8LkiimsVbYzbQfd5A3HftKoq/muBKwrfVcG3/
 T70CzwN0QVg0bs/fvQcwrWpKtFbR5XMaJadcWo94D3C8Q8iQH3Gt9WSJq1v6W3SGa+0IwMQnfIm
 IRHQiR3C+GdYYEfuwSq05ed7/Ibf4e6hMiaYaBs0Qy6tOQKmxlU7EvE6PvAocgP1Uc/XWxt48QG
 KZF90H1RLg8Ex90iKNpk5TMeZS1BsYh3ca/jxiW/OlcI65JhYhCQUv9b9avJBxUf5GOzWU8qpAL
 Zdi1CqvuHd3Vjbo61UhNgvX1NRlHS7eagwMYkOxcXiWsbUHS80FpeacC/fwe4Iq9Vv08l348Z4g
 I/1Cp95zar/UdA7JmmuIHY/2MaWMWmqHSDyRc7ryebpOgNb3kgp2bzlWoQhXLeZBYazhN30UY2N
 tYKjkLh7n4HDFwAv+TA==
X-Proofpoint-ORIG-GUID: zX0dMtLuLioJFyhnZH07OmdKu6zIa3Qz
X-Proofpoint-GUID: zX0dMtLuLioJFyhnZH07OmdKu6zIa3Qz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA4OSBTYWx0ZWRfX7Xb9mcPwnmUW
 b0iJYc6toUj10Jvi7YtAyRrSq1paeMLt0WtAybxJbFO1JQDMWw00zSQFjo7Hymw6nHOc0My4bdF
 BcbVGVTtuPSjnVcg21UJD3Pfas7tDZIkZ903JZGPbm16vD6ryHuP
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11965
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=10 impostorscore=10 spamscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=10 phishscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130089

On 11/13/26 1:04 AM, Gregory Price (Meta) wrote:
> On 2026-11-11 12:55 -0500, Tal Zussman wrote:
>> migrate_vma_setup() installs a migration entry for each page it
>> collects, which carries the uffd bit over to the new PTE. However, a PTE
>> that maps the zero page is left in place without a migration entry.
>> migrate_vma_insert_page() later overwrites it with a new PTE that is
>> built only from the VMA flags, so the uffd-wp bit or the RWP PAGE_NONE
>> protection of the old PTE is lost. The same applies to the huge zero
>> PMD.
>> 
>> Once a driver has migrated such a zero page, writes and accesses to it
>> no longer fault into userfaultfd, so the manager misses them. With async
>> tracking, PAGEMAP_SCAN unconditionally reports the page as written or
>> accessed.
>> 
>> This requires a driver that migrates memory to a device.
>> 
>> To fix it, do not mark a zero page for migration if its entry has the
>> uffd bit set in a VMA registered for WP or RWP. The driver sees an
>> address that was not migrated, which drivers already have to deal with.
>> 
>> The uffd bit can also be set after the zero page was collected, as
>> write-protecting only takes the mmap lock for read. So check again under
>> the page table lock in migrate_vma_insert_page() and
>> migrate_vma_insert_huge_pmd_page().
>> 
> 
> Similar to last patch, this changelog could be improved.  My best
> attempt at summarizing:
> 
> """
> Device migration replaces a zero-page mapping with a fresh entry,
> losing its userfaultfd WP or RWP protection.
> 
> Don't migrate the uffd-protected zero pages.
> 
> Skip protected zero pages during collection. Check again under the
> page-table lock before insertion, because another thread can apply
> protection after collection finishes.
> 
> The alternative ...
> """
> 

Thanks, I'll trim it along these lines.

> I have concerns with this:
> 
>> The alternative would be to carry the uffd state over in
>> migrate_vma_insert_page() and migrate_vma_insert_huge_pmd_page(). Not
>> migrating the zero page is simpler, and a zero page that is protected by
>> userfaultfd in a range that a driver migrates should be rare.
> 
> This basically force-fails a migration of a uffd protected zero page.
> 
> Wouldn't we expect this to cause drivers to fail to make progress if
> they require that page to be resident on the device?  Not sure we want
> to force drivers to try to handle this special case (if they even can).
> 
> We'll need some input from the migrate_device/GPU folks.
> 

Yeah, makes sense. I can implement the alternative approach, but testing
for this is a little tricky without the right devices... I might drop this
patch and send it separately with the GPU folks on Cc.

> -- 
> ~Gregory
> 

