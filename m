Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF313C3422;
	Thu,  9 Apr 2026 11:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775735812; cv=none; b=peindD6IWkehRlRq4eIxJ+mmsAwghADLRYyK6vwi2ABxYxMaJ7EgKhVnuo6jzwRKgx3zbjQ+pc+sH4ZQY1cOXa/iqTw8N0Yr1+2RcgrSNLIsv9wpiF5iRZvnTgnModXqMalW1Qz5y8WLIVUwZxd3ad9XZmIDU7R65pxuz+yws8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775735812; c=relaxed/simple;
	bh=y7BqNP1W2KHlU19MlaW9q/B2IueRNczxl1oFvHsBkhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMj+NZm/k8lv+2HnavmR8vZXmoYEUR3A8RxxVs6hbgL7xLxFMRpFpAXHH5rRcC+cF5tpIrAZf0aw8FZYbIILT10HuYvcIm9wSMxOf20yF9NJAOhvkBLGOfqFiqXqA1hPWMx0ouK4h71TI8R/1Kjrhrj7Yt2Wt7woyJtXvpPME38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBaBeupr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBaBeupr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C506C4CEF7;
	Thu,  9 Apr 2026 11:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775735811;
	bh=y7BqNP1W2KHlU19MlaW9q/B2IueRNczxl1oFvHsBkhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cBaBeuprHZm72wS3WWjG/PSuQyvKttdSOA1j/vK6PgAhE7Lsj4gmjD878J/MRzNEC
	 5oJoD2FcJ4OXH1yIHVfmZuhzBpQmC2/9TAy/Lp08swOsFcAg0VcfdesDv0k6jl/TuI
	 XT9azHwufArq+ht+v4XCMoV2YhdajSjejTegQ/rMas9hAZomilsEQzEhSdEDu3cC72
	 a7k8WsSeNJZx/MsHsnyYhMFntLXV3S11rIwOaDsd1ND0ekP8dlyImVQHyyRwrw8t/Q
	 jjYDSiaa8Q+1lcs4dlPdBM2amiK1ig8anEMJo0gAS4xKzuA4PbnFq3htCofpI/VPgr
	 U0o2gzxhpHdtA==
Date: Thu, 9 Apr 2026 20:56:49 +0900
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: "Denis M. Karpov" <komlomal@gmail.com>
Cc: rppt@kernel.org, akpm@linux-foundation.org, Liam.Howlett@oracle.com,
	ljs@kernel.org, vbabka@kernel.org, jannh@google.com,
	peterx@redhat.com, pfalcato@suse.de, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	usama.arif@linux.dev
Subject: Re: [PATCH v2] userfaultfd: allow registration of ranges below
 mmap_min_addr
Message-ID: <adeUASM9tEzo1Tnx@hyeyoo>
References: <20260409103345.15044-1-komlomal@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409103345.15044-1-komlomal@gmail.com>

On Thu, Apr 09, 2026 at 01:33:45PM +0300, Denis M. Karpov wrote:
> The current implementation of validate_range() in fs/userfaultfd.c
> performs a hard check against mmap_min_addr. This is redundant because
> UFFDIO_REGISTER operates on memory ranges that must already be backed
> by a VMA.
>
> Enforcing mmap_min_addr or capability checks again in userfaultfd is
> unnecessary and prevents applications like binary compilers from
> using UFFD for valid memory regions mapped by application.
> 
> Remove the redundant check for mmap_min_addr.
> 
> Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")
> Signed-off-by: Denis M. Karpov <komlomal@gmail.com>
> ---
> v2:
> - Remove the check entirely rather than replacing it, as suggested by
>   Harry Yoo and Lorenzo Stoakes.
> - Added Fixes tag.
> - Link to v1: https://lore.kernel.org/r/20260407081442.6256-1-komlomal@gmail.com
> ---

Looks good to me,
Acked-by: Harry Yoo (Oracle) <harry@kernel.org>

-- 
Cheers,
Harry / Hyeonggon
