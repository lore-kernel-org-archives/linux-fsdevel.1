Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3913CB2C1;
	Mon, 13 Apr 2026 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776088939; cv=none; b=lLzMu2I4Xh+lbSFWPw9zxYQmzpvg1AgmbsbA0EalwNhUpyxFJLTTG3czSS1RXrzoc8nkmz5ja/hTyuNp3yzWPCjoNH2m7eNvhoJ2AziZJBVmkvk1ITAa12cG2+JC/B26mZ6/8KRF7PESIewUrq7Bo8qnGax0dPjyKzv4DY07JXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776088939; c=relaxed/simple;
	bh=J8T6Dw9NftUnSxGcHO5ibrBAJE+CebJPNtYC8nRk5pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNeWsPvfwnaWIPwNYDOs4aCnB0/eonx6EIgGvvw7mdncHfUzPNFyocZAnC0xPmNmGMYK1oRFo0H4fepNG5NNgwk2D/el4Zo1nYlwL6efg6pA7LoMTwaugYHxTIeZR4h3ZI3IU2C573aovlnZw59XKKOtm8qiypkZ2h/bfBQGoGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEan9QiV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEan9QiV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E55C2BCAF;
	Mon, 13 Apr 2026 14:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776088938;
	bh=J8T6Dw9NftUnSxGcHO5ibrBAJE+CebJPNtYC8nRk5pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AEan9QiVkF11/pica1V//uavUJAxHURk/fNrhf3UJDdRX9JPHIySKLThL6kSQhGZ3
	 trvibNDdlVNJIksx0OS+AKn1EjpwXRdjWcoi4b6yN36RlD4pQ7bGMFzHDBgpavKd+D
	 1hamjYOUtE6h52r+6PvngIsmIWpf59C+AmQb8TpJn1xV3n2To5sTtK/OiEeRNX8oGr
	 GMRryoclRICNbN7OuW1Ioav8jzY6/GjnKXN3Fjg6r2wD8SNPpnXVEn+f4OVXnxx8sB
	 HvHi9yKQnO0LOSowMStisrHJcv5OHF4Enok3jCl2dXUgdLdR45CVLDuFDMIAJnx70d
	 n6ZDuCnEUS23A==
Date: Mon, 13 Apr 2026 15:02:12 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	David Hildenbrand <david@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH mm-hotfixes] mm/vma: remove __vma_check_mmap_hook()
Message-ID: <adz3XI5vimbxDghN@lucifer>
References: <20260413105713.92625-1-ljs@kernel.org>
 <adzg2DWDWDR3DFJh@shinmob>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adzg2DWDWDR3DFJh@shinmob>

On Mon, Apr 13, 2026 at 12:28:46PM +0000, Shinichiro Kawasaki wrote:
> On Apr 13, 2026 / 11:57, Lorenzo Stoakes wrote:
> > Commit c50ca15dd496 ("mm: add vm_ops->mapped hook") introduced
> > __vma_check_mmap_hook() in order to assert that a driver doesn't
> > incorrectly implement both an f_op->mmap() and a vm_ops->mapped hook, the
> > latter of which would not ultimately get invoked.
> >
> > However, this did not correctly account for stacked drivers (or drivers
> > that otherwise use the compatibility layer) which might recursively call
> > an mmap_prepare hook via the compatibility layer.
> >
> > Thus the nested mmap_prepare() invocation might result in a VMA which has
> > vm_ops->mapped set with an overlaying mmap() hook, causing the
> > __vma_check_mmap_hook() to fail in vfs_mmap(), wrongly failing the
> > operation.
> >
> > This patch resolves this by simply removing the check, as we can't be
> > certain that an mmap() hook doesn't at some point invoke the compatibility
> > layer, and it's not worth trying to track it.
> >
> > Fixes: c50ca15dd496 ("mm: add vm_ops->mapped hook")
> > Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > Closes: https://lore.kernel.org/all/adx2ws5z0NMIe5Yj@shinmob/
> > Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
>
> Lorenzo, thank you for the swift fix. I applied this patch on top of the
> next-20260410 kernel, and confirmed the failure disappeared. Good.
>
> Tested-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Thanks! :)

Cheers, Lorenzo
