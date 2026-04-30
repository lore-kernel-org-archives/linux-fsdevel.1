Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABAD3AEF2F;
	Thu, 30 Apr 2026 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777560921; cv=none; b=fKIrxiBDg8zZbEvvx2orKbaXzzUSv2VqOpSd9lkeD57XsM8zgwxO0q1g8H+D6+ALktr6h5oLf8xYidJvDzyAgERSg/eOwTvtXowbsl7vc4ySXJkkvYUEMYP81tx+PcHg73S2qokww7BCTKASRcu8Xvu49MHAQTx8tc58sX0CErI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777560921; c=relaxed/simple;
	bh=LYmcweuukRQSiowb4Wlkm+2NNgyqTmW4tC+OVlEEIrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAV2TqSeqnzHnTEpxtZRSC4JhujkgZv8PT94JeXQ16k21cZymWQm6oj6Ko2RzBLuXKG8OOkDJWvtEsY8af80kYB/PlBEFNGuDAueDqG7ZmkSP0t6h6BlYL1dsO6MiAl4FI680mAfeuEK8pOV6nHI9yZwXGEoI2Xr3q9dGjr6lo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaNPcTuZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaNPcTuZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7973C2BCB3;
	Thu, 30 Apr 2026 14:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777560921;
	bh=LYmcweuukRQSiowb4Wlkm+2NNgyqTmW4tC+OVlEEIrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IaNPcTuZw7TviLU9kqCN04Z0RsJFwDtuEt3pWjHMe/ci53A6HJEgeqthZsBzvCBOd
	 WDHIyd3xbb/8CwxrmUxDRiOSWeBcOyD+9mO6sV6v8BVdfIET6ZP/rWwerc0LLyLM7l
	 pU8RRSDeQJvoGM5ZpZ20fxZxCRk4PoStUDVEGEGWu5MacJGwk862NOHr7kEGwupd6b
	 W7MUMm8hVfY1I4c9KNzpy4DqExjWrqND91EsmSzgeTR7+k/jCScHo13bK+Pc1uCpJX
	 wLMS7kh/wpyYYcoC4XS/NB+kAyQi+DfbZ1Y7D3PfTO8mtlPXzqS9du1ADeB1FMog9u
	 5RWDOv0pDnKNg==
Date: Thu, 30 Apr 2026 16:55:10 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Peter Xu <peterx@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/2] userfaultfd: merge fs/userfaultfd.c into
 mm/userfaultfd.c
Message-ID: <afNtTgHny2HC1kLP@kernel.org>
References: <20260430113512.115938-1-rppt@kernel.org>
 <d5f17a01-4504-4a7b-b58d-c183cedc37f1@kernel.org>
 <b31e1b5e-511b-4213-a8f8-d9721959d709@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b31e1b5e-511b-4213-a8f8-d9721959d709@kernel.org>

On Thu, Apr 30, 2026 at 04:23:08PM +0200, David Hildenbrand (Arm) wrote:
> On 4/30/26 13:38, David Hildenbrand (Arm) wrote:
> > On 4/30/26 13:35, Mike Rapoport wrote:
> >> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >>
> >> Hi,
> >>
> >> These patches merge fs/userfaultfd.c into mm/userfaultfd.c and make
> >> functions used only inside mm/userfaultfd.c static.
> > 
> > Yeah, makes sense to me!
> > 
> 
> Thinking about this, is it reasonable that the kconfig stuff stays in fs/ ?

Nope, missed that.
 
> -- 
> Cheers,
> 
> David

-- 
Sincerely yours,
Mike.
