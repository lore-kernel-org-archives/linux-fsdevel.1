Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFC9433E80
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785510073; cv=none; b=IzJDNST9ZbfZ7gXXgV0IiKsDk9Mcp9+bbp4NFWbmVsk95CBuHDxGJtB1PCIN6PFaEEzIukamQMomItSq33Q3JMOCVqb6jtyspcABTUtb7BBARDJvX+stTwhjDE8xaG4aC/42D2vKToYKf2PGaWzUgIXVHsDgYq0OBYf7110k9NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785510073; c=relaxed/simple;
	bh=jCwR7UagNch/98g5M6Z4T9zNj9d+3bCJlJdwHm8NK5I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mGXJMEUnG9+WwUAiAqkWyT29fp/0Nt7h9DIymzMd8ML4hiO7cfQ0vNjrVOMguWDkIyEx8JJig9UGGDdeIEp6jMvZoCisH1iAdYO+qXHk6k5NS9vJWkWY84UKoOWypJ77ivWwIs6cZbNvtWw/2h4r8DBhHfuViQ9e5/3IBKxsnEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=d4tCqrO5; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="d4tCqrO5"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-455ca262ccbso769625fac.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 08:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785510070; x=1786114870; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0QWMMe323FpJCSMO/+srY4nRAHRMTDbNnpPaXX/8/JA=;
        b=d4tCqrO52DeJTRWTIViEZUdlMomE5Z3+CvCFedNxYTPGMVMBDDkesM3kDS4PldKomW
         I3zHUSctZfXAUQ5yF4GJvWFyNhdl1pdoKgSKPy4HeXXdvnC6GEE9p9mFrBtFSzbNZ0e0
         MeU/ntCOEbYzhnSrfYzGWiewfJZDfjypVHovXAnSZBZxCcWOZfytK4czPrMGpMeQVj5B
         8kRAAJHLCr30sXEQ3iRvurUK9ypImGPfGw30SCwE+ziPSE4+hyfCm0Ts8xMh10Im2EtK
         VGm+Sq2DFb7skc7myo/B4If0YBj4QGU9Kb/SbStk5sNoKf1+3rC6Tr//3lHJShhlEuHS
         TzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785510070; x=1786114870;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0QWMMe323FpJCSMO/+srY4nRAHRMTDbNnpPaXX/8/JA=;
        b=gmJ2YqNpoP8rztAT+XZRulfL1kX/dEE9aUZrJ3ssptX1Qf3vQ5RT7RQ2sTT1Dt+Y2K
         nCobJo59EpS+fZm1fyjjW85wE8oAvjYhy77Zb1hce+30GD5AuqKL17sxvGxFD8YXZ+LN
         jEYPp/ehLfcMT3iEAXj9P7irfWS1qgxaoSQfN27AgPdrEQjnKPgkIv8n5j2fBWyp9yfK
         Hi5VThFLitb1VHmPronF7BeV/C7mMOCIe8idOKMQN5RlCtEVzItuC/dHD8gkNXJYmcZr
         gvGjREwJGDQ+NSBzXtE80hjI6xZxcCWBjWiNDvRVgUGevXbhGW/ehtnu01wiPj4YdPu2
         NQlw==
X-Forwarded-Encrypted: i=1; AHgh+RoOgKPBXv6cPtWUZV+d/n3CWfUkTbDvSf0/hNYQ9NtLyalJqHJ0tSFrQee7w2/JDzVd6l/fLmy5do8IeFd2@vger.kernel.org
X-Gm-Message-State: AOJu0YzgfWyeCAro9JkGpqhwCeMhH7eS4mMlKk/3qc9/IATSwVAvDjA7
	4jOQ57tioiClTCGP/CM10cdRnim0bBdli33l5Lx5YXmYHZB77J5bQBCs8UzhBIHyYtE=
