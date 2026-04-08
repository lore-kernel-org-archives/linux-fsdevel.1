Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352C036F41F
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Apr 2026 20:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775679045; cv=none; b=XGmuJ1a3ZvveAJw3hGtDqP8a3vsql1KWHxWOhXIsXeAr3BKJpFTuFUDQmRkm2DS0dkvnCcKvDcuSznnDkm+fmfagh2Cm21C2IwN/OvZZOEHWoEvE76wXOcRdAKq6LJ3NR3bSVhIcsxgQUZ4MSzISXGnUvhuwKL7iduWX3BjW41c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775679045; c=relaxed/simple;
	bh=WMLKKNYiSxEy2xAU6WTHaAaTE+cBa07ovGOG8ufCpc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFaMcmfhsnlfgxmFJYz8Usjr0AqgZPEiGfjNPeROyz3Ic8Z7q7UdPZElUwML3E7+ehGwL6BmbEQEk5DSCu0hCtV1c24WieB+7QaKW2hHQBpTpwtj1jADNUssNh2npyMx9V7X7WrriVVKT6xYpfwDx/zwjJbWKErgK0ucM5Ni3Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=g//499sA; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="g//499sA"
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638JuCJv1414353
	for <linux-fsdevel@vger.kernel.org>; Wed, 8 Apr 2026 16:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=vSff
	Q46dxsNqLEMfW9mFNMfZBuciexIdSUQp95L3zYs=; b=g//499sAUgG6l/aPNEY4
	MrWDgZlHmfuOJ2N7pJMdRvAl/ADxc31gcYWWhPadhtApYsJGBMdVuAZ84Tyf0TLd
	o7X5qy6NkDuP6cuAUkdTFD8YsGuNlKCVqHKCAnE9rBvb0CUUJkvkmpeafOlj6nFb
	KtVZjONIOH0+rMVhdndCyxP4SZmYj9cAcwKbHQBhr3E0D2JfV0q7q15HV/dekLR8
	RPvAfnvNTl8WK7OvOdrYJ5LOORWmu9FgFUIZkXM0Vzzwg+Yg6PWm5vkmCIWOp7A6
	AKzSJZs356dJIl90Rk97kyFsa3pwGkyruHvPJHy6Wv6ixy5KnZy0bZvHdbim9/DG
	Ww==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4dda3mfn3d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 08 Apr 2026 16:10:42 -0400 (EDT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50b3544bc7bso1684191cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Apr 2026 13:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775679041; x=1776283841;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vSffQ46dxsNqLEMfW9mFNMfZBuciexIdSUQp95L3zYs=;
        b=bW1hikjn/0KSQSG9QbUoBsFDg498UqbD2KN719VxGUdA6WbzrfRi/fAYaXD9PhVkNN
         Qg/mMahNB9h0X8xf2MedcMF7uSrnn3kF2kU7Oke3ip3O1IicmmJhv53wbxad58fEHbG/
         /lC2Jk6/FgHGVlIwWgCC+E9tR70Q42SeO9IGxmDta2NO4g1a+VzgVhciFOTDNjuEjUcT
         lUlc2fW8BpbzKlXp9xi09uOwPNoU9+Y03eTVfxVmVjkT1X3hcgnZo2vDzr4WgGQ78US9
         Nc/eoF9MmduJq9Q/M9Gvpa2AZQGi6E6z1jL1ef0GwCjOeUXo3DZLn+90KHqOJkbZdB9m
         JbPg==
X-Forwarded-Encrypted: i=1; AJvYcCUzfr8y1evpeOAa5rYkP+/zMdaTOUZJauO6hd0XZFQ9w50i8Bi+tTLk+FnECbelXLKSEnqS17peZ2wlBFEk@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6qiHZ6iH2V/71/fcnkJfwF8w8MMCgv1zB7R5lbBf9Gjyhp896
	LdLc89PiOV6WfHDc0CGm+/UilHCQdlS2zdnV2n34TyVOQYollfua6bIkz+HLhhkU1bURh5Vpk++
	+0cpKUIGXQqUQlljq6S6V5D+/BOQZPhRfrIADQlMd40/y6VlqN8JmMu7zUi6ZidwTpu+Icis=
X-Gm-Gg: AeBDieuGr0OS2New3JDTT5Bd1+OGP7WiRAbSo3cj7zwjA08aRy/+sl+L/oLXWJwzhSl
	Z2CIV7g4DWNkBDapUgNr7gzOdT/JAF+eRqhiVTGmFK+7/OavlQp8LTpwtl9c1TfoSxsW4aXy0aM
	QWe+V/XLAgSvpAXGyJsq1u48CmtBKZT9HDwRdLHwcwZJ4Vfav56xdhIytUWd1N7o50KNQd0pSoz
	E67ZOWbCUkPTQNxZpNkBote+PFBJyLi52ipQobO490Pmlx09LhPWXmLuEw9XdyU9/2Yw+I5jgau
	gSb4OPfjQSouSWX9qq9GElH0vQJvZzEGAmRa5exy09abYK55sBxPRVqhT27ntCJoZmUcG5ujg0k
	FHXjpjkvxBb8+EyUpnk0qfFy2P1GZJ8WYcMRqGf3Z
X-Received: by 2002:ac8:5846:0:b0:50d:83d7:686c with SMTP id d75a77b69052e-50d83d76b21mr252299101cf.31.1775679041400;
        Wed, 08 Apr 2026 13:10:41 -0700 (PDT)
X-Received: by 2002:ac8:5846:0:b0:50d:83d7:686c with SMTP id d75a77b69052e-50d83d76b21mr252298531cf.31.1775679040871;
        Wed, 08 Apr 2026 13:10:40 -0700 (PDT)
Received: from [192.168.129.206] ([216.158.158.246])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50db5cfd8a9sm20333591cf.12.2026.04.08.13.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 13:10:40 -0700 (PDT)
Message-ID: <62c1ec17-082d-4215-85ca-3e87048a6226@columbia.edu>
Date: Wed, 8 Apr 2026 16:10:39 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 2/3] iomap: use BIO_COMPLETE_IN_TASK for dropbehind
 writeback
