Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9B1366057
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Aug 2026 19:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786045916; cv=none; b=h2kOC0QN8sHPB/580QDQ0zBeyMqT0jLrw/9uRuykDlc+moAdmDmdBgrXlRCqQLK0jID/fPWplnif2f3C7//KA/4V8eY9DIbBtU17BcdmkJlrJcE8hdV+Td0Y/GO1PaSiW6WduwpK5e8Eh39XLRItBCBdaPmBXmYteEkAXhXLdVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786045916; c=relaxed/simple;
	bh=lTTpjODhYHba5wOLeu29fKL9Vo+uC5X6ugh4lCvBx3s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KleB371nWuHafQZk8idp19/tv6ZRAnt/WmmO6nbhVTXjYgajhXk0TsJEMERRIl6+VY84pHhisViosUX6LXcOZce9UbaSSlWKWI2iHrMK92bYlxpD0Ns3kuidk9YZ92RTnAGy7yYr9DbUF6Olf7LJRS0TxLkyZm0G7ieXhEF1mtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=YxHt4sU1; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="YxHt4sU1"
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676IYKYH085228
	for <linux-fsdevel@vger.kernel.org>; Thu, 6 Aug 2026 15:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Zkma
	NtQ8BSIkFCQ/5kE6NoXn5l5qzjWnoHIHZn2DAkI=; b=YxHt4sU1bLe939IWOhZb
	iVMmeBgmLwWs7T31I0opvtRBd0Nipn73SR99bDHGSlepuLOnV0Qgyt4RI5h5RRrV
	NA6iRkzhwa0faVOYd94hoCW+jnQtUot0zZqwgoU5fmQeZjZyXNDK0VMBcBUOCTH7
	fwoUbvzoe1Ai/S1oI4Xj246I/6m3WDt95ZjM7EdrFgnsKcV8n5D1snn8JJOCmaHK
	4fYcWO1QlqRfRcd0F4Pk+5P6bqZHXNEr4IiwDayCqCMUMoDyb0jppMuqUuny+xVb
	rXFOEkWflxcTfPBs60DV1RZFaeUdravsdMUMrVZE6Vg+8fGhl8wrqP+iFWRkszAA
	yA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4fvxnrh0nc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 06 Aug 2026 15:51:41 -0400 (EDT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52ce3c7cb2eso38963811cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Aug 2026 12:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786045900; x=1786650700;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZkmaNtQ8BSIkFCQ/5kE6NoXn5l5qzjWnoHIHZn2DAkI=;
        b=jDzzUUI9lH0unrN9uPZS5xO/cXQKuSNqkDFPYVS9mBVkEV2bYGcRVHTyhTQ9fWkD+O
         PUOfkGFYDoQWCjTscmDFKYOe1EbOXmOjczrTBKNztHVVGqiR6xy8mEdLK2idKLFd31bn
         TKVl1r38jS39Pf0kloFjQQJmgZDLURl0WKSIkSt/Atlkt6G0Nl5hmozCBf2nAK9gDGUi
         YDGeosOATp8EzOSt1d+sKIZFbFd0mtVldDEc6pDBwknbtCCBvm9kJSmztejpHBONAzGA
         Hxp1pQPo1J3NfW/RwulVq7ywn+j4U+0a66ghkrfLzSInkho9l3kwB1L7KkOjc2BLQ/fy
         90Zg==
X-Forwarded-Encrypted: i=1; AHgh+RoS4yqctIRs9SKtIoiwz6Fu4G+RfUId2m2yHwI/nIazqoD5SGhARAty9EYaew6UPyAKauUXlIk8cIikzzv8@vger.kernel.org
X-Gm-Message-State: AOJu0YwmW+GycD2ILbNiIl4PNPGPwqICb+qXz2m2GUoiVT47jKriD8dN
	XuCZqB/4VBbIy9h6aTAIucP4CQjWSKzXaV2JBMeDLnGLzuKd2rWsecJnNEHl62rxl5ZyZndKqEm
	8AnchTJLKzO91MzKH/8YNWCXPfa7w0TnbJAW1JNe9x4Dieih8mr5NFs5wsezu/4o=
X-Gm-Gg: AR+sD10r7N+K5eFySEtFUfqHVTFcak+f1W8dY0XL67dTcupSugFTjgyzuhORh+S5fIr
	slzesIeDcOIdswVE8J4z+RaZM8pbXpN22tC6b3PY/MtzLNXjyN/TeM0v0+SYLC5h4MMfbyt1IVO
	SBA/9odWpb7HRHKlanofqWgJH5du8mY3ewHDAQC9hntv/cT4BxsnEmzDKHLqo70RJ7RDW+a4C8r
	o/aYPyzy4+NDF4mcbUmiOX49cIqxxAV/Q2nLxapFVWyXBt1NcnKoA7S5CVYP8z/79pyKD28zfWv
	7kUNU2WJ6LBFXW6lCqkDuitXQhm9vy3vPYQM2dif6c8tia0Y2k8Ok7ojA1ajmRzkQYYaIwF1tqh
	5PN9LzQBxolPwuxhvGfjMRg8H5jvW2Mtpshk3w1ye05IQHbtBNAj5hWPsoQJYglGT
X-Received: by 2002:a05:622a:261a:b0:516:d83c:edb6 with SMTP id d75a77b69052e-52d0b06e247mr51576991cf.12.1786045900651;
        Thu, 06 Aug 2026 12:51:40 -0700 (PDT)
X-Received: by 2002:a05:622a:261a:b0:516:d83c:edb6 with SMTP id d75a77b69052e-52d0b06e247mr51576641cf.12.1786045900174;
        Thu, 06 Aug 2026 12:51:40 -0700 (PDT)
Received: from ?IPV6:2a00:a040:199:782e:b593:3821:1a47:8a5e? ([2a00:a040:199:782e:b593:3821:1a47:8a5e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff79b529fsm9689344f8f.12.2026.08.06.12.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 12:51:39 -0700 (PDT)
Message-ID: <43fbe30d-54da-4bcd-ad2e-5391b327b642@columbia.edu>
Date: Thu, 6 Aug 2026 22:51:36 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] ceph: convert ceph_submit_write() to folios
From: Tal Zussman <tz2294@columbia.edu>
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
 <f835fc25-7841-47ff-bb2a-7f91b534dec1@columbia.edu>
Content-Language: en-US
In-Reply-To: <f835fc25-7841-47ff-bb2a-7f91b534dec1@columbia.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=MNZQXsZl c=1 sm=1 tr=0 ts=6a74e5cd cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Da8U98TiO7q1upZEImrf:22 a=HpS3TJQ9O3Ob1ozEcmik:22 a=b_efBAy1TN-SQDnTdmkA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE1NSBTYWx0ZWRfXytHVsskI6dCL
 1ajAU91GGoInR4Sprj6lpfZ5rO9Zwg85A3KOse8bCxxjC9fZ3yZ65bUoKBj3mtt9jQbbt7TuOO6
 wrVQxMt2WiJDbcQUYy2Fiv/RZTRMZT7X/f8t6c8btYsNCfKsMvlv8fwVnsjky8E//uC2Bp7ITxr
 YFE1JHObAjAlcn92wUsisGnisX9Yr2e8HtByfbVzzB96p2LzQMv7dm3ysV6Za8bhfwD6sZdgD5W
 YLygYCdRRQEpwtVP3JwjOLx2B6qm/hFfK43PQ0ba1dfk0d4QHI34dmf66AXt9dz/ISFGelDjk6P
 Vyvaj3NerPgUcJ23kcr4CZ47CGXIWdweEsMW8XJST8MWT7PowpFqyZGZZh/nUIC/IB8uX7o73xv
 6QX9OyayGrlgoyW8sOevMfDCUs4VkIQfZyoETIIb/Xt4W5ut/ciYMtf7YXBFfVV2QJOUFk+X+p3
 2uSNItxLlGCpSonodLg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE1NSBTYWx0ZWRfX5yVpnhpLmP1G
 uhuE5D+IAxfReSzBXZr7ckIVEd0SRzTnlKFJ1in4FuYfT5l41jBXz87hf5xANhQFy0yGBP1PAZ/
 ZJLaSyhdI2PhyXJq1eftRoqQNWkV4oSXjrh7xSKX541Y++pSwUNm
X-Proofpoint-GUID: MsYV33RdRO64wEjjBMba7f_A5_C6ouzU
X-Proofpoint-ORIG-GUID: MsYV33RdRO64wEjjBMba7f_A5_C6ouzU
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11867
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=10 priorityscore=1501 suspectscore=0
 lowpriorityscore=10 phishscore=0 bulkscore=10 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060155

On 8/6/26 2:58 PM, Tal Zussman wrote:
> On 8/4/26 2:52 PM, Tal Zussman wrote:
>> @@ -1436,14 +1445,14 @@ int ceph_submit_write(struct address_space *mapping,
>>  	struct ceph_client *cl = fsc->client;
>>  	struct ceph_vino vino = ceph_vino(inode);
>>  	struct ceph_osd_request *req = NULL;
>> -	struct page *page = NULL;
>> +	struct folio *folio = NULL;
>>  	bool caching = ceph_is_cache_enabled(inode);
>>  	u64 offset;
>>  	u64 len;
>>  	unsigned i;
>>  
>>  new_request:
>> -	offset = ceph_fscrypt_page_offset(ceph_wbc->pages[0]);
>> +	offset = ceph_fscrypt_folio_offset(page_folio(ceph_wbc->pages[0]));
>>  	len = ceph_wbc->wsize;
>>  
>>  	req = ceph_osdc_new_request(&fsc->client->osdc,
>> @@ -1467,29 +1476,28 @@ int ceph_submit_write(struct address_space *mapping,
>>  		BUG_ON(IS_ERR(req));
>>  	}
>>  
>> -	page = ceph_wbc->pages[ceph_wbc->locked_pages - 1];
>> -	BUG_ON(len < ceph_fscrypt_page_offset(page) + thp_size(page) - offset);
>> +	folio = page_folio(ceph_wbc->pages[ceph_wbc->locked_pages - 1]);
>> +	BUG_ON(len < ceph_fscrypt_folio_offset(folio) + folio_size(folio) - offset);
>>  
>>  	if (!ceph_inc_osd_stopping_blocker(fsc->mdsc)) {
>>  		for (i = 0; i < folio_batch_count(&ceph_wbc->fbatch); i++) {
>> -			struct folio *folio = ceph_wbc->fbatch.folios[i];
>> +			folio = ceph_wbc->fbatch.folios[i];
>>  
>>  			if (!folio)
>>  				continue;
> 
> This, ...
> 
>>  
>> -			page = &folio->page;
>> -			redirty_page_for_writepage(wbc, page);
>> -			unlock_page(page);
>> +			folio_redirty_for_writepage(wbc, folio);
>> +			folio_unlock(folio);
>>  		}
>>  

Actually, Sashiko points out a deeper issue with this loop:

"Could this unconditional folio_unlock() crash the kernel?
Looking at ceph_process_folio_batch(), folios that fail folio_trylock() or
are already under writeback are left in the fbatch array without being locked
by the current thread.
Then ceph_shift_unused_folios_left() shifts these unprocessed, unlocked folios
to the start of the batch.
If ceph_submit_write() subsequently fails the ceph_inc_osd_stopping_blocker()
check, it iterates over all remaining folios in ceph_wbc->fbatch and calls
folio_unlock() on folios we don't hold the lock for."

...along with 5 other pre-existing issues.

Seems like the folio_batch loop here should just be deleted? But that seems
like it should be a separate patch with a Fixes tag...

>>  		for (i = 0; i < ceph_wbc->locked_pages; i++) {
>> -			page = ceph_fscrypt_pagecache_page(ceph_wbc->pages[i]);
>> +			folio = ceph_fscrypt_pagecache_folio(page_folio(ceph_wbc->pages[i]));
>>  
>> -			if (!page)
>> +			if (!folio)
>>  				continue;
>>  
> 
> ... and this check are unnecessary. ceph_fscrypt_pagecache_page() can't
> take or return NULL, and ceph_shift_unused_folios_left() compacts NULLs
> out of ceph_wbc->fbatch. Will remove both in v3.
> 
>> -			redirty_page_for_writepage(wbc, page);
>> -			unlock_page(page);
>> +			folio_redirty_for_writepage(wbc, folio);
>> +			folio_unlock(folio);
>>  		}
>>  
