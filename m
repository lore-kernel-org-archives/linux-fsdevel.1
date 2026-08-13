Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADDB417BD2
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 11:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786621848; cv=none; b=BjAPBfov3AyEOr2L+Ah/WV803yWotBJSM8yYEgU6mfjYD3nafS0XkkgjEoWqZYcO5/B2CkmLPsoF9qhqEt5QYiQ6tOBVX2r4HrGsYAH9XH4O25yZIpIG4vrsqgnQ3ou7Hn4kwSljDSTcuienV7movnc5grZL0jAm7cI7XAFzjZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786621848; c=relaxed/simple;
	bh=FLpb8Lu8xiPeId1yyOToOq7ZG1ZLcpNiPMrBxpZ0Svg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxG2qvTw6pfCLNJjkASif1wfIN5jrWQi4WWMPAKn33LkVhZZHQunA2yFZVFQ1o1b6vCLiQnJqB0pJzPLVaN6GaGIqn+MGsbJ6lPSrnZymcVog0ZFhuCuVp2oTIRXZbKs3/l4cB6EoCejMeEr9ZAKyu9xdmNkc8MRXJ5dd27qy50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Vo3HK4Sc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vo3HK4Sc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YmWE56RD/47YLwpBg7jMd//bb0JWz/XaJINUJAJCtBI=; b=Vo3HK4ScYRZ7QxGq6/fxgLrCM+
	kKgsx5Jz4Dl+Rqv5hmwpcI8fXw6q2dKJOT4+MYZRHs9YxOExPtLJLKE1RJqJKzOOyYHfYU8ct0MRX
	dSKHnI02X+AiVsuOsxlro+bEf9zm6UY4mvzxziSn9pqcBllH+k3p5cOAApXj/xcu18wMu+8xOZkfx
	B0hlJZfZPpYwTyaUPns+kbUz9K7Eg+Xzzj748baAJ9urv+N9gqdvbY1o+zHXB5Syofr4Xn/BpS3Ue
	xUh/nUy+GB0BxZ1gBEdGE1dYKYinK7jucLyecG5Lnplvo7OZJztwT7KhH2+QNutzxFmDAUwLvGoGi
	j+IdbW4A==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuTx8-00000003X9f-2ULy;
	Thu, 13 Aug 2026 11:50:30 +0000
Date: Thu, 13 Aug 2026 12:50:30 +0100
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
	Sean Christopherson <seanjc@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Gregory Price <gourry@gourry.net>
Subject: Re: [PATCH v9 05/15] guest_memfd: Use folio_has_hwpoisoned_page()
Message-ID: <an2vhg4Uvdo52WPX@casper.infradead.org>
References: <20260805210557.1118966-1-willy@infradead.org>
 <20260805210557.1118966-6-willy@infradead.org>
 <32873b50-c900-4fe5-9dc1-cb086bba77e7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32873b50-c900-4fe5-9dc1-cb086bba77e7@kernel.org>

On Thu, Aug 13, 2026 at 09:20:54AM +0200, David Hildenbrand (Arm) wrote:
> On 8/5/26 23:05, Matthew Wilcox (Oracle) wrote:
> > folio_test_hwpoison() only works on hugetlb folios today and will give
> > the wrong answer for other large folios.  folio_has_hwpoisoned_page()
> > works on both.
> 
> guest_memfd only uses small folios, so it doesn't really matter.

Well ...

virt/kvm/guest_memfd.c: /* TODO: Support huge pages. */

and one of the followup patches I have actually removes
folio_test/set/clear_hwpoison() (it's a bit churny so I didn't want
to include it as part of this series)

> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks!
