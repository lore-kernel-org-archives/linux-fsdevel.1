Received: from e3i432.smtp2go.com (e3i432.smtp2go.com [158.120.85.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F9431B114
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 May 2026 20:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777926244; cv=none; b=J689TycGG6xcN9RJWACQDSK/ekxpjzqEoz9oQpZ1fspcnCSV2HG0ANjLXax/ZmoA8KPFPqQf8j7JFKe/wh95Lxh43jh2PSUElO8+SUS0kYMGBGm1/GKwm/ddOX3itAi9tjsI0c6/ZjHDWeGIO2mwf/N04NaREOdjyJoIZ2VMPsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777926244; c=relaxed/simple;
	bh=XI4Fj0z7pooldJ/2eC7J8+I39C4uFxxaIC44PQ0TLnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbGVyFA8fRihOKXLIYkFJFdq9dgt1IydJiWr8gcAhKJZNvaVYgjlr12MTFnR/AZebMSM/6jXKEPcgXmFO6QQOgssrVSQFlK4hiOjUQUKfG2EiyEYx4PWwTHRrAg6ZK7CBYAuzUjZiQrQ7IYqQRDutgWjQWpbE1s/Nk4grUKoOOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=C5Sba0cn; arc=none smtp.client-ip=158.120.85.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="C5Sba0cn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1777925333; h=from : subject
 : to : message-id : date;
 bh=4wCA54cVg8I6wngdC5dE4awASRWsyxnda2eZdotTRFA=;
 b=C5Sba0cndV22eHV52CSYPc8rb7x1DUhCw51vQsfvTmw+30ipOPfjBapjUMSlmFy1Wq9mg
 5gQZGD0Pthdnlgt8Hp0gVjITC/vCGNHvnSybdBCHnoLt6vFPxAk81q8LLUhTGUOZfO4/bxq
 WyAa0JZhUhSCxU7fGg7X6Hw8GdJaEyG7I3RSGQ1DEeK4fGFnmR+p4HNinFczNx09vZQMNkG
 0Y/CTqUy8lSYinUSZtZhOLLVlrHYqAf279r75C8g42hSM5NBu3nq+PTtZ9HdWlhsfTSdlWQ
 4trdnhOA/+murdlt5UaG/IWFp8f2/HkgbTkBhSUzPnfGd0yaH4ewRGdSKjYQ==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.99.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1wJzax-4o5NDgrvBYf-rg09;
	Mon, 04 May 2026 20:08:47 +0000
Date: Mon, 4 May 2026 21:47:17 +0200
From: Remi Pommarel <repk@triplefau.lt>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: Re: [PATCH v4 0/4] 9p: Performance improvements for build workloads
Message-ID: <afj3xZOpaUlvFuIj@pilgrim>
References: <cover.1774380535.git.repk@triplefau.lt>
 <aeBGIg9aEPFbzZuZ@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeBGIg9aEPFbzZuZ@codewreck.org>
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sYZT3vgZ5L
X-smtpcorp-track: qYCat2ZrR-Kv.WuPV7Z6jHZOu.tZZafgxgSnd

On Thu, Apr 16, 2026 at 11:14:58AM +0900, Dominique Martinet wrote:
> Remi Pommarel wrote on Tue, Mar 24, 2026 at 08:43:30PM +0100:
> > Also sorry for the long delay for v4, it's been quite busy lately.
> 
> Thank you for this v4; I've been busy myself so can't complain...
> 
> I think we've iterated enough on this for now, so I'll tentatively pick
> this up for -next shortly, but there are a few fixes I'd like to get in
> first and we're a bit late to send this for 7.1, so this cache change
> will be for 7.2 in a couple of months
> 
> Meanwhile if there are other comments etc we can always iterate (with
> either a v5 or pilling patches on top)

Thanks but if you can hold that a little bit as sashiko.dev found some
important issues with PATCH 4/4 that must be addressed. A v5 is
comming very shortly with the needed fixes.

Thanks.

-- 
Remi
