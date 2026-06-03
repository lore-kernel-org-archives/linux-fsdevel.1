Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE0D407CE2
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 08:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780474182; cv=none; b=WHIkZol7W79yKScTevJBeYWtYLluBNgbluv+5H6L6GcP7WCQVqNv0yNDuJL2jh9GxUihHN5qtEOKmuLkpgaAHIxMkL6oflSNpuoNp5seyH//xouUIeB+PSXBZe76HkVw0eEw+4/rn38LsWN3moDGgLSAK/eBNG4wDhRKSCp227A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780474182; c=relaxed/simple;
	bh=5s+7uVqEpDGZTPTC+yb19t5vL1xF3cmzFRBvQRsrfTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0hqVPqHoY+zyb3N2nzXXp+w9vbIj3fcA/aV5svDst+dtEEfzlO1Qo4aajrotejrSct73zrBAsfg1OB/ZcG8CP3rWjynotFgoses4HEjJWCaPX0l/jSR8uMB4ffKD8L8MF19fLjoIW7X0i2rzVUhEzPnFflHYsRkQeqsHLmod1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmMaYfmM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmMaYfmM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002F81F00893;
	Wed,  3 Jun 2026 08:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780474181;
	bh=jQc5iLUzstdKBxpmTn+A2FF3xOPRB25Unp5WlO+5Ib4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BmMaYfmMVHIGAYvqWTuezbkVWWeeTjphU6uaweVp9yq80wS2yB+PeM96y2rv1ycPE
	 NBVf5I65HmPlZbNKQZQJOcRhg7+1UFo9yDrdG6Hb+99Xsa7O9TxpzUg4EhrI+6aDA3
	 xpNFrAfqAfMBJQ+ulgt4KLGUINp0w/LJzoTLojm8zIwHJgwYnKMEZI2CbiZ4Wz7b/J
	 5h7AWNsCHvakuBIVB8R5Sq2N7hQmkUXQjMwAzOb+qKQxvS9dJ64AKYd4uBShUGzk0p
	 gVXUV6S3q7g0kLfER0uFwEdRiMijeU/KYvV3VxfrHa9QkfRgBpLvBSQGZJcAN/08T3
	 VKitapCHFL5/w==
Date: Wed, 3 Jun 2026 10:09:37 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 1/3] get rid of impossible checks in
 detach_attrs()/configfs_detach_item()
Message-ID: <20260603-lausbub-meerjungfrau-hierher-272084648719@brauner>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260603074815.3033766-1-viro@zeniv.linux.org.uk>
 <20260603074815.3033766-3-viro@zeniv.linux.org.uk>
 <20260603075340.GU2636677@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260603075340.GU2636677@ZenIV>

On Wed, Jun 03, 2026 at 08:53:40AM +0100, Al Viro wrote:
> 	Argh...  Please disregard the 1--3/3 part of the thread -
> I've missed the stale (and really ancient - it is from back in
> 2019) files sitting around.  Sorry, should've checked what the glob
> had expanded to... ;-/

I'm more worried about what time it is where you currently are... ;)
