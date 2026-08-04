Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678BA47042C
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 15:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785858420; cv=none; b=q+71/uTav/NbOFry5ux/SbD/0Vhexk0e9lOkw2WxbWJuRN/+bODGoGb8gytlCfYFGzzr/Q9JG3z82uVVW0S/IYsC2UGH3/JwN+KpG9jaIiyDxPVSqOMvqhKXmPH+WV2kxDorCL6vEBg5iAkpdMHugaTRIW54YIeO23lagIxxPxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785858420; c=relaxed/simple;
	bh=D6Iy4NSFRSDDRDkJSxpsJ12jmJbqsUkgJMuoquK0mbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNtQRHzoTJzy2dqIOdqOpc3TswUQJur1M72YPa6WMQkeqB0yCujC1FM5fng2w5vvRUCu8LygltNjRHwkfpZoiRjDKCoJO95Svoqopx21F2to+mpVfA4kz9XHtmzdFq6qy1dVEhDI0VqlyRrE4Sk7EmaQ+RzYXFPatqWRUUXl3Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C5Hi/CYQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C5Hi/CYQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=No2AlOpVpiMo9L5YjZVP0hbFpt5iqBLbhuLbStEN1Ok=; b=C5Hi/CYQ85Cm4C6FcX5YnP5HpO
	+vWVNRnPQisyCy15f5qnKcfDnZ1ybd3gBXMhWehr4wAhGGVSvJDQmfwp4V755VOh5KHheO3fxyuti
	nldJ2ebik7yG63zkAvhf6LZzYvoIwxiWho+TcOvzmPmZDrpi93YppyMb+GMoYWOdDit/Szvbh0kok
	BhDevoV1YLCwUOaeFF9k3M3bnNlkN8O1uMru3nZOFf4XSOA+sAZTeiP+LUXJ7qAv8CQbr1fUf9Rv0
	ojXEyaZRc6wXdDwtfNe2ffV6k63gsLd6y5XFz4Ew5YYaLqk7Df4xGGjBhOKVu1u7sMIWXbP+jysxQ
	L3u5oBtw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrHLt-000000049Sf-0qQq;
	Tue, 04 Aug 2026 15:46:49 +0000
Date: Tue, 4 Aug 2026 16:46:48 +0100
From: Matthew Wilcox <willy@infradead.org>
To: jane.chu@oracle.com
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>
Subject: Re: [PATCH v8 06/15] kpageflags: Use is_page_hwpoison() to set
 KPF_HWPOISON
Message-ID: <anIJaPXquzQrnCdK@casper.infradead.org>
References: <20260731200802.574821-1-willy@infradead.org>
 <20260731200802.574821-7-willy@infradead.org>
 <7a72bcaa-06ed-4485-954b-2376f754eebd@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a72bcaa-06ed-4485-954b-2376f754eebd@oracle.com>

On Mon, Aug 03, 2026 at 11:44:28PM -0700, jane.chu@oracle.com wrote:
> Good idea, but agreed with Sushiko about the bit setting issue,
> with that fixed,
> 
> Reviewed-by: Jane Chu <jane.chu@oracle.com>

Thanks.  That's the only diff I have between v8 and v9  at this point:

        if (is_page_hwpoison(page))
-               u |= KPF_HWPOISON;
+               u |= 1 << KPF_HWPOISON;


