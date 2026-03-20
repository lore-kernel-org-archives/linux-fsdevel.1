Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6909A3B9614
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 14:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774016814; cv=none; b=KfoVIbt1X5VwV3USqEAqRrPn/z18tgMFBLWvN8weq1w3/0wXgcx/hDJa/TD8ZQP3mamHV6VUF8ZMgjyuD5Tbt4t86ZW0iqf6M08/stKKKK/ZRM4t3plLcieRK327gESrXvFr0GSzlon1d6zU2SzpSb5MxaJ9f6XGfzNFp+5qwdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774016814; c=relaxed/simple;
	bh=0A3E8OFKs0O9ILXNdXWvmGC5H7JP8qHQNC5ofyYrUPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qiq6CSPNskARZwGp86wieyMD+emYVHuNv5ib2py6chxOrxrAMQyvf+iDW8MEQI0tfBZ/L/FxGECrOP42V2wINKuuebm6HU7XV+OfhVdP7/Z71uv0uWMrniZ/D2lxbSJqojjeAQMIPXWGjddD2ONxJw5UI77b5XXdoibgsfSHPt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvKHz0yv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvKHz0yv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551BAC19425;
	Fri, 20 Mar 2026 14:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774016814;
	bh=0A3E8OFKs0O9ILXNdXWvmGC5H7JP8qHQNC5ofyYrUPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pvKHz0yvaHt7yXjkgycz+Mh6vQI/FtlyH5zkdPe9fX8OLgpxBlJQ+5g688D+xo4EB
	 boPXgnXBIjx2PLKFFLWfBG6a5n9Ns9bNfoevs8tWypTGgAd3KAoHwG83XxmbWlaPe8
	 bJ6QZ/1X68mtWRbF15uCLRJEvTgQyBFMN6GbJ2pBi24hV4MSwKhP9ahYm+o/adWidK
	 PYiWp4ea9WFVfanPvEiTHxIbXvqOB+0m/1mSkVGAbCUEA1s/2X1H2YmvMKZWxmQyYO
	 BsPLYHdkfsFYIbYp84qoTr0XMh1fv3ZInf9WC/ZUvCultXNbBT9Gc0CFSa1sRYBJd/
	 Ix8mMA137gMTA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3ED2FF40068;
	Fri, 20 Mar 2026 10:26:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 20 Mar 2026 10:26:52 -0400
X-ME-Sender: <xms:LFm9aeSBuUCrHINfbPMjDM5NOuwsec15zikcAYsd_e1YaxhM5GSKdg>
    <xme:LFm9afc4eZo5eHohZD66T-vSSuX-HZ3oMZf64h09IN15YVDqSmzUpbAwr8xmufPZy
    m9xB9-AseZUQRroFN4BU8VtHYnUlMWxjWrbe7T-cDTYDk72t7X1_pfN>
X-ME-Received: <xmr:LFm9aXcQ62hYHa5fAZpD3wct0dWtIrMStLzszKWngoHcqbAciXOgrBpktvbA_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddtudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueeijeeiffekheeffffftdekleefleehhfefhfduheejhedvffeluedvudefgfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepjedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehushgrmhgrrdgrrhhifheslhhinhhugidruggvvhdprhgtphhtthhopegrkhhpmh
    eslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepuggrvhhiuges
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdroh
    hrghdprhgtphhtthhopehrhigrnhdrrhhosggvrhhtshesrghrmhdrtghomhdprhgtphht
    thhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehrsehhvghvrd
    gttgdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopegrjhgusehl
    ihhnuhigrdhisghmrdgtohhm
X-ME-Proxy: <xmx:LFm9aWJL-Ss4VdQh9OttEJlT8Zf4nVQblfCHB4NkuN0R0ulAXU5f5Q>
    <xmx:LFm9ad2S784Cw2CLErVJ-CsAKIS3XDTHQ04Fl2vvan8jvQZHTc5XSA>
    <xmx:LFm9acrITVLMbY1A7gbnjs8AZ8JtpLketSqNd9lSaUs7Gf9fzI0muw>
    <xmx:LFm9aVq2Y2vgmS6pQU4GVPJtd_34daD2fwzbHPhe5kJTjNutWkIeWA>
    <xmx:LFm9aTzlGZD1DjptI-AgFUkbuM-4axTLedVlLdmnC_tWJRhkBKwYAZUf>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 10:26:49 -0400 (EDT)
Date: Fri, 20 Mar 2026 14:26:43 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org, 
	willy@infradead.org, ryan.roberts@arm.com, linux-mm@kvack.org, r@hev.cc, jack@suse.cz, 
	ajd@linux.ibm.com, apopple@nvidia.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, brauner@kernel.org, catalin.marinas@arm.com, dev.jain@arm.com, 
	kees@kernel.org, kevin.brodsky@arm.com, lance.yang@linux.dev, 
	Liam.Howlett@oracle.com, linux-arm-kernel@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, lorenzo.stoakes@oracle.com, 
	mhocko@suse.com, npache@redhat.com, pasha.tatashin@soleen.com, 
	rmclure@linux.ibm.com, rppt@kernel.org, surenb@google.com, vbabka@kernel.org, 
	Al Viro <viro@zeniv.linux.org.uk>, wilts@infradead.org, ziy@nvidia.com, hannes@cmpxchg.org, 
	shakeel.butt@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v2 1/4] mm: bypass mmap_miss heuristic for VM_EXEC
 readahead
Message-ID: <ab1Y5fLNJ466kK-7@thinkstation>
References: <20260320140315.979307-1-usama.arif@linux.dev>
 <20260320140315.979307-2-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320140315.979307-2-usama.arif@linux.dev>

On Fri, Mar 20, 2026 at 06:58:51AM -0700, Usama Arif wrote:
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 6cd7974d4adab..7d89c6b384cc4 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3331,7 +3331,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  		}
>  	}
>  
> -	if (!(vm_flags & VM_SEQ_READ)) {
> +	if (!(vm_flags & (VM_SEQ_READ | VM_EXEC))) {

Strictly speaking the fact that the file mapped as executable doesn't
mean we are serving instruction fetch page fault.

FAULT_FLAG_INSTRUCTION would be the signal, but it is only provided by
handful of architectures.

VM_EXEC is good enough proxy.

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
