Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4261C37DE97
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Apr 2026 19:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775677482; cv=none; b=SXHHerns7vdsVLUfZXyyAXWz8QmE5j/IbIfMV22R1eJfZH2zhNxmxVcDMa/HbZjgLEfDXQEpxE7ZAiy9TKj/xJx4nLVoI2IFfJ/V0akFn927mVic7eV3FkgfJL5iVvrA8gGZpfZgBWTfHl7YpBipxa/hNfyJWBQB+O9vQPRmg4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775677482; c=relaxed/simple;
	bh=UKOON8VnufQeIosYs85uC5OQYu8eeg0kTOI170aPmhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G8xCZMpnG2tQtQm9n5r6rkffqKdkQOGFTKc2zBuONwaiXKCUnqdPJPgnuUqOLCL0kV7x2rv/z0jmM6wQoCsBklxGsC6jqwXTw/nn3H2y2uF3Pg4Oz1pPaNJbfClta7Wdl+lUZfVz2hyTPeVJfVJxch9k3G3Y262vqs4i1sZR9Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=iUwfPg//; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="iUwfPg//"
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638JPhLq4156575
	for <linux-fsdevel@vger.kernel.org>; Wed, 8 Apr 2026 15:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=cQ/T
	G8NyYW11ar8cP2zAAoS1p0Xy/yaGNX7PKSKfnNI=; b=iUwfPg//iz4QeOnNBzRS
	26n2mXDCUin867E41bkq6MbXzJHVhjIy/JEpfgrWMmzpIsMffhoxNVTijCNdayK/
	omdxmyQIaWWqjhhsoGUDrlftst5MjFj746hiLNxRoVv72HAOs+GhT20N0600pdSJ
	u5kM8hnYgRkZX6K4bIoCR7Qo/G/l5U/VGm6eJWpF8tJjbvRicduLndw2xV5BJFV6
	2MO5int4NAEXn+ocjmyXJjwWv5Zn7wusO7sw/CSCjPjDYkxyp/CFH6qM1gnEVUvO
	4Dt9o5W5NtfMdq6ljtr/V5OX8jy9ZDscvwkt3yUFXutNGJ/muM2RT9QZnmgA/w5E
	Zg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4dda3mq7x7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 08 Apr 2026 15:44:39 -0400 (EDT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50b220c72bbso6228791cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Apr 2026 12:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775677478; x=1776282278;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cQ/TG8NyYW11ar8cP2zAAoS1p0Xy/yaGNX7PKSKfnNI=;
        b=HormOkmjwvACVDx/mlecausUH7ZwUWLWtLCxOTH4iKcYAzYFFkjdS5Oxude3MoDnfn
         1E8z1FUT2eRlJSCSq/8uzqn6s51QMC+p6FZrtiuZ3OQ2yCshE5AXtCZER7DzFmNhhIP1
         efLAfqI4fwZ0hMFFejRrv0KaeKXDT2QOWCS8jsiXgEi40m2J9WglNX40uWsvma/4+iH9
         LILtipNE1W890UVRSE0hgRngGHQvoPjhfb6QYahJU2eL5uviKDo8nPLLTYfNzFGqd8Yg
         GbUEA2nhKXOhXuwa5sQhQS0nBEpw/jXddpSOk8MKmSDQcBqZSyGxuL2MGSEQmA79lhg9
         X4jw==
X-Forwarded-Encrypted: i=1; AJvYcCW4CWBU4S2G3aUgsIfNkuRwLsSPyO6N4nNUFq9VN7VoX/W5WvFQbStfigxAiKcIlLeGy86ctrImXYSC9j8U@vger.kernel.org
X-Gm-Message-State: AOJu0YyNf4M24Zkdk8vzUuceNC3iBMQTQhAlTDpXt9Bc+yrNGCWsGz/S
	k2bwFmOhnppje1oI737yNRcNPH8WwHDz8E6T6SheHTRSDmbVfz88rUVmPShFMqTsjnERNr7djJ5
	VFQxHBOfb/eFIc8Bs15EZCv7crL0NRLocIDTwHhC5ahYK3QEEQtDiSRWnZcOo8A8=
X-Gm-Gg: AeBDieswCOMXmGAope2XuWdFF75q5aU9SWjlEulvM/5fy1XR4KoZuyodNn8iAJmVI3m
	vWZjKk7yHwW5e3u5VO/qs9cbBxVwshFyMtf/v1cWNMGl24SfEfkZ/KXaWig3ALKDFmpQrJsOzv/
	yS7PeH7zkoST+PzHYSbLqTAaXpsHP/b6gLkyl3r+9zJ+QHdyYm5SfeZZY7wxj26yTEM+JUb6tlK
	3DSebeCdaPXaBe35dvPEFBqhf4T1Iw3wyquoGtZzTiDn2Z5ylgemzVEfj65rRof1BoJC5Q7PESu
	t8pB40CzWZo9D2nrJfmDawlyujOLng6/lUcjMO6Cqoixs4DQw11EiRjuzGk9QP8hXYoAILuJCp+
	tFZ9DW/usl4p1o0E79eB0ett7dH81bUhoy0mjECN+
X-Received: by 2002:a05:622a:558b:b0:509:3098:819a with SMTP id d75a77b69052e-50dc22dd2a7mr10872181cf.44.1775677478532;
        Wed, 08 Apr 2026 12:44:38 -0700 (PDT)
X-Received: by 2002:a05:622a:558b:b0:509:3098:819a with SMTP id d75a77b69052e-50dc22dd2a7mr10871821cf.44.1775677478076;
        Wed, 08 Apr 2026 12:44:38 -0700 (PDT)
Received: from [192.168.129.206] ([216.158.158.246])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d4b1a3fc7sm215560781cf.5.2026.04.08.12.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 12:44:37 -0700 (PDT)
Message-ID: <9631d652-fd3a-45ac-b8a3-b632b26f6fa5@columbia.edu>
Date: Wed, 8 Apr 2026 15:44:37 -0400
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
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <acRDyJrkJhnHHMSe@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE4NCBTYWx0ZWRfX+aMRrjaobf//
 JN2het0F06l0F5Pitqr4PTfjDwGl72FiPVEvcGSnlWcQvmbwU9B8AqN9HVd67r84wacV/ynUGVt
 ANUzsZ5N1jSwuV7M2hdSCiFlYa0X0MFsRnyKryOhi0TsfGVeclHH3L7djv+hsQid7s886e1opab
 75unlR7ZJ2Aonon+6gVs65/nKMFmDv6uV5qytYMzA2HOL8+wOfl09+WtvKUC1YPfzaLrNkn0+3T
 4uwOavt6XJyfQgGcWtloN4/q6iBp1kXRsElCHQdO728p3O/MqLl45qznlZ7lh+kdO49Nqde0nUW
 qAPsIe1N8nT7A906tFsVXt3PwC3p+jt8KzAoFFsdl6VNnBSMzkWN2Y2iGIqaedZmWk18cbC2QlW
 BSQhlhSkqKIBWHWy0Jv9LhaBk/HdHtR9fIMDbGIqKk5sCDfegYr+2M7fqs+LVXPMz5sYpwkfbDl
 nfeEi44Bmp5zcYmkn6w==
X-Authority-Analysis: v=2.4 cv=U8iiy+ru c=1 sm=1 tr=0 ts=69d6b027 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=mD05b5UW6KhLIDvowZ5dSQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=X-nALmS6JCAzqVr0gswA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: tUk_esTVPBp-1ZQOpSTQdf3TDnfOtP2R
X-Proofpoint-ORIG-GUID: tUk_esTVPBp-1ZQOpSTQdf3TDnfOtP2R
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11753
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=10 bulkscore=10 spamscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=10 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080184



On 3/25/26 4:21 PM, Matthew Wilcox wrote:
> On Wed, Mar 25, 2026 at 02:43:01PM -0400, Tal Zussman wrote:
>> Set BIO_COMPLETE_IN_TASK on iomap writeback bios when
>> IOMAP_IOEND_DONTCACHE is set. This ensures that bi_end_io runs in task
>> context, where folio_end_dropbehind() can safely invalidate folios.
>> 
>> With the bio layer now handling task-context deferral generically, XFS
>> no longer needs to route DONTCACHE ioends through its completion
>> workqueue for page cache invalidation. Remove the DONTCACHE check from
>> xfs_ioend_needs_wq_completion().
>> 
>> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
>> ---
>>  fs/iomap/ioend.c  | 2 ++
>>  fs/xfs/xfs_aops.c | 4 ----
>>  2 files changed, 2 insertions(+), 4 deletions(-)
>> 
>> diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
>> index e4d57cb969f1..6b8375d11cc0 100644
>> --- a/fs/iomap/ioend.c
>> +++ b/fs/iomap/ioend.c
>> @@ -113,6 +113,8 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
>>  			       GFP_NOFS, &iomap_ioend_bioset);
>>  	bio->bi_iter.bi_sector = iomap_sector(&wpc->iomap, pos);
>>  	bio->bi_write_hint = wpc->inode->i_write_hint;
>> +	if (ioend_flags & IOMAP_IOEND_DONTCACHE)
>> +		bio_set_flag(bio, BIO_COMPLETE_IN_TASK);
>>  	wbc_init_bio(wpc->wbc, bio);
>>  	wpc->nr_folios = 0;
>>  	return iomap_init_ioend(wpc->inode, bio, pos, ioend_flags);
> 
> Can't we delete IOMAP_IOEND_DONTCACHE, and just do:
> 
> 	if (folio_test_dropbehind(folio))
> 		bio_set_flag(&ioend->io_bio, BIO_COMPLETE_IN_TASK);
> 
> It'd need to move down a few lines in iomap_add_to_ioend() to after
> bio_add_folio() succeeds.
> 

Actually, looking into it more, IOMAP_IOEND_DONTCACHE is used as part of
IOMAP_IOEND_NOMERGE_FLAGS. I think deleting it while maintaining the
no-merge behavior would be uglier than leaving it in.

