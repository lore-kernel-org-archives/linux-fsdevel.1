Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00B02652A2;
	Thu, 18 Jun 2026 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781793030; cv=none; b=R0k7u5HhsSq6LbLuyFLfNEcsPuepMomdZegYPn5haIvOoHL/5GPfcnBbAn7w+79AzBEcS3OhpbdOn+l44L/zKOkSbLinuv6lEAtKjER3bVckotX7Zk+i2pMgUX3bMZU64RQiFwwdEGS2WstjKWt7LoWJL3yODiS9m/o8K8e0j98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781793030; c=relaxed/simple;
	bh=7vtR+TjrpHHmFHags4WZ6+/5p5KaBqxoHk0CbYvy0rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4DorbsBKIHqZEKQN4wbcSUrDMv91RTYDGT5T/qD2Ai9ZdN2ieMJMloF5auTfdH46xzl30usudziW7i/VVJyhF53nyukXgnOg8o4doV/4DTtw/Ja1Ri4xpq+38wbNYxOEWpNoQqacCRB2wqJ+cIZuh0IjX+iNsFr4fzc6JdbPpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmvOiCQm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmvOiCQm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB111F000E9;
	Thu, 18 Jun 2026 14:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781793029;
	bh=7vtR+TjrpHHmFHags4WZ6+/5p5KaBqxoHk0CbYvy0rs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YmvOiCQmVodx2octUGvCQzdDxtNKbcJlmIqTU4tmDqF0lCZuux41OQnmCaMdopaax
	 w3IWmQ+RS2UlAZ8d1rT5f5EG4J+UhpKlNTDxSjIfmQEpl9yQIiJojIhFrnzsQuutWa
	 vkIz0VwtfcUx+OTEwIW0PYUS/iLM1Rwrz/oOthBVg/BwV8zubvXY3+WyBtOnHWZjA9
	 I2rZUYCXlCMhDxirUaziR5SJVUn8H4W+ilrHJ3/L85Q+h/2LCW4csITCJHi3h5SEps
	 f0F4DZyNHwhfvcKgc56CSWIyioxXDBsUvwxRUsCNAHedjurK91mKzuhq5i7bYn3Srz
	 YJAAOfMTFS3yA==
Date: Thu, 18 Jun 2026 15:30:22 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: kernel test robot <oliver.sang@intel.com>, 
	Frederick Mayle <fmayle@google.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Andrew Morton <akpm@linux-foundation.org>, Kalesh Singh <kaleshsingh@google.com>, 
	David Hildenbrand <david@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Suren Baghdasaryan <surenb@google.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [linux-next:master] [mm]  7b32f64bc5:
 pts.svt-av1.Preset13.Bosphorus4K.frames_per_second 45.8% regression
Message-ID: <ajP_-zqVPtbzvc9j@lucifer>
References: <202606181547.617a6967-lkp@intel.com>
 <6z2rqmo7b6m2rdhqurspwya25ps4dj7lctdygnmq3rn4xt6h3i@57kiiy72epgd>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6z2rqmo7b6m2rdhqurspwya25ps4dj7lctdygnmq3rn4xt6h3i@57kiiy72epgd>

On Thu, Jun 18, 2026 at 11:30:47AM +0200, Jan Kara wrote:
> On Thu 18-06-26 16:00:42, kernel test robot wrote:
> > Hello,
> >
> > kernel test robot noticed a 45.8% regression of pts.svt-av1.Preset13.Bosphorus4K.frames_per_second on:
>
> This one looks serious enough and real. It would be good to figure out what
> happens in this benchmark that it benefits from the readahead across VMA
> boundaries so much...

I think a revert first no? This seems pretty huge for something that isn't key
to the kernel, then a new attempt can be tried with this issue addressed
perhaps?

I seem to recall objecting to this in the past, had a look around and saw [0]
which has some discussion I think specifically on the VMA boundaries thing.

[0]:https://lore.kernel.org/linux-mm/CAC_TJvfG8GcwG_2w1o6GOTZS8tfEx2h9A91qsenYfYsX8Te=Bg@mail.gmail.com/

(Sorry to be naggy buuut :) - I see there wasn't maintainer [Matthew] signoff on
this, we should really be in the habit of _requiring_ that for merge).

Thanks, Lorenzo
