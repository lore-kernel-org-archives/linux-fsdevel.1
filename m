Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794436759;
	b=xY2ep85Hnlw9Z39NpppqiHg+HvSCUYOA27q52KvPfEMnw846a0/DK4Tc0baXaOaCehjq
	 KKlLFHPzY/t3+v3llxOJQlet7tGYrpGJ8kbGOTFOBT57cuPlPK3Jtda6ykr+35FBYR6UI
	 /XDQ0gMXfuEXTJ4GJB70xQLG4bj3a3bHsbiiNn6UFL4gzxeUNmrSnQZyAPb5oq0B98TjE
	 YeqPSOG9GZlFeb8XqGpLQb8dfATge/2J6ujZ4OR761EIuyRb2QGa/Z1EVH9n5zjdBd1H/
	 bjy45AicD9UNjQq/b4XM93JS70ysqHxxeQpFxLZI4ieTf0lgeF7FybMMajC19U+MelQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436759;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=tyB99dES1VWSWEDHCuA5hRT/5p/ujc67VH3aWrgWNkc=;
	b=pizYyP2cp1RAYR6uEGk8NE02UUQWbEWGJmgsWGu6dGQgB4yqrNgK3El+ppWff4Jenxrf
	 3yfay8PrRSqTijm4jM8z6keVHlGCx/3sbnnVVoS1kaj6J5W00trfgLF9/9SavSyBt4062
	 WjLxL+4CwRiCXnduQHBduW4mXY9ZXuMmFN4dE5VTEnpILo+bN9TAVzOFMDY1qnlrx+tw+
	 kgB8TsizdEz4diP04rUPtEH9OWZY5AVRg7A2d25wlLTWMEruVtxl4vy8qyDUNRdj4REZU
	 ttelqYSM9iKWNcCDGOlbxFTXg1HvbLUof/4izu8wizsb8PHbxlwGWhBUnvjT5Zm3cJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b="IT/8NHst";
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=m2ipMgTt;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF2B606A321
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 22:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EF2B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=IT/8NHst;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=m2ipMgTt
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABMBw58474455
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 17:39:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=tyB9
	9dES1VWSWEDHCuA5hRT/5p/ujc67VH3aWrgWNkc=; b=IT/8NHstUgDEGgSQnLX6
	Vaiv1AWGs/qhkiRKlUcq7D3eR5gJ6ItvRqnKsmZtifCmYF83Etsk6xnSg4ghYtJq
	E3Nqa0kPb00QkhUF3JRsTPPds/3MgmGm6kO+aDh9nKa4vJnXR2esYIlCFPgPXPSF
	lDUFil5vp3qkfjAq/6sbqbK9b31ugJ/b+kyU7psmTCLkP66JQr1rsht9NlWn/cmN
	je7rKgCUnqELG3AW5AuZzJoGUPyEc5DA6apdCCOb7QTWpyxE8PDE5hdqLeYunDsC
	dTBiuFo0GmbBv8Ls2WN0w0DzSQA2IFSMjQ7cwioWb1nXGym7TLR/jbioy1JwNf9Q
	0g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hvvasau26-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 17:39:17 -0500 (EST)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91ebb902eebso70098156d6.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 14:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794436756; x=1795041556; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tyB99dES1VWSWEDHCuA5hRT/5p/ujc67VH3aWrgWNkc=;
        b=m2ipMgTtQ01aPSI3MnlI6+7Ebr6Gg6B6s3/hgBmmCLfHtrrGc6Fht9Xtxn34JDJRSY
         Wi0Vc5mc0T12XHIiMt3rcJDcK1ciqmQGVKx0NpabmZ6TaNLGVlJuVEZOkzK2XZyWbXLx
         r+7sbLhztAGJEGbgXUSY/ofSgqYKc+t2UqEjQ85rj3kHh6JB7mxNZg7+UnRkzEat6Olw
         spsRk0qdEg7xzBFvCLGd4ZPD/TXPwLZHONYzigvtK2ZJ1QTPdG7re/OeXmGFp+oqc2bN
         GDYpFlfQaehnkb2pA3EAL9UO+NEJXZEcCtChO891xp5rUT8RiY+hTLAbWw2nINzDBTyV
         fQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794436756; x=1795041556;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tyB99dES1VWSWEDHCuA5hRT/5p/ujc67VH3aWrgWNkc=;
        b=pKm4wmpUTcQftMUBtbC/l200KnvcAZ4oOPIZGhf7AYmHCr+wXpNaA7ee3QFhiKsrSG
         lvj66kOzkKpX8jS1/0T8GIX/z7Qiba5wJu4Pp5xhY0msGLJ4q2L1sdRkpPuyC/lW8ldB
         mY5NYvL++AlE0e2AIXPSPBajKx/+h9G04ojZhdkz5nKo+EyZADnB8+RaX/sbWTHnw1E4
         vMIojTBrCzEte6jG+bFsqvqm3E4ngWSJBK85TtMTvnaZnK7QKWR1qhKy00w+0VjEONzd
         vxYMUZ82mICTOaDCBANIKDaU8XsL1oCSTYbBIvthViNv7lXRsbdMDaxqq6EUPVTRcac5
         a8hg==
X-Forwarded-Encrypted: i=1; AL+hErGpKvHEm2Q4nhs5Tgu8Z9kl6NS4WRDQ+p7dDEq8tU4p1ln9V+0fJaTKSt6O1nGMvy5GXG7et+HIBpUURwpk@vger.kernel.org
X-Gm-Message-State: APuU4Z+dBDqKnPuaG0YHu0arXd4i07TQGxhuoSDdt1eteBUvxANJhty9
	Dj30fL9nHdCYDcLbfzKhip2EBEXv2rj0/nXUYTFSO+InoPhQ+g8TEsjmX4WZGPaZ8piihb3OyJP
	s3bqLMcheBNYq2S0mVm/1ga+Zci3PEW/M3zlim6VYgWNM+CVG0NyWcfbl4crIsr4=
