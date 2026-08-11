Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6273264CF
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2026 10:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786444183; cv=none; b=NTd72ji0qy6Nl1XNG9akx7eGxUUkpmxPOKngwDJ2DmnSuwWoqFAzE3k4104N8zurRLolospA5a0/lydoj9e81MUFoVYF+AvCCQ9QkCeUhSRfSbSTjROrmf9/+VLuWMvley+5UXU8mof+qz0o4r7pz8FC5gyhw0Wjo1tFTFz9cXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786444183; c=relaxed/simple;
	bh=cfzSzPe+6UHI6dQDdAZW5nWlA8/Dx4QFNAx0BZ/4zAU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ZekKrClA/ssQhlyS61wE4i2WZ98/j+4yVG3KXE0eZnP2pmvd4wXtGREfUiRn6ZnEs3ZgzhIkalJ0Lxx/jTAwgY4wvweQ8ngGTN4tRTEd/LJz8qdkj/eh/AhNLLPXK1+403jzUUWosPOXBByBGNDEywy0GmWPeOmW7PV8MQ4jUyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=pcpclvzD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VRRaBF1S; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="pcpclvzD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VRRaBF1S"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DFCF57A00C5;
	Tue, 11 Aug 2026 06:29:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 11 Aug 2026 06:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1786444174; x=1786530574; bh=EsjRc3xEaTxfvBP4zJ4Mz9nkLJEyX1rtgQ6
	RQWaQzEQ=; b=pcpclvzDhHAE54A3Si6xoSyFyNRAX/uFWjgU/65xjBo2JpKNH1D
	OhWxzdz49zhy+JDDa174Q6SMW/H7kUCLlQKtqkp9iLLZpTB/ZTa5b4k0DszaEiiP
	VP0LUmc/lcWP8MDC9EWggh3laPPEZB8nkAkKpvejOYvfaab1FkNgGvtpOcVQvC8Z
	oKNQClbP4Tff9J5NhtDcDPkSUrl3MDtzX+CpSQ0v1f+jDqsrqD2uyARlx2mfS6yT
	y0e4+CwBeMvUTaaen+ku9ZnBZibTQxmdZPM+2hp37CWhtFQ1XszQPMR/GUugOpte
	xEG8tJPe6CVXD8lWRhKSCps9FAUXtBx2iQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786444174; x=
	1786530574; bh=EsjRc3xEaTxfvBP4zJ4Mz9nkLJEyX1rtgQ6RQWaQzEQ=; b=V
	RRaBF1Shal1KX5oNKskgA3qs2TTtDB3BT/MY7UBRKL7SavHv1Yf3Jj/bFrI9/+KY
	KMZPzAd64Ct8n9DGbHOv6W3VpnuT7qfP5QH1+OcfAPMjyiOQ3hNNEzuvFKxhslcj
	HcjXJwmduJabMiY64b4Z1LrrKqYlXIixkhQwGzn2OhXev9gAMD/tTsfDr9goUxjF
	nUbZcPts8lf8NT1D0cmR/ZQFSEpBCbsG4aiFIkLhuMm6wDWmun8xyzKOk6nUddnd
	XLtknrPLas5FcyDQ1cTPJMctPUb/gZ6r9MKJz4o12GN9ZovSA+rG7vMqeD4jMQQx
	Fl56nTZls9odLB5lSdN8g==
X-ME-Sender: <xms:jvl6atIq0PH5NoTUUcYQp8pVI-kdy2Vcs_t-5SDZvg0-2H8nLQLYBQ>
    <xme:jvl6akk1SeB3Me0goHlkdmUIDN6q-20le4DvR5z-siT3vr5TjltGQREp5mvjhY8BN
    MUssyvWL1Y_k1L-NHwcBlwBYJLM6zz9AoSFEZ7d8Id6FlQqjQ>
