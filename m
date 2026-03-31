Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387D529ACDD
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 05:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774936148; cv=none; b=q+/RwkcroNb5d1X4a/12rZ9oWhICtPVIjgZt0+9edFiuQ6Zb8zYzb/7f7/IjT4Cjzc22le/Dzxt0KReXt/lZ77Iq7SxoPWzdk1U865cn32zFBzFJJoSTGZs4+s07TinC0STqAg34RupxkxWxCz/6wiJN8mRP7oyPoo5z9KG4cMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774936148; c=relaxed/simple;
	bh=ukag4235Gu1zYmeXxwL/ORBYT/L43X9QZMEmXrcKaLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcvVSGhxLrg9ETFJA0r0RTWpgc5mqz5Y/D6YedvT7O7pT7E8KpKOwCxbIe/VNl88UDrYJa8FRnF7if4B8K2feqV6VTP6pVmIGmpSH0tcoHhzOxgDgBeZp7/VHnxPJmIFTGRVdWQex5zW03qfDDXzmrkbJF9yA+NjcyEYnFH/OVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3B50568B05; Tue, 31 Mar 2026 07:49:00 +0200 (CEST)
Date: Tue, 31 Mar 2026 07:48:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, sj1557.seo@samsung.com,
	yuezhang.mo@sony.com, linux-fsdevel@vger.kernel.org,
	anmuxixixi@gmail.com, dxdt@dev.snart.me, chizhiling@kylinos.cn,
	chizhiling@163.com, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH 1/5] exfat: add iomap support
Message-ID: <20260331054859.GB31506@lst.de>
References: <20260326115045.9525-1-linkinjeon@kernel.org> <20260326115045.9525-2-linkinjeon@kernel.org> <20260330063059.GA5897@lst.de> <CAKYAXd_uzuyfz6BBNPxDDiN9GRSoqOWPe__kKx=UbZNxVG70QQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKYAXd_uzuyfz6BBNPxDDiN9GRSoqOWPe__kKx=UbZNxVG70QQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Mar 31, 2026 at 02:26:55PM +0900, Namjae Jeon wrote:
> > Can you explain the logic here?  Shouldn't the iomap buffered I/O
> > code do all the needed zeroing for you based on the map type?  If not
> > how could we enhance the core iomap code so that we don't need this
> > in the file system, which feels like a bit of break of abstraction
> > barriers?
> The reason we have exfat_iomap_put_folio() is because of exFAT's
> VDL(->valid_size). When we map a range beyond ->valid_size, if we set
> the map type to IOMAP_UNWRITTEN, iomap_zero_range() does not perform
> zeroing.
> However, if we set it to IOMAP_MAPPED, then iomap_zero_range() treats
> the area beyond ->valid_size as valid data and could expose
> uninitialized garbage data from disk. So it explicitly zero out the
> portion beyond ->valid_size in exfat_iomap_put_folio().
> I agree that it would be better if core iomap could handle this case by itself.
> I'll check whether we can improve the core iomap layer to avoid
> filesystem-specific put_folio handling for ->valid_size.

I suspect just adding a new IOMAP_ type for this should be fine, as
the above description sounds coherent enough to add it to documentation.
I just can't really think of a good name.