X-Gm-Gg: AYBFou0DjO1Q//9+6oF0GoiOECN49ajVL34qOJhqSfF+201241jYemuK98wuuYz4bK0
	obmox/s+AtB1KN2SajRWWTQAsL/rJpijkhAEIiDokp3DtNtQ5UjVEDlxhi0dgkwi7JcqYkW9/Ja
	WcY3u5LD3Y44W1V+CFWqeuv+ka5kUZ2hG+QcOaPCI7x2fEzAPnmALscIzi9uWSDCq35vuqWVAE0
	ONg8KvsRih+CbS36vJfBA+zch1q6jwOr3/1ys8YruFaMQXJ7zKjUCvtkqy7u0DjChnGha97sArB
	6aq6LmbBBAyG2st/V0b4VL++FRJ76+KZlW0DwF50fXoHMOX31c5Y2g8eyvoXLtsi3cuYB8sRLdP
	+oFJbZay/x+zhyDHLdPY+E97culr/XEeX2/O/G24n9PRq7iuiC2eK+DqZP9nz+RDIr2n1YTosj5
	Aqzch82XsqF8wel8pI8ORRFoxJIWY=
X-Received: by 2002:ad4:5943:0:b0:91c:996a:7fc6 with SMTP id 6a1803df08f44-91f03e26d40mr67403386d6.6.1794436756502;
        Wed, 11 Nov 2026 14:39:16 -0800 (PST)
X-Received: by 2002:ad4:5943:0:b0:91c:996a:7fc6 with SMTP id 6a1803df08f44-91f03e26d40mr67403156d6.6.1794436756029;
        Wed, 11 Nov 2026 14:39:16 -0800 (PST)
Received: from [10.207.116.169] (nat-128-59-177-239.net.columbia.edu. [128.59.177.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef04d8397sm57802366d6.18.2026.11.11.14.39.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 14:39:15 -0800 (PST)
Message-ID: <956d86f1-9d8d-4d4a-91a1-00583987c622@columbia.edu>
Date: Wed, 11 Nov 2026 17:39:13 -0500
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
Subject: Re: [PATCH 07/12] mm/mremap: resolve uffd state when the context is
 dropped, not during the move
To: Kiryl Shutsemau <kas@kernel.org>
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
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang
 <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
        Chris Down <chris@chrisdown.name>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
        Michal Hocko <mhocko@suse.com>, Mike Kravetz <mike.kravetz@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
 <20261111-uffd-state-fixes-v1-7-00713d368976@columbia.edu>
 <avS_43B79K2lUV3Q@thinkstation>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <avS_43B79K2lUV3Q@thinkstation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: qFGeUlD31zvLGcH5c_mp9KqF2EWdEZ-g
X-Authority-Analysis: v=2.4 cv=YqCa1IYX c=1 sm=1 tr=0 ts=6af4ee95 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=BoHXNMl2GZKy+iVh/K8zVQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=VwQbUJbxAAAA:8 a=kkTTwOaqnXeBwKB4IF8A:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: qFGeUlD31zvLGcH5c_mp9KqF2EWdEZ-g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA5MCBTYWx0ZWRfX+lYf1SC7q0Rd
 BZ/tudKb217rWl3FxKhiFTMAoxsJy6HsWFVYpHagj67I2GveqmqAFfr2UaSpmV6nXLTK/YeSQQ1
 GHmaIzTH41frHUwhvL4DusH0w3/qR/OBWZmDwwrIU1fUIgmlfmNy+H9oE1bn6+hT1bvmFt4CHv+
 ZCoulxBJcpIPkwXiRGNI/9iDNe6TYN0zIWWif3XTn9qTjjNov/03au/ufvydD1yr7UEIAtFcs+o
 oE46lTheNEBughDLA1/CdDW0lK2XhK9/n41x2z91tQAnFLrCP0H3P+jwgpIT+7U26jlrIlYJ6Ef
 6hbG+A6UcwFi+S0+T427XnKokAWr54Xe801c0s4mlhcLGh1+5/MK0qetMfXZ+iQxPLLBwpPg8n2
 QuY7oiWaNQAuYxxYVKxMB7nP02WJhTmn8k8/I/U3uJTiMlA22Z6nvG8UeWL3P26e4nJDn3U0zB5
 XwRbXhX+UO456FlBErw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA5MCBTYWx0ZWRfXxRHP653tyvnm
 KbSst+MMrX8vN5/O7I0vZDEO4G7thkGLpnNLJmSDWtL8Tnx8OuLiICkKlv6g/rXnQQcHDBuo8Cf
 YKcCAyxN4Q+kfMhAi+OuChaucfZq9WrimCQ5vQo1d/2vFo1BEYft
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11963
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 bulkscore=10
 phishscore=0 priorityscore=1501 impostorscore=10 lowpriorityscore=10
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110090

On 11/11/26 2:20 PM, Kiryl Shutsemau wrote:
> On Wed, Nov 11, 2026 at 12:55:15PM -0500, Tal Zussman wrote:
>> However, this adds spurious minor faults on shmem and hugetlb.
> 
> "Minor faults" reads as UFFDIO_REGISTER_MODE_MINOR in a uffd changelog.
> Maybe "write faults"?
> 

Yep, will change for v2. Thanks!

> The RWP side keeps its behaviour: vm_page_prot does not depend on RWP,
> so resolving with change_protection() gives the same PTEs as the
> per-entry code did.
> 
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> 
> -- 
>    Kiryl Shutsemau / Kirill A. Shutemov
> 

