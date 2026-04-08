Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04A9370D47
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Apr 2026 19:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775677912; cv=none; b=bWiFTZG15nEYFGVZtYtNnkDBknwWOhhBHRlV/9Vurs6lhx9+F/yg0VDXh/U8REyVLFBuNa3C66r/A/dZ2P/eUCDQ1k66FiD+xHJXNKjcbh1Mgxpy4fOPeaPLEigWz+oytq1CrXP01KZVeyqbJvaEiBLP9toQO5SJAqR4Fcp7NH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775677912; c=relaxed/simple;
	bh=VozKVFSNS/gs8NcxxeuKasgV5xRpmuKE3f5a5NANObc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pN1+/6/ob21c1NPgKrnbknIFWZQ5PZUSr+28vpfgyPFsG6sq5PZRmSv/n0t5q2nT0RAXgA/LTTXouxdvemut/FmmFUkGSW+eNhDrJx+skK3RkgzA0/DizgvmMQZuUgmzkI4yfkTr76Cyu8utlHmUtP12zrC8aYkVF/jvnapR1Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=Q+yEQpBZ; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="Q+yEQpBZ"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d9b21d1461so124977a34.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Apr 2026 12:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1775677910; x=1776282710; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UXmjLbQMnBqeQgGLuSxxqcM7IYKVin1hxCkiOdMcuyM=;
        b=Q+yEQpBZ/+AVOkNJvgio7qjowFdyPiWV4hMS5fyGz4B58/DfEvZLTw5yP5uP0L2tS6
         8tKm1C8nOqwTgYCvUOYLXCPoPtUtYOeApb4+uA80YecH4z2Pm/rHYpm9bTbvzwCHXXHp
         YxA0kA4MNr/rA6UrWeAVKo1ONz2sxZDDDT58MTzao8Mk4q1zFx9z6UtHGoF1+Yu4oUq/
         90mJxQbctxtZv8W5hSI9kPSGJg/Sde3fZTWw7XZdTNh3bjFzrV0sYur0uhUVy7T8z46G
         pODNiJ4wXd8W3SZxqm8MnEAIBaqOwNobxhAGg30VWbEDMZlACaJAOfoTzMYg/R9l9UHS
         LCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775677910; x=1776282710;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UXmjLbQMnBqeQgGLuSxxqcM7IYKVin1hxCkiOdMcuyM=;
        b=TC5fwRTKjfjtpg+9aKmA2t6VMVi4dPVxP97U5cCS+QcqKkGZ125rv3lOgX2Q5SInoO
         RpbEmwQt16H7wh0hasjT909rSbmcXNJ4gHBiEKlhVXb4gXZvmjZRcj7zif+clvdU5l75
         hD3uiMj2gAc4dCR0Gaq52bgu6Awzcm6u1HCeoasoTP37jowszAotScdcajnxAUypcUcJ
         J6JPYohHT0m7WdrMUTGrQIiQWvRUUGgynWoIf/aKUk7YOdL8J6JnduOxRBdtggmyEZbA
         T5XiJ5nsDuYrH4NDTiOcySNR6N6iDZW+ldn2sZDz+ZBG2ckQKfSZ6tJLdVNKiAbqrNAO
         e71w==
X-Forwarded-Encrypted: i=1; AJvYcCV59ZF8Xkj7ODtRcYMELjoh40N3Ja2t52dP+KUcz/b3M7tjDHiThzeaZ6T7o+9UNZVX3lQUDv5HFsu41ePI@vger.kernel.org
X-Gm-Message-State: AOJu0YwXxno7jHfboH3L1N0t2qth2x4PUWN5L/X7IZSWALnfCKg+gvD2
	N+LRK9GbqbBkDKPK2ZFODF0Cmjz/q0aFj3raSvC26LS4Tm425VItdwIYy3XtZRwo07Q=
X-Gm-Gg: AeBDiesbsx+KtQ2GnHG2jf5E4aHMCLSs2lGxa6sHvlsqJnWKrJPzJBfC3nHTj/pKWB+
	gASLwn8S+UOb7jRbRuHA0nTzdCsf1cHQ0/clgYES/M12ziSBkZVVJrQHzlwf22PEpVtHjX2RURr
	wblp+ro8CB06yqljFUDMbVJx53czdKwCV48c784YRM+rvj4ZyHxHlTr1DztBoJLuGCq58lmXQwy
	2NSpZiK1Hlk5WKAk+h9uevgydaFYog+R46ab4skYXyPTUyI4Ns2fIXiIOZS4ISf6b6GnE67rWef
	tHSyfkxmEtGbzQOjRSfQrO/OZ1NhDiGw9RQgd9NYsPryDfhxb6jKNTan4hkH4pfwm13Mo48V5Pb
	o8R+KbeHHugUcqGm02bCjsUcAA7dM1dbp4k+tj4sG/qVfDly3d0e7pCYkz09GSOvppLjiEL2X/h
	DpE0Rr8HuNVJ09nXHJckTRnvftCHEnFiIsK+mroXTKA9yA72G/dNJK/fYOdoMxpcTtWnvIn6bdB
	nJtb776
X-Received: by 2002:a05:6830:4c97:b0:7db:bdd6:635a with SMTP id 46e09a7af769-7dc17728eeamr330070a34.9.1775677909639;
        Wed, 08 Apr 2026 12:51:49 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dbfc1cb79esm3395778a34.15.2026.04.08.12.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 12:51:49 -0700 (PDT)
