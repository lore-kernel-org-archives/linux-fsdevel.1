Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B33C345741;
	Fri, 23 Jan 2026 06:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769149204; cv=none; b=E/O6IoZNuYDX2GnaqzrbdLDqVXAgueDF62K9JXE9vENPbE/sfsU7QmtC/oZVsZyHRbYoGDi/1x2Qr2oMbY7C9pp8vCDhAQ05+jygZ0rkxyCk4XJppy447KKESLK2IVE4cZQ3PKmkNtw137Z6rfo/Tve3bSuk71TH4zhtxF0WwuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769149204; c=relaxed/simple;
	bh=LI6raesR/RAFw/aEN6CzDVw2W4jMu3hCaFnf3TKTvqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCRA6uU8DXnoQUDf3vnlWy2tEP542WwcQPgik+ejpxyL8QNxccL1DEUfdlSJB4wteY2PLOvDWBcZh3hFXKHvBVT7GQlRTYLFgTui7pBVcbegcXBBguttScEVtwjtt8nD5I27pOPqlOyBvRm1z6PbbjQrBN/635aKAcTF4wY1FIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 47569227AAE; Fri, 23 Jan 2026 07:19:55 +0100 (CET)
Date: Fri, 23 Jan 2026 07:19:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>, hsiangkao@linux.alibaba.com,
	chao@kernel.org, brauner@kernel.org, djwong@kernel.org,
	amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 5/9] erofs: introduce the page cache share feature
Message-ID: <20260123061955.GB25722@lst.de>
References: <20260116095550.627082-1-lihongbo22@huawei.com> <20260116095550.627082-6-lihongbo22@huawei.com> <20260116154623.GC21174@lst.de> <5aa7566e-c30c-470a-ab77-8b62a3cdf8c3@huawei.com> <ffdfbf7c-25fc-47ca-8c90-c98301847a1f@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffdfbf7c-25fc-47ca-8c90-c98301847a1f@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jan 22, 2026 at 10:48:27PM +0800, Hongbo Li wrote:
> Sorry I overlooked this point. Factoring this out is a good idea, but we 
> cannot use IS_ENABLED here, because some aops is not visible  when the 
> relevant config macro is not enabled. So I choose to keep this format and 
> only to factor this out.

Is it?  If so just moving the extern outside the ifdef should be
easy enough, but from a quick grep I can't see any such case.

