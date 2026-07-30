Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCC13A5E67
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 20:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785443949; cv=none; b=MmWeIu4gR3epNoc6PBM01HRVHMNZ99PYg6hX1nhfKDHKdQUx+UlV/FeX2cI3M5uoJHXngCgWoMrz1DP53WzJ0zWJ/gtPpyCwAy/NZ05AD1YjO5RQXlZGEKkQljAmialmbS05q9+b7GiWeTLu1cJ90GW8u71O595aq/jmb7Vr7f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785443949; c=relaxed/simple;
	bh=G/vRUOm8L2XZ3XeP9CnNcbxvMqQWrQcmwiBXs9OOzgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OSRZpsb7j088sZJxS3Z2G7r8yGTD5kQ1d1b9YkORLlkQTQ36TEFUfa27k4YnkNiBZBOoJkeve7GEyT0f29jS/5TlI+whfMdptgytDm1KejeAjUthUdDTbykrR3jhZSv6zkQ2Gu47si5C5dtvn4o3NCzoNjo3FCyuxXIkLTld1/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=WQ7HnPHx; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="WQ7HnPHx"
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UKY2Mq3753119
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 16:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=T8e8
	k+5EzrTp13lWK2mQytn9hp17i2RRCkab9M9He5A=; b=WQ7HnPHxqZL+jR81XllF
	JTKnzPju6U39UyyWhhTcphUfZ+xAg2wqUa791ebQ1v5NhvW0IuF//dLqtiOJvHMi
	fmyKW7M+TGXkdSy8yhCZpU5HL/IpFm8hExjB6Zd8ZTnCZBp0FfiM/4VmQMN3Nyjj
	wy9qKWJdLe5TFEiS34dauGmL0aNhbdETHjmjDl6ehafIPC0BA5I6nCfjcLjVALJk
	9EAViui9QVuK3SVhaPP15FKa4Vxbk1NUe/8NEuykcAZ7ZyTVvPKKcmrPB5R0nGP7
	1xqHFPEmX+ojBlGjFW+JqGfOPxg4M0VGW9uE0F4ziDhKljsql7UvZhC9GapkEQy5
	vw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4frd9kr98n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 16:39:06 -0400 (EDT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-520a00c7a03so3518341cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 13:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785443945; x=1786048745;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T8e8k+5EzrTp13lWK2mQytn9hp17i2RRCkab9M9He5A=;
        b=o37Kb+zfSyhnV9ZDoFxXz1BPFPQ+f1PBWRG2VmYb1pQ6AubKF7YM/gtfh7FgeoGpmR
         JhJ0UyM8y9WDcTV+Td8YeFtVWCy4X0wEL/XAvYL6qDrHsm8T5t3FSe8td+llLYiZ3TOt
         tkzVLqcFqbyG73HKjZlJmV2fvC3kCejf9gBrb8OzbcDE2Fx/N9jzkqt+kkKXOfAUMWT7
         JhiU41GSJ8Q+wQs02bOruy/0GjxGwIVh25i5cDKYcFgTKiSwX5DYYhEhX3Rh2yPkUFwq
         4jlSQrISitIfPqdnv4v3IFzgQCFjS9jFXw0P4qlK6j7wZ01nmoDz92GWDmC6KOsnIS5W
         Gtog==
X-Forwarded-Encrypted: i=1; AHgh+RoUFTQYTMf+tTFcqUISRMRycENx3JGkzuD0GQ4tuNAy3B/dnPy4ySXpuE/m/G9k/bCl/svXO3imcE5CJql7@vger.kernel.org
X-Gm-Message-State: AOJu0YzytOw4ABboaN/fyEZpngfaHX+3oaGX5he3IaEWDsaKod9qO5hA
	4gLii6rlrkO0He9BwjHdari2avy0xgsvtMzoY6pCR/EZ8+JYEkrNXObFClY2qjFRbGgoCLAOQJg
	m8mJHxN8qhiUaE3IuTHpSCzKgeeC40cbNna8pSi3PJrMGueC8tnfSEbN6A9LvdDM=
X-Gm-Gg: AR+sD10mPCmLPDsH79Thx9s8EWIIzCS7GKxtbNhn77sLnTUztHrGBrCNmSQUNTI2LYG
	BHLzpCjwOrc838e23ob2b+54k2gtRbtskzz3u9X+mk7ZNznv6JDus1zr9H4BqCI74EGM/X0QJgW
	yGko8fRsB1wyWSAQjWo3DZjCATN3xjANzj1E2guO/RzXxrvjNHC5pFQWpKaeGSluH9QGhpuBW+8
	e78c4p3esE6aMfgJ55YwWcG4bftjAKIwKxz7RyvUWa504mc2+rPK05sKVq+YA/RS+HOfXI1P76Y
	FfG83uesxzR+NVfQOOYjewEHZ1UOVb45fZh92SsDrrU0BCw9nO3MWIF8d/zDADRrpAQyiPpNka3
	FE7qJ5NpH3okBh9I=
X-Received: by 2002:a05:622a:3d0:b0:51c:7b11:41a9 with SMTP id d75a77b69052e-52b38757e60mr44335581cf.86.1785443945558;
        Thu, 30 Jul 2026 13:39:05 -0700 (PDT)
X-Received: by 2002:a05:622a:3d0:b0:51c:7b11:41a9 with SMTP id d75a77b69052e-52b38757e60mr44335011cf.86.1785443945082;
        Thu, 30 Jul 2026 13:39:05 -0700 (PDT)
Received: from [10.206.71.35] ([129.236.231.134])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529e2d8251asm48127221cf.19.2026.07.30.13.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 13:39:04 -0700 (PDT)
Message-ID: <15506dc8-e5b8-4fa8-a85f-912a92edb83f@columbia.edu>
Date: Thu, 30 Jul 2026 16:39:03 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/5] iomap: use BIO_COMPLETE_IN_TASK for dropbehind
 writeback
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong"
 <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
        Sandeep Dhavale <dhavale@google.com>,
        Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>,
        Dave Chinner <dgc@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        Hillf Danton <hdanton@sina.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-erofs@lists.ozlabs.org,
        Christoph Hellwig <hch@lst.de>
