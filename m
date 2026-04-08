Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F44B337B81
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Apr 2026 18:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674247; cv=none; b=hklczu5x8qh5Ua2ycvB328e+Zczuve7pD87o92ipJiOyJ5kUu35C0Nb0l0RyRuABxtVkGc6j7XjKIvMox4QcqmliCkDMqGEtBBt00BUyJTxgvsmZuXAueBv20vhu7UmZxgh7YCX13wecNK1q9HAMaOmgTCKimoRlEWYTx/wmuS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674247; c=relaxed/simple;
	bh=6r64QEmD8ewTp+MQthynMekweXjdEhiTg6eQUVwrNdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Srs9uvk1F/+KNzWlgr4mN8Nrr6MStLICCbZaDx+8sk0LLsE8zx/bMGtRhSBdd2VhdbFX/jYwDb0fspBZOEytzclxpTOrQJyGAE0U+rvuwDGRoA8tHSZR0JexDEDDUF5C7R31Oi2MfXH2xMuUGEv4dj8aVZKHUl/uhEGTfRB4bZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=im1YecM4; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="im1YecM4"
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638IjUDv4070658
	for <linux-fsdevel@vger.kernel.org>; Wed, 8 Apr 2026 14:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=WLV/
	VVxZXil8J0HLTMUXd1+6JdBH4scZJMZYCy57u0g=; b=im1YecM4tYnwU3cp+l94
	/ilwcemuWi7FpGFRSqYCYA5GZceUKxrLU+c6Fh/L0pc8XlgZuE3LGJDOFTnD9pAz
	xMSVh4/kELzqe4bPmmNRsuuUi4Gmr/sMkpC/BrYfhSYctkb2Mz7+90S8zbrcWXAv
	TIVdwxVWLJ1RjOkjt2+0OLUXZbdzQH65IN6CvXs5loGdKb4hAz29CuJTynbwvDuW
	3TFC24cOvqGRrXKQByQC31IYVJEY47leYIvp5Og4R2DDlO0Yc9wYNYd5XcH60Aow
	xXF95Yfny01hF/UNFGlNYqreBmYhq0E3Vo8Eaimg6aYCLiww08Vd33VvMOAERzIA
	zQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4dda3mprs4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 08 Apr 2026 14:50:45 -0400 (EDT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-89ebd9e1ee4so4639776d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Apr 2026 11:50:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775674244; x=1776279044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WLV/VVxZXil8J0HLTMUXd1+6JdBH4scZJMZYCy57u0g=;
        b=YqyPk0uxlOcWoDLljraQQz0IjVTCjV53XPAk7pJqoX7py/G0TwEsf/SbZFanH3eVa+
         j1rpqWw2AMTt4M9UidzyajgoTcfnoXtYZSQ1bueMBD8CkG/l4/05BCaSwH6GeygsXpFU
         1aNwFis77tExetR7D1JMvoUXYnvohQ5mCbI+mAbl28VFBwIteLB3Nq5VqpXf6M36KjgZ
         wuB49j1eyYI79WKfrYABjWFhkojCfWvAnAQOZUuNocBA6t6vkinVxLPwXqXssI++QPgR
         bWRlB2fUaQQN+dPlZZJX7FMqin8/w3eKnU/9E5VOS1hCzLChk9FKvbeTEGXqGHr2fMJn
         JepQ==
X-Forwarded-Encrypted: i=1; AJvYcCWu/6N+BDDr5c/qVQauzbJQeyqNc3mJzy5Zrh2+KG0nBdrqDecyyJyxOdKfiYqRZbhY+0TmWNoZ5KpeCHDv@vger.kernel.org
X-Gm-Message-State: AOJu0YwptIGajJh6XFjRvYgOwHDWvlEtxsFuG2ebCJ+sJN7FzWUddkxw
	tUda1dKgUitf9VcANZGr/TQHDqofVlqxHURxK8wx7uhXvELl8u9vE5kGVEDp+Kbl4/B4tEhbB0U
	pxpxldJyCApjWSrS9o1RPxVMPICF4iY6AxEPEEIlFaaFjRZY7YFn1lx6fB/sYPYY=
X-Gm-Gg: AeBDiet07favUDGoWF3XcUtv+Qwi8nD7yyHVJt3K0XR+7cmLy+L+S9T18BNFU3VtieS
	je6eh31JjSDy/pnOD6/M6GBImcCgTB5urNpMSVPA/3qoM+RwLHsiMUVxI6CMXR3SnwGm8UkXRSy
	KP6ZsJzkoww735hjZg9/O7VoZ85QHkjnPmZzYuwOWGsg0jZ/Cn60UtVZETRiVB+7FgXlDPLKDXq
	zY4c4xADTEmGFn3WQzT4MRl6kI+YlPMpCKhSW3ek3rS2rblCoHhuhbaZrxr/vrWc0DMfGg14y39
	NeW/7Yus6HZtlc95MovcYWVt9vYrWIdLxnvBhxCwOtLQW6gOoHoELxH6Ge94X98Z9gj3cwiyNbO
	cx3eplzJ8qyiJXTkODaanRYblHbmzy8y3IZVq1/06
X-Received: by 2002:a0c:f204:0:b0:8a0:e086:64d1 with SMTP id 6a1803df08f44-8ac7447cea9mr11723126d6.53.1775674244589;
        Wed, 08 Apr 2026 11:50:44 -0700 (PDT)
X-Received: by 2002:a0c:f204:0:b0:8a0:e086:64d1 with SMTP id 6a1803df08f44-8ac7447cea9mr11722756d6.53.1775674244086;
        Wed, 08 Apr 2026 11:50:44 -0700 (PDT)
Received: from [192.168.129.206] ([216.158.158.246])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8aa70136e87sm90361846d6.22.2026.04.08.11.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 11:50:43 -0700 (PDT)
Message-ID: <9fa7a89e-2461-4c58-a2df-d61af60b1b42@columbia.edu>
Date: Wed, 8 Apr 2026 14:50:43 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 1/3] block: add BIO_COMPLETE_IN_TASK for
 task-context completion
