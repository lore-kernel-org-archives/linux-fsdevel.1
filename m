Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AE8C2FF
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Apr 2026 04:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775448113; cv=none; b=b/mQrbSab0hN6uvX0ZZ68npTBU24wdDByIcrcYTB1nTF9rNB0OLb/1s+T5PYfOsDf1qXXyJ8nzG0Eo49mkKlZ7FqiL3L/SoVU0mgrZQAnrGWf7KcdVtb9U7av6S+teJre6gDQukeJ9L6qEcPE5VZ2kIRlLApnxFlmI1IF75RGSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775448113; c=relaxed/simple;
	bh=k/b7d6yh0ZU3ll/Ke/6+wOCmCTU5582BW95QwPVIm+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdbGhvOwnbnGvPRGmsPMDQNNXX/rvKEbYsrNxbq/UKbvV+XWg3AA3wekm1KY2JTHpKHPvTDHgSXMMkTBsCf6M2xLiYUneqfkYoDh5fEglp1G/EAi3iJ/8cmz4vAAAbL07kKAjlvDpAur7tkKG/VOpw2M1vzwDqCgzgsPk8PAGjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=iUpWgyO6; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="iUpWgyO6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hGl1XMWP7m9LCblVCLU09T28GTA5LM4hDdRwGsg9y6Y=; b=iUpWgyO6sRpXjb73idu7hIS72p
	9XdUzZacTUgSrP3DrA2UCPhGmejWKqV9dqZe5PAMCmIZNFv1ULVxUgKOSDX88opkHCVyuQu49H/KQ
	KjJxmCaHBNYwJz3mGHDJPgM1UCBYRWCu19mhlzzTne3bdAZdb3yswFQw7ZcFCtcfmaPqOXGxTJQCF
	T0RAjOmqJvbCzf0XDH3ZKYdMwcmzdX2C8ILflbbfEjoNL9lq+z4Y7U3gD4L5JIRePHGBbDHS7+vf6
	GDefEoJgmNdWQU0WH7gY8+Ile4nt+WFiZ16iKYhY33hVd1yoKWqBF8Cur7sX6a6IOTVeTKJDm4XuG
	rluOAbFg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w9bDO-0000000DtKY-2HV8;
	Mon, 06 Apr 2026 04:05:30 +0000
Date: Mon, 6 Apr 2026 05:05:30 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: fs/dcache.c: bogus comment re LIST_POISON2 around __d_drop()
Message-ID: <20260406040530.GX3836593@ZenIV>
References: <20260405190402.GV3836593@ZenIV>
 <177544136061.1474915.4475662411738222301@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177544136061.1474915.4475662411738222301@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Apr 06, 2026 at 12:09:20PM +1000, NeilBrown wrote:

> It might be help to add *why* it doesn't.  Presumably this is an
> optimisation for when the dentry will soon be added into a different
> list.  There is no point setting pprev when it will soon be set to
> something else while the lock is still held.
> Do we know that the compiler won't work out this optimisation itself?

Er...  Neil, it was your patch in the first place ;-)  I realize that this
was over 8 years ago; for context see 61647823aa92.  The short version of
the story: we want to avoid a window during d_move() when d_unhashed()
(actually, d_unlinked()) called without ->d_lock would give false
positives.
