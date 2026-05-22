Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA9736C9E4
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 22:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779490075; cv=none; b=WoQfY9d+Ud9EOdYHVOsxHKStwB+9XXsAYBDk0SKRp0StVcopVRHMDkdBO2tG8yRuSjz1Zcf3v5oGsPPwQcKI4/7DscGaMoUlfeSAdrLZHvrLIDESMWKjHDBRyz5jFHIgDO2TCi+BA1u4KU3lMG2mWZXzdsxq2JAE+c0lRqssYq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779490075; c=relaxed/simple;
	bh=uoKzIXGyLSdhgTaP6+mkc6gT7TgNsg+NqAIq/YBaHoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQGRLpdB8fu8DG9LVoLXE4+0rnzTiHasl4BIUcHVM60AVGp6J8AXTCKWJ5eLjRRp1IATs+YzNNBiUsQpvaoFNl4EV8Tq5880bwo28LM7fBBQvy2o7/ENcvrbgNSHAPtfw7pX8ja7g6UziTPBzwWwhObAKbz8PKCaQf58u9XEZko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=vFpYLWSb; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="vFpYLWSb"
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MMTOc31098082
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 18:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=TT8g
	lPTJWpZIUOrxyHUumKTmUNTeW5g1ZoNuE+A9ihg=; b=vFpYLWSbBpFKJ85ciFEi
	u2SR/IdqoXjnN6kLyLFAjIYNXlFduNAnKzlEOJyqebGO0BXFOXjsCKKQJvRpDhUH
	aUpuTGjW4y5shIkVkdDenX3gvbQPh7KZhgEc7Hc9vmM/v9gxlvZ3XsuWfoK58UbO
	vrXMR30AVDvhb9znjiDddAxgzDhPpb0AbCsj0BEwoahpaDGgnCWx3G+WBTDbFEXh
	YAtoaNiOY/hYZBSdZmzrj4AAJ4rTdfh2MY+l1WWXcYKdOY+FTwg32JJcgVrKzrxm
	fz3jOddrfZIJJZdVvcWgGxEk0/qjEKpkEhlr2iPrthjaCzM9KuhM1MTjfH79+HsB
	/Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4easg0k352-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 18:47:46 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-514ae0e3ad6so197895971cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 15:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779490066; x=1780094866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TT8glPTJWpZIUOrxyHUumKTmUNTeW5g1ZoNuE+A9ihg=;
        b=nFAmcFvyqIYY4txHAEOvbeaxhcyPcqkjgnaKir6WqLbxjh+3n2f2fsnb8FsVYJOVcZ
         BNYG6Z/c3sF/SB2osPaDBmxp8NcZhEpJY0rbwCFEz66yAVLp2IpusaywFJF8G1pxZSuM
         3COWeZgRJz/5SKxWHTX0KD8MdW5dosNrI7fcm2hVVDnapEUVuOyErCN6JAQLzxFf5AZY
         AFnQ3QgnXPI6v0DMqaKFfZyjfIj9zZVNz/Ecy1cGtL/ea3oLVjO39uR+lSAxeVKP8pzr
         9zc1jgQyXs/KKcnrSJYpOMFYKvvfrm5yiJlZ4DxC7VxZTaFDGMW1im2PL5afc3gq4Xeu
         okIw==
X-Forwarded-Encrypted: i=1; AFNElJ8Mm1rGCnlDFHeGTgeNjsy9FaeED73Fz6ATn9VlUvS+jBeK27cTel5NMmnSCkXQnCFT9bGLBxgsiTtD/3Po@vger.kernel.org
X-Gm-Message-State: AOJu0YxLqzNDlFP692cvIwtnYeM/2gsnhikVEmBWYicY2npHpU4EUVMa
	5urYt8sZHYORpQ9wXLn2PyDHad5pnmUHnV4NYuP3cAQIfWYDKU16U+pBqOjnSquo8+50hbDLcfu
	2jgao63xuo7bvKUvhIkC6p7dbxdouRZlEBc+TUT/JHMQmcgg4gEvCPjaSDT3H680=