To: Dave Chinner <dgc@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong"
 <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20260325-blk-dontcache-v4-0-c4b56db43f64@columbia.edu>
 <20260325-blk-dontcache-v4-1-c4b56db43f64@columbia.edu>
 <acRE8pp6HxjK7Z74@dread>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <acRE8pp6HxjK7Z74@dread>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE3NSBTYWx0ZWRfX81nb989TRQmO
 7uXbDkhiCNAkzs8oO/tOHcwJuUY8q6fcHyLJHXw0Gzd0EH6VHHuAKyaENTg5GuoxbPaMcP0ul7F
 AxASOwqmyeq1/9+t+wRAPVnzm8uHNdVIUuk0Hh/jbx15KAdG87/QIIJxeiCUiLjKgcVCSO0F8TH
 Dmk+Cd7W19XGvzuDTvWKk2uVQc+aIXebW7SE8IfVmH1+yJriWjtHvE9RJeU9cwg/GztuhvE6a4h
 fRL4H8kGuEXap+a+FLPjAMVoSJRjQIQvCc9Op7VyP1P7pV+4VGiQ+bRz9JBhyn0ftimmlhCM0vm
 adPKcxBXshzSgghmCH2p6zGoH2AY25ToE2WJHe9k94Dvsh8+KPg7+p/VqtIs+tLTnIoQjKAQ4GP
 lHQ3jQlZGuyV7LNfqXjbN2H0pOA0eR9+LKptczA8Hc9apskeR/Qe0pXMvjoaBZFJtaK9O0cBRXe
 khWoAOjzegGAgwbx6XA==
X-Authority-Analysis: v=2.4 cv=U8iiy+ru c=1 sm=1 tr=0 ts=69d6a385 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=mD05b5UW6KhLIDvowZ5dSQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=JfrnYn6hAAAA:8 a=PFLxJxkoOJ40U2LAvKUA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: gEluqcVubJuxGacN4X7jdyH87zUbbJqA
X-Proofpoint-ORIG-GUID: gEluqcVubJuxGacN4X7jdyH87zUbbJqA
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11753
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=10 bulkscore=10 spamscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=10 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080175



