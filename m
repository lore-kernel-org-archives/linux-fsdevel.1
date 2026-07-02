Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEA9222584;
	Thu,  2 Jul 2026 13:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782999327; cv=none; b=ceIwTO+4byMV/0jDJTylOtdEOg7cpsoWjcdpoMnNizPzaD3C8iTlkrGYy2wm5iiuB5OMgYMe34S4S2bA4FeQG0hDdM1/2Cm8guqy9pHDOpnc+f1NkAjtyv8uyraVf9CdVXatlv1q1Gp7gZi0ZRAgFbkaXei9byJzpb9PbWw1hxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782999327; c=relaxed/simple;
	bh=AfxBDMN7iXKzsYSUCGhdOzT4BhUCuRIT1eU3gy/DvsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fw5rIgllhDDL6xOg+NKX2XHy0cBVUexkmnbaBb+Fl/I5c74wUBw5PIur8v0sm1MTduFgd9dSamAe517Xjv0Umkp2At27C/UoTL1tU05nMiIvvAz4l7zofeTzyccCvYxFyTony260R+F5AybYCgb0ywyIilr/jY/0RA+tsgVgFJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TO6rCNIV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TO6rCNIV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nPTghitvQM89Yy/0LkcZsvfoW0u1ekLjPu2MuK4Pg0Q=; b=TO6rCNIVElslT9m+NhM2CmNSAN
	kgZC2GCfL7FL/YTsFzX819/oK3kaFABTnahaI0gFF7qlYPHdo1X59LFRE6IUs3IUEOdfnag9fT/8+
	+E87boQ+nyTyOLmHUKB4uNwg5IrDmPK3KYxfD4clJzkUm6cF87v12UeFeXe6X2xTFSrGkJymnk/8B
	I0LelBZvpQW14nTlk+NGoYiJ52LC18dXaRvbhsXi4pwFbRG4mBOLXdD11pGTmEunyGIdtsua2HiY4
	xyRDn4jCA8CvRfG+HYPoy0NGBs1zRBmZv7tZ4fTcReLFPYzg8K99f+5/y46r4udOdlvu2xGyv4ngo
	LhdFm+yQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfHZY-00000004X5W-41oX;
	Thu, 02 Jul 2026 13:35:20 +0000
Date: Thu, 2 Jul 2026 06:35:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Jeff Layton <jlayton@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution
Message-ID: <akZpGHIiprENwZRS@infradead.org>
References: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
 <5e7b9d23-4291-48fb-bdc6-47db82d33c80@kernel.org>
 <20260702-seekrank-stilrichtung-mitentscheiden-69a64ee097ec@brauner>
 <1f29f48d-b9ff-4de2-a392-dc05781728be@kernel.org>
 <akYz2aMIco1fbD-t@lucifer>
 <54d3a698-a275-488e-ad36-ef423db30f70@kernel.org>
 <20260702-weitreichend-aufgearbeitet-flausen-fd92f38bbba0@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702-weitreichend-aufgearbeitet-flausen-fd92f38bbba0@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jul 02, 2026 at 03:26:58PM +0200, Christian Brauner wrote:
> Tbh, I think that's equally pointless. There are also very few instances
> of non-AI attribution with Assisted-by.
>
> If the tool mattered to what was done significantly then it should just
> be disclosed in an appropriate paragraph in the commit message. The tag
> itself is imho equally useless for this. I really don't need to know
> that you used grep or git-sed or tcpdump and it certainly doesn't need
> to spam the trailers.

The attributions that matter are things like coccinelle or sed, and
people do it by putting the actual script used into the commit log
which can be pretty useful.   None of that is doable by a tag that
doesn't help at all.
