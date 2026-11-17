Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.9.28.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794880839;
	b=2BCnUxCTL13kbGqt1esU5OREkQnzo0BG4sNeWLQ5yh8uWqDt80d+nP7k0a8bhCjleWTO
	 jvVdgE+9XQyGRIz/3MhLNjez7QEeEEaCkrrNF+ICsQp9aXp9DEBpCVRUK4b6mV3fEUuy1
	 RLz81AcmVbZrRHLpX0VB7i+QH2OzmpOTrHYnZbVgKCee4o23jFDJkov+Jgya1mdyCnT+4
	 /YB7VuIM3PxOn0mtTst2nQXT6M/7bChm6AN3ybd1pWXO9DFuZervRpg2NVGQM4C/KyhHt
	 NV/zZkoG6n4oXbTfMMPrxXVLCTBVhFWNsbHwNg9BueH7aGmPlOZW3BBH1vwyqNBsWow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794880839;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=VkLy1I0kQBdGGFa3JjJKMLWd5KGqUrPpkyuEnh2673M=;
	b=Qxpe1IuZKoHUj9H61yGnbtQOHati6sZo09D9MEiAoFS2M6bPyA/gQiXXIMwcCTiKwxZL
	 8rubDYQFy0PBVT4SBwIILKHN9RSaLbdS6uw54qoMuuN4uUs1SefZSE+7MAtwx8jwFOZbG
	 ZHnmFP7Pmvkt24oG9AEHQZTi00ByvwQNYNaDNO9zghVXaz5seOndfT08bbwCT83kfD55t
	 EqaljrzqwHWgdESgoZy9lJUXqFVKyxAoZt8OCqFXQuZ99SkVqdsr4qrGNWMg8xmnpHvf8
	 1hDo+MpQRFAJ/gF4kd9dicL/PYBAATLhrydvyWoJqp6r/u9HtMcz2r+65iYiyhr1pWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mit.edu;
	spf=pass smtp.mailfrom=mit.edu;
	dkim=pass header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=WcdmYwdK;
	arc=none smtp.remote-ip=18.9.28.11
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6122A606A32A
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 02:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6122A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=WcdmYwdK
Received: from macsyma.thunk.org (c-73-9-28-129.hsd1.il.comcast.net [73.9.28.129])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 6AH206Us030545
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 21:00:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1794880810; bh=VkLy1I0kQBdGGFa3JjJKMLWd5KGqUrPpkyuEnh2673M=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=WcdmYwdK/b8BiflVThD+QvJau9tSH5SE0/LeO3ZvbLeNGt+w+JTi/Sr5h1QYXdwCh
	 vhh9bZBTJSX81ajwsFfm/ZzCNVwpLM7Ygihz39Mp+HA7wL8H08KTMUTikdKbdbw4S6
	 dzV1+AsWE6sRU7DAAHFtAJMpCI05dgkmvBsM2wbQW3z+VveeYwsd3iNai6Ra12arfc
	 /t5e+iRwK4fGFR8U55PGXmcJ/qCDk9aClAg/19fUSu+QZ8EVn7/0vQ41Uo20BYoI3F
	 xLegQQAOPNKf4IxmHDG7ZoqFdE5Z42UnsoUpXFg7XPHQdS8xTuOhoFKvg31cIwn6ou
	 6J19UUH4mLIIg==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 8394627BABE9; Mon, 16 Nov 2026 21:00:06 -0500 (EST)
Date: Mon, 16 Nov 2026 21:00:06 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: Sarthak Kukreti <sarthakkukreti@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.co.uk>,
        Eric Biggers <ebiggers@google.com>, Dmitry Torokhov <dtor@google.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] libfs: reject casefolded names that fold to ".",
 "..", or empty
Message-ID: <avu0X5E298dHRBHY@mit.edu>
References: <20261113065332.929085-1-sarthakkukreti@google.com>
 <20261113065332.929085-2-sarthakkukreti@google.com>
 <878q2swoxp.fsf@cartola>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878q2swoxp.fsf@cartola>

On Mon, Nov 16, 2026 at 02:34:26PM -0500, Gabriel Krisman Bertazi wrote:
> Either way, this issue is another example of why treating ignorable code
> points as 0-length strings was a bad idea.  I'd very much rather
> utf8_casefold would treat all ignorable code points as foldable to
> themselves, (i.e. commit 5c26d2f1d3f5 ("unicode: Don't special case
> ignorable code points")), but that was tried and broke applications
> that relied on variant selectors code-points being ignored.

Sigh... I really think these characters are *evil*.  I wonder if we
should simply drop those code points unconditionally when they are fed
to the kernel --- not only folding to themselves, but *not* preserving
them when a misguided application tries to create a file with one of
these misbegotten Unicode charactesr.

I'd prefer to simply reject creating them with an EINVAL, but it's
likely that will break those stupid applications....

Eventually we can have e2fsck offer to fix directories with those
characters, and eventually we can make these characters become a bad
memory.

The other question is what *other* evil misdesigns are in the unicode
spec that we should be preactively trying to addressw hile we're at it?

     	     	       		   	     - Ted
