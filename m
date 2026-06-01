Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C45343884;
	Mon,  1 Jun 2026 08:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302846; cv=none; b=eONaPgkunYhxZ9uvdxv+Lo7Ha4uNkb5jcyrhmS39XuwKq+7J/vtsdIVh7gN11DTPk4b1znU4XxVfMfZejg5QPeHFe35EuhLbeQTP0OWktz7wyRXF4oW9AQbrSHA108tnyt1LXIpKkJ+dZm3S06IjmUmrQlRtS65Q9ShJ9Je3SdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302846; c=relaxed/simple;
	bh=AltAPJcfXfD5rPwbxWGz0cnk7SQB5oAhxX9NMTZ/uTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HO6Yvgwo3GNc8NhMfK2xEYGs2ZSM+as+EGvZZsN8xdkAM1MbePSxjHz5XUnKqx4L3XY8nWA5P/jQljzm8enQqnsLkFDN+XYn8i1Fz4vxm/YU4/TXOSw6sbzVHLCoxNQYM0uFiZ+MIeLJpJE4IhBrf7TzOr5denJ68r5zhZLaAzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXftPvFa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXftPvFa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F9D1F00893;
	Mon,  1 Jun 2026 08:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780302845;
	bh=wiTClsOVSwfu9VvftExmoMrZ2cWgx+kZ+kOPgJ/Qv/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CXftPvFaiZwnbZbbHShsnTN4L0B5W4IrTBJ29qVbhhvlXdQM6DLVoBZUGyjRLfuQd
	 Ufoc9yi6e/6XFngBSfsUC+B1mrc82WduoFl+JqsRZUrBBDPTO6MjTXk/WnkL2SgbPX
	 wH7Tp07EIw5F35piYK82HmjuQC3enpLjZj2bM1KMpF/3tVk28mRpCiRRpUFSsNsEtm
	 zMTiKSKdEVIuu7SyE0jfQgMhUJvUgIMQgR7ygEZBXIG21d0Zz2XSDdrAdY3wZ1JTw8
	 8MjE+g98tl0vvyAu8dRBSDj/HCsuSlMiGiXWSq0ZDJZhrnDNz15yLBRVfLmNVw/3N/
	 mBhCJ2F+swj0A==
Date: Mon, 1 Jun 2026 09:33:57 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, liam@infradead.org, jgg@ziepe.ca, 
	leon@kernel.org, david@kernel.org, shuah@kernel.org, vbabka@kernel.org, 
	jannh@google.com, pfalcato@suse.de, balbirs@nvidia.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, linux-kselftest@vger.kernel.org, 
	usama.arif@linux.dev, ryan.roberts@arm.com, anshuman.khandual@arm.com
Subject: Re: [PATCH v2 0/2] mm/hmm: A fix and a selftest
Message-ID: <ah1D1Qs4fPnO5sH2@lucifer>
References: <20260530085413.1270139-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530085413.1270139-1-dev.jain@arm.com>

On Sat, May 30, 2026 at 08:54:10AM +0000, Dev Jain wrote:
> Patch 1 fixes a stale warning present from the time when only migration
> softleaf entries were supported at the PMD level.
>
> Patch 2 adds some code into hmm-tests.c which exercises the pagemap path
> for PMD device-private entries.

Thanks!

FYI running the HMM tests locally I ran into a nasty issue that I sent a patch
for [0]!

[0]: https://lore.kernel.org/linux-mm/20260601083044.57132-1-ljs@kernel.org/

Cheers, Lorenzo

>
> ---
> Applies on mm-unstable (404fb4f38e8f).
>
> Dev Jain (2):
>   fs/proc/task_mmu: do not warn on seeing non-migration pmd entry
>   selftests/mm/hmm-tests: test pagemap reads of PMD device-private
>     entries
>
>  fs/proc/task_mmu.c                     |  1 -
>  tools/testing/selftests/mm/hmm-tests.c | 29 ++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+), 1 deletion(-)
>
> --
> 2.43.0
>
