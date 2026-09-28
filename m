Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D4F361950;
	Mon, 28 Sep 2026 05:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790573808; cv=none; b=ZwLeTVG/+jkCACecrfFOVNGvvQzPaXrAqeC+hzzWlw+/7sl7IZJosW4YfrmuJlj4sRVN5Amjbd9iZgAtlGdpI3ImmoNGrvYiieEU/4PP/tLFYd1GaywljkJ81+1ejFGm8AbRP0SKJsCcyj2CyDF003aCpGbfa02L5IvsKreW8I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790573808; c=relaxed/simple;
	bh=kCsC9ZlanwM2zEWCUBqqFtWQeAXR121vhqCnYCfzoek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XijHCkKzBswkPWKSjwb/ygLAIuW/1LLe6flRFw4veQhfVhu1D29t/gPRdS80oVLkzNXp0QvOlv5Mv1jhCdFWmUnpSHeeAbNO8+BpcUt/Udc8aC27cy/vdnwflDF1g8vFfCgZF9cNy5uzwXTjTCgVI2N5jt2uHiT5kdb1VHHAVT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 02F3668BFE; Mon, 28 Sep 2026 07:36:42 +0200 (CEST)
Date: Mon, 28 Sep 2026 07:36:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Christoph Hellwig <hch@lst.de>, glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, vdubeyko@coreweave.com,
	willy@infradead.org, brauner@kernel.org, djwong@kernel.org
Subject: Re: [PATCH v4 7/7] hfsplus: switch address_space_operations on
 iomap-based support
Message-ID: <20260928053641.GA19334@lst.de>
References: <20260914233941.2966421-1-slava@dubeyko.com> <20260914233941.2966421-8-slava@dubeyko.com> <20260918135747.GA18697@lst.de> <2bb826db81e9d1fadb175be873623d003d7ce385.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bb826db81e9d1fadb175be873623d003d7ce385.camel@dubeyko.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Sep 25, 2026 at 03:35:08PM -0700, Viacheslav Dubeyko wrote:
> Does it landed into some branch or is it still only on fsdevel list?
> Otherwise, I need to wait when this patch will be in some release.

It hasn't landed anywhere.  You can include it for reference, and we'll
find out a way to merge it if both patch series progress at the same
pace.
