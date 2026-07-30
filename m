Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E253AEB32;
	Thu, 30 Jul 2026 20:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785442844; cv=none; b=IaJ4PF1XdxHBGt3cByYSNfU5dqDKoEXs+6ZUB8b86M3xK/Fcn9JcYHfSfkm7WjJjYu0LFhg+tdTFO5aizdZlKuvmiQj3jicKBuIEp1N/Y5qVSIO5IkqqdVhRkTP+jtH6ZPZdkF8PLPr9xXv1ilKZbnQ8gf7IfG3nj6ZFqNTq2Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785442844; c=relaxed/simple;
	bh=wO3UTVRJfFJufhKVHmP+76JFGP0pm3Iq3d2nSLi/HCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7gFEVUrS59XwRNWRvaEldhXPvEkVMzbZ11MfrR+OwC0FRt0U2L7Lz8TnIrgj3Il2E2tPxB5oMY1kw55swDVdn5+p1Yz2rS/1UcQkNRXIqfZwMkMX1CvEarGHGvHAI6oMhx62b9q/8nGMjFD2xgw8Y7AkyqpL2KYraYGLeQ35ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UqDMXldq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UqDMXldq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KYeTQUT6Ff/gpczv1+werC4xHoosUiAfud7+5CM5Af4=; b=UqDMXldqWuzLeBVyrYUnyR1s/Y
	aGG+JQJRujECxWL0lh9f/izGsmKlWm96iqivRvhUuCdreUnmdmr0oihDK9vtohiQ0McZCzkoIUFE7
	IesNVn5wALcQmL76xg4SeKCO9pwcenQl6xCkSduJZhxrml3LkSnbKTZSWFbpfWpUDeHajCuhAOHXg
	kKOUX/cEPlkc929w2NTzQsf4+2tL++As+k95gOV10jFLOGcl79cB6NYCWARptuuPobqtHi0fldxTD
	UO50HHQnrzxrZrj4Z/pU4HT6zOZq1PnwhJynUtPyLr6ahyoSrCEwVuC1lGb5SWDFrRc4Qu8p6bswW
	dNuuDiTw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpXEu-00000003ptf-3eNS;
	Thu, 30 Jul 2026 20:20:24 +0000
Date: Thu, 30 Jul 2026 21:20:24 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Chris S <coshi036@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH v2] fs/buffer: serialize set_buffer_uptodate against
 concurrent clears
Message-ID: <amuyCIg0Y1YRiFT7@casper.infradead.org>
References: <20260430053645.1466196-1-coshi036@gmail.com>
 <xaqwfkwjnp7h2lg7ir6wy2tnyay26t3im3ftkdl64rhys3rhmu@lc5vfh5tc2f5>
 <CACd_6n17-pJuNoCLsstP7goocedrr5F8T8BwTjRUNx8frKEPgA@mail.gmail.com>
 <bnchcfog427eo3bxt5h6qautlq7sb2o4ww7cjgad73biycdn5f@np7qkbyqizup>
 <CACd_6n1Sht4xs6P_GT0-+wj1uu9Ww_4X=TysQRvq6ZSFJ71CBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACd_6n1Sht4xs6P_GT0-+wj1uu9Ww_4X=TysQRvq6ZSFJ71CBQ@mail.gmail.com>

On Thu, Jul 30, 2026 at 03:47:23PM -0400, Chris S wrote:
> Hi Jan, I'm currently working on the changes we discussed.  Based on
> vfs.all now.  Four things came out of writing it that I would rather
> resolve before posting.
> 
> 1. mark_buffer_write_io_error() is not safe for jbd2's buffers yet.  It
> dereferences bh->b_folio->mapping directly (fs/buffer.c:1057), and
> jbd2_journal_write_metadata_buffer() points the temporary bh at
> virt_to_folio(jh->b_frozen_data), which is slab-backed.

... yeah.  That's one of the unclean things which keeps me awake at
night.  Sorry you ran into it.

My longterm plan for this particular usecase (pointing a bh at slab
memory) is to have bh->b_folio = NULL, bh->b_data = (address of data).
Maybe we could do that now?  That would make mark_buffer_write_io_error()
work without change today.

There might be a good reason I didn't do that yet, but I forget what it
was.

