Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A883242AB
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 15:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782400675; cv=none; b=FrR9hSVCr1TikyDbUSxTQFlwwyAxbVDR4qMIodLDSoxIJnJTAxX31Eq6u35tPs8Y+HDVqXxsr1S+p1tsFUqGWdEuqRxsEc5ODU2N8WJagrac6NTg8yhSFMdGO7PiQYMBCgslaTCK/N+dQ0i2HRneTJZbnGW9CPXYSjBlpRksUmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782400675; c=relaxed/simple;
	bh=oiph0kGwGVoZPEVNJN2n7BGfCaRNK/6I8vgxwW/ZlGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fk8WZRCChvk+wE/+cbGud6rW3ovM+KOoZFLM792OklCHpRLusOVuC9vaslwzkbvoM1SKTzmjrfG8l8Icl75Uyb9li7mQ6dIEsnTc5QP00jpaWNd2rQyczuFMuG33I4k2gwBBTWw04mvPbbfRMwcYcpqOoCsUiEsdh2B0FU8snmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EYBM9tu3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EYBM9tu3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ho2osq0XeRu7S5voc4mfyO5ITrtAk2DlnfwLQFYApok=; b=EYBM9tu37PTqUUd9H8IHDUvrx8
	PmU+AM5y1CZBwEsTdHlnZoVjJ+HGCeqexTNPWYy+RXdzCvNJqzX/dqaV+9HkbzOCOmLpwA9H2Q+Ws
	stTpKBoCBgm0XS9YDt2UsTXfH0UkM+nWo1bC7kw8jCEpTS1ogKS/udgq0wDgwBJiGZHB5Hr2p2sRv
	AIiK22G7zkdK/yoT+T5Y9Xq2eO4VBNrw9CzHdebe3wmOTEQcwXcXimZknk36ideJRrs4a5rOZgCwb
	ejbIZm/rybKip5TtQ27O9m1CASXOkOe79fUxwEFcxk805v9IJYSfifU6v/omPQOeAYCkSwyV3lscg
	6w/4ZOJg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wclpt-0000000A7Ov-0Iwd;
	Thu, 25 Jun 2026 15:17:49 +0000
Date: Thu, 25 Jun 2026 16:17:48 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Barry Song <21cnbao@gmail.com>
Cc: josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH] filemap: Remove file pinning during fault handling
Message-ID: <aj1GnMERF_j54sFA@casper.infradead.org>
References: <20260622192114.1147198-1-willy@infradead.org>
 <20260624065818.49975-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624065818.49975-1-21cnbao@gmail.com>

On Wed, Jun 24, 2026 at 02:58:18PM +0800, Barry Song wrote:
> > Now that faults are protected by a per-VMA lock instead of a process-wide
> > mmap lock, it is far less important to avoid holding the fault lock while
> 
> We could have fallen back to the mmap_lock from the very beginning in
> do_page_fault(). And for GUP fault-in, we have always used the
> mmap_lock so far.

Your own data showed that this wasn't the point of contention on the
mmap_sem, that it was the fallbacks that was causing the mmap_lock to be
contended.

> > This should result in improved lock contention, although it is possible
> > that some workloads will find themselves contending on the VMA locks
> > due to them being held for longer.
> 
> Hongru reported that 82 of the top 200 Android applications in the
> China market call fork() in heavily multi-threaded processes[1]. It
> would be good to take existing applications into account, please.

No.  Collect numbers that show it's a problem.  I'm not interested in
theoretical problems.
