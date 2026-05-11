Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97E83A4F54
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 07:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485572; cv=none; b=EHYWr3rOzuM6K7/lR+GjbBMoG7wcxR6n7wmz4wsCVt0CeXxWTZemY+iLj5V6elnPoyqqWaBwXcyYuH3VWdjkCh0U5Mnyo8AIFc4SyCBxh+s1en5002mpWAzJ2Ap3/1bn9qHBxytfwsK2xpBikLFeNUv0Zl2dulOFzZUcvRSP5xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485572; c=relaxed/simple;
	bh=Qi+7EVfG8K0aBJnJx9/PolqsHmenpN18TD13bthhgCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifivCwozo/PWnJ3F9YBRQzh2phQKSTEAO2DF993o7LZqi7ddF/sN6y6Y9DS0eWTGn1EvrbF1oz/cI4ya0Cj77pY3NCoXLFEP3fwXXuE1e9nm/LbXX507Lc8eNq0IFrawndJDGh7OCEitr5Vplse0Pkazu0dUN0UcwEtGVTsdIZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 91D7968BEB; Mon, 11 May 2026 09:45:56 +0200 (CEST)
Date: Mon, 11 May 2026 09:45:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anders Larsen <al@alarsen.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>,
	Luis de Bethencourt <luisbg@kernel.org>,
	Salah Triki <salah.triki@gmail.com>,
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Dave Kleikamp <shaggy@kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Bob Copeland <me@bobcopeland.com>, linux-fsdevel@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net, ntfs3@lists.linux.dev,
	linux-karma-devel@lists.sourceforge.net
Subject: Re: [PATCH 03/10] qnx4: handle set_blocksize failures
Message-ID: <20260511074556.GA28186@lst.de>
References: <20260511071701.2456211-1-hch@lst.de> <20260511071701.2456211-4-hch@lst.de> <12893675.O9o76ZdvQC@oscar>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12893675.O9o76ZdvQC@oscar>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, May 11, 2026 at 09:42:49AM +0200, Anders Larsen wrote:
> Hi,
> 
> On 2026-05-11 09:16 Christoph Hellwig wrote:
> > qnx4 uses buffer_heads, which don't handle block size > PAGE_SIZE well.
> 
> qnx4fs uses a fixed block size of 512 bytes, so this will never happen.
> 
> > -	sb_set_blocksize(s, QNX4_BLOCK_SIZE);
> > +	if (!sb_set_blocksize(s, QNX4_BLOCK_SIZE))
> > +		return -EINVAL;
> 
> QNX4_BLOCK_SIZE is a constant (512)...

Yes, which means that sb_set_blocksize fails when the device has an LBA
size larger than 512 bytes, and this failure should be handled.

