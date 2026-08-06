Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94F3348C54
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Aug 2026 18:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786042703; cv=none; b=j/7/7eRgaQ6MehdfLu/uJoEgLPozky4s0txmQrQgAewUdY50BJxGTQf/03OFNW7+0JUcBYr0zZN45jTfHkDlil35h6sRRpIjIrKD05io+pw7Mq5K0FAJKBxoH1uJD1NwkCxVRzVBp9TWcBDcKeT8vNH1/Bjm9aDSlp5ERyNdADc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786042703; c=relaxed/simple;
	bh=N9hw8Ri7IUbQtn8HTQRQ3CpuXmDT9HAdbE5WJ27I/2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iytShK2n/Uen4+BPbVCAyfrY+me+TkQvG/0E/eFjEkQniAjdNa3eh4jviMFz82KYtS1SFTcqUwE1NycXzHegC1XcVwhOY8O2+TjMgJPUlD0Gsn8GGUYzp45QjLQf3TpgHRnfuu71wSgIv2zZPsG6kVxZKyZ189wJvNUdSLjWagw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=HUXP8HtD; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="HUXP8HtD"
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676IYITR4109367
	for <linux-fsdevel@vger.kernel.org>; Thu, 6 Aug 2026 14:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=E4r/
	Kz62Dp3MnNegLcstylRZKtOlPDdEQUeD76T1NRw=; b=HUXP8HtD2W9xKBV9xfAr
	9LPpNCOEQJgXhH8rxQCaGu/K+rhFN0xajLHugIRl/cQmDxmd+NM9Zmo7q2X4PiGb
	Nwruq6hDE7L8gZeMrmu2ayb7U9IElIGtm7txA/vhPkW87XOwPS79xQuVdK2gusVm
	8TC5+tOqLKk45W1QeYkHYntfLL9kIquuGBFLscxcCSkQWbXv6sg2TrKUrX8RlZW+
	S9QHqB1IuYIyD3lQZYwJqpk05xIVAMJSXb5fXDr1hfTG47yp0ay4KOfHjJel3ZvX
	GYl0kuWf2gM1eucIRZZmEVCLFRV9IosDOZ/IuZ6XSQXtMD2G9pE4nJ8XrySm72Ni
	QQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fve195xjp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 06 Aug 2026 14:58:16 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c083f1818so27222671cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Aug 2026 11:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786042695; x=1786647495;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E4r/Kz62Dp3MnNegLcstylRZKtOlPDdEQUeD76T1NRw=;
        b=F07SqAx9LRqdOFRyIb1LnlGRi3JXpHvsv0A+ocf0mbRpMdfM1TlU/m331ePaZkccCx
         eZV3/ku4IfZu6RN0mtQ2iwTwiIFpA9A7EMou4DdLPshi+ZR6wPPdgbzAr3nlHah1Vy4T
         h1Hd8sD3IX3ReV6rzm8TyxtQsbpKEWrCClstKTSwimNVc6rgBmQ+pEZX3Z2T7M1BloVj
         evjj/4+P2jZCXgJhpeGE8jjtKMJ5QDCDwrUHyoUFhuDKaZg21ktWGdzQbNSJMq9i7Hbh
         hIRMokacZ42SzlKflR8qrD1Zy+Mm2PM6VcpytwnV0fU1cX8d/wmuQS1TePEWvt3REqGv
         nWgg==
X-Forwarded-Encrypted: i=1; AHgh+Rr5VXIj9qwKfQnHMsh1q52anzHsr0d5t6DWJTF/S9dIQ4T64fuPd8Sna0Hl9dZYe0W3T9cvzuUBDzUdPS/E@vger.kernel.org
X-Gm-Message-State: AOJu0YypPQBp7xh2IdjGbXzL/jDXJV14Hm6Lr2lZsHM7BO2C00+VKLeG
	k9SMEuZ7gQFF61KqBoyvLyh/0yRH4NIo7ZcCaJsxMeyIdEm8RzqHZ0g8CQr4I11jleBbrz9IFO9
	6cTslLtlHzoxQamsUQBe2GkjHgeruy49wOHmuIjpd5ROL5i+9xEWHOKnlJpG5l89vsjMCb08=
X-Gm-Gg: AR+sD13ilAE/qQQQ0fTw0I86Nkz86533FMEa2ZppdYJwYM6rXzZEWrKBFnTOMhleEQ1
	4nKeTRKhtFdwxE7gwYJL/tm3/OB7tUuryDljb6A/CaHycRxrpmaiQ/KJqKB2soXBSefACLEEcIs
	VxP0DUyc0LLdFAoKB0o3XgkwKsJRUpwoFmvsqjLrtzar6YQokt/mDrd70DS0SfyP3p4BISkuPlJ
	DhxpcOJisXht/uqVx1NtmEJj6qgF0G0b67sLncxVwBZ7TVNnUKa3AmofrNe6fjUeh014Cqt64U8
	KMap3nF/4nbr3YliRJK0uT19uSszKgbMV6LR/F2eXXxohGQaFZNk4oQA7tUc09thaklgvPoWDME
	Amf9A642c+zu1NbVr2gSnYDo1dT80IRS0S3atfYRVo+B2+3EmRxfr0uyi0WK0ohaA
