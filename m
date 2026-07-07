Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3955420862
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 10:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419508; cv=none; b=r7HndN1Ekd5GbED4pHnihcEFxKQdw6i7rMR//TOBPv8nQigCQ7iqhY9T+IXzI43ehFsRu08DhYw3RLCCeqJb2mFRR3V9t3Wqc91ppJKXhju9duImytXRXk0U9atsWSw5weCWkl7DkU4hyDk5lW2PqU2hWpugnIUdSSXZaqo61Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419508; c=relaxed/simple;
	bh=98VhNMModFCcxiqm7ARQ8dKwSt5GANhTPKLjWFAsCsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4BQPPwgdcO8ch650nTHNB9MaX1KqHs7E4kdVFN5YAdTehyeL6Kr/EOPcDNG1VwemsXKcZOt/XEYutLlE83NLZ8hDBlorIpRMd0YL99mna77OpZUaRExwK6PMGTYeLPUVfe6hSBK8YavzQv2PhHy80vh3PeI2srQ+jjrP7xxV0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ifONFYuO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HpNFvvQR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ifONFYuO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HpNFvvQR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783419506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3slwj2XyzWQtqngmhVqaSA6RBHzpXga6waGc30WeTwg=;
	b=ifONFYuOk72bELdNfNMhYpqN6wc6bDcAmrY6szzV+H6J0wUe4QHj7g18AvhZZ4+4XYdVCo
	1K1ZuL9KS2kFLlvSYCWLmVhta1Y+rU+3RQ8HIHRH2lOWRAFkPsSK/F9HBKeWJBPEeY6BsX
	xOK0VsBNAvk9xuKYudhiskE31be7Y2U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-py6nHpjuP7-xJ6uMQ_5LjQ-1; Tue, 07 Jul 2026 06:18:25 -0400
X-MC-Unique: py6nHpjuP7-xJ6uMQ_5LjQ-1
X-Mimecast-MFC-AGG-ID: py6nHpjuP7-xJ6uMQ_5LjQ_1783419504
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso32213255e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2026 03:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783419504; x=1784024304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3slwj2XyzWQtqngmhVqaSA6RBHzpXga6waGc30WeTwg=;
        b=HpNFvvQRI9otjk1BVz0MSDbqpHp15ROiz8a9LEj4sDSMnW5YdhaY1fQO+8vViU3NnI
         BNEx0TQsXfGyTDk7b7mar6FDGNC3R9OFdTxuarFkGoxIslO7zMe0tSGSJ/WtGdSbPCGB
         4jriprwpnwHiL7qQidH9hc2CCVC0JtNHV5z6C8c3AgMpWmy2rd7MGMMUawXXLRApSLxn
         wNsC7P2wOu7+Akqm62YHjRlJlh4dmB9+8U8a1EWl5U0O93P0VWXTscwO9i9kO/L2HJsq
         mkl7L72xHnM/OReRUuZ1Z9lZWTiau+QrefSttG7ZTx32Q610dWG0TvfjW9uzDLfeNWZH
         U8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783419504; x=1784024304;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3slwj2XyzWQtqngmhVqaSA6RBHzpXga6waGc30WeTwg=;
        b=hx3UzPRFJ/Uy9ilQpSTMelcU4QErukti3MFC9qAYZwJpLPir9KjbY4wFyb9mRknLJ4
         mgM141QQqfgJZDOsT68I7o3pPVskncOcoVjf4NA2O3Rk3ChCQq4AKmOYFS6nrRpk+tyq
         b7p9Ff/HIvVhz6aE2TqfvbIXKmeQo9ZRZ0g69+PTdx/6WqHrd+xgxtQ8opqVUS8e5A6Y
         jD0K0htP4IZSC9bl4WF6B3ZWP1dZTbTbX7AS2D3UwY9cRy7I2zKoCI8omh9sSPyRRf4f
         1ldJFi6P2SVYkvD7d3L3nn1grD90p6JKQGJVavOJ2UQ994cov9qRrxoTRh+NPxlEDnQk
         edXQ==
