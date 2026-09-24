Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093784BD79F
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 18:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790276019; cv=none; b=AkLmQGGzrM1Yd6JxCWUm+HyjrYYCsu+qgnRFa9in0f7uBIKTm3PNUJPM7XTLQjdqpXKIRlMiw98ApnR2GoTxtnYw4tgMo6xi2TJraFBFYjeCRO6erQuj28kxGVgo1TmYdyK4ewBTsBkj9dy+HVMHsbwPu8U8l0lSQjXJk9S41Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790276019; c=relaxed/simple;
	bh=/Q5WXPJVDllfj1ROTbP9FyCa6AAhcbDU+9YYxytBPiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j21RevfvSLTuvqlcRFa8B7H+yX7a5BnI4sD7zqfp2ZpojUrHypjy8P7FNFKViEAoi1DvckuDuV5Ej13mypbop61PzjeE+HYn6haxh5Fl5AARONT7uPzCEnlmROJlgW8khf3KPoZbVk8+nnjvIacfmXxue6riuv2YkjLxt+ZGO7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MZrYCRc4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MZrYCRc4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EJILEH5+ka8tzKqUVnB7R8kbKSlDulJBwhuxcrxu3g4=; b=MZrYCRc44NmK1/D5cDgxMbBZ4K
	rJDe3lulb3qEdJhh6cmUkzSfnNflMzceAXOU/MWh2zlmwuKX1XgaFF5xk3oIeLnVfLCM74lmDlsfk
	YmbqbuHqAxvU2bxlSN1tyAkTHlLLmco8Grc0/3TfuxSlJ1bqyINdyAVFtijDGoKwHge0OnkhzfRQH
	RYakcAgulkv9KQ+6b6h9thSYs4u+uNSnH+I2Z3Z/Dv01bW+rHvSc+y3QFCvDdncyADhvQi9Wjr6CY
	F5wyfFwGDVwecJR/yrr4c/tJaYhcKiSgROjBcz4WAHlCKWfmLwa1aX7GehFfbS164eK3vM344/XVC
	9Vx9wYCA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9oZB-00000000JXz-44fz;
	Thu, 24 Sep 2026 18:53:10 +0000
Date: Thu, 24 Sep 2026 19:53:09 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>,
	"Gregory Price (Meta)" <gourry@gourry.net>
Subject: Re: [PATCH v9 08/15] hugetlb: Use the has_hwpoisoned flag
Message-ID: <arVxle46OHWjL7Sk@casper.infradead.org>
References: <20260805210557.1118966-1-willy@infradead.org>
 <20260805210557.1118966-9-willy@infradead.org>
 <a51a6236-8881-4479-8f04-39676e0e1f14@kernel.org>
 <an3uN4TAAZ2miXhe@casper.infradead.org>
 <7608c80e-645b-4d07-bba3-ef45ee36fba4@kernel.org>
 <arGidwZQrrWVPAoj@casper.infradead.org>
 <7a23511f-365f-436f-b934-6a520510409c@kernel.org>
 <arQkP2uEzog8ChN0@casper.infradead.org>
 <6121136c-de9d-4577-a30d-f00dbe244e5d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6121136c-de9d-4577-a30d-f00dbe244e5d@kernel.org>

On Thu, Sep 24, 2026 at 12:32:13PM +0200, David Hildenbrand (Arm) wrote:
> > Oh, no, it's awful and complicated.  We could strip out the two bugfixes
> > which are at the start of the series, but why would we want to do that?
> 
> Andrew usually wants us to separate bugfixes (especially stable ones) from
> other work. Unless we all agree that they are not urgent and can go in in
> the next cycle. I assume that's the case here.

I don't understand that preference, to be honest.  As long as they're
first in the patch series, they're easy to pick out and don't depend
on the other patches in the series.

> I am not convinced about the huge_poison thing though, that originally caught my
> attention.
> 
> So trying to understand the race we are trying to solve (that is independent of
> the original idea of the patch set), I realize that these races are only on some 
> slow paths we don't particularly care about for performance.

They are not hot paths, I agree, but they are user-triggerable paths.
So I'm not happy about the ability to spin up thousands of threads and
delay other accesses to hugetlb_lock indefinitely.