Message-ID: <699933c1-c150-4e10-a5fc-6f128260d0c1@kernel.dk>
Date: Wed, 8 Apr 2026 13:51:48 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 1/3] block: add BIO_COMPLETE_IN_TASK for
 task-context completion
To: Tal Zussman <tz2294@columbia.edu>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20260325-blk-dontcache-v4-0-c4b56db43f64@columbia.edu>
 <20260325-blk-dontcache-v4-1-c4b56db43f64@columbia.edu>
 <c4453f4e-c1a2-4f5a-b278-76b63d5dc4a3@kernel.dk>
 <01e6c582-fbab-40ec-97ac-02675e6a08ed@columbia.edu>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <01e6c582-fbab-40ec-97ac-02675e6a08ed@columbia.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/8/26 12:48 PM, Tal Zussman wrote:
> On 3/25/26 4:14 PM, Jens Axboe wrote:
>> On 3/25/26 12:43 PM, Tal Zussman wrote:
>>> +static void bio_complete_work_fn(struct work_struct *w)
>>> +{
>>> +	struct bio_complete_batch *batch;
>>> +	struct bio_list list;
>>> +
>>> +again:
>>> +	local_lock_irq(&bio_complete_batch.lock);
>>> +	batch = this_cpu_ptr(&bio_complete_batch);
>>> +	list = batch->list;
>>> +	bio_list_init(&batch->list);
>>> +	local_unlock_irq(&bio_complete_batch.lock);
>>> +
>>> +	while (!bio_list_empty(&list)) {
>>> +		struct bio *bio = bio_list_pop(&list);
>>> +		bio->bi_end_io(bio);
>>> +	}
>>> +
>>> +	local_lock_irq(&bio_complete_batch.lock);
>>> +	batch = this_cpu_ptr(&bio_complete_batch);
>>> +	if (!bio_list_empty(&batch->list)) {
>>> +		local_unlock_irq(&bio_complete_batch.lock);
>>> +
>>> +		if (!need_resched())
>>> +			goto again;
>>> +
>>> +		schedule_work_on(smp_processor_id(), &batch->work);
>>> +		return;
>>> +	}
>>> +	local_unlock_irq(&bio_complete_batch.lock);
>>> +}
>>
>> bool looped = false;
>>
>> do {
>> 	if (looped && need_resched()) {
>>      		schedule_work_on(smp_processor_id(), &batch->work);
>> 		break;
>> 	}
>>
>> 	local_lock_irq(&bio_complete_batch.lock);
>> 	batch = this_cpu_ptr(&bio_complete_batch);
>> 	list = batch->list;
>> 	bio_list_init(&batch->list);
>> 	local_unlock_irq(&bio_complete_batch.lock);
>>
>> 	if (bio_list_empty(&list))
>> 		break;
>>
>> 	do {
>> 		struct bio *bio = bio_list_pop(&list);
>> 		bio->bi_end_io(bio);
>> 	} while (!bio_list_empty(&list));
>> 	looped = true;
>> } while (1);
>>
>> would be a lot easier to read, and avoid needing the list manipulation
>> included twice.
> 
> Yep, that looks cleaner. Although do we really need the looped variable?
> Can't we just move the need_resched() check right before the while (1)?

If you do that, then you'd also want to check if the list is empty. You
don't want to schedule_work() for a potentially empty list. Either way,
you need some check.

>>> +static void bio_queue_completion(struct bio *bio)
>>> +{
>>> +	struct bio_complete_batch *batch;
>>> +	unsigned long flags;
>>> +
>>> +	local_lock_irqsave(&bio_complete_batch.lock, flags);
>>> +	batch = this_cpu_ptr(&bio_complete_batch);
>>> +	bio_list_add(&batch->list, bio);
>>> +	local_unlock_irqrestore(&bio_complete_batch.lock, flags);
>>> +
>>> +	schedule_work_on(smp_processor_id(), &batch->work);
>>> +}
>>
>> Maybe do something ala:
>>
>> static void bio_queue_completion(struct bio *bio)
>> {
>> 	struct bio_complete_batch *batch;
>> 	unsigned long flags;
>> 	bool was_empty;
>>
>> 	local_lock_irqsave(&bio_complete_batch.lock, flags);
>> 	batch = this_cpu_ptr(&bio_complete_batch);
>> 	was_empty = bio_list_empty(&batch->list);
>> 	bio_list_add(&batch->list, bio);
>> 	local_unlock_irqrestore(&bio_complete_batch.lock, flags);
>>
>> 	if (was_empty)
>> 		schedule_work_on(smp_processor_id(), &batch->work);
>> }
> 
> Makes sense, will do!
> 
>> Outside of these mostly nits, I like this approach. It avoids my main
>> worry with this, which was contention on the list locks. And on the
>> io_uring side, we'll never hit the !in_task() path anyway, as the
>> completions are run from the task always. The bio flag makes sense for
>> this.
> 
> Thanks! I'm going to give Dave's llist suggestion a shot on top of
> this as it seems like it'll simplify this nicely. Looks like that'll
> involve turning bio::bi_next into a union with a struct llist_node.

Since these lists can get long, I'd keep an eye on llist reversal
overhead there...

-- 
Jens Axboe
