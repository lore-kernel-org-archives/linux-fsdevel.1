Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEF12BE7DC;
	Thu, 25 Jun 2026 13:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782392783; cv=none; b=HkBGExndeTpuzw5WF2TwlU6wfCijA59cYlKBMVYjt0f8JUZWb7PWuAdvxoxEGgikhT5IW0ussfdmGZRZJ4dPE2zxAC99HTssYBYMYlRz/L60MZHJnbkBnUcMX6InIqwp6GAl2soIfrDPy85tpWwWe/ZV+L4koQpN/rMWGyYEL5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782392783; c=relaxed/simple;
	bh=y9Ri2TdtoXl1X0F39YTsXidtkdn771IHjwPSMt9Pa3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edOmVIs7VzyXOlosRMR/2pvbtgQVSz587P6YehFSkv0MpqZHFsWroIcOLxao55Zvh+sNVSm8FLVLlef+40IuMs86hBZbCx4kRdaeY+lj45O/kDCkMrsEA81X2uNPWHXxiwFBUB38hYYT7g1SIOISJVIa/BcoFa8d28Y9H9F2/P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CYvjEdHH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CYvjEdHH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Z/+ugFYMnzX+gal9e3En2BSj9Nh5yvMh/PjC9VOLQP4=; b=CYvjEdHHfxvK/KRyrYM7opybUy
	dF1wSNDwXubtXVBBybkt4wK96tXzDOj5GYSjsL6HKqJ2/PdSRbf/g07BvyQE2MJZPuxZrMWYvDakP
	KXUD5L1VQNnEvnP5tthi6xU6h62OTl7aW5xI8EygiXszq9BamaLagY4CrmyBl8u8DfN3qq9CtxLtQ
	R+NJtSWWV+Q2oycm5oO1Gs1iRLC9Pep2ImJ5QvB6rxVTUDgOw7P+oy7ChTBBA8/l7csPkGusDor7x
	lfLNXTVFHyHd5We3iyAoiCGiehkC+bGHaxidv4g5F7GK0cSmaJdTVEQtakoWdsCIYhAdpB7ai5Cvx
	F3zKQ/YQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcjmc-00000009w9X-2Dtf;
	Thu, 25 Jun 2026 13:06:19 +0000
Date: Thu, 25 Jun 2026 14:06:18 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jiaming Zhang <r772577952@gmail.com>
Cc: frank.li@vivo.com, glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org, slava@dubeyko.com,
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Subject: Re: [Linux Kernel Bug] INFO: task hung in hfsplus_write_inode
Message-ID: <aj0nyhoWMKmU0Qwz@casper.infradead.org>
References: <CANypQFb_2TqKGrztAXj5m0_v+QChxXDnQVeifzV8J25Vuju10Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANypQFb_2TqKGrztAXj5m0_v+QChxXDnQVeifzV8J25Vuju10Q@mail.gmail.com>

On Thu, Jun 25, 2026 at 04:53:49PM +0800, Jiaming Zhang wrote:
> Dear Linux kernel developers and maintainers,
> 
> We are writing to report a task hung issue discovered in the hfsplus
> subsystem with our modified syzkaller. This issue

Do not try to be syzbot.  You are not good at it.  Please get your
syzkaller modifications upstream and then let syzbot take care of the rest.
