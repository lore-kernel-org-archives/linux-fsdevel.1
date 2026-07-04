Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C00A16F27F
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Jul 2026 11:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783164667; cv=none; b=fF2Jhb3J48A8fXqS7XFyV44Up4dOqTvDYyEgpbuqpNxdYMdo4yIQLZh1somEaRZ2kO4TMUSYYsLpXWZsTXG0aTckOrvzdl5P+EsGsjKGJYV5pWqyn1MF2FfnMzqi4WC3bMuaJV90FVo5HzUue0CB0oL4Gg4VoWA6JQvdOIqlqiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783164667; c=relaxed/simple;
	bh=n1OYwIpk6W/NamQGW8rOzZf+nkQSRjimhmU+F2SkDMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQfIX/NL8YNoEhb5bZQOAN1MPvRYxM3/JpW88mtCKhu9Ro0eVEBrm9EclOUBstkmXw+f3DpxIcpL8vm4m6vxe1tIejOp17AZJs33W5j6HcMh0QmJk4KORxGfenWzhu3PttbKDo/broU6bq30SF21/SeQ39fRog9ZJZPWwU6RHDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2hnVSZHj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2hnVSZHj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=n1OYwIpk6W/NamQGW8rOzZf+nkQSRjimhmU+F2SkDMw=; b=2hnVSZHjoSOG/X6xp5VFNsF08I
	7sPJD6Ca0Edjy652pCtL7MLIdulFhwRsMsjg16oQcM5+jjnOe94Q9L8JUkgvxjmVkzurb/cF028Hy
	jGWlk5x7HDq2d9Ra7Jsuf7jJEAzjminHR1qmH35aDuJXL6AEM5JHvaFsqgjfmskaxWAJz9FUTzbOu
	plDXaHdXk/TtykXcVz0hkFAyqimk5tLLqaOe8E15rQIfarkXYw+82yMCVQ1FCl5oaYsgiDBqdC/mH
	VSOG3lYJBxdYRnnPAjOwUm7//Zf8nyqKXuIvM1ZWmTOaWnjgYaWJTl5340OQT4ZleosaXzasQKuCT
	SSUIAQoA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfyaK-00000008O3S-2fez;
	Sat, 04 Jul 2026 11:31:00 +0000
Date: Sat, 4 Jul 2026 04:31:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 1/2] fs: refuse O_TMPFILE creation with an unmapped fsuid
 or fsgid
Message-ID: <akju9Nag-jhIoVq9@infradead.org>
References: <20260615-work-idmapped-tmpfile-v1-0-754a94d81f83@kernel.org>
 <20260615-work-idmapped-tmpfile-v1-1-754a94d81f83@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-work-idmapped-tmpfile-v1-1-754a94d81f83@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This commit causes failures in xfstests generic/633 generic/696 and
generic/697 with messages like:

utils.c: 948: openat_tmpfile_supported - Value too large for defined data type - failure: create

