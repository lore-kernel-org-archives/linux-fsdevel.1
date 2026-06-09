Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE93324B1F;
	Tue,  9 Jun 2026 14:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014109; cv=none; b=VX/O7PGizUk2pbPM0Kz0W8FiZ1qbDZKAT0l+uoQ6W3ugbylkdU4+ZME/3LWYui+uufZQGiXAE4TTCI3QC0d0Hyi9VrLmj3chB5p6PJb676ikKx9y/VCWd9cdcRQKyEc3XrrnkBE6dkFpDZYrYkCbEt9o4Z59J7AkcjhCIsp8DfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014109; c=relaxed/simple;
	bh=nYmm2n970jnom47XtVuM9g/2ttP62EHRbQT4YkRyUyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dH5xA5nfoX4Yc8b4sCE/yUosMva2hLu3qki204jxaIPidS8mkFTL8tcxNlx8eXwqNW6dPWiObDW/lesbp3cj/OnrkXrs1ybFftli73cpM6MNw7iM4d01+zUHG7eOJJE5K5AhOoCXjy7oRWyjpj5pz9uir1i5ZCh4pf/w69Qv4U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RKNvq2QF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RKNvq2QF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=23O/6Tf6MpVRwtvYUKBhYia4hyeYv+ef8hCE2QR/6H4=; b=RKNvq2QFHvvLEL1zh+zRwgj2Bt
	YuUPc0537Qqd1i2U81KMQ686eOvBmQ4O0qo6EP/QTPcDwlGg+3mXXDfQVP3cPvJW5NosodvwRuM5b
	EApY1BVe8tOoqT4FoFKgrAluvblkkUHgRq1wxllP6v+3gUqTl5Tq83Re8WcLbZJkKuAVA6kNBh3QL
	JhaqvrV9pO6cJqoYNQr8NlBxfKhGYyTMgjf06Q615Eno/nVJ3Bx5EqCJlBK4faqtcW4CJRp4qvo1i
	SZfZFaFopfNAmQUAd7udRkqVztjqgCBOyTAUGNKBSRNNpTsHYyDAhFCm1bIhxFT0p1sfL/g1BCPG2
	zMmX9niQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWx7t-0000000Fp8O-3Dbn;
	Tue, 09 Jun 2026 14:08:21 +0000
Date: Tue, 9 Jun 2026 15:08:21 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Longxing Li <coregee2000@gmail.com>
Cc: syzkaller@googlegroups.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Kernel Bug] INFO: rcu detected stall in sys_access
Message-ID: <aigeVQT3U22a-KWw@casper.infradead.org>
References: <CAHPqNmw08zSCwT+QsavaXJinOxZuNr2T3uf9TFg4MLzDBJhyHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHPqNmw08zSCwT+QsavaXJinOxZuNr2T3uf9TFg4MLzDBJhyHA@mail.gmail.com>

On Tue, Jun 09, 2026 at 07:44:50PM +0800, Longxing Li wrote:
> Dear Linux kernel developers and maintainers,
> 
> We would like to report a new kernel bug found by our tool. INFO: rcu
> detected stall in sys_access. Details are as follows.

Please work to get your changes into upstream syzkaller as it is much
easier for us to work with syzbot than with individuals.
