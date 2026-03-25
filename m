Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690AE36F433
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 20:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774469697; cv=none; b=dbLMu2FVLe8d3jNtT16IG60TvSWKUQF9lk+4ZOyj3CvAPVpk0bEZFPTrEg995amGe0eZnuookaMotyri/XwQ0+cRvQ7lQYp5/AlZtwt4iBChfKYty+oA3anVr2NHZo33d4Uy+ImUsECinSYL1RxoPfYjWMpRU1IlvmZZ9eQx4h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774469697; c=relaxed/simple;
	bh=TUGGsTUoaa7OmlTYcOqxOvlR6dQCgDcIlIzZN2FX1Q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l7Fniu1LJ61MKe6SkOrTLjaFTsgd69zDS1b9ygj994sV5MUEFlxa6ss/7OGI6d+2lVSkY1MQ2sAx4lyA2A0MVlRFApIBYXftvfpVdZ06TWqhKsZk3VnxIOwzd78nHPgA4eRAgquqXgWiahqaaenpmmZcI2vCK4xQRktMteMGzMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BdLSkuLb; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BdLSkuLb"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-40429b1d8baso117941fac.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 13:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774469693; x=1775074493; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6PlzBqe1IIMZnSLJe3Nt9W0mLjdauDVoWC1E+bHzQXs=;
        b=BdLSkuLbkvjvqo4SHXcM9hOSCpAQMP1s6LNcsPqujNgtRq77JmMpYUWmgXnm7UQim7
         OD40cvf+fJrO0J9FQyo+MUyncnrhVCXddAkvF7AceTQz8cqeghEu+HxonccduuJ4LRrV
         H9brCnPfzhJ8nRZ+OeOvsLegk8k3JwsaxW3WyJLhR0/mK2xIIqOvX7ZGUu227FxQkwRL
         lxc37GLfYG7StePtmm9rTSGHVlUEcX9WhaTCEmeLzS5hP0camnKeO+SmORIXb7s4WNBJ
         J7YR291hbfHCT1s2zoPH2lztTIGzFmt6noVFf7LZMzjfOdV3KwuepTrRKoUo7oLYZUz8
         JhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774469693; x=1775074493;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6PlzBqe1IIMZnSLJe3Nt9W0mLjdauDVoWC1E+bHzQXs=;
        b=b/Ufm5PokeUH4haMTrCkVB9pgfiQGM9aoxMUW+JSWL0v8QlnSGz2LMcVizGLSP9cQL
         JgTJ4+Fpxlz2hqSFlimiIiJSaPeSB028NfJ560P4l/anN360dvFTeBNlM1uogWRknplO
         ODJnMKWYH8x912puf4cpO3fp0oWqonog0YIFkqPkH17qMUoiiNvO4KRAGRkXb6tib4lT
         nUIjGlQT5fKwXjffw3WfOAWztJuEyXwfldIMko5+5cXebGGbxDqDZP5oYiOOUCIZ+zAO
         fRBlzoQxf/VY7E4WgglPysza7PMvgFdHNMizXDIluyco6B+T0z9f8Zcirypj4WVwYB5K
         w0WA==
X-Forwarded-Encrypted: i=1; AJvYcCVJhBOphHX1UByEQwD7tk8XxsLYB0XonP4hyGdTsGgqfh1WzkxOlJMX8OiFIWE2VWuRwozDQ+yb2i8X8/Kr@vger.kernel.org
X-Gm-Message-State: AOJu0YwOYxhLGpRD9eAdFV9xYNgvut8KeFJOSZLvROCOvklhb+zRb4em
	6usSJ3uYff3T3e+w0+g1awZiGWaheVq3Psnb43jAC+FzeItd3R5Kz1tNEmJ+XZTwqDY=
X-Gm-Gg: ATEYQzxPtznSwPC0tEuONDzY9WIUuJjzOcA1aJmikcrcyRG0u+pcFnuSEIwK8gg5umV
	Mfc/ZlIrR8T9c9Thr35ubrqqZ6s+7WXlxzbw1BGCC7UZPsekdur5duQsXhgxSlmArUEGFlGv/rz
	u3gabKtwzMW5tu1T2ZJwhcqWuMylxZ695AG0diszDoSN1dFKLGs6DgoDpsd25t91vqccc62tTio
	UoQGch5Vuwvdhshm8VHElUGWi0YSN5AA5qs+J7bbRjQD0YJmSOo9DHyOa8xpCsoh7/ITE7rpa+H
	2Hr3XVwhemtL1USJBf4v/lZhVWzMtF7HNvJJl0hatrxzA0NjvloUOl3lbKeSA6kNJHvr/ScKyzK
	uAq70no+YJivhiH8nb8o8xRFc+C7J//wFzoNo+jdluf/Cn569Vt15b61C64qLFJ4KvONcAiBHxr
	peKGpwePx3V5sfjLKEZJV8CI4AbqD9ZNkCOLv3I5xFZ+Micr+aipptFykNUP4wWSCA6NSUJqI1B
	v/GiTGa
