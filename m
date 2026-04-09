Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4993378D89
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 08:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775723265; cv=none; b=CGtmvGMnArANWNh4Ek1atis1rBU5jHP7bYL5RUc7Vm6PZu9DGSLYNGk8mQtGIVF6n8YlzhcLc1IVjtPX2wGVxgIFvPnkpTFUy4xteGdDZMEHQbVGoLK+cMGw584zLPnktJa+QcY7gk86XLtw9kiOGPSX7AQLypnN7kuZ/YDqbiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775723265; c=relaxed/simple;
	bh=XOLbiyFZ6yUTc+lvkxPmguuF+R5YrtfocWqBWRVawTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9id62XDsISTReUeHer1DDckLki6+7q1icWpHp0NE364zwLdsij5nId7br0ocQw+AG0QczY4GDRHZWYl9uZYwKjb3gSy0sPkEaGOdtFff5MrFvZ1lXcT4adM5+wiUg7IE5EFn2aQj4QoHsTkh6B71l79QAfi/sBD1CrPVU5K32k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDjVTAIi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDjVTAIi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F0AC4CEF7;
	Thu,  9 Apr 2026 08:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775723265;
	bh=XOLbiyFZ6yUTc+lvkxPmguuF+R5YrtfocWqBWRVawTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DDjVTAIip4E5V92VROBLPSNEdCRwyYe7VvOXqlsaszBjwomvTUkfdwYa1WVb8oO7a
	 Tzb1od3eGe+AysPGY6/Dv0kx+EQT8nHOWUr2CdAumZOap50cHVsAvhV6g2vE/X2iEC
	 3AqSDNRKX4otwBgcIh6cVZtLMtB8Qehn+pXh2bXQNVZ+VshbERf9HhuNuQqodsSrFZ
	 AcZWCVEJ8yuJZ0dKUcLrI3MBowViBvmIuFi8U6YN9ghjHFE65x0bSMobAJuQtvA/fk
	 Pjb7TBluBzfgyNVOcASwY3MBDd+EVSLLRp2PvyM+K1D7GvSDdyN3zsVIsd7nh+K8Ok
	 3hgNqLlysNMtA==
Date: Thu, 9 Apr 2026 09:27:40 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Michal Hocko <mhocko@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH RFC] fs: drop_caches: introduce per-node drop_caches
 interface
Message-ID: <addiCaDKTWYge-3R@lucifer>
References: <20260409063503.3475420-1-wangkefeng.wang@huawei.com>
 <addP4MKmA8zfSN1o@tiehlicka>
 <addRr9Vn_LNiXp11@lucifer>
 <f8eec130-efe5-4e08-b5b4-a9701ccc7056@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8eec130-efe5-4e08-b5b4-a9701ccc7056@huawei.com>

On Thu, Apr 09, 2026 at 04:21:43PM +0800, Kefeng Wang wrote:
> Our use case is as follows, for hot-pluggable nodes, for anon pages,
> migrating them to other nodes, but for pagecaches, just evicting them
> since pages could be refaulted. For mem-tiering, a large amount of cold
> memory is stored in the low tier, we think that evicting pagecache is
> better than migrating them back to high tier, also this avoid the risk
> of accessing potentially faulty memory.

Hmm, this feels like it should be a heuristic in mm rather than something people
are manually triggering by writing to a file?

I'm not sure I'm OK with us allowing people to manipulate core mm page cache
state for non-debug/synthetic perf analysis reasons.

Cheers, Lorenzo
