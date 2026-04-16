Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BE83C1F;
	Thu, 16 Apr 2026 02:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776305720; cv=none; b=LQfOG8dRHIhBsUNGkcgVkkzCpmlYEotox/K810LsOFP1KeI2Qg5GMDLxTu8hEWDbKUSoP39/Mc5PWcuJjLu4SHAQ3E5T5H9LdYX9K3X+0bPw1fFn3eXBMIzH4voKwX+Seynzu6Kwbhp9X351/F3YvGffn/x3D93hEfPPwNhqP7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776305720; c=relaxed/simple;
	bh=3M9x4Wpaitxqa4NUY6ik4dbt5WDukItbvnuHbKMs8M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9BlWgZ/2tBzqKOSTnPDYzypbUvJO4ki+6i2F3M6oqyPn6V7rZpY2ETX+AVoBwTqaVwMAswdpueg+cFN4J6rNt0op6RenPubrsiGSIQvzCY0HCADoA+baSZW3vXCczkGGTxCCiVHcY2I0u1rg10lCfsEcQa4OEBs8u+UM96WXuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=mP87qPgm; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="mP87qPgm"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 2916F14C2D6;
	Thu, 16 Apr 2026 04:15:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1776305717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUfJyO+B4NVQDlG68Pr9dSyQjk5jcqH8CJuvkJPJBqU=;
	b=mP87qPgmOqpsTGXSQin/KpeRSSrdk+DrakZLYW2TIqcx7X4inIXcLlHBbhZIYcVCnK0wuH
	l2+xEiEk+0/g3XCJ8T2wWZQ6TYxp/AzZ+ykNEgOlwtP+JoiNGVSNXeiHHphgwXu0AJdxFl
	gDSTzJAj3TwhSQTn0EgeHpFBL/RLsfxcKrMh1tZsT8V7Kx39hV+C3LLWV8NBCUPQ/XFoNv
	usgYpVm6OKxUCnoQN2RoG7AVWBuJiAgajpYG/ZChXKCmWEctfpfWhXM9ng05vlNxCBpIPQ
	OxrFUgHwBh7HJVc1mzf6FN11vcXi5iyj4Gv54MNob1S/k+XLmhephYXAufEDfA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 2d7f01e9;
	Thu, 16 Apr 2026 02:15:13 +0000 (UTC)
Date: Thu, 16 Apr 2026 11:14:58 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Remi Pommarel <repk@triplefau.lt>
Cc: v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: Re: [PATCH v4 0/4] 9p: Performance improvements for build workloads
Message-ID: <aeBGIg9aEPFbzZuZ@codewreck.org>
References: <cover.1774380535.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1774380535.git.repk@triplefau.lt>

Remi Pommarel wrote on Tue, Mar 24, 2026 at 08:43:30PM +0100:
> Also sorry for the long delay for v4, it's been quite busy lately.

Thank you for this v4; I've been busy myself so can't complain...

I think we've iterated enough on this for now, so I'll tentatively pick
this up for -next shortly, but there are a few fixes I'd like to get in
first and we're a bit late to send this for 7.1, so this cache change
will be for 7.2 in a couple of months

Meanwhile if there are other comments etc we can always iterate (with
either a v5 or pilling patches on top)

Thanks,
-- 
Dominique
