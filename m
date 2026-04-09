Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0BA35AC3B;
	Thu,  9 Apr 2026 15:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775747859; cv=none; b=AkSHqtmoWoE6P3n4ZkGZ4liUAAJ1ygq+1NJAMfiOKVZkApzlKezONyvxXdBI/kU59O3VbtnP/tN6IeKasfwJRpi/hIGCOxqCtyrE9J58ZvFt/Bk9pc3BAsG4KwexAaCWxzX3SWeEhxTjPiMhdOZrbG0+CuvcjCydgFWNDaRrYoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775747859; c=relaxed/simple;
	bh=sAn4kmA/v5fslLSRk7scPloEbnAS+gMCiSVeAY7naxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGe5pOAta8eZQw6QtfsFg8xpNug6MVnQVSoEOr5r72keUhHP3Hf7RIQfqHlNcZ58HIuMN5Bhv4S7dTNmfUQF8Q5m0bypO5Z8FlJT7d76KUFQR+JAOsd882sXjfVjNJkjryEPVhkr5KD88FFjvWMMXLtm8blP7VaZhJD7Im3QblM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qht0fFe/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qht0fFe/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926CFC19424;
	Thu,  9 Apr 2026 15:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775747859;
	bh=sAn4kmA/v5fslLSRk7scPloEbnAS+gMCiSVeAY7naxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qht0fFe/mAYbgemHSrTJUo++6CxWDoPmooLnV8Mh+eLdG0nRX6n9/3kNfXrV6fK6u
	 1IOsS72bzgsHmIjHQsmj6DxoD0K9xK8F+reRJx4L9gaTBzbkYf6VfezuwKZF/KpURX
	 pvpBEUbxTUQPfmb2WFB7KZWcFgNbRMw5kbbjtRbYrhz6xu448ViLBRW7fRq/8sw/5f
	 99kGM+McX3C63N32vBWaWN2FBEnxBCM61AA3iAzmQbf+YgB6jJLDp3qX9VeDL9aRDR
	 /h1GRhpWpMU+9nwBZlTNSMfqiUxIZ2WCbdPg2XlTs1P/yC7XPqvESzIz3OeKz13Lig
	 CYrrj9wd9kEsw==
Date: Thu, 9 Apr 2026 18:17:30 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: "Denis M. Karpov" <komlomal@gmail.com>, harry@kernel.org,
	akpm@linux-foundation.org, Liam.Howlett@oracle.com, ljs@kernel.org,
	vbabka@kernel.org, jannh@google.com, peterx@redhat.com,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, usama.arif@linux.dev
Subject: Re: [PATCH v2] userfaultfd: allow registration of ranges below
 mmap_min_addr
Message-ID: <adfDCpTH9n2lG63n@kernel.org>
References: <20260409103345.15044-1-komlomal@gmail.com>
 <d4xigmgectqbv5q5dxsrlunea3ynexa4ym4nuxy2rokrawsqu6@yfhzm3hl5nya>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4xigmgectqbv5q5dxsrlunea3ynexa4ym4nuxy2rokrawsqu6@yfhzm3hl5nya>

On Thu, Apr 09, 2026 at 01:30:07PM +0100, Pedro Falcato wrote:
> On Thu, Apr 09, 2026 at 01:33:45PM +0300, Denis M. Karpov wrote:
> > The current implementation of validate_range() in fs/userfaultfd.c
> > performs a hard check against mmap_min_addr. This is redundant because
> > UFFDIO_REGISTER operates on memory ranges that must already be backed
> > by a VMA.
> > 
> > Enforcing mmap_min_addr or capability checks again in userfaultfd is
> > unnecessary and prevents applications like binary compilers from
> > using UFFD for valid memory regions mapped by application.
> > 
> > Remove the redundant check for mmap_min_addr.
> > 
> > Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")
> > Signed-off-by: Denis M. Karpov <komlomal@gmail.com>
> 
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> 
> This looks relatively safe. However, I'm not sure if we want this in stable.
> This has been broken for 11 years now, with no complaints.

I believe Denis has a new usecase that wasn't there for those 11 years :)

Denis, can you share more details about your usecase for us to better
understand importance of backporting this to stable?
 
> -- 
> Pedro

-- 
Sincerely yours,
Mike.