To: Matthew Wilcox <willy@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20260325-blk-dontcache-v4-0-c4b56db43f64@columbia.edu>
 <20260325-blk-dontcache-v4-2-c4b56db43f64@columbia.edu>
 <acRDyJrkJhnHHMSe@casper.infradead.org>
 <9631d652-fd3a-45ac-b8a3-b632b26f6fa5@columbia.edu>
 <ada0KnRjpYnY_QYh@casper.infradead.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <ada0KnRjpYnY_QYh@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Ran96yF8l1em0Vp5vWJM2AQ-wBJcl4VO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE4OCBTYWx0ZWRfX/wBGM4p/WS5A
 3bFVnuAuas8B6E8Nu2Esx+GJTWF+KwA4RgoGrOD1x6eQqpoWWfBfoicZJW17vF4bsZGYQIctpQD
 NfNODyqbC/OKKhg31fefAW5IGzqZoEOYNQKL5xvvS+eNC7G9MkjzSuY6nJB7VVIVqw0zklDf7mm
 FradhLWjlevDdCi7Zu75LX8YVUyyGx3rPCmX8zlDa6oVbUulVZAMh0lqXjUBG6EHIRUviOzbS+H
 mV8MO9CfXwppvFNGNqwgL/9wnO7krrb4WY9qr1PsOt+XrwZYNqTts+BeJWa2bsOb7RnknNjmMF9
 ha/CnJ9Ng+ZZq18UcOK5iwqSKTXm3rP0S2n1a63hQzz9V6WHaoIvS6pj1bakkNfn3OHndNpxtlp
 8L6/oYFRgmMQ2RvZhz7xWwbHNWYDh42EngGd+Yr2BQnfykJPTtQBPUJymwM/8WLwWPheGr8p7S6
 NoWhVZq0IYjyBpv+1iQ==