X-Gm-Gg: Acq92OGj4lHg+UIcqN7JO37+wizBVzio+7AWyLpHsIdeiLAdEDUeLHCmcY08YBNCsXb
	2XYiZ+mqVwzzwwGcB4iJMWyJhvJu5MnohMyy6Ms/1spMPrp+f4NSc2/zZ6kjbVuhoImyU6IXsHV
	D+Nb3/a19phP1PyftDPYcevcXpkj4jMIqWt+Ll5sZRHU3bFS1QibiMMSxYINaw8QP/V9YXhQ90z
	DJ5ZIyhWrMKqYBN/15p4QjQzNtVGWZRFfCOPhS738KEffhBO2mnOFVCGRHRQtlCB2LcH8tirWqB
	kOZ+gtNuXmZoSnoTFoa6YGkhdRxC4gQEvLl1g7y3PWKRkhQD1MJhlOe7xGbpEiDoBslRUv7Sj24
	6b6N4Gw4feKBlQoduUT6sgWANYyUocKK0PpyF7Q8UMMtPcEQP23+fYAvYpKzUrzEsAmdVpcfViv
	AmNvgGIqA6DA==
X-Received: by 2002:a05:622a:647:b0:50d:987c:8174 with SMTP id d75a77b69052e-516c54ce3famr103506851cf.4.1779490065817;
        Fri, 22 May 2026 15:47:45 -0700 (PDT)
X-Received: by 2002:a05:622a:647:b0:50d:987c:8174 with SMTP id d75a77b69052e-516c54ce3famr103506511cf.4.1779490065251;
        Fri, 22 May 2026 15:47:45 -0700 (PDT)
Received: from [10.207.65.224] (nat-128-59-177-214.net.columbia.edu. [128.59.177.214])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8b00143sm26022671cf.3.2026.05.22.15.47.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 15:47:44 -0700 (PDT)
Message-ID: <ea1fa305-3ba2-4cfd-b7cb-86875032a300@columbia.edu>
Date: Fri, 22 May 2026 18:47:43 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/4] block: add task-context bio completion
 infrastructure
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong"
 <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Dave Chinner <dgc@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Gao Xiang <xiang@kernel.org>
References: <20260514-blk-dontcache-v6-0-782e2fa7477b@columbia.edu>
 <20260514-blk-dontcache-v6-1-782e2fa7477b@columbia.edu>
 <agq2KRd8RkP1TAf5@infradead.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <agq2KRd8RkP1TAf5@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIyNyBTYWx0ZWRfXyz3YnTBkHudW
 /2RDHKbu+PWEekndX8r4rw9cVP8DMkk3Meqysn9sSij5bhyQ+istSzDhllkLRWqkQ1pQyqxQ6Yx
 gBw4ohXZj48jEXdVQLYFi03f9R8EN0F7QIZp1vDAcx7JH1l4cas7PrSGLOwhrRBQMPxp+YrJneH
 ijD1v7Sx7Om0Nhcq1Z8MY+5wIy8wCUdD1j6PkjZ8FwNp97FyajPvEYvoQmOTb9ub1xQU6TEZ0rr
 nJ7Z5CUe4Pw7/PyZ8wWgROPBxja8dLQw48J1ovYSNU/uX59z2G5Ol/x4wR7Qoz5Uv8roz9zrmsS
 xZPz+n0v8gt8uK8W57bpYyRRkUk9mplg38JsCQgaSFz/4nbTwXEFsCYqtFTy5UIcqcXGxEZqO+E
 I7kP2M3cBH0dY/GNysGLYA4SqMNARP7OVCVhQkN+P5DAa1/iDSRvlBIzKkAGgvf3P+/A3aE8I9M
 njDVVuULb6zYwJ9OaFQ==