X-Gm-Gg: AR+sD11EIsrTCoAx3Tk953mVSlR0I76EekhoPcF0CJFu3Mtx2w1ZszK84Yf343kTj1o
	8jnXRfcu5jdj0mdUc+s40UU3x8dQroo/W3T7jRuyRCw3W/L80jkoxEWxJyN0YODhnVY9M5xFnjQ
	jlwYrKUVyGXpiNSt2wIu6bLi7nAaP5b6XTKoYBcoh6pTOr5GXAXM5ew0kdmTtbHC8zXTSIKKuDN
	Ha34/9ku1oBlqMH80iTVV5EwYUZRVAenxi4fE5r1Lj36/8nFl+UyVDAIsov/05yKV5s9R2xUhAk
	8cQEbvbEu1MFP+dd6i0Z9o6DMvZySMB0uY145acr4N80viK2ikNeyRbsjSsWXiattMDlBp/Lm4s
	n3JgAlbgI/f40sHDQgD5T0bM7MqHMxPoqlag1+aJXsD0IQQIdh3/FYLVPo7rJr0sJ6m9BssM32r
	VCjs/l9Dpe8rBuoB3Ih0tGfNj/d5teFUiqcyJlT6M/efzmBKgIYe8+8riDtFcFW/jNHWgSoCgDh
	Sd11HhfmBX1S5ceHcgzafzxjrtf/9TXG2L5w93UKg==
X-Received: by 2002:a05:6870:92c2:b0:455:9e4c:6bd8 with SMTP id 586e51a60fabf-4590572d113mr843225fac.2.1785510069701;
        Fri, 31 Jul 2026 08:01:09 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-458f67655fesm1139402fac.18.2026.07.31.08.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 08:01:08 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Christian Brauner <brauner@kernel.org>, 
 "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@infradead.org>, Gao Xiang <xiang@kernel.org>, 
 Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
 Jeffle Xu <jefflexu@linux.alibaba.com>, 
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, 
 Chunhai Guo <guochunhai@vivo.com>, Tal Zussman <tz2294@columbia.edu>
Cc: Dave Chinner <dgc@kernel.org>, Bart Van Assche <bvanassche@acm.org>, 
 Hillf Danton <hdanton@sina.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-erofs@lists.ozlabs.org, 
 Christoph Hellwig <hch@lst.de>
In-Reply-To: <20260730-blk-dontcache-v7-0-3e8e6850068d@columbia.edu>
References: <20260730-blk-dontcache-v7-0-3e8e6850068d@columbia.edu>
Subject: Re: [PATCH v7 0/5] block: enable RWF_DONTCACHE for block devices
Message-Id: <178551006694.14426.18417795913299417263.b4-ty@b4>
Date: Fri, 31 Jul 2026 09:01:06 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 30 Jul 2026 02:57:50 -0400, Tal Zussman wrote:
> Add support for using RWF_DONTCACHE with block devices.
> 
> Dropbehind pruning needs to be done in non-IRQ context, but block
> devices complete writeback in IRQ context. To fix this, we defer
> dropbehind invalidation to task context. Add infrastructure that lets
> bi_end_io callbacks run from a worker, in two forms:
> 
> [...]

Applied, thanks!

[1/5] block: introduce bio_in_atomic()
      commit: 8ed0831b5263e1aa48d99063795a1f20e4e69b50
[2/5] block: add task-context bio completion infrastructure
      commit: 77e73fa61b3888c9765a549af02c928372522cc9
[3/5] iomap: use BIO_COMPLETE_IN_TASK for dropbehind writeback
      commit: efbde6f9f449da3306f5b5d32f08829954ffb44d
[4/5] buffer: set BIO_COMPLETE_IN_TASK for dropbehind writeback
      commit: a2c924c240e74dc2dd14ff763245dc86b93db714
[5/5] block: enable RWF_DONTCACHE for block devices
      commit: 8b5ffb43ae9d27eed9165e1962963d685d879219

Best regards,
-- 
Jens Axboe



