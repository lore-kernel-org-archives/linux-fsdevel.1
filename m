Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB654A32;
	Thu, 20 Aug 2026 08:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787215781; cv=none; b=fse0vT9+M14UUwkPp51bMXciNCyYUnLum/zFFrJBk+FB7EWCKmhWGiGuwLBuDCgWZJK1gCJha6mOtjXrDII2G04NXutEimd6FyUdopOReZOnQPAIq3vMmI/JAhOK4vZImanhnd/Bofvk9kHLHYAwAqsFixya/BXlkWnQDxphAm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787215781; c=relaxed/simple;
	bh=ZMLa3JcB5tSsjYVZl0BpBNNpOSfPEiUMh7fdTEaN67w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQx1Uo57MAsd9gHI9eN9wfAkW/jjaGr2ih1gra/Hlvfdit420KjxFLViz68xkl2A8HbW10haxL4pOVY3TizdOS+tlM/zaOk2OqnoU7htreuCyZQFFwSWXzmdvp8NsRhTwJifySt8JD/g0MvlDWV1YRtIo/yIdokj8SjD2totocM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=E/tMM9LT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E/tMM9LT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6jxfOD4bOvRu3R+XpcygwKPVmZ/VUDro80ay2eMAlY4=; b=E/tMM9LT8i+YrEpaq5NGEmVVfR
	+ubiJSSI28zHSuOkh+IDZEXppXw1rS7X6HfNY4tdO7s03GOk0C9CNw8JniV1zY6Tun9wROJU9q7yG
	g576mYxu73oJdnAkLNdegn5YFscTbLISZGZxPlO+DV5kfiyrL5lcpSn8KYqPTBxFLBIsy6er3uYeG
	pL4G/xc4rCEokuXL8dIeWoyHDAYYm4gf3Ck2xfPPweIJHfHGvewMnbRNlRPDdCjQjX+sQtkskldVr
	BHVjTFIBdkhlsj62iwOgdXX8IFQVtj/OUt9QC632q+qQkc8sO9GDlxkNTX4hUOggAnXQCMDz6xgoG
	nAYC7ymw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwySt-0000000FCp3-0Cb6;
	Thu, 20 Aug 2026 08:49:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A46A13006FA; Thu, 20 Aug 2026 10:49:33 +0200 (CEST)
Date: Thu, 20 Aug 2026 10:49:33 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	fuse-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fuse: permit freezing while waiting for request answer
Message-ID: <20260820084933.GA4036497@noisy.programming.kicks-ass.net>
References: <20260819023542.561653-1-senozhatsky@chromium.org>
 <CAJfpegu2wOG85R6KSvCwHOuxe2fWczA1KbrFcCZz=ofUch4K=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegu2wOG85R6KSvCwHOuxe2fWczA1KbrFcCZz=ofUch4K=w@mail.gmail.com>

On Wed, Aug 19, 2026 at 12:03:32PM +0200, Miklos Szeredi wrote:
> Why is this unsafe exactly?  Does that unsafeness apply to
> filesystems?  If so why do we allow freezing while blocked on
> sb_start_write()?

Getting frozen with lock A held, while another task is blocked on A in
an unfreezable state results in the system not being freezable.

IOW you deadlock the freeze.
