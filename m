Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794870410;
	b=KnQCap9rHTLlIFfDjvEgyHgjoY+gvl2f1sd9M8D3uiBarcNlhytO9Uv3p2sGCFxRAZI4
	 20OWfWA9+gVp7i9lC5OTNkJZJIbLgq6ktz9yBudB625LTTSaBUnP3MIaAIBUnZqQ3v/l2
	 xV+foxCiHDd88jFHnnIioYxaG8kKi0fH0myaMAoYXnxJThIy47nNR+ZIkrbv0eABcOR2K
	 IrlwQ96VDLfx+N4/IkwYUEQytBuD3e2QZ/d6qff2p9PU57zZUeL4r4L+eeeNkpms/hiYB
	 lBDrFgSjC5UY3QvomJB80ZqMTMwCA5KPIdj3qq8ZykX/z9oWHs91CxXg6CpeV3BCMKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794870410;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=shtRRPv4sO05cfKy9jDsVgauLpUzE/l0Te4xSbg74SE=;
	b=h9PmbSLspYatGKtjgQpx42OLuJoZJEdGDada5hyCNheJs8A7s5iIbsunU+WmTeBiBU4M
	 FkqdPz+WX5QwkjTuVCmNFnKwhUbFKh454oPOpjDIXRnfrDk4ePKIWAQkXwfTA3gAopT8D
	 DkAHtOGwgIH9qW99GXuF4BA4zNgaHhKRDkf4L4BFK3rOen1XiVwYsfPSJR/aW3kcjcPQz
	 kZE1rQRx7RwJp95rvDnoIImdnMO+L//zbfWJv4STsq1PWBDH4JY+I9bgRpLnj6LJpZ4dm
	 LaB0GD5ikJxPjDzE4Amd8xPsx0GnCRhKUzab/8mcKf7gI6wjWdPyAVJlGO0KkwoTpjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=iYLVIb4e;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=QmtsIiyT;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCBF606A8AA
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 23:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BCBF606A8AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=iYLVIb4e;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=QmtsIiyT
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGLYrRm3519985
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 18:06:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=shtR
	RPv4sO05cfKy9jDsVgauLpUzE/l0Te4xSbg74SE=; b=iYLVIb4eyo24+udnvs3G
	MJgMkShakHkhAOAO9CCgFnM6i8wa3coBagtc8oRa+Lz6Z+MsbX20IDG3LJDy0vFX
	Z0Yjgn48CeEZWOfHZUatppMpD+9lfvTeu1uj/3fqHOBdXDNgGL9YK9AfIpsuUf6b
	JdLsR/VkazINFOI0UV6cZ08cE5if7g0pIqYZr6Tij0qLt8/TfT5VCHu0/nirog4e
	J04gsFT5b3xlACp4HxuRzGUOdy0q0fmWzSUnd1tqycWphXxfpPmPT2mfDAxLoHOg
	MM4XfQsJlIgAnl7FQPviBjf51Fu25cAE/NqerET3PQEQk5MvIcw/7mao9MSb59qZ
	Lw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j059ybkqv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 18:06:48 -0500 (EST)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91256a7b7b3so66016986d6.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 15:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794870407; x=1795475207; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=shtRRPv4sO05cfKy9jDsVgauLpUzE/l0Te4xSbg74SE=;
        b=QmtsIiyT4J+a4IZ//dVKEGkqMqkLf0JvUGdVJUfIdB7tLsVvRk6oB2Q0xIngFzW4hg
         bZDmsDu//ZpC6SxLhY7Wz7tf5ta6W7f8QAViYzzmNtCEzlYv3kTKO+lYa2t7ShV8nOY3
         /LtTnn2LtduheeAs4Oe65sUGiYt+2qD1V5Hv++TJLmO51eriXWbMDM2bHWppC5FADUx8
         PrWpenCORqsY3udzEUQPMCGHNd3G+CdaQRpT1eOxBa5SUeyBMWItIkrMFIP9X5d/bged
         ipEEcQw+tkTLyEdkmAd52NO9nQzpdbwm2Ue+oA9iq4Jf3QyNfLcjpSKpS7VGT7NVpx4S
         Zn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870407; x=1795475207;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=shtRRPv4sO05cfKy9jDsVgauLpUzE/l0Te4xSbg74SE=;
        b=bad+gt4kKBS+qkZzU/O8/WgPmNBkHYWe8OcOeSyt0yQQF5fR/CfL6L8bE7SVapz8Cb
         Jfy/pLFg4/FwlcNix+ElpEFxw/3YFru6hFwcVFsQk13/3HH0V5sUBiLgic262jPox+3U
         NsiBp5jnbV4ooBu9OvpY81vGZGPQZ/sMT6Gm0RFSkaEj/sQEgyKpBIxiVZqcILeKLfo3
         4RXDs9jqAXZRozysEMyxMZ+cb92u90UMKbs4tX58r37jz6P7s1Dhx+gwYvjRmgqerIgv
         buRG72p5pEyojFFAbend+OF3ANlXIJ7ki3+ssD6JIGWbNVIGzNu4hUYK4h+iMG4Z+etx
         ueyA==
