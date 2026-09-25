Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96916440635;
	Fri, 25 Sep 2026 06:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790319457; cv=none; b=Nk7u4IJgktctV0e9o4bb8vv6X0PXxvWuOs5+5pyBfvhPOGnxRFL4NGlc9hExNPpWFW6HpNinmEas2xQkzcGgYqD92fG+1ZNZbvEcMS+8qqBz+GZNQ8JppysL6L89oZEP71LeoSRzpDdzK+xau4MG8L+Z7VZ1tdn95510JN3ssf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790319457; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0vbUaji6dRCNuDEZ26iTtEknsXLomgWxSoR6KKSqw3MN6mMY40GdRy8ZLxAX2Kr6xK1udeJdhoYaM4XqOUdcZMew8fDFm4mXJ1uD2DmCnMvLn4kwes5GhMIodRqU1Svj+DtVn+a10GI+shR7rUHBBIAGHYx12qPUFGMmWAxi1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 344C368BFE; Fri, 25 Sep 2026 08:57:32 +0200 (CEST)
Date: Fri, 25 Sep 2026 08:57:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Huang Shijie <huangsj@hygon.cn>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, zhongyuan@hygon.cn,
	fangbaoshun@hygon.cn, yingzhiwei@hygon.cn, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	yefan@hygon.cn, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] fs/drop_caches: skip filesystems without fs writeback
Message-ID: <20260925065732.GB4457@lst.de>
References: <20260923070116.3226846-1-huangsj@hygon.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923070116.3226846-1-huangsj@hygon.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
