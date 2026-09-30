Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AECF4D796E
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790783001; cv=none; b=CE7BPqHs+Casa9wiHhSPq2AhQdCf1aKINiW+rBDsdcHqoH6qbC3KXL6mWtQawphhCP9miA9GRgEvx9578y0NuFFJrZ9F7MJABkdrYJuoXM9zOlbnJBXW2pAppYhQPPsPwsYD9PfcmEO2ljqWLU4V3eNIFWEk0l9tq196mc4RfMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790783001; c=relaxed/simple;
	bh=SsK5FODFHiWcJT9sigPvRg3BRnqFfkTLRzG7haLebAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CklZTohjrOd9gaKWxawEiN/+Dg5/wK1UfhLC/sxlZWlypj/PNRiN7TONXep7kaPT46G8oqU6kdcTyeEOz4VoDR2UgTnx4U/J9ie5bToAG1UqHCHO+beQ+grt62ZEB8z061oAjirnxqwE7lQQVjesOnybzV45mPeRvQW0z4cfjmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HynggV0O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HynggV0O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785D71F000FF;
	Wed, 30 Sep 2026 15:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790782998;
	bh=SsK5FODFHiWcJT9sigPvRg3BRnqFfkTLRzG7haLebAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HynggV0OlK5OMJTerhRL2PbQvJ7glPgIzXslMxgR+4LGyqLHaaq+azuzN08qqg8Jt
	 iwv8XlNRyutecVHp6xk5uXnEie/c/8qjtfELhhIBgE14G27hxuhRVvBPTM9Es39JMH
	 WXtleGTz3qGOHHv/TRvJb4HH4fO5BcyekTzxyeUojLZ6GwsGf4S7diN8IfkXR2jy3Z
	 HHjEFL923B9+ZZ63VPrkPELm/fGD5jUEQDrvYIjw5/xRyQFvJnKnwEMZR3t1mYAORn
	 DKJGXUAzjdUkLrukd5WDdWn9RB8awVqYzkYPnYTFrtpWAWg8IWLGo6O4pDixonHrqF
	 Cqc29YIaR1KSg==
Date: Wed, 30 Sep 2026 16:43:13 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: =?utf-8?B?5aSp54u8?= <rockeet@gmail.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC] madvise: best-effort deferred writeback for shared file
 mappings
Message-ID: <ar0r3QnZWzHdJt6Q@gremlin>
References: <CAAE3jtfeKJLSypScqRAEEgvO8En5kJfpbcFn5X+LQ2YL+xz_vA@mail.gmail.com>
 <85aff663-2131-47da-ac04-8f0799a49b91@kernel.org>
 <CAAE3jtcRQ407P9LTbg=JOwhABQRViSaq2XBefnDdNWiD7PxvUg@mail.gmail.com>
 <1ce9cf3a-15dc-4815-ba29-2e22b05206fb@kernel.org>
 <art8EKRKMdwSDCkr@gremlin>
 <CAAE3jtftxMkCfWJ77W-xvV2x7jdAN8C8kyofYC3fEivM-Cq6UQ@mail.gmail.com>
 <arz0auULA33fqoWu@gremlin>
 <arz8Plu6J4YOTi0a@gremlin>
 <CAAE3jtcanTUrV3xfofwrvYGCFe5o=Vn7gS66bDzuxzeGg6c5=Q@mail.gmail.com>
 <CAAE3jtdHi7aSsJ62TpEjkxvwA-3TBLvr5i1ohCNg2aupND+_XQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAE3jtdHi7aSsJ62TpEjkxvwA-3TBLvr5i1ohCNg2aupND+_XQ@mail.gmail.com>

On Wed, Sep 30, 2026 at 11:29:09PM +0800, 天狼 wrote:
> Hi David, Lorenzo,
...
> Per-file deferred writeback would require minimal kernel changes and pose
> a very low risk, while offering enormous benefits.

I'm afraid the opposite is true.

The proposed expiry hint does nothing as soon as you hit the dirty background
threshold and in any case violates kernel writeback as explained.

And nothing you've proposed here is upstreamable.

A locked down simple process handing out memfds (as explained in detail in
other mail) or a named tmpfs file survives process crash perfectly fine and is
the correct shape of the solution.

This is what you should pursue.

--
Cheers, Lorenzo
