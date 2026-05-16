Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA78B38F232;
	Sat, 16 May 2026 23:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778972972; cv=none; b=Oj6fPIaQDEMcgDw+4abcS65HDcb36xE0JQIlqsi69vi6vyZ6+tYLUlwkJoGGW9auctUgG3Hjr/RFB/Lat9hlHU8e8WjMEc7IS9DTuPSNgzRngS+MQoPdCERyj+/DIv0WXV9Mlc4ydGTBWBRWW4WGH4Ry61UYl0HUWkuqsNfk5v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778972972; c=relaxed/simple;
	bh=4jy1+XI1Xl9EQs40qzW8fgGrbGAr43OlIdo+VEffCkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPbQX1t39EUoSDIpCXi9kGENcLLulUNTQiIJLze/J4NW2hb9ZXcUxA798Gm1Wns9cVpU1kVTzB4teQ+SFLvZTNRrWIGd81Z1GE4xrYdgB0KvaR4YVF63a53JsHnrEmc1qcMqtpubfGTMHnns6bLJkEwkUwWau8Hk9TDuPuH4uZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qJYlFVYp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qJYlFVYp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4jy1+XI1Xl9EQs40qzW8fgGrbGAr43OlIdo+VEffCkI=; b=qJYlFVYpglchFIrSnRcodJBOnv
	kvXo+zmb1h5cWEpvTEC8YHj6eg8s+BPD+StFgiWY2dxgKA3rgFZ0AQxTyjMZ+x5J4lCOelgaY/sPc
	qWUw3qufNgioD5p+Z2V8dfs7S99j5+q1oJolJS/ZXLaVla/2pJHdiGMr/tuaj8ic66mt+i2I8utFE
	6HomLafQlniTEkaTfJLzSIfU2MgsrWKmeAoEvMUxMzToLtd9Gx8XC5s32J2DfiMkozHpG3Am//3W5
	RQRLeZLb7l+sjnx9v/kMqzzOqIACg7tEzUbib0c8TaU/releZPvDiDFyC7r8XfIv5RnpFInJZ2jwe
	uGdvdw5w==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOO8M-00000003KdM-1WQ7;
	Sat, 16 May 2026 23:09:26 +0000
Date: Sun, 17 May 2026 00:09:26 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Horst Birthelmer <horst@birthelmer.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: [PATCH v2] dcache: add fs.dentry-limit sysctl with
 negative-first reaper
Message-ID: <agj5JkPZ7eNbFueR@casper.infradead.org>
References: <20260516-limit-dentries-cache-v2-1-c733a78e603b@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260516-limit-dentries-cache-v2-1-c733a78e603b@ddn.com>

On Sat, May 16, 2026 at 04:52:54PM +0200, Horst Birthelmer wrote:
> There was a discussion at LSFMM about servers with too many cached
> negative dentries.
> That gave me the idea to keep the dentries in general limited
> if the system administrator needs it to.

I feel you should link to the dozens of previous attempts at this kind
of thing to show that you're aware that this has been tried before and
you're doing something meaningfully different.