X-Received: by 2002:a4a:edcd:0:b0:67b:be84:e085 with SMTP id 006d021491bc7-67dff50ad22mr2303872eaf.27.1774469693263;
        Wed, 25 Mar 2026 13:14:53 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67e0ab1b9e3sm535628eaf.12.2026.03.25.13.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 13:14:52 -0700 (PDT)
Message-ID: <c4453f4e-c1a2-4f5a-b278-76b63d5dc4a3@kernel.dk>
Date: Wed, 25 Mar 2026 14:14:51 -0600
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
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260325-blk-dontcache-v4-1-c4b56db43f64@columbia.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/25/26 12:43 PM, Tal Zussman wrote:
> diff --git a/block/bio.c b/block/bio.c
> index 8203bb7455a9..69ee0d93041f 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -18,6 +18,7 @@
>  #include <linux/highmem.h>
>  #include <linux/blk-crypto.h>
>  #include <linux/xarray.h>
> +#include <linux/local_lock.h>
>  
>  #include <trace/events/block.h>
>  #include "blk.h"
> @@ -1714,6 +1715,60 @@ void bio_check_pages_dirty(struct bio *bio)
>  }
>  EXPORT_SYMBOL_GPL(bio_check_pages_dirty);
>  
> +struct bio_complete_batch {
> +	local_lock_t lock;
> +	struct bio_list list;
> +	struct work_struct work;
> +};
> +
> +static DEFINE_PER_CPU(struct bio_complete_batch, bio_complete_batch) = {
> +	.lock = INIT_LOCAL_LOCK(lock),
> +};
> +
> +static void bio_complete_work_fn(struct work_struct *w)
> +{
> +	struct bio_complete_batch *batch;
> +	struct bio_list list;
> +
> +again:
> +	local_lock_irq(&bio_complete_batch.lock);
> +	batch = this_cpu_ptr(&bio_complete_batch);
> +	list = batch->list;
> +	bio_list_init(&batch->list);
> +	local_unlock_irq(&bio_complete_batch.lock);
> +
> +	while (!bio_list_empty(&list)) {
> +		struct bio *bio = bio_list_pop(&list);
> +		bio->bi_end_io(bio);
> +	}
> +
> +	local_lock_irq(&bio_complete_batch.lock);
> +	batch = this_cpu_ptr(&bio_complete_batch);
> +	if (!bio_list_empty(&batch->list)) {
> +		local_unlock_irq(&bio_complete_batch.lock);
> +
> +		if (!need_resched())
> +			goto again;
> +
> +		schedule_work_on(smp_processor_id(), &batch->work);
> +		return;
> +	}
> +	local_unlock_irq(&bio_complete_batch.lock);
> +}

bool looped = false;

do {
	if (looped && need_resched()) {
    		schedule_work_on(smp_processor_id(), &batch->work);
		break;
	}

	local_lock_irq(&bio_complete_batch.lock);
	batch = this_cpu_ptr(&bio_complete_batch);
	list = batch->list;
	bio_list_init(&batch->list);
	local_unlock_irq(&bio_complete_batch.lock);

	if (bio_list_empty(&list))
		break;

	do {
		struct bio *bio = bio_list_pop(&list);
		bio->bi_end_io(bio);
	} while (!bio_list_empty(&list));
	looped = true;
} while (1);

would be a lot easier to read, and avoid needing the list manipulation
included twice.

> +static void bio_queue_completion(struct bio *bio)
> +{
> +	struct bio_complete_batch *batch;
> +	unsigned long flags;
> +
> +	local_lock_irqsave(&bio_complete_batch.lock, flags);
> +	batch = this_cpu_ptr(&bio_complete_batch);
> +	bio_list_add(&batch->list, bio);
> +	local_unlock_irqrestore(&bio_complete_batch.lock, flags);
> +
> +	schedule_work_on(smp_processor_id(), &batch->work);
> +}

Maybe do something ala:

static void bio_queue_completion(struct bio *bio)
{
	struct bio_complete_batch *batch;
	unsigned long flags;
	bool was_empty;

	local_lock_irqsave(&bio_complete_batch.lock, flags);
	batch = this_cpu_ptr(&bio_complete_batch);
	was_empty = bio_list_empty(&batch->list);
	bio_list_add(&batch->list, bio);
	local_unlock_irqrestore(&bio_complete_batch.lock, flags);

	if (was_empty)
		schedule_work_on(smp_processor_id(), &batch->work);
}

Outside of these mostly nits, I like this approach. It avoids my main
worry with this, which was contention on the list locks. And on the
io_uring side, we'll never hit the !in_task() path anyway, as the
completions are run from the task always. The bio flag makes sense for
this.

-- 
Jens Axboe