X-Proofpoint-ORIG-GUID: CK5P4yibAska1JZJP-0L_2KNWSdDU2_x
X-Proofpoint-GUID: CK5P4yibAska1JZJP-0L_2KNWSdDU2_x
X-Authority-Analysis: v=2.4 cv=OcKoyBTY c=1 sm=1 tr=0 ts=6a10dd12 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=n4JpGxNP30DHW88kdRRHAg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=76MgQrUCaxHmrnKOjHwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11794
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 bulkscore=10 clxscore=1015 suspectscore=0 phishscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=10 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220227

On 5/18/26 2:48 AM, Christoph Hellwig wrote:
> On Thu, May 14, 2026 at 05:51:14PM -0400, Tal Zussman wrote:
>> Some bio completion handlers need to run from preemptible task context,
>> but bio_endio() may be called from IRQ context (e.g., buffer_head
>> writeback). Callers need a way to ensure their callback eventually runs
>> from a sleepable context. Add infrastructure for that, in two forms:
>> 
>>   1. BIO_COMPLETE_IN_TASK, a bio flag the submitter sets when it knows
>>      in advance that its callback needs task context (e.g., dropbehind
>>      writeback). bio_endio() sees the flag and offloads completion to a
>>      worker automatically.
>> 
>>   2. bio_complete_in_task(), a helper that completion callbacks can
>>      invoke from within bi_end_io() when the deferral decision is
>>      dynamic (e.g., fserror reporting).
> 
> Note that method 2 is unused as of this series.  I do plan to add users
> ASAP, and at one or two could even land through the block layer in this
> merge window.
> 
>> Both share a per-CPU batch list drained by a delayed work item on a
>> WQ_PERCPU workqueue. Producers push the bio onto the local CPU's batch
>> and schedule the work item, which then dispatches each bio's bi_end_io()
>> from task context. The delayed work item uses a 1-jiffie delay to allow
>> batches of completions to accumulate before processing.
> 
> But this 1-jiffie delay also means we unconditionally increase
> completion latency, which feels like a bad idea.  Do you have any
> measurements that show where it does benefit?  Note that queing work
> already often has very measurable latency on it's own.  This also
> directly contradics the erofs experience that even went to a RT
> thread to reduce the latency.

I added this per Dave's feedback on v4, where he noted that XFS inodegc
uses a delayed work item to avoid context switch storms. There's only a
delay for the first bio in a batch to complete, as we only delay when the
list is empty. I'll run some experiments and measure context switches,
completion latency, etc. to see if this is necessary.

>> Both methods are gated on bio_in_atomic(), which returns true in any
>> context where a sleeping bi_end_io() is unsafe, including
>> non-preemptible task context. This logic is copied from commit
>> c99fab6e80b7 ("erofs: fix atomic context detection when
>> !CONFIG_DEBUG_LOCK_ALLOC").
> 
> Let's not copy it, but have a prep patch that moves the erofs logic
> into the block layer under the new bio_in_atomic name.

Will do.

>> +		while ((bio = bio_list_pop(&list)))
>> +			bio->bi_end_io(bio);
>> +
>> +		if (need_resched()) {
>> +			bool is_empty;
>> +
>> +			local_lock_irq(&bio_complete_batch.lock);
>> +			is_empty = bio_list_empty(&batch->list);
>> +			local_unlock_irq(&bio_complete_batch.lock);
>> +			if (!is_empty)
>> +				mod_delayed_work_on(batch->cpu,
>> +						    bio_complete_wq,
>> +						    &batch->work, 0);
>> +			break;
>> +		}
>> +	}
> 
> Ån all mainstream architetures we now default to lazy preempt, which
> should remove the need for need_resched() calls.  Do you have evidence
> that we actually need this handling on recent kernels?

No evidence - I added this per feedback on v3, but agreed that it can be
simplified.

> Otherwise this looks good to me.
> 

Thanks - AI review found a couple more small things, which I'll respond to
in a separate message.