X-Forwarded-Encrypted: i=1; AL+hErFt+kxaTV3iQLso8oat+l0BMUVaS1TJaRN2qD9eYPjL2T4p+wOLOptUFh0o/Z5+bdbdYb66cl9l7d8FihJ2@vger.kernel.org
X-Gm-Message-State: APuU4Z9EpnBDcR61aQMbLYl3aWyogrBCOSJYrPsPT7c2pLCsAOQQ+cBy
	DSv+dQgmKi/WF9qkJc8waZY7DQ1nGzAFnEVN0M8my/Cnnw6Mp2xrLqRRtT+3PhAK8CtHutuAUdW
	kD/pfcxkfjNSaAI7XIubsJXcyPR8ymv0mglb9LAOkIaSTr1Z4GSUAXxU3xiVG4Jk=
X-Gm-Gg: AZFdTZdZ19fdouF94b1VZjDLf168e00UWSSgnVMCKkyT3pXwu6fKNfWtPMwMf5KIq5J
	uiNh/WEcSW8Y2Vxnb7IeSRyYWLijeip/Csznj/3O4Zw8+VDHi4YRz3KbhasLnreQHKZ6c+gtR3K
	BsA6FBg6E09d9PgNskaeA47oeQlBh63V4QUEblFpZo3dx/BR4YUkxfoy2Vf7Ka1IKvjAzRLdZ5l
	oCGk1jP9LR2i8P5tOkkLjpXvxU5LF/JXQBJmsDq8Khpb2/xjvZioAF+oF90+LtbxjXZo5/n6Bbd
	ht5HtmN2bfixRuqSdIiGQWdwK4o8XkSrtMS4gVGxyOzvLPLLx751DT2RzzSyjkmyBhqSSs2Z+lw
	4MR2tMM+DjrCVxP/hcBseZoOB/htlftQa6afQNl7G+p+5zyPiBay+eXwKF/sM0Gh7GyTfU128UI
	e2RvcZodRGEaB0c8YB7UH5VTWs
X-Received: by 2002:a05:6214:486:b0:91e:cb85:f84c with SMTP id 6a1803df08f44-91f241ce6admr203454536d6.27.1794870407344;
        Mon, 16 Nov 2026 15:06:47 -0800 (PST)
X-Received: by 2002:a05:6214:486:b0:91e:cb85:f84c with SMTP id 6a1803df08f44-91f241ce6admr203453936d6.27.1794870406649;
        Mon, 16 Nov 2026 15:06:46 -0800 (PST)
