Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B143ADB88;
	Tue, 12 May 2026 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596299; cv=none; b=Pg9Hx6unD7IGshsAs1Bdr0uve3rwcu2Jewb8jNCX6bZBvfuKPMzSH434dQi7QtQvHaYPAr69nUrlwgsfbwQHLk8gXZ9I5lx/jny23iS0ppIIUSZTsGJzRKb6kwjgoo36qmZgHsL8HRuGfCpzmQ3yILNsRIO+PgftcuX7J1GNPts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596299; c=relaxed/simple;
	bh=nkIkpv4GRXorK8gVnpt6+GcyiLt/ka0buoR7Clf7E7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdrDD8txETkZEkjuj8SrAxj5GFHOjlQvAZZlGRqhamw6WZe5veFyBb8VBcVKmUI5nZ2oXDxViBxUk1HTdKn7QhvIEAf8LgWFvkds1Lnq6d1z2gr5+3GCvk+xtaSZtTYPWIWf0zgvHc4kWy+avFLjnfJm8okPPnGA5v2EaEj2CA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=w6l5hJGt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="w6l5hJGt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zSyQLJxSsL0bCWnNBg6NGMoNuakk2nc0J3zkOk/uQIg=; b=w6l5hJGtiKqlAWtdkEunFkEhwd
	EqPwxdQbVxIl0P2XIwxiTNKLM4WijJVnpn8X7B9c2pMp9bwoWoSVaNZgTUIdJBb3wcTXHWS+oEUu9
	yktUIV26qndpP+oiGYcnd7I/QUfjjmLksM+7KlhGJNfTaPjtG2u0/Z1maKWFRZ58Ci9Xb+j6AKdVA
	+83mcA4TUNyy+EZT1W/zH6ujynL3+U/ydIO9mLG0RT8SAwFdkrRsI7VCI+PUZfjhHqYs+xabJtb1C
	6aEVJxy8KW9NflI+fmj5xOANDsPLCS4TIA4xIOJMEsS+iItMpbGxatkL7kJDButqxvwYZMGyEf/hd
	p2AjUjog==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMo8z-0000000H2fZ-1mId;
	Tue, 12 May 2026 14:31:33 +0000
Date: Tue, 12 May 2026 16:31:30 +0200
From: "Liam R. Howlett" <liam@infradead.org>
To: Joe Perches <joe@perches.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Alice Ryhl <aliceryhl@google.com>, Andrew Ballance <andrewjballance@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, maple-tree@lists.infradead.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: tools/testing/radix-tree/maple.c & vs | defect
Message-ID: <d55seaqi3srxbpepscwp6ibul7f4je2wyxwsc5uwrlawnmb4ss@fqrbhgdvsdz3>
References: <d9cbb89faa5bdb71d451781d214a51ce8923a83e.camel@perches.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9cbb89faa5bdb71d451781d214a51ce8923a83e.camel@perches.com>

On 26/04/24 07:38PM, Joe Perches wrote:
> tools/testing/radix-tree/maple.c:       MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL & GFP_NOWAIT) == 0);
> tools/testing/radix-tree/maple.c:       MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL & GFP_NOWAIT) == 0);
> 
> Presumably the & here should be |

Thanks.  I'll have a look.

