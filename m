Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793146460;
	b=BfBZnkew6q1EKIb8TcvGMGnYFArSeOHfL4AGJtHmELKqLtI0+6uGHlgOv02cFFHsJjIM
	 8eP7ygc8iOhidbN5WcVPPqRoWVejLpfrx8zoMlXUp2vx2oQkIVE2i5VwzT8F5DKr1QVnY
	 CnxLs0tgffoJ3UajutKvKTehVNCXsI0XAPAoSNflopyv1y7kWtATRtp20etKeLwAROjHD
	 1w52vq39kd1nDlQS+NuCCwPypz+iBhCDd9D7dohm3b1KodV8OsTHAuQG5+lmQhagdhq1l
	 zfjm2wc4X8oXE1TVbDJmGOpvVfsrUBsqW8CP1vIl9wpatOH6haXZFI3suaXwTtctQLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793146460;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=7p1ucq/Ny8UBz6ghlqYuLhKrCHyG8ylaL7otql1jOZ8=;
	b=uWb/A7C90xoxbaExWMKNVULk7gpThx3e+KcRmZR0T2uK151gOmt9NCiHKasEQ9oj83lx
	 +VGPq8LHoCT1tu+WRsxSIsvJTh/FLhA5v6Oqgtw3KJvLwmFykYL9gJIAPG7oiR2TEgEG2
	 2nW7I6WppcB7JoQ1xt3dZq23mfeyHEmSFhsVMlJLCaXaxGDEwYB4DAlP6JUuA9nNLq+Lm
	 JcheCJBT0292Xo1pZwQPJe+F4NEvr3YUrGyrsABZSLS9WD7A9nkaRUDcoHL7iWMnClsn/
	 3eEctxQyy7nF1ejrsyG3yyflVuWQy6TcayFizB48QBCsAd8dHKQOsSYIbX/AHQgj5Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=lsovCs6I;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=Q4NLyjW1;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A67606A320
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 00:14:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4A67606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=lsovCs6I;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=Q4NLyjW1
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RIvCiV052528
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 20:14:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=7p1u
	cq/Ny8UBz6ghlqYuLhKrCHyG8ylaL7otql1jOZ8=; b=lsovCs6IxaWMyufeHyab
	UGnNVfqeJNBrnilLDH1hmBBzIDO1Xw2PYSUP6AO5lBNUxpxEQbs+32FmrWqXgs2U
	tOPH30t80MNHG2qpSiuiuflnpzM+Fl8MrVaIQ/TzOQwsV3+8EA9G3C0UHn/qCG3Q
	PQj237pzIWWLwXlIO/8itmTx5LzX4mvdorMSSEhTUlDiVt+iAvZg3DPutnck/E72
	SD4t4EgnBW4hfXCWuhw5rDgUQrr386PNS4Nzie4yCvvMNEyT2eeHSzgksDyKzRBz
	69BiiAg+4Y9BSAZh6oP9aUSXMEnXOkAGEduwN+78Gc0cdd8YkiEvb2dw4F4cmelV
	dQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hjxe84uv2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 20:14:12 -0400 (EDT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91b8c60c550so13968766d6.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 17:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793146451; x=1793751251; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7p1ucq/Ny8UBz6ghlqYuLhKrCHyG8ylaL7otql1jOZ8=;
        b=Q4NLyjW19/i3ait1GGvuGUivPbsqagcGPGP+qWcDf7njdgRSJuYGwHwfXBRn6+WApZ
         u2dU/OtMje0X9b8UevuOY8/zp+xcTBSlA+AQPyXfpQIFvqXQkrx7HvxUuLeKu1xIjmOz
         kiBinAtDG9/rbdMBTxkVC2eZ+5y6Lcu8Hj86h5xFKIuiV8Oo+uj+Ulbj4qOr85BrMbkh
         EyxD2Q8Thz/bitPJU4cocw8Ol6X7hbw2JlkPyQ66x5sGjM+qvJmR/qMkUXyApTT34u/s
         sZcQJdUwxGiWQoZpZVBv/TUZjOGT3aT0Y0GxHW03AK0xQsXqWosKF43hPhwNOMY3TfSO
         p3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793146451; x=1793751251;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7p1ucq/Ny8UBz6ghlqYuLhKrCHyG8ylaL7otql1jOZ8=;
        b=opjaU4FpEoxFBLtd9N7QwI4ovKkpJMMlEfBFxn0m9paPjLA83qIkUgyQv0bsW6pMHf
         a+jD6jMpFXK8YaKwgWQOY+/I1PR07uCbh4NYK3ELavRvz8Dgm1ci6k4cM2/XRQC1ppDC
         Csn6TxJqDYaqO0/JxxvDX6lhEOvC3YtQKkQq9pPKJM7Vy9dwgQfH/Wt7xsNyD5zWthQV
         zHy8tjw7Fm/2hVT5XEelpHqFGd6GpkwIqZhTed4oArtm/0DWLSkFFEDaWT1o//odybpb
         2pf6CCR94D2QSPoXvSoH2o7MhXXe44OJDdwcxN1oFkJzP2plDMOrBIQ6NlxkLwd2jD4W
         OHrg==
X-Forwarded-Encrypted: i=1; AKwUvBxoqRSK/TovWvgMYOPs6az51AoYtRFP6BZN9Vlhh/89ZMVgVLVXnl+7SHLqTeiQoQTW6rxOPBOsgS//L+CS@vger.kernel.org
X-Gm-Message-State: AFq9FYLiUcWUM7uDvIZqVx3uBIrZ+MUJXncqoiVTE8XXEUYSX0Np7vlb
	xHNwxTRUGIXbi1RiVc9C1PW7tIvRhB1/q4XVDGXACsma+cgTavjhGRJpIytuwYrlw4zhWJPkeGk
	Drf5iOA2MEevxau91OInXUtnTSLcMz+hnxrCu1Lv8Z4eoyYoIvo3lxFmFmbZ/4lM=
X-Gm-Gg: AYBFou06YRV1dYM497my6xoaCUFovUJFnoY7pWPsW+myl3uQ5fT4+Y0BflVh6qA5QKJ
	k3CdWHj16BJOQ9MP/w0Bt+bmiHMqd4nuBQOUBJ4CO/jyjXS0OwzGSVpCX7Jrfk3UIOaS8ahzAdI
	Eo69B5GY+nWW+goQR9PcHNF1RnBb2a487KYqhYx9mxCAqABROSAKhvy6WNtCvvEUh4lhao1j7UB
	lriVc3opkY3rrbYJXapP5H5SbVELRMBdqce1RgV0KeQWBxSlrJXsRenSvbWoM2k0EH3hisf7C11
	kAoUIrQBVsUeTXZ5bBhAtWU9hbC8AlvhYEL2jf1WGtpD7Hgp+agr5tq77fmzHanHuHjFEYnOQ+q
	Kj3f+Zag1v+HJ39A2Rn/ngO8PLS/kVKJYgQtOcw7KSE/geM+ygmxALyQAhQTpJt3ylI7Bw5kwVr
	E+q+zDRrCbPCo/IYArGrANDn4Gh/xqiv1LbN5cXikMTJX1rXSBnQfBmR9Jb/3encXfxxwfFOhQS
	YS25XbJ1HevSng=
X-Received: by 2002:a05:6214:21e7:b0:91c:76aa:2c67 with SMTP id 6a1803df08f44-91c7d1aaecbmr12070226d6.39.1793146451375;
        Tue, 27 Oct 2026 17:14:11 -0700 (PDT)
X-Received: by 2002:a05:6214:21e7:b0:91c:76aa:2c67 with SMTP id 6a1803df08f44-91c7d1aaecbmr12069876d6.39.1793146450883;
        Tue, 27 Oct 2026 17:14:10 -0700 (PDT)
Received: from [10.206.51.58] ([129.236.225.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c6d8103b1sm40645156d6.44.2026.10.27.17.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 17:14:09 -0700 (PDT)
Message-ID: <3c754c36-86de-44a6-ab3f-5c86e4bf83a6@columbia.edu>
Date: Tue, 27 Oct 2026 20:14:07 -0400
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
Subject: Re: [PATCH 10/46] mm/huge_memory: fix list corruption when
 deferred_split_scan() races with deferred_split_folio()
To: "David Hildenbrand (Arm)" <david@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
        Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>,
        Barry Song <baohua@kernel.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Baoquan He <baoquan.he@linux.dev>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Hugh Dickins <hughd@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Lance Yang <lance.yang@linux.dev>, Rik van Riel <riel@surriel.com>,
        Harry Yoo <harry@kernel.org>, Alistair Popple <apopple@nvidia.com>,
        Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Usama Arif <usama.arif@linux.dev>,
        Kiryl Shutsemau <kas@kernel.org>,
        Matthew Brost <matthew.brost@intel.com>,
        John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Nick Piggin
 <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>,
        Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>,
        Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>,
        Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>,
        Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>,
        Gregory Price <gourry@gourry.net>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org,
        stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-10-6f74bec9a5bb@kernel.org>
Content-Language: en-US
From: Mani Tofigh <mt4022@columbia.edu>
In-Reply-To: <20261027-fixes_core-v1-10-6f74bec9a5bb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAwMCBTYWx0ZWRfX1rG6OoVdFZuW
 yHGu8tsuYyzwERcE4sanvXunaU4S6OFm2e8OVV+hxl8nBZWd4Bu8SjvxSW+Xc1/N1+wwGcYcDaV
 V5WLlt6wvcPNiXdKNuV+fOPVEc9Bdely4SaiV+U8M7BBK6DiWimB5RJKaC9vJSdtYoiVxm5vrwk
 ueZ1OK23lziRH5swLb2zIfKibcUeW9Bddw9Bs53vBkqhZAT44ie75o+OCK3eAapq4708SsnFzNN
 9ILpQeHGVEgIuT3NoXsVYdPXy50o3Uhsp2vqhZoTHwsmnR6estfRRg0B0KCcaoLyhc0HXbeq3B3
 nxTO96NDp2HbvwwQsmDCuswat9asihu2XCqOsG/jIvx9/iWMoeofCXHWaQwyIOQ0CScQTNo0R5L
 cnLRNtqtrmqFsgzNjY987dQEHvZiysyuqCcidX9aEEnLOxd8xbHt+a/yma+r6CM7osPCA2K2Dmz
 lYRJAwayFtEVMyylZ7A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAwMCBTYWx0ZWRfX6++mylvF0w59
 Tc7VnrlH7tZLA9HixkBFV8EbxmKxYHG5iRO96aYi7pvXnUl5XE/vt4NZI85dHxh0cKbKZ1jQ+5z
 TLgLiU6kYuvdSpY9BpsiiPyiYdfdZyonMwt4jO/zEpFKWeskl/AN
X-Proofpoint-ORIG-GUID: 3MeU8wSbzEO8WmHUNyB6vtw_dhc0K07I
X-Proofpoint-GUID: 3MeU8wSbzEO8WmHUNyB6vtw_dhc0K07I
X-Authority-Analysis: v=2.4 cv=EP+TQFZC c=1 sm=1 tr=0 ts=6ae13e54 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=TdXXog4ttPu8yHJGq4T0ug==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=VwQbUJbxAAAA:8 a=maIFttP_AAAA:8 a=_zromwrzjHPDTWxWFBQA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=qR24C9TJY6iBuJVj_x8Y:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11948
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=10 clxscore=1015
 impostorscore=10 lowpriorityscore=10 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280000



On 10/26/26 7:17 PM, David Hildenbrand (Arm) wrote:
> Since the deferred split queue became a list_lru, the isolate callback
> moves the folios it took a reference on to an on-stack list, linked
> through folio->_deferred_list, and deferred_split_scan() takes them off
> that list with list_del_init() without holding the list_lru lock.
> 
> deferred_split_folio() does not know about the on-stack list. It only
> holds the list_lru lock when it looks at the same list_head, and it can
> run for such a folio: a THP is queued when it is mapped, as a candidate
> for the underused check, and is queued "again" when a part of it gets
> unmapped:
> 
>    CPU0 deferred_split_scan()          CPU1 deferred_split_folio()
>    list_del_init(&folio->_deferred_list)
>      next->prev = prev
>      prev->next = next
>      entry->next = entry
>                                        list_lru_lock_irqsave()
>                                        folio_set_partially_mapped()
>                                        __list_lru_add()
>                                          list_empty(item)  -> true
>                                          list_add_tail(item, &l->list)
>                                            item->next = &l->list
>                                            item->prev = tail
>      entry->prev = entry
> 
> The folio now sits on the list_lru with ->prev pointing to itself. The
> next removal leaves the neighbours pointing to it, and they still do so
> after the folio has been freed. With CONFIG_DEBUG_LIST:
> 
>    list_del corruption. prev->next should be ffd4000000270090, but was
>    ffd4000000278090. (prev=ffd4000000270090)
> 
> Fix it by grabbing the lock around list_del_init() so
> deferred_split_folio() cannot race with it.
> 
> Fixes: fafaeceb89a5 ("mm: switch deferred split shrinker to list_lru")
> Cc: stable@vger.kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Mani Tofigh <mt4022@columbia.edu>
Tested-by: Mani Tofigh <mt4022@columbia.edu>