X-Received: by 2002:a05:622a:8893:b0:51c:f8f:13d with SMTP id d75a77b69052e-52ce61bd900mr186870381cf.37.1786042695460;
        Thu, 06 Aug 2026 11:58:15 -0700 (PDT)
X-Received: by 2002:a05:622a:8893:b0:51c:f8f:13d with SMTP id d75a77b69052e-52ce61bd900mr186869731cf.37.1786042694934;
        Thu, 06 Aug 2026 11:58:14 -0700 (PDT)
Received: from ?IPV6:2a00:a040:199:782e:b593:3821:1a47:8a5e? ([2a00:a040:199:782e:b593:3821:1a47:8a5e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995bb88b41sm7274825e9.0.2026.08.06.11.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 11:58:13 -0700 (PDT)
Message-ID: <f835fc25-7841-47ff-bb2a-7f91b534dec1@columbia.edu>
Date: Thu, 6 Aug 2026 21:58:11 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] ceph: convert ceph_submit_write() to folios
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20260804-remove-wait-on-page-writeback-v2-0-81f0ab065284@columbia.edu>
 <20260804-remove-wait-on-page-writeback-v2-5-81f0ab065284@columbia.edu>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <20260804-remove-wait-on-page-writeback-v2-5-81f0ab065284@columbia.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: XbV11CLKjP3xyfhlXowJbsLRokJrLdk1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE0OCBTYWx0ZWRfXwd4dYJtDM1yl
 3U+jpmHH//W1/rQhr47H4UJGWDR1I4dkR7l3Llpcdu+HoOtxRXeA7PLbrCuNvkiKZ9qAat1vkvW
 CXb2LpN/vDpvy3rFxzoRQ0gD50MxERZ/M4J5b1NPHJEBFfVYfldp
X-Authority-Analysis: v=2.4 cv=LdEMLDfi c=1 sm=1 tr=0 ts=6a74d948 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22 a=5poVChmWhSypMT2yhmcA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE0OCBTYWx0ZWRfX9XjKqYnI1cSk
 1SNFu3aCaBySHaB8dMLeI6Bl4qGDoik2tuyXAoWXMz9kYdTN9uHz1cO0AZxRqfFlcL4eEkhdc6G
 zTaHenkgPYw+EYHRVyeJ2qgr07lTmH7q4fAq8g0RrnX5KO9KXAWn1tBzGBcJCOeAd2s7jzi5YOJ
 XWBlw9waZLjocprsDSF1wjnjjuxFmUo3gvYoE6kjv97djjOQNArEW2aNqcadR8ZiS94/5knrXCz
 1HvTyoTkbnkMyY+KPKPrSKCzYZixv0vGvr1WjA5+GGW5UeeuGh6h52lbpfsxnenlP5AM1Fdrbdf
 RQqXHP0ZZwyCe7cyCz05A16O6UHxRMp2y+DUsRuGae1wmD3OKhwtkfrPUfR3gS5s8YOBZKKFS+0
 T9/7GDe8auzoRvRqDldsO6qSDHCCvTtRKWKTxU7dnH8i+L5XkzlyJDvCdQ8NUwE+XwhbX0IWrvL
 r8HunWy27hSp74/rmvg==
X-Proofpoint-ORIG-GUID: XbV11CLKjP3xyfhlXowJbsLRokJrLdk1
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11867
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=10 adultscore=0 malwarescore=0 clxscore=1015
 phishscore=0 impostorscore=10 suspectscore=0 spamscore=0 lowpriorityscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060148

On 8/4/26 2:52 PM, Tal Zussman wrote:
> Convert the request assembly loop and error paths in ceph_submit_write()
> to folios. This drops ceph's uses of the set_page_writeback(),
> redirty_page_for_writepage(), and unlock_page() compatibility wrappers
> in the writeback submission path.
> 
> Add ceph_folio_start_fscache(), a folio counterpart of
> ceph_set_page_fscache(). The remaining caller of the latter in
> write_folio_nounlock() will be converted separately.
> 
> In total, this removes nine calls to compound_head() hidden in the
> page-based APIs, while adding four explicit ones via page_folio().
> 
> Note that get_writepages_data_length() must still be passed the
> possibly-bounce folio, not the unwrapped pagecache folio, as it checks
> fscrypt_is_bounce_folio() to round encrypted lengths up to the fscrypt
> block size.
> 
> No functional change.
> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>  fs/ceph/addr.c | 44 ++++++++++++++++++++++++++------------------
>  1 file changed, 26 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index c81e9da42df9..a96986c503bf 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -553,6 +553,11 @@ const struct netfs_request_ops ceph_netfs_ops = {
>  };
>  
>  #ifdef CONFIG_CEPH_FSCACHE
> +static void ceph_folio_start_fscache(struct folio *folio)
> +{
> +	folio_start_private_2(folio); /* [DEPRECATED] */
> +}
> +
>  static void ceph_set_page_fscache(struct page *page)
>  {
>  	folio_start_private_2(page_folio(page)); /* [DEPRECATED] */
> @@ -575,6 +580,10 @@ static void ceph_fscache_write_to_cache(struct inode *inode, u64 off, u64 len, b
>  			       ceph_fscache_write_terminated, inode, true, caching);
>  }
>  #else
> +static inline void ceph_folio_start_fscache(struct folio *folio)
> +{
> +}
> +
>  static inline void ceph_set_page_fscache(struct page *page)
>  {
>  }
> @@ -1436,14 +1445,14 @@ int ceph_submit_write(struct address_space *mapping,
>  	struct ceph_client *cl = fsc->client;
>  	struct ceph_vino vino = ceph_vino(inode);
>  	struct ceph_osd_request *req = NULL;
> -	struct page *page = NULL;
> +	struct folio *folio = NULL;
>  	bool caching = ceph_is_cache_enabled(inode);
>  	u64 offset;
>  	u64 len;
>  	unsigned i;
>  
>  new_request:
> -	offset = ceph_fscrypt_page_offset(ceph_wbc->pages[0]);
> +	offset = ceph_fscrypt_folio_offset(page_folio(ceph_wbc->pages[0]));
>  	len = ceph_wbc->wsize;
>  
>  	req = ceph_osdc_new_request(&fsc->client->osdc,
> @@ -1467,29 +1476,28 @@ int ceph_submit_write(struct address_space *mapping,
>  		BUG_ON(IS_ERR(req));
>  	}
>  
> -	page = ceph_wbc->pages[ceph_wbc->locked_pages - 1];
> -	BUG_ON(len < ceph_fscrypt_page_offset(page) + thp_size(page) - offset);
> +	folio = page_folio(ceph_wbc->pages[ceph_wbc->locked_pages - 1]);
> +	BUG_ON(len < ceph_fscrypt_folio_offset(folio) + folio_size(folio) - offset);
>  
>  	if (!ceph_inc_osd_stopping_blocker(fsc->mdsc)) {
>  		for (i = 0; i < folio_batch_count(&ceph_wbc->fbatch); i++) {
> -			struct folio *folio = ceph_wbc->fbatch.folios[i];
> +			folio = ceph_wbc->fbatch.folios[i];
>  
>  			if (!folio)
>  				continue;

This, ...

>  
> -			page = &folio->page;
> -			redirty_page_for_writepage(wbc, page);
> -			unlock_page(page);
> +			folio_redirty_for_writepage(wbc, folio);
> +			folio_unlock(folio);
>  		}
>  
>  		for (i = 0; i < ceph_wbc->locked_pages; i++) {
> -			page = ceph_fscrypt_pagecache_page(ceph_wbc->pages[i]);
> +			folio = ceph_fscrypt_pagecache_folio(page_folio(ceph_wbc->pages[i]));
>  
> -			if (!page)
> +			if (!folio)
>  				continue;
>  

... and this check are unnecessary. ceph_fscrypt_pagecache_page() can't
take or return NULL, and ceph_shift_unused_folios_left() compacts NULLs
out of ceph_wbc->fbatch. Will remove both in v3.

> -			redirty_page_for_writepage(wbc, page);
> -			unlock_page(page);
> +			folio_redirty_for_writepage(wbc, folio);
> +			folio_unlock(folio);
>  		}
>  
>  		ceph_osdc_put_request(req);
> @@ -1506,8 +1514,8 @@ int ceph_submit_write(struct address_space *mapping,
>  	for (i = 0; i < ceph_wbc->locked_pages; i++) {
>  		u64 cur_offset;
>  
> -		page = ceph_fscrypt_pagecache_page(ceph_wbc->pages[i]);
> -		cur_offset = page_offset(page);
> +		folio = ceph_fscrypt_pagecache_folio(page_folio(ceph_wbc->pages[i]));
> +		cur_offset = folio_pos(folio);
>  
>  		/*
>  		 * Discontinuity in page range? Ceph can handle that by just passing
> @@ -1540,12 +1548,12 @@ int ceph_submit_write(struct address_space *mapping,
>  			ceph_wbc->op_idx++;
>  		}
>  
> -		set_page_writeback(page);
> +		folio_start_writeback(folio);
>  
>  		if (caching)
> -			ceph_set_page_fscache(page);
> +			ceph_folio_start_fscache(folio);
>  
> -		len += thp_size(page);
> +		len += folio_size(folio);
>  	}
>  
>  	ceph_fscache_write_to_cache(inode, offset, len, caching);
> @@ -1556,7 +1564,7 @@ int ceph_submit_write(struct address_space *mapping,
>  		/* writepages_finish() clears writeback pages
>  		 * according to the data length, so make sure
>  		 * data length covers all locked pages */
> -		u64 min_len = len + 1 - thp_size(page);
> +		u64 min_len = len + 1 - folio_size(folio);
>  		len = get_writepages_data_length(inode,
>  						 page_folio(ceph_wbc->pages[i - 1]),
>  						 offset);
> 

