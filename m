Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816BC42586C;
	Thu, 16 Jul 2026 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784209718; cv=none; b=gRLd4c6awED9+sDJsfLVMWzIJ3Di+Mvp2+0fZWHxAYT5ZOtJHwEiyMAjuOOiyZFubpp0GkYT5kbu77F7Ownkl8pKIbPknShKgW9+WZ8SA6RrtszmaC+SD5ytubezN+WNse0GVHfTADOmqEAPdyTkamh0FLqOvq/Dlm0+D9LNOfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784209718; c=relaxed/simple;
	bh=HD12P3t/fBJLa16CCl2JSPV68XrmBTcICXjHN44zzxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kajYTQrSY/sm3XvQyxuy8xvQN35ohg8S6lgUX9JnA64zzT5V3/F9leqQu9RW26XFhYRcO6SNAoqdAKQ/ZkX2L9iMAdFv03of4Q+tM72/DRTSeSoom/KSSkMAxgANlhq7YKgWve+bb4hxHGeyP+zPCOcHIp9wHLMDCzNJJkBT5zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vw6wLQEi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vw6wLQEi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77D31F00ACA;
	Thu, 16 Jul 2026 13:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784209706;
	bh=688ykzG8ykPiM0npkBRxxK87841vXMSxY8kc1hKMOxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vw6wLQEiSYMMzvpHWNRYt+3s4FDZunFyyV5t8QSapGHwdOhsx77TqN+bQNN/7FMEb
	 L4GQgT4YO+vgjsmgBgdlJoVoQ5ZTswchVmEhk5RFQAHrVxr/b6PH9oN5nBy9dgGlbt
	 dSvlgfGIR3yl0s/aQVSi6WTTjE3Kyw7dsElMXq7CaCIKdmBRp8bRnb3ZnSD1hlJsDx
	 E3Shg91EctjhSOsnfJaxcg5IQOeFJ67cr/t30QEEQnQRQAGAtgl0NC0qGRQ6JmrPn5
	 hEhM+hu9x8pLt6UFbvfDoJm6yd8sUGeKX7E8Vs6lhu/lZt7cPVlykVglllQaXLyMS0
	 cRFOKSMgrYgdg==
Date: Thu, 16 Jul 2026 14:48:11 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] mm/mseal: further cleanups
Message-ID: <aljhBBTRUtLs-N76@lucifer>
References: <20260716-mseal-fixups-v1-0-3a9609bf041b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716-mseal-fixups-v1-0-3a9609bf041b@kernel.org>

On Thu, Jul 16, 2026 at 02:43:08PM +0100, Lorenzo Stoakes (ARM) wrote:
> The mseal implementation is still rather confusing, so tighten things up a
> little.
>
> The only user of do_mseal() outside of the system call is the MMAP_PAGE_ZERO
> process personality - retain better control over how mseal is utilised by
> providing mseal_mmap_page_zero() for this instead.
>
> The comments are overly long and confusion, so cut them down so they're a lot
> clearer.

s/confusion/confusing/ :)

>
> Remove confusing mm_struct params (mseal can not be used on remote mm's) and
> wrap the actual system call logic into the system call declaration.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
> Lorenzo Stoakes (ARM) (3):
>       mm/mseal: remove superfluous comments, fix confusion around mm
>       mm/mseal: limit scope of mseal address zero to address zero
>       mm/mseal: remove further superfluous comments, do_mseal()
>
>  fs/binfmt_elf.c    |   7 +--
>  include/linux/mm.h |   8 +--
>  mm/mseal.c         | 156 ++++++++++++++++++-----------------------------------
>  3 files changed, 56 insertions(+), 115 deletions(-)
> ---
> base-commit: 59c684a9908d2e6f7a791f7f033eae57ec2b3a61
> change-id: 20260716-mseal-fixups-131ad0939de2
>
> Cheers,
> --
> Lorenzo Stoakes (ARM) <ljs@kernel.org>
>
