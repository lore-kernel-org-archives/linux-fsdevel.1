Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2431D88B4;
	Tue, 12 May 2026 06:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778568045; cv=none; b=oOzB4ROUpTnatgmCugTN056N0ZF2ff8EvRL/Z9/LwRCll3AJlvL6hjp0ReXeVj59JwDQfyQGeROmaC+TydvWs216lhKHhbHczovewDYkt4XEtNESj6PdZ7cKBuCJjprrrLXaVelSdX2qwOgcFpQdkDIeckAAK2x/G4rDF3gOObM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778568045; c=relaxed/simple;
	bh=j2+wsLxtZdVEcNpRFrr0EaNUWNQv0Tth+Kaqqm7uvAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gD6BJAePEWN4SOYiFb31DOLkprFWv2I03sU4XQajt4K1IWcOwT4l1AE8rgqeAPpiFJFRFM53W0HY553BTkUBinb7h/Uu/1wQPcU5DJTI/5s4SU7DQAfQwFEol5r94QIGjOxKb63NlgrGq5HkbwP0FrXB3zX6Tqx+gHiuTud72xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8B4086732A; Tue, 12 May 2026 08:40:27 +0200 (CEST)
Date: Tue, 12 May 2026 08:40:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, brauner@kernel.org,
	djwong@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
	anmuxixixi@gmail.com, dxdt@dev.snart.me, chizhiling@kylinos.cn,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 9/9] exfat: add support for SEEK_HOLE and SEEK_DATA
 in llseek
Message-ID: <20260512064027.GB31640@lst.de>
References: <20260507124238.7313-1-linkinjeon@kernel.org> <20260507124238.7313-10-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507124238.7313-10-linkinjeon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

>  	} else {
> +		/*
> +		 * valid_size is tracked in byte granularity and
> +		 * marks the exact boundary between valid data and
> +		 * holes (or unwritten space).
> +		 *
> +		 * When IOMAP_REPORT is set (used by lseek(SEEK_HOLE)
> +		 * and SEEK_DATA), we return IOMAP_HOLE. This allows
> +		 * iomap_seek_hole_iter() to directly return the
> +		 * precise byte position.
> +		 *
> +		 * For normal I/O paths (without IOMAP_REPORT) we
> +		 * return IOMAP_UNWRITTEN so the write path can
> +		 * distinguish it from a real hole.
> +		 */

Ahhm this mostly has what I asked for earlier.  But maybe also
describe the IOMAP_F_ZERO_TAIL handling a bit above?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
