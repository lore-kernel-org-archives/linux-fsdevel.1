Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15193B9DBF;
	Wed, 19 Aug 2026 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787150378; cv=none; b=mte+WozdgAS4lIqBIRD/VmLla4d3wtxGTamK1tgoOOOhWUK79OwvU1N7qIsjqMnECfQn3FNcMdUifgof2g05j2/TJH1hGy3V67mxK0gAd8YnDWFN8UBE7V7QIyK58UrtlnnigwwFrvo8Y6ElAEjCJ+Sxcms/ynTLLEZmLIBADRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787150378; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=It3Rl1/XPgY9neE90yoKQa66IPuYgNHPbsnQn/M29oi0uQ6+KdAUAszdBvK3Q4bw7QljsDZrhAanoqS//9Qlg3OQpipg29Yqf+s3XeBmkACQHGbfpEWlMO0ro2H9fmHpug1Sew1dHR4XKe+s73xI5eK8FtVmjxin+X+sk/PUb/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2TYirFOk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2TYirFOk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=2TYirFOkCzvSlrZUBMm/DEJ3Q5
	yCtfRoTqXMPfpCY20VycF4bauDCCyXNanpemH5dyOKAxiG74EKrhLmfdOD/yrYuuvkKWdskmWZAmK
	ZLi0wuRQnzNry7moPCcaeGjoqBXpfUhuYxYvqKfFO3GRBPni43vhg1Flh5ETeYGgZn9gAx9+RKGQ9
	JFniURqcxuG2Bf09U+VGy7q9zUobPf12JPb9tEU6uM4f8+AUirrwTPh8ALK57o1+qriqtcb4aVDtS
	OieCX6Ky/KJROd6sG48Hdx/jj8ExcllXzkVJ4hP+y7NjqjdwB0QCmn6DUgAdIAQymL5SHD/Hx58j5
	U3+JP+Sg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwhRx-0000000A06F-3ge6;
	Wed, 19 Aug 2026 14:39:29 +0000
Date: Wed, 19 Aug 2026 07:39:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jann Horn <jannh@google.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page-writeback: document folio_mark_dirty()
 locking more explicitly
Message-ID: <aoXAIToVFbw9vxLd@infradead.org>
References: <20260810-set-page-dirty-warnings-v2-1-1bd40fadfacd@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810-set-page-dirty-warnings-v2-1-1bd40fadfacd@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

