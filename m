Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0644841685A
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 10:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786616309; cv=none; b=oEMNnxUq2dJIHsvfnBWQLLo+o++yqiPuAN/pIjwkpTu4dSbDB1wUYVqCUVrGKJY/5soBVKxWxNmnyNcoD8Rwwqp+6H21UmoVgUsxpGefBAohOADSwnfEr7Oq8zj1rnw3AVc3haoqtLTuRYQk39uU9gMNwtDfCt2zzDQSm6mFTW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786616309; c=relaxed/simple;
	bh=8TbDVwlrlU970Q3rYRkWoqx5ffOdYIgQF6TyapzBm7M=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=e7jEtF200frEdWptHIfpfALjvdmfoHYvVGJOLjPFmHq5T8sbvNdaPfR0fLPFNbbex/s+O2XVbHgmfLUoj9RvPDlwH3rUEDFv3veOrC9td3BMU5dTFF/p8lpidWDPGzjlWsyx3K+lJW/ck8zReojtG6P1Jto1wmCq/uTaVbsNJFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXpVK7gU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXpVK7gU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48E61F000E9;
	Thu, 13 Aug 2026 10:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786616304;
	bh=IcXmeeGKhWTLYyvvtQKUgVRN0u/3h3nZ9Go1TSRRUr4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=fXpVK7gUn6Bmbe3LCcgIzHgX9v11jWp30xXeservPN/ArNuyRCSM6LNxOG5eZ7efd
	 6grBrHacFGfIqf8obZ0sEPpgWpsr1u2e3Y8F+TVYzJpgXZbfFYrn5pE2kv5Fh8ctPo
	 ZvA/TXotmVCt5b2dzp9KeCRVaGCBBymXfgO7wGGavE2y1YFYEM5Jtk57ssFd6iLskk
	 CN1TDx23TPFrgXo5XiwBSQD1DiIPhXiXUYfW6VyLsoR3buOtd6gP9Caqa14S4ATmsb
	 4Y1AEflS/n6s/NEFUVEhdGLvRCa9Ln7Ar07fHD+GS3de4xqElHOXacQ6MhKd951tYX
	 ddqI9sGUjXheg==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 0/4] VFS: prepare for changes to directory locking
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org
In-Reply-To: <178644416888.2852630.13027304385741135044@noble.neil.brown.name>
References: <20260723015330.3093207-1-neilb@ownmail.net>
 <178589951580.3252194.4525601427061509874@noble.neil.brown.name>
 <20260811-worte-ergotherapie-aggregat-37e626a98182@brauner>
 <178644416888.2852630.13027304385741135044@noble.neil.brown.name>
Date: Thu, 13 Aug 2026 12:18:15 +0200
Message-Id: <20260813-bronzen-fernhalten-perfide-99cf86e3a487@brauner>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1525; i=brauner@kernel.org;
 h=from:subject:message-id; bh=8TbDVwlrlU970Q3rYRkWoqx5ffOdYIgQF6TyapzBm7M=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTVznwZofRnCXvyz/X5+12u7z7Ps0Xxw77DHCH7Twhs7
 Vkxg+/SqY5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJbPzKyDDT1fD8SQexpO4I
 zYnKFYzsUzvlD0lkKmhyvJj/WkHW35SR4W/a47tdtoGPJzn9NOmqTJ98+AXHHrtuNbtFkV18Iky
 TeAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-08-11 20:29 +1000, NeilBrown wrote:
> On Tue, 11 Aug 2026, Christian Brauner wrote:
> > On Wed, Aug 05, 2026 at 01:11:55PM +1000, NeilBrown wrote:
> > > On Thu, 23 Jul 2026, NeilBrown wrote:
> > > > Thanks a lot to Christian for the review.  I have address all this
> > > > issues found.
> > > 
> > > Hi,
> > >  has anyone had a chance to review?  Is there any change this could land
> > >  in the next -rc1 ??
> > 
> > I haven't gotten around to it and we're kinda cutting it very close.
> > I have reviewed prior versions so I'm not unfamiliar with it. If there
> > are no real costs to pushing it to next cycle I'd prefer that.
> > 
> 
> I would be disappointed to lose another cycle....
> These were, I thought, ready to go in the previous cycle but they got
> little or no review and Al only took one patch (the d_alloc_parallel
> wait-queue change) for reasons that were not made clear.

Yes, I hinted at that in one of my earlier replies that there were some
api quibbles some cycles ago on whether this direction was right or not.

> I had hoped these few could land this time round so that I could post
> patches to maintainers of various filesystems to start using the new
> APIs.
> 
> If you would be happy to take those follow-on patches to various
> filesystems together with these preparatory patches in the next cycle,
> then I should still be able to get everything ready for the next step
> without losing a cycle.  Would that be OK?

Yes, that would be acceptable.

