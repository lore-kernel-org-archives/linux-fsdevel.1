Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36356307494;
	Mon, 27 Apr 2026 11:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777289706; cv=none; b=smB5TGZfZUWbOHrUHWRMJKTZZG/dprlOV7HDnYvUnBGTVZEwmzA8zq0osicV+fXdj2BUgsthlM5zbCSOVkenGw/vI3iDJ52+SlnOTLVbCQG0lC2CfplUWHK9qbMqxEnKT7UszuSWP85ruH7rZAj7H94rO5Z9r8WLH+QL/vp+Bm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777289706; c=relaxed/simple;
	bh=H1dHoAM4HOsOpa5Ljr+Nts3jk5x2j0G2BqulrmMIUcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDjaYcvBlksrJB7YA68mWYlLF6vpNcBuVHcKD6tKYTuMuP4LWyH4s2ifJk5vG8WEwhZk7bJ8XyfNLI7XjDdOCL69Pz25GG9qMogLNXbz/nEeTFHQ+S8y+3QH1fz1ou8CxqWmEHYiWQxB4DCAVBrs6XJb0ND1/Gjt9j0Q0rEF3+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=b79Pn0kp; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="b79Pn0kp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=/ZJjWYJEBe1j1UXPI8uSHg2lT/Aimpgb4SQ8c8oJ6jA=; 
	b=b79Pn0kpRLWY/63lVphIcJgh81kotGsdlZabp4Xawl8+qSo1+NyzQJlU7kvoemOpWdTgKzGwI/t
	wgi7LvUnMco4NLM3YDYRuTIXCLFLXnlakiNmfixEnHk40bpq1Tgt9Z/U/9ZIhMnM9qf996SCAuvsR
	dNfwHFO8iOzWKgZXE66RzCJ3AI2hgHED3cCtJqIKwSXkIWRXrzTryrslEEAfS3EHb79OzSa7VLEs+
	vX44zlPEoW1prpUwCtGlBKdYIwj5CCdNDIdeSiAGi45+/N/fLLTwedF6YCoU5y1B54omfBBHdu0pE
	56+D43ZBZoy2O3QsMsBTydxB+6ENaKhSASfw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wHKEl-0099Ag-20;
	Mon, 27 Apr 2026 19:34:52 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 27 Apr 2026 19:34:51 +0800
Date: Mon, 27 Apr 2026 19:34:51 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, Thomas Graf <tgraf@suug.ch>,
	Vlastimil Babka <vbabka@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	syzbot+5af806780f38a5fe691f@syzkaller.appspotmail.com,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH] rhashtable: give each instance its own lockdep class
Message-ID: <ae9J29Tjq7wuICT5@gondor.apana.org.au>
References: <20260427-work-rhashtable-lockdep-v1-1-f69e8bd91cb2@kernel.org>
 <20260427043149.e8fe46494d92d561175861ca@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427043149.e8fe46494d92d561175861ca@linux-foundation.org>

On Mon, Apr 27, 2026 at 04:31:49AM -0700, Andrew Morton wrote:
>
> Is this related to https://lore.kernel.org/202604211323.fac1b29e-lkp@intel.com
> 
> Are we able to identify a Fixes: target?
> 
> In the above-linked thread Herbert had
> Fixes: c6307674ed82 ("mm: kvmalloc: add non-blocking support for vmalloc")

I think they're two separate issues.  The addition of non-blocking
support triggered the vfree while atomic issue, while the lockdep
splat is simply due to the use of rhashtable in fs/core.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
