Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322031A23A6;
	Fri, 22 May 2026 12:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779454431; cv=none; b=ediBJ3GXmOCbjdzwTn9Kqhju0NdmYb+XEYdkTQfU2yDHFlS1VwfIkXBiChAU/OVDM/LglRAFjjnzGxGyLP2p2N9/g/YZKmAYLvDl/KNTVepIk7WJt4HuTykposnJTebxtt+gZWEfMZ4q4T7Gsv+ijn8Z43SULCW1y8AKM91CQ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779454431; c=relaxed/simple;
	bh=PpVpak6Au1A0z4mDohdPRa/E4+EQV1zbsT+A64Ko5MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itv1t1jZ48Q/tdFeVd/J9eBFwE37ydrL6P96rYqPHtXu2kNKI2rp6BK5TnRfeL2vKgTpSkX1eRjvRvxM9HBYpFtHgITe5wJ1/wqkuUCQ2v4A/vvgJuuyD9xqQ7FiND4w7RhsZGS0bBseoGJ/VR8A9IZ7N6XRdIp4vtnkRt8bygU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViloaseZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViloaseZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384D21F000E9;
	Fri, 22 May 2026 12:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779454430;
	bh=WI1qEP242yVi91yt5C4eBWu7bjAjiJRmatqX+BtFb4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ViloaseZvbFDZF0QiHX2tNv04MZQ3bGGF/y8pDixV9C/E9nr1aXF+JkWzC4LbjvCL
	 wmJvIkJ1UY/3niTOHIUfZgzn/0BRyFb0qqg7Qkbiye3jH9X1K2QczbvbMytNkfGQz+
	 0KywvK53E00QMnR51KCYVWgosPdSOnosdBQKtGI4wwQF62Q4ynCA0MejgpiwaLMl4B
	 AdusV5MeCEvm9t+cmLMp1Lxx8yKAYi4V/qJ6kDEaWq/qZVnhady+HUCdlYeeR8e7S/
	 2PvZ5JkORVcvZORRttlZSWSXTrjb+4FTLlgH5dwMjwareDro9UoMmXembDaIytPmvF
	 yUJrHsp1rsCpg==
Date: Fri, 22 May 2026 14:53:45 +0200
From: Christian Brauner <brauner@kernel.org>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, djwong@kernel.org, 
	hch@lst.de, linux-fsdevel@vger.kernel.org, anmuxixixi@gmail.com, 
	dxdt@dev.snart.me, chizhiling@kylinos.cn, chizhiling@163.com, 
	linux-kernel@vger.kernel.org, charsyam@gmail.com
Subject: Re: [PATCH v4 01/11] iomap: introduce IOMAP_F_ZERO_TAIL flag
Message-ID: <20260522-euphorie-duften-seebeben-eba5c7ce28a3@brauner>
References: <20260518114705.9601-1-linkinjeon@kernel.org>
 <20260518114705.9601-2-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260518114705.9601-2-linkinjeon@kernel.org>

On Mon, May 18, 2026 at 08:46:55PM +0900, Namjae Jeon wrote:
> In filesystems that maintain a separate Valid Data Length, such as exFAT
> and NTFS, a partial write may start at or beyond the current valid_size and
> extend it. In this case, the region after the previous valid_size but
> within the same filesystem block is considered unwritten.
> 
> This patch introduces IOMAP_F_ZERO_TAIL. When this flag is set in iomap,
> __iomap_write_begin() will zero only the tail portion while preserving any
> valid data before it in the same block.
> 
> Without this tail zeroing, stale data in the unwritten portion of the block
> can remain in the page cache. Subsequent reads can then return incorrect
> contents from that region.
> 
> Acked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> ---

I've applied this. The branch is marked as shared with the exfat tree
and will remain stable.