X-Forwarded-Encrypted: i=1; AHgh+RqaaFTFlY2zpeNkDwBZ8MqVnUsXEAAHi+hJnaBkLL/f0jTDGmLP3HK6+QEQMhjdiNCAgRxXCV4FC5PJj3EJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4QqqeaWitY43H77Hk74ghWk+Ysrn5Pw9rGPLsnqD2Fw3Gyafm
	PkWYVLTntBZ9+vET1wmPav0JfKj+/jHwcbhr8pc545nHYk3SPdcQonors5SBPM2UV7vKMNkB+wZ
	xP94N8V4ctTrBXUZosBuWNI1G0BwxA8fvQax9OVbHkO0KozD2lkYIqJdwOtcH/puUA/I=
X-Gm-Gg: AfdE7clfc48E/G9s5Z23fI6AOn5nI5dGrxLwa5UJ0o59NTe49u7bWKq69YSQr1Dn0as
	/FgWKQHdNtsrOIAq6Uws6jXR95u9B+vR1flQdUFNfNfVCQj1uTKGY3+o/H+07DhUVAGMzegwQg9
	yvA9TMGTqpvyRKkS1bj7GAw/z1RJ/9Qk8EHDSGSodgHr2pff8cJAWGaNsJIFvdJkCjfcBd9diA4
	eDk+x0eYi8ydqk3cVruaf3S7L9TXtS/zmcV95mJo0ww9dKJCSil0sTjPT1zLJOBLeaWcZrMxtYc
	UZSMdgplGMhCpivol5iFykdQPwVlAapb/mA3x3Dc0T2e5MHSqSOPCk2SlB/arwXtmnADKs6qBDM
	xx1YsLFmT+QrcNARTZn019JbmsFHpr2hX
X-Received: by 2002:a05:600c:c173:b0:493:c98f:12e3 with SMTP id 5b1f17b1804b1-493e3066380mr12492035e9.20.1783419502643;
        Tue, 07 Jul 2026 03:18:22 -0700 (PDT)
X-Received: by 2002:a05:600c:c173:b0:493:c98f:12e3 with SMTP id 5b1f17b1804b1-493e3066380mr12490105e9.20.1783419500441;
        Tue, 07 Jul 2026 03:18:20 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0078d49sm49438995e9.0.2026.07.07.03.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 03:18:19 -0700 (PDT)
Date: Tue, 7 Jul 2026 06:18:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sourav Panda <souravpanda@google.com>
Cc: muchun.song@linux.dev, osalvador@suse.de, akpm@linux-foundation.org,
	david@kernel.org, ljs@kernel.org, liam@infradead.org,
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com,
	mhocko@suse.com, mhklinux@outlook.com, fvdl@google.com,
	gthelen@google.com, mike.kravetz@oracle.com,
	pasha.tatashin@soleen.com, rientjes@google.com, riel@surriel.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 6/6] mm/hugetlb: support free page reporting for cached
 hugepages
Message-ID: <20260707032839-mutt-send-email-mst@kernel.org>
References: <20260707064235.1386552-1-souravpanda@google.com>
 <20260707064235.1386552-7-souravpanda@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707064235.1386552-7-souravpanda@google.com>

On Tue, Jul 07, 2026 at 06:42:35AM +0000, Sourav Panda wrote:
> Implement free page reporting for the HugeTLB dynamic cache.
> 
> Register HugeTLB hstates with the page reporting framework if they
> support caching.
> 
> When pages are added to the cache (either via recycling in
> free_huge_folio or direct population via sysfs nr_cached_hugepages),
> trigger a page reporting cycle.
> 
> Page reporting isolates pages from the cache list, reports them to the
> hypervisor via virtio-balloon, and then drains them back to the cache
> list, marking them as reported (HPG_reported).
> 
> If a page is allocated from the cache, or reclaimed, clear the reported
> flag.
> 
> Signed-off-by: Sourav Panda <souravpanda@google.com>

So if you are going to look into this, I feel the 1st step
should be reporting pages from hugepage_freelists - this
can be done independently.

-- 
MST

