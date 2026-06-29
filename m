Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F160E33B961;
	Mon, 29 Jun 2026 10:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782729349; cv=none; b=gwAsKQxI9kyQSk+Vt9rHY6lpy22Yrz+2Boow6ZxT0bphPWPZ11/gT2bL1YhcmOYsDRF2oPCGNOvy+dj+Xk1epJBvm/6VJlEaF7e3teb+2z1eVipKFHyBkTYAlI4iAWmt8Hwxl1K1aVXTK3NnwivcmNyQ8/wVTidyLjVOytaFMcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782729349; c=relaxed/simple;
	bh=oZKEgsAeSbUFcWNbYqqA+tqAigfpU6kxFl6/5tR87ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVBTgiPU/8rYKa+YIikMuzB/DM7V46F/2DKxLIKJzeTAoU52nChZv2IOC3PTyfp4RwV/zXvFFRFGMmIjn/aHc6k2I2Yg/VBAUBD961DhAfcrj3TERPnlY/2bv9dvjpSAzyeLqEuCAjPGKuXXkRPOo6PLcRys61XcNimXm6WFXHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKa10FBf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKa10FBf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1971F000E9;
	Mon, 29 Jun 2026 10:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782729348;
	bh=oZKEgsAeSbUFcWNbYqqA+tqAigfpU6kxFl6/5tR87ig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EKa10FBf0Q4RGAZAmqjlC0fIa+dP/+JGG7/kE4axKXYgB6hT9NCUClwF0SqLSUgiw
	 0ohRCRkT0gbZKnag0Tm94xuSWdRL9D44yPjlcmP9Zw1e4Jy+EW8SZqZOoZe2mnr0mQ
	 6h0sabOs9e8zOTT4g42Q8HxSHZiEVhO/N5SO+nILifZyWNxADGkCbOiGJp3zCy1IH+
	 dsTfu+8JafH0SNVpLac/SPfCFC+Li0l2ifyeUqi3Uux1mapzsYMOjkDQm0hcQ+T63A
	 PmBrOTU9B+xw6vnMlDZGW6yzSunCDQNSfQ0MGHHmevPBiqIy6N/qYY2IJba3A7LdoM
	 xYwt6sUiE4jzg==
Date: Mon, 29 Jun 2026 11:35:39 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: kernel test robot <oliver.sang@intel.com>, 
	Frederick Mayle <fmayle@google.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Andrew Morton <akpm@linux-foundation.org>, Kalesh Singh <kaleshsingh@google.com>, 
	David Hildenbrand <david@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Suren Baghdasaryan <surenb@google.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [linux-next:master] [mm]  7b32f64bc5:
 pts.svt-av1.Preset13.Bosphorus4K.frames_per_second 45.8% regression
Message-ID: <akJKSZQTvnUhkMWV@lucifer>
References: <202606181547.617a6967-lkp@intel.com>
 <6z2rqmo7b6m2rdhqurspwya25ps4dj7lctdygnmq3rn4xt6h3i@57kiiy72epgd>
 <ajP_-zqVPtbzvc9j@lucifer>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajP_-zqVPtbzvc9j@lucifer>

On Thu, Jun 18, 2026 at 03:30:28PM +0100, Lorenzo Stoakes wrote:
> (Sorry to be naggy buuut :) - I see there wasn't maintainer [Matthew] signoff on
> this, we should really be in the habit of _requiring_ that for merge).

To be clear this is no comment on importance or not of review - all feedback is
taken very seriously and I respect Jan's opinions _very_ highly indeed in
particular.

This was merely an administrative point.

Cheers, Lorenzo