X-ME-Received: <xmr:jvl6apNZQjoDNX-yhBr-r4wm1wb_QdT4UdIUmH6B9MySxxaTIYRIuiuOCzgYQz6WGwokV-g49fXMJqdnpSG9RUy0r_vTDOo>
X-ME-Proxy-Cause: dmFkZTEuN/NZXUVj+ln3+/Mc1t/WGJxHJFh8MIXvcPIwfiv9cCFPnaSFv3pEEwvPY4UtNS
    FLAIma02f/1+xwcfhiDOH0v7lIbnFxV+UBUbmHEzIAbrjVv9pRsujvIH50W22KDpErgh4x
    qWtOXZiy4/0A2NQQLT0R5nfFNLooLnCtSbcfPRfoJvX8QOtT3aRbfKaXlEkAsLt0ESfLrP
    IkB7/HdHKe+VCVeIyPKcttJfgNNXlHs3T7H4iDOnyc6EjrP7mYC1HY7/D1fav9ganS8LDL
    QA4go/qFONXJfGIrj1ILkQXoRuTbGNhEYFUc5WoyigFaF9BQBj98KXSphB8OoKKT1Z9rN7
    LWEwxh3yr9pgeCaLepvuyIfMrub0OPnpT/LN9ewwkVvTLHQH+HI/PKVwARQrhau15Ve2Fz
    /e6fE3ldxyQpIkCCJ8bEj8G7dGPhaabAwxWyebZGkiHCIeR9c1qgozbcU0VO9mLZc4RmDd
    /gObvRP1sE/5x3s7YYTQc0qh/0lcHKxiwnU1s2kDq7lOuDhJgb0aXUue6iMPE3efXlSw8i
    FvSyvq6dRov1fActwi9A+bDZ5hlfqILM9IIaLf3pLTdu0MVWoU6V+8fRTZUp5JYm/++sCG
    zBsR3W6JMk4C2CkZ9mNfSRuhbki7GeLtFKUTeViMNpl7UBMIXQ05liCISPZA
X-ME-Proxy: <xmx:jvl6ai0ca5OdUBaJbu59T7PfRj3RHR-IFnC3Tu7UKO9wmdg8a7cyyw>
    <xmx:jvl6agkAeqKflvITb-BT0vvv5HtvuEMA5qQwVRSTP8QRY1mSYs0ixA>
    <xmx:jvl6ahVE5yWC4Uhe7B0lnP-bpmsW0D6PmwadsLRtUQMOFC23NnHILQ>
    <xmx:jvl6auuXFBleTAulScnsd5UZanRYaUCIpW9J1IwwldRNpIip3xQmPg>
    <xmx:jvl6aq6BxtlSp9nCNMs_hWlvMNQ5PKLbLl2IMpZtp7o1mb0hdGaA4pJk>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 06:29:33 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] VFS: prepare for changes to directory locking
In-reply-to: <20260811-worte-ergotherapie-aggregat-37e626a98182@brauner>
References: <20260723015330.3093207-1-neilb@ownmail.net>
  <178589951580.3252194.4525601427061509874@noble.neil.brown.name>
  <20260811-worte-ergotherapie-aggregat-37e626a98182@brauner>
Date: Tue, 11 Aug 2026 20:29:28 +1000
Message-id: <178644416888.2852630.13027304385741135044@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 11 Aug 2026, Christian Brauner wrote:
> On Wed, Aug 05, 2026 at 01:11:55PM +1000, NeilBrown wrote:
> > On Thu, 23 Jul 2026, NeilBrown wrote:
> > > Thanks a lot to Christian for the review.  I have address all this
> > > issues found.
> > 
> > Hi,
> >  has anyone had a chance to review?  Is there any change this could land
> >  in the next -rc1 ??
> 
> I haven't gotten around to it and we're kinda cutting it very close.
> I have reviewed prior versions so I'm not unfamiliar with it. If there
> are no real costs to pushing it to next cycle I'd prefer that.
> 

I would be disappointed to lose another cycle....
These were, I thought, ready to go in the previous cycle but they got
little or no review and Al only took one patch (the d_alloc_parallel
wait-queue change) for reasons that were not made clear.

I had hoped these few could land this time round so that I could post
patches to maintainers of various filesystems to start using the new
APIs.

If you would be happy to take those follow-on patches to various
filesystems together with these preparatory patches in the next cycle,
then I should still be able to get everything ready for the next step
without losing a cycle.  Would that be OK?

Thanks,
NeilBrown
