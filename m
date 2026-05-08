Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7229B382368;
	Fri,  8 May 2026 08:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228454; cv=none; b=RCl7g7wQWTDaRDi+Zoj7JJc/UY0V0d0YDv1Q5EAwqY1M5+DhAJPS39HUXaZ9poF1Rk4wYf1Yv96y9gZ6KIl3AEDdt+Q1ZyTH4fxvEe9thk3JivLhYCNCzRqATEMGY4qljJU9sLWY1sLSGxNKdVTzCX/uE7caSi9uIkBtMo2ikgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228454; c=relaxed/simple;
	bh=DMFmVT/2ok3zEcTv2iqGBCxx1k3WLEJwHbtGWpTnME4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1V6jH2AXDr55GNfzmIgU+jWw97VKYNKrFwUN4u5d2Wzm+UEt9N1u6ENy9NDfRGrLAYvQCrLIuBXKTiT05NFHmhObvzlcg/eQugk3TfI/lmMZihbqNUdUJVNp4EGA5f8OF6zzvdWhS66PMytNf2Jd7sFH+JeQBoUEvqoD0T64cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=I/5Nm4wV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I/5Nm4wV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Zkisq+nZ9+CHwylgMN2ygPINVVeeO6D8/0fnAwpndjo=; b=I/5Nm4wV3PRDZP/D/AqkSSGw4N
	EsW/0ty3dksH3teSQv6mp0d+2EwhighKdvq6fZINzN6bLB7Kp+jhtDosteYgpT1SGjMFrricSHpSn
	CaUnJuuxhkVmGf4ExRjvfHuqNmMujXvbgOUbugoaZvx9WDJyDsEBJneCYi+59El79kA/K+tgL88t7
	frB7P6NA4FHnqGu79MSXjDK+YzuficgPUzCAt/YuyLWLE5M6DGxWZGIt4kQdO/E004Yz4qCs828GB
	KijyWHAPeuFNrETJhuKbzcCvk9HwnI1iHBQhJuQ4K3w5ykRNBLVymd2DemjKnG33++WlqZk/o9CDK
	0pAaC0VA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLGS1-00000005ylP-3jcF;
	Fri, 08 May 2026 08:20:49 +0000
Date: Fri, 8 May 2026 01:20:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, oliver.yang@linux.alibaba.com,
	Carlos Llamas <cmllamas@google.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Tatsuyuki Ishi <ishitatsuyuki@google.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] erofs: use the opener's credential when verifing
 metadata accesses
Message-ID: <af2c4X1YCB7NEb8p@infradead.org>
References: <20260505155615.2719500-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505155615.2719500-1-hsiangkao@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 05, 2026 at 11:56:15PM +0800, Gao Xiang wrote:
> Similar to commit 905eeb2b7c33 ("erofs: impersonate the opener's
> credentials when accessing backing file"), rw_verify_area() needs
> the same too.

Two things here:

 - rw_verify_area is a helper for use inside the VFS and file system
   read/write method implementation.  Erofs as a user of the VFS should
   not use it at all.
 - using the opener credentials when accessing the backing file seems
   wrong.  The entity accessing it is the file system, so it should
   have system or mounter credentials, not that of someone causing
   metadata / fs data access.  And this applies to all access by
   a file system backed by a backing file.