Received: from [10.207.2.125] (nat-128-59-176-174.net.columbia.edu. [128.59.176.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d459c6sm97731756d6.14.2026.11.16.15.06.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 15:06:46 -0800 (PST)
Message-ID: <71aa028f-c753-40d5-a8e4-8daef5aea3aa@columbia.edu>
Date: Mon, 16 Nov 2026 18:06:44 -0500
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
Subject: Re: [PATCH v2 8/9] mm/migrate_device: do not migrate a uffd-protected
 zero page
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
        linux-fsdevel@vger.kernel.org,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20261116-uffd-state-fixes-v2-0-4397a0196479@columbia.edu>
 <20261116-uffd-state-fixes-v2-8-4397a0196479@columbia.edu>
 <a384d75c-2134-407a-924f-ee511f65a2d1@kernel.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <a384d75c-2134-407a-924f-ee511f65a2d1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MiBTYWx0ZWRfX7ST1xxk6tr2L
 qsMeexHUJn4diPbrTFa0o1xpuoQMy2H3C6ZCcYJv4VNTBjglzxooYrmwXehHYAD/edBtS/LAlGe
 PQVY5FATccZn3FQ7fJQkTut7P4dvLdB+UTkhyl7Q9k6TSdmTpW1R8JyQKR98J/GW6IhXJ+/PJF0
 wgjXHphh8vq2nfJMXlfNrtDdWWm3E/BGsQ1A7R6iMXnqQkaWObqzHE2/q25UFOJ1W9EGWe7exmP
 wdG5kFuQSJYXN2hBSRAKF+Op6dTJGhZYj0SueYFVOpjZdSvMOUQs643BSPn+ATGVgs65IclnZBX
 JWG5KUefiiYK83CrlkCyrXkL0xu5frxJaCEfHyWIQyniDXVIOi1/Wg3sf6fEINpM9ZIF6xMc8wv
 O8gN7L6VZcxgoHs+CeOMPSZ2aDJuFlqRlBaEwRMpJV2a7tVS+IfhMtIT1VTVRP9NvUpNONrpz9X
 +Wi0nj0a4T8m2UxkLTw==
X-Proofpoint-ORIG-GUID: qqmSaRInNFA9hQxuu1XelcNU4TN6atYW
X-Authority-Analysis: v=2.4 cv=MOv1C8Zl c=1 sm=1 tr=0 ts=6afb8c88 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=KPY1cyGZ6h6m4ASiENTC8Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=QyXUC8HyAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=zd2uoN0lAAAA:8
 a=9jRdOu3wAAAA:8 a=e5mUnYsNAAAA:8 a=Ikd4Dj_1AAAA:8 a=zEWuSTdDNGilpxNPLJEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=ZE6KLimJVUuLrTuGpvhn:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: qqmSaRInNFA9hQxuu1XelcNU4TN6atYW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MiBTYWx0ZWRfX//SDURTSZmRf
 M0DhvTLa976A800M5CUs91xCN8QVY2mVeO3YCoaLHEUK8uwIi5dPTzHKWYcfkOJXGuu2qGhKG8c
 FAt7zBOLstT1qbDltnbT0zBg3Isr49CHtsQDcYVXsS2Rs/3F4Q4V
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11968
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=10
 bulkscore=10 adultscore=0 impostorscore=10 clxscore=1015 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160092

On 11/16/26 3:45 PM, David Hildenbrand (Arm) wrote:
> On 11/16/26 21:02, Tal Zussman wrote:
>> Device migration replaces a PTE that maps the zero page with a new PTE
>> that is built only from the VMA flags, so its userfaultfd WP or RWP
>> protection is lost. The same applies to the huge zero PMD. Writes and
>> accesses to the page are then no longer reported to userfaultfd.
>> 
>> To fix it, do not migrate a uffd-protected zero page. Skip it during
>> collection, and check again under the page table lock before inserting,
>> as another thread can protect the page after it was collected.
>> 
>> The alternative would be to carry the uffd state over to the new entry,
>> but a uffd-protected zero page in a range that a driver migrates should
>> be rare.
>> 
>> Fixes: 292924b26024 ("userfaultfd: wp: apply _PAGE_UFFD_WP bit")
>> Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> Cc: Lyude Paul <lyude@redhat.com>
>> Cc: Danilo Krummrich <dakr@kernel.org>
>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>> Cc: Jason Gunthorpe <jgg@ziepe.ca>
>> Cc: Leon Romanovsky <leon@kernel.org>
>> Cc: dri-devel@lists.freedesktop.org
>> Cc: intel-xe@lists.freedesktop.org
>> Cc: nouveau@lists.freedesktop.org
>> Cc: amd-gfx@lists.freedesktop.org
>> Reviewed-by: Alistair Popple <apopple@nvidia.com>
>> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
>> ---
>>  mm/migrate_device.c | 23 +++++++++++++++++++++--
>>  1 file changed, 21 insertions(+), 2 deletions(-)
>> 
>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>> index 9e19fadfa65c..140b99f72508 100644
>> --- a/mm/migrate_device.c
>> +++ b/mm/migrate_device.c
>> @@ -159,7 +159,16 @@ static int migrate_vma_collect_huge_pmd(pmd_t *pmdp, unsigned long start,
>>  
>>  		folio = pmd_folio(*pmdp);
>>  		if (is_huge_zero_folio(folio)) {
>> +			/*
>> +			 * Nothing carries the uffd state of the zero page
>> +			 * over, so skip it if its uffd bit is set.
>> +			 */
>> +			bool protected = userfaultfd_protected(walk->vma) &&
>> +					 pmd_uffd(*pmdp);
> 
> Now that I read it 3 times in a row below, these needs a helper.
> 
> userfaultfd_pte_protected() ? userfaultfd_pte?
> 
> That might help you to get rid of the local variable (that should have been
> called something that includes uffd and should have been const)
> 
> 
> Maybe just add a simple helper for the pmd as well and use it below.
> 

Will do. I'll do userfaultfd_pte_protected() and userfaultfd_huge_pmd_protected()
to match the existing wp and rwp helpers.

Re: the local variable, I'll rid of it and just call spin_unlock() in
both branches, which is a little ugly.

> 
> -- 
> Cheers,
> 
> David
> 