On 3/25/26 4:26 PM, Dave Chinner wrote:
> On Wed, Mar 25, 2026 at 02:43:00PM -0400, Tal Zussman wrote:
>> Some bio completion handlers need to run in task context but bio_endio()
>> can be called from IRQ context (e.g. buffer_head writeback). Add a
>> BIO_COMPLETE_IN_TASK flag that bio submitters can set to request
>> task-context completion of their bi_end_io callback.
>> 
>> When bio_endio() sees this flag and is running in non-task context, it
>> queues the bio to a per-cpu list and schedules a work item to call
>> bi_end_io() from task context. A CPU hotplug dead callback drains any
>> remaining bios from the departing CPU's batch.
>> 
>> This will be used to enable RWF_DONTCACHE for block devices, and could
>> be used for other subsystems like fscrypt that need task-context bio
>> completion.
>> 
>> Suggested-by: Matthew Wilcox <willy@infradead.org>
>> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
>> ---
>>  block/bio.c               | 84 ++++++++++++++++++++++++++++++++++++++++++++++-
>>  include/linux/blk_types.h |  1 +
>>  2 files changed, 84 insertions(+), 1 deletion(-)
>> 
>> diff --git a/block/bio.c b/block/bio.c
>> index 8203bb7455a9..69ee0d93041f 100644
>> --- a/block/bio.c
>> +++ b/block/bio.c
>> @@ -18,6 +18,7 @@
>>  #include <linux/highmem.h>
>>  #include <linux/blk-crypto.h>
>>  #include <linux/xarray.h>
>> +#include <linux/local_lock.h>
>>  
>>  #include <trace/events/block.h>
>>  #include "blk.h"
>> @@ -1714,6 +1715,60 @@ void bio_check_pages_dirty(struct bio *bio)
>>  }
>>  EXPORT_SYMBOL_GPL(bio_check_pages_dirty);
>>  
>> +struct bio_complete_batch {
>> +	local_lock_t lock;
>> +	struct bio_list list;
>> +	struct work_struct work;
>> +};
>> +
>> +static DEFINE_PER_CPU(struct bio_complete_batch, bio_complete_batch) = {
>> +	.lock = INIT_LOCAL_LOCK(lock),
>> +};
>> +
>> +static void bio_complete_work_fn(struct work_struct *w)
>> +{
>> +	struct bio_complete_batch *batch;
>> +	struct bio_list list;
>> +
>> +again:
>> +	local_lock_irq(&bio_complete_batch.lock);
>> +	batch = this_cpu_ptr(&bio_complete_batch);
>> +	list = batch->list;
>> +	bio_list_init(&batch->list);
>> +	local_unlock_irq(&bio_complete_batch.lock);
> 
> This is just a FIFO processing queue, and it is so wanting to be a
> struct llist for lockless queuing and dequeueing.
> 
> We do this lockless per-cpu queue + per-cpu workqueue in XFS for
> background inode GC processing. See struct xfs_inodegc and all the
> xfs_inodegc_*() functions - it may be useful to have a generic
> lockless per-cpu queue processing so we don't keep open coding this
> repeating pattern everywhere.
> 
>> +
>> +	while (!bio_list_empty(&list)) {
>> +		struct bio *bio = bio_list_pop(&list);
>> +		bio->bi_end_io(bio);
>> +	}
>> +
>> +	local_lock_irq(&bio_complete_batch.lock);
>> +	batch = this_cpu_ptr(&bio_complete_batch);
>> +	if (!bio_list_empty(&batch->list)) {
>> +		local_unlock_irq(&bio_complete_batch.lock);
>> +
>> +		if (!need_resched())
>> +			goto again;
>> +
>> +		schedule_work_on(smp_processor_id(), &batch->work);
> 
> We've learnt that immediately scheduling per-cpu batch
> processing work can cause context switch storms as the queue/dequeue
> steps one work item at a time.
> 
> Hence we use a delayed work with a scheduling delay of a singel
> jiffie to allow batches of queue work from a single context to
> complete before (potentially) being pre-empted by the per-cpu
> kworker task that will process the queue...
> 
>> +		return;
>> +	}
>> +	local_unlock_irq(&bio_complete_batch.lock);
>> +}
>> +
>> +static void bio_queue_completion(struct bio *bio)
>> +{
>> +	struct bio_complete_batch *batch;
>> +	unsigned long flags;
>> +
>> +	local_lock_irqsave(&bio_complete_batch.lock, flags);
>> +	batch = this_cpu_ptr(&bio_complete_batch);
>> +	bio_list_add(&batch->list, bio);
>> +	local_unlock_irqrestore(&bio_complete_batch.lock, flags);
>> +
>> +	schedule_work_on(smp_processor_id(), &batch->work);
>> +}
> 
> Yeah, we definitely want to queue all the pending bio completions
> the interrupt is delivering before we run the batch processing...
> 
>> +
>>  static inline bool bio_remaining_done(struct bio *bio)
>>  {
>>  	/*
>> @@ -1788,7 +1843,9 @@ void bio_endio(struct bio *bio)
>>  	}
>>  #endif
>>  
>> -	if (bio->bi_end_io)
>> +	if (!in_task() && bio_flagged(bio, BIO_COMPLETE_IN_TASK))
>> +		bio_queue_completion(bio);
>> +	else if (bio->bi_end_io)
>>  		bio->bi_end_io(bio);
>>  }
>>  EXPORT_SYMBOL(bio_endio);
>> @@ -1974,6 +2031,21 @@ int bioset_init(struct bio_set *bs,
>>  }
>>  EXPORT_SYMBOL(bioset_init);
>>  
>> +/*
>> + * Drain a dead CPU's deferred bio completions. The CPU is dead so no locking
>> + * is needed -- no new bios will be queued to it.
>> + */
>> +static int bio_complete_batch_cpu_dead(unsigned int cpu)
>> +{
>> +	struct bio_complete_batch *batch = per_cpu_ptr(&bio_complete_batch, cpu);
>> +	struct bio *bio;
>> +
>> +	while ((bio = bio_list_pop(&batch->list)))
>> +		bio->bi_end_io(bio);
>> +
>> +	return 0;
>> +}
> 
> If you use a llist for the queue, this code is no different to the
> normal processing work.
> 

Thanks Dave, these suggestions + the pointer to the XFS GC code were helpful.
I'll incorporate them into the next version.

- Tal