X-Proofpoint-ORIG-GUID: Ran96yF8l1em0Vp5vWJM2AQ-wBJcl4VO
X-Authority-Analysis: v=2.4 cv=X7Fi7mTe c=1 sm=1 tr=0 ts=69d6b642 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=mD05b5UW6KhLIDvowZ5dSQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=rfDhleDhcnsx78YaP-MA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11753
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=10 priorityscore=1501 impostorscore=10 spamscore=0 phishscore=0
 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=10 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080188

On 4/8/26 4:01 PM, Matthew Wilcox wrote:
> On Wed, Apr 08, 2026 at 03:44:37PM -0400, Tal Zussman wrote:
>> On 3/25/26 4:21 PM, Matthew Wilcox wrote:
>> > On Wed, Mar 25, 2026 at 02:43:01PM -0400, Tal Zussman wrote:
>> >> Set BIO_COMPLETE_IN_TASK on iomap writeback bios when
>> >> IOMAP_IOEND_DONTCACHE is set. This ensures that bi_end_io runs in task
>> >> context, where folio_end_dropbehind() can safely invalidate folios.
>> >> 
>> >> With the bio layer now handling task-context deferral generically, XFS
>> >> no longer needs to route DONTCACHE ioends through its completion
>> >> workqueue for page cache invalidation. Remove the DONTCACHE check from
>> >> xfs_ioend_needs_wq_completion().
>> >> 
>> >> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
>> >> ---
>> >>  fs/iomap/ioend.c  | 2 ++
>> >>  fs/xfs/xfs_aops.c | 4 ----
>> >>  2 files changed, 2 insertions(+), 4 deletions(-)
>> >> 
>> >> diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
>> >> index e4d57cb969f1..6b8375d11cc0 100644
>> >> --- a/fs/iomap/ioend.c
>> >> +++ b/fs/iomap/ioend.c
>> >> @@ -113,6 +113,8 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
>> >>  			       GFP_NOFS, &iomap_ioend_bioset);
>> >>  	bio->bi_iter.bi_sector = iomap_sector(&wpc->iomap, pos);
>> >>  	bio->bi_write_hint = wpc->inode->i_write_hint;
>> >> +	if (ioend_flags & IOMAP_IOEND_DONTCACHE)
>> >> +		bio_set_flag(bio, BIO_COMPLETE_IN_TASK);
>> >>  	wbc_init_bio(wpc->wbc, bio);
>> >>  	wpc->nr_folios = 0;
>> >>  	return iomap_init_ioend(wpc->inode, bio, pos, ioend_flags);
>> > 
>> > Can't we delete IOMAP_IOEND_DONTCACHE, and just do:
>> > 
>> > 	if (folio_test_dropbehind(folio))
>> > 		bio_set_flag(&ioend->io_bio, BIO_COMPLETE_IN_TASK);
>> > 
>> > It'd need to move down a few lines in iomap_add_to_ioend() to after
>> > bio_add_folio() succeeds.
>> > 
>> 
>> Actually, looking into it more, IOMAP_IOEND_DONTCACHE is used as part of
>> IOMAP_IOEND_NOMERGE_FLAGS. I think deleting it while maintaining the
>> no-merge behavior would be uglier than leaving it in.
> 
> But why was it added to NOMERGE in the first place?  I don't think it's
> harmful to merge writeback I/Os which are COMPLETE_IN_TASK and I/Os
> which are not, as long as the final I/O is completed in a task.
> 

Looks like it was added in commit 34ecde3c5606 to ensure XFS DONTCACHE
completions were actually punted to task context... which we now ensure
elsewhere. Will delete and mention the side effect on regular I/Os in the
commit message.

