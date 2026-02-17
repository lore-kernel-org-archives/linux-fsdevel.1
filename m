Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BE6284B3B;
	Tue, 17 Feb 2026 05:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771306730; cv=none; b=TLlZI9aTo1hAcxb2FlOAEHoahdqpGmUBGTHRBrIXZ3Cuko+c1ISlNwL8iICdrcZCAlNvLYrFj6HZ9Zz+xlhzJ2lVMdeecNTllL3AZefJmbuiqLrmCUtiUm2Yw9N2BaMc2NxpSaSurwPBR3BXsqdxQ1xw2XraqDXtUWnKE4Gq4e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771306730; c=relaxed/simple;
	bh=D99YK0/YHI3q9zZKMv4NHOEH2JpWbKKLB45g+f1ODEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BiqCuTnytsDL98jhm5WqMXTkZUajv+L7JW1/sPjf8nu6RnGVYPU4lseqqv8++uEujGk3ACcEHK2oCi8oxC7wF7Jg6mumpMxrF2PDZVKYTkLcDDbenkXfsoNXmqHJTAS53OeW4gFeD/nNlqLatd6C3tJIqeUjr6FH/UWWj827L94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1VJHA6r0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1VJHA6r0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=P6xMgA+2fRPjbwfQEvqYw488if8pmbv7/gTYpXeUB6s=; b=1VJHA6r0wjc6O4jtjuVtERM8yl
	BHrVH5eijzbYQrXAVNYt1Y3aiCcZ09x0Tarp3TEaYiqvE3IjVhma4S0ZV0/Q10B2f8A/1pnAuoSMJ
	sJ9uq1k3byU0MUypdiV/5DbP0Gr9V/e7LJbAoBi91uGHE6Ytfwc+jXazVXU/mUM7TX7cVAnciKY5M
	QW13e5wiRH+QIJLxG7DMxvfDajzpKqKkWfqOnBB5lda2BYkKqMk/mV4wWU/2NNimy7MBRac6fntM/
	UCv/Z4asWgr6TeFwqSUfUvge30dP553KACwhM4j6cuUXARvymtrWVHzCVZytDYpKYvL56Mw569Jif
	F/zL/aIg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsDnM-00000007eaA-0klD;
	Tue, 17 Feb 2026 05:38:48 +0000
Date: Mon, 16 Feb 2026 21:38:48 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Pavel Begunkov <asml.silence@gmail.com>, axboe@kernel.dk,
	io-uring@vger.kernel.org, csander@purestorage.com, krisman@suse.de,
	bernd@bsbernd.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1 03/11] io_uring/kbuf: add support for kernel-managed
 buffer rings
Message-ID: <aZP-6FbNU5oGjrLR@infradead.org>
References: <20260210002852.1394504-4-joannelkoong@gmail.com>
 <89c75fc1-2def-4681-a790-78b12b45478a@gmail.com>
 <CAJnrk1ZZyYmwtzcHAnv2x8rt=ZVsz7CXCVV6jtgMMDZytyxp3A@mail.gmail.com>
 <1c657f67-0862-4e13-9c71-7217aeecef61@gmail.com>
 <CAJnrk1YXmxqUnT561-J7seaicxFRJTyJ=F3_MX1rmtAROC6Ybg@mail.gmail.com>
 <aY2mdLkqPM0KfPMC@infradead.org>
 <809cd04b-007b-46c6-9418-161e757e0e80@gmail.com>
 <CAJnrk1Y6YSw6Rkdh==RfL==n4qEYrrTcdbbS32sBn12jaCoeXg@mail.gmail.com>
 <aY7ScyJOp4zqKJO7@infradead.org>
 <CAJnrk1ZnfdY9j1V8ijWx29jaLcuRH46jpNqR1x5E-Zqfz7MXVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1ZnfdY9j1V8ijWx29jaLcuRH46jpNqR1x5E-Zqfz7MXVg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Feb 13, 2026 at 11:14:03AM -0800, Joanne Koong wrote:
> I think we have the exact same use case, except your buffers need to
> be read-only. I think your use case benefits from the same memory wins
> we'll get with incremental buffer consumption, which is the primary
> reason fuse is using a bufring instead of fixed buffers.

Yeah.

> I think you can and it'll be very easy to do so. All that would be
> needed is to pass in a read-only flag from the userspace side when it
> registers the bufring, and then when userspace makes the mmap call to
> the bufring, the kernel checks if that read-only flag is set on the
> bufring and if so returns a read-only mapping. 

Yes, tat's what I though.  But Pavel seems to disagree?

