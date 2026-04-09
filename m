Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D759A37EFFC
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 08:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775723456; cv=none; b=beZhjZX9GZ/O8503WAeZcU5cMaltNg1eM2lAv4AwQ5oPH0koBoZ15ez3nTjS6wWka+PqisewzF5jgQulCyAITopQr9Akaqhnz/SwWtNyU1zlOBB61m5CTuQkmINDtyi4Xr3Jtx+0aLlagz5lXeDNJnby090SZEoAfEXvYAuxzlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775723456; c=relaxed/simple;
	bh=w7+WQEPdZAbaIeNUWLI05wldYgx//0og0LMFZyzUjgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bO9Ux3yc7z9XMHLBpRcx8kvG54GdSKOMJhjmDHFJi5i3FSJxIF4v66AkIuQjmLQ7EupKosZmK9h7NR0GUT/skrcYeypQuXcpZHAM390GKOWL7Cpe1gZAkYZ+hDbLgyDPJxFHxHtkImGJZfkF1Vm7mSVxnVEdfykXq+MpsoNNdrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ruokKZdC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ruokKZdC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557F8C4CEF7;
	Thu,  9 Apr 2026 08:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775723456;
	bh=w7+WQEPdZAbaIeNUWLI05wldYgx//0og0LMFZyzUjgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ruokKZdCmJx7L5SIx8dUn8jgqp0U92ztzhYLlfLOqemt50nL01wCCr87saOVWQkRn
	 ipR56g2gMUyn7hp5+Eg+kRgPjjm5gs9mbHMTLD6GflZ0s7PnS91k99hm9zGOpRFz4F
	 JyYlNHF8Lq5fGjKdsebU+Pvd/wITCV25iGAxMFCH97JBmmWGKHPhk35PvUdWbNkED/
	 8+ct838P5EjqYeOX4zufsxjdQfkPyVX433K0rQWltCB8+3McXZNSV4fI1fGyFMFOKv
	 ZyN+vXRT8msUUf4WC4sEJuglCnHfUfpgzR+ceWRNb6RdYszyVIyVRorxDRUvuPAOHC
	 252EmDm7wALmQ==
Date: Thu, 9 Apr 2026 09:30:51 +0100
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
Message-ID: <addjLJ9MVTNQD7YZ@lucifer>
References: <20260409063503.3475420-1-wangkefeng.wang@huawei.com>
 <addP4MKmA8zfSN1o@tiehlicka>
 <dbb92553-58ba-42e1-b7df-b8450bd69d33@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbb92553-58ba-42e1-b7df-b8450bd69d33@huawei.com>

On Thu, Apr 09, 2026 at 04:08:37PM +0800, Kefeng Wang wrote:
> On 4/9/2026 3:06 PM, Michal Hocko wrote:
> > Quite honestly drop_caches is not the best interface to build any new
> > functionality on top of. It has backfired a lot in the past and we have
> > tried to make it extra clear that this should be used for debugging
> > purposes only. Extending it further sounds like a bad step.
>
> I am not clear about this history of this interface, but some of our
> products do use this interface :(

All the more reason for us not to add another one like it...!
