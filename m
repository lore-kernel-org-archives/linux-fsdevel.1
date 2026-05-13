Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763AC5477E;
	Wed, 13 May 2026 02:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778638482; cv=none; b=fmxZPoH88ud1go2ao74UkezvOuUBfdrWzEcp726+jdTTxUiRimO4zgTRmCKM4AOAjjFD2BhyrskdjQ0TBFitwx06w1egImZ4YC1oJtmFCLOWG+KYPsG6XAced66ows/5WrAr5oJTC/WdWwZT6B9wSafaO9H0XKSZmBI5G9lgU5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778638482; c=relaxed/simple;
	bh=O/ddZqxcWhwBINLytCJFvAuCnJUEDwehGHtAA7PXYTI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OrrNYXDYaYGwXUJ/ojyrN2ZexvOCQwvXY0bvcbEmLHtxwMrjNw18ChPqpMLhSnqIo1PUptblWPGRsbAH+ikpbdtXh9X9sgge5KGLIKKKMVkzrhz47nMvgZWfYLGPnkRt9qr6VH2jLD15yRIfzx6qU1wNv7BDOayxYyKMmK0stFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=g8FwxyNO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="g8FwxyNO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EE6C2BCB0;
	Wed, 13 May 2026 02:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1778638482;
	bh=O/ddZqxcWhwBINLytCJFvAuCnJUEDwehGHtAA7PXYTI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g8FwxyNOW9AKOG3ojvuKqlesFKDRaGo1cBCUnwWQ+Wq5ihLFVYckbY0epcRhW7jmC
	 +/mUSooio+QhEqdHXlGxKfH1D6wm5SXHP5mK4KeXxyh73kK1DbyqwPbiOHh3+jjYaa
	 CftAc2fGSbureGPyqi43jl81k5+1F6jejDK8XbdU=
Date: Tue, 12 May 2026 19:14:41 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Frederick Mayle <fmayle@google.com>, android-mm@google.com,
 kernel-team@android.com, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/readahead: add kerneldoc for read_pages
Message-Id: <20260512191441.c535e288077895b127a5794f@linux-foundation.org>
In-Reply-To: <agOWHm00w2vlh1_o@casper.infradead.org>
References: <20260512203154.754075-1-fmayle@google.com>
	<20260512203154.754075-2-fmayle@google.com>
	<agOWHm00w2vlh1_o@casper.infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 May 2026 22:05:34 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, May 12, 2026 at 01:31:35PM -0700, Frederick Mayle wrote:
> > Formalize one of the invariants provided by the current implementation
> > so that callers can depend on it, as discussed in [1].
> 
> We don't normally write kerneldoc for static functions.  I'm not sure
> why Andrew told you to do this.  I have no objection to adding
> documentation, but I don't think it should be marked as kerneldoc.
> And if it's not kerneldoc, it doesn't have to be written in such a
> stifling style.

I'm OK either way.  The main point here is that [2/2] relies on
unobvious and possibly fragile behaviour of read_pages().

