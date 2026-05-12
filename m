Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AAF42EEC0
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 06:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778566087; cv=none; b=Vg0cT0ugmuiSfVaP7RqkNLaMOemJv8QTYNDvJeOPhdkrCc7IRzGc5lQmxKDlnl/uYfFkelnP4Ki371AywZzLveHnFSFX95l4Vwto9RmPIJtfnE+dorNUjud/Vo3+Z2QbGkrHhnalzbyOeOdVPSw+r57FU+Bkf2k6FGoW9+2RSDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778566087; c=relaxed/simple;
	bh=Dc7Qz72sxAi2w/RT3OkgGmogk0JPN22P1Cce854jwQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekJi/a1cuwlFQT7wzxc7V0LrqXZMB56nspVzSQlNIZ6+3tE01snnKdqz2FYyqtNmNSaYUAVBvM1HPiBWZwhvMh0s9KLpngH2hOJzUkIngAl6iVgdOS3teu0LOCfVKEGCIgEbvKb7dy+SzI1HOb2lKhCZDTjFzNPG1EWFgBAMv/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2A7006732A; Tue, 12 May 2026 08:07:37 +0200 (CEST)
Date: Tue, 12 May 2026 08:07:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: djwong@kernel.org, Namjae Jeon <linkinjeon@kernel.org>,
	willy@infradead.org, xiang@kernel.org, hch@lst.de,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RESEND] iomap: remove over-strict inline data boundary
 check
Message-ID: <20260512060736.GA28955@lst.de>
References: <20260511141151.6021-1-linkinjeon@kernel.org> <20260511-banden-sirenen-86654d8201a6@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-banden-sirenen-86654d8201a6@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, May 11, 2026 at 04:57:26PM +0200, Christian Brauner wrote:
> Applied to the vfs-7.2.iomap branch of the vfs/vfs.git tree.
> Patches in the vfs-7.2.iomap branch should appear in linux-next soon.

Shouldn't this go into 7.1 as it fixes a user triggered BUG_ON with
ntfs?

