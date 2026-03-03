Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF4837B024
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550026; cv=none; b=ihIT0oxL5hOrgL/cfmh9mRBH1UwitNn7qSfD6ISFFEmvPz0ctPn0fGRkoTrewYcpfAPFNTG7cI5NZr7/J9g+N9Q7FYioGQ6iUkWSIfw+a9sMaWeomIABOqkIPP22jBLby6V5YYF+E3TKuKmdxBbsmn4+T1ifiHyBftJvMVqy+eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550026; c=relaxed/simple;
	bh=Zq6qc07TNNM9SXexlADopG/SfpnnDjJNi9OE99tP7m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCokfwy+nNkwBuT2KNexOr5PrIUTQlBxaFPozmMxirKoTnt1jrjGK7FY883/Ubam7Wo7pyiaN009uEAnINOh4FvWQXaqKaW/NG2u2iakpyKGzUlbN6gc32WUv8T7ELMuwC0E2cCBJFQL4fk5IRZ5i8wOaNue+aSywp5o61YhvMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lK742Vwb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lK742Vwb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UocHEni3/4kdD2iaE8QnBZ0MDguWpGfeX2+s8hR5X9U=; b=lK742VwbLoO7XuSYh2F+XgwptB
	Y9rI9/nfYoS/osAx8s7vqitU8HGcaYgNq7W1LNQOEOjfgJSU4hGdJs7zf6vDLz81N5AW/53zjKklK
	sCH0SJ3R9pj/nVBUgE7gyfrPD9fMaxWOu5yg2aTfCywqEAR2yEbtD94IybKd//2nW7I8cQMNtIFYb
	izt8GeEa6U8Km3uKHqWxp2Tl7q9ejYBF6Oj15P1VqlGZTsGiUDGR2Jt2qnHX9/9Hd387PIRArHOTa
	xbHUG1pp0kG4QkIVli30Wey5PN8KT+aMMhEF+vDnZpgRc8bOclqN1CM9q8xphfkkuYETJ0uvk1IXT
	w3Ac2zsA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxRET-0000000FNLM-2VJP;
	Tue, 03 Mar 2026 15:00:21 +0000
Date: Tue, 3 Mar 2026 07:00:21 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Chuck Lever <chuck.lever@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] fsnotify hooks consolidation
Message-ID: <aab3haz7W4ZqTT-3@infradead.org>
References: <20260302183741.1308767-1-amir73il@gmail.com>
 <cf1cb14e9b74bfd5ca5bfcaf4d6a820ee2d4324b.camel@kernel.org>
 <CAOQ4uxhWZBrcPXRtP5Vq3GcPZpZ3LkHD9D5A6LtfaqnJFeC+mg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhWZBrcPXRtP5Vq3GcPZpZ3LkHD9D5A6LtfaqnJFeC+mg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Mar 03, 2026 at 02:18:47PM +0100, Amir Goldstein wrote:
> > simple_done_creating_notify() is a better name?
> 
> I will go with simple_end_creating_notify() because what it does is:

Shouldn't the notify case be the default one and the nonotify one
stand out with a prefix like _nonotify?  I.e., steer people to the
more useful one by default.