References: <20260730-blk-dontcache-v7-0-3e8e6850068d@columbia.edu>
 <20260730-blk-dontcache-v7-3-3e8e6850068d@columbia.edu>
 <amsHrVCJnuXzeGG1@infradead.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <amsHrVCJnuXzeGG1@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE0OSBTYWx0ZWRfX+D4QeK2JDTCN
 C/9aDqgTd60Tul5Oh5rriNmSWj1uuU7kP0OPnG74Lqsddzl9Zo8Kr01EEEqSjPMHEBhaKq25av2
 6gfFejR9rs5n04uoGx8bp2+EcBaMmid47HWw3PeasTIs0SvJZsMn
X-Proofpoint-GUID: vBa1m4JaCcgs3_BZA9sUr63-uyZJrHCL
X-Authority-Analysis: v=2.4 cv=fPYJG5ae c=1 sm=1 tr=0 ts=6a6bb66a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=Mx06nvryMUGB95QVe9e23A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=qsXxR-sLYAu0WPx4Yu8A:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: vBa1m4JaCcgs3_BZA9sUr63-uyZJrHCL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE0OSBTYWx0ZWRfX+xOzWA33ikb2
 99BnO5kWckSGdvh17pK2r3IQCOpX/AZkezeFd4sC6w/SyXpuBAXxrfCLAISg347M/eX6Qv2q6kI
 yCnUikLwLd6QdDs5AJQd5WknxAvPevj+LteW6J8CILw/62rfC+9DLUDleSSOHTslVDZGDsxXp00
 CvlmEqmR2EM9kAPYwBvRo/i33eO0E8ce58A3VJnXCFhnqSDDTfuY+jFS+oCl0mfNA5Q+StPFs98
 5iGS7jo5Y7cqGBEf+qFw7G4H6mT3D2oSi1yb4P6362FIb/mHcv9RgYAk4O3pcmP/l1T1f1sA6mS
 o3ZZ5xC3X3uBLJFrzuUx4M5zmwK99aoKv+dDpPo5wTwuNH3wjCVgODBSGpdwJTlu6wba2+Kzakp
 k5VCwTKeJixK2elJSZkb69SSdUlslAUmcn1ROFA58aIHh/Ap0zVqKo8oV5/pTfuFxmVVTqKpC+m
 MFUpiUwzBmrbyiauBYA==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11860
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=10 spamscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=10 bulkscore=10 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300149

On 7/30/26 4:13 AM, Christoph Hellwig wrote:
> On Thu, Jul 30, 2026 at 02:57:53AM -0400, Tal Zussman wrote:
>> Set BIO_COMPLETE_IN_TASK on iomap writeback bios when a dropbehind folio
>> is added. This ensures that bi_end_io runs in task context, where
>> folio_end_dropbehind() can safely invalidate folios.
>> 
>> With the bio layer now handling task-context deferral generically,
>> IOMAP_IOEND_DONTCACHE is no longer needed, as XFS no longer needs to
>> route DONTCACHE ioends through its completion workqueue. Remove the flag
>> and its NOMERGE entry.
>> 
>> Without the NOMERGE, regular I/Os that get merged with a dropbehind
>> folio will also have their completion deferred to task context.
>> 
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> 
> This seems to be missing the bug fix you identified for the double
> deferral?

Sorry, I misunderstood and assumed you'd take care of it in a follow-up.
I'll adjust it as below and send v8.

> I although thought a bit how that could be done cleaner, see below:
> 
>>  		ioend_flags |= IOMAP_IOEND_SHARED;
>> -	if (folio_test_dropbehind(folio))
>> -		ioend_flags |= IOMAP_IOEND_DONTCACHE;
> 
> I'd keep this flag.
> 
>>  	if (pos == wpc->iomap.offset && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
>>  		ioend_flags |= IOMAP_IOEND_BOUNDARY;
>>  
>> @@ -256,6 +254,9 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
>>  	if (!bio_add_folio(&ioend->io_bio, folio, map_len, poff))
>>  		goto new_ioend;
>>  
>> +	if (folio_test_dropbehind(folio))
>> +		bio_set_flag(&ioend->io_bio, BIO_COMPLETE_IN_TASK);
> 
> And move setting the flag to iomap_ioend_writeback_submit, and only
> for the case where no io_bio.bi_end_io is already assigned.
> 

To confirm, this would only work because XFS provides its own task context
and is the only consumer of iomap that sets its own io_bio.bi_end_io.
If another filesystem set it and didn't provide task context, this would
break, right? I can add a comment about this requirement, but I want to
confirm the intent, as it feels a little fragile as-is.

