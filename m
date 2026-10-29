Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.210.214.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793253897;
	b=wgendh/UWCzH1rp8Gy8MNAZrF50shiEkoUD0eHyCLC+g9uCWxoQWgaQLgl1Y8gB5B5fk
	 wUOfYmbi/gvYUUOIQgOnHAUhfPKE3rz8TEmxjZ3YjN8NmOnLUDwO747naEXijXxnvg7e9
	 Rr45ulRaW/ylJAaNjM6UhDJPFNasfoaeV2acu8JKE5/rJn8Aam5XYwe2jcfrPjc4Y8Cc0
	 mEq88dGNqOC6O4B1/rwJ4D1a6deH0m9Ebpbjz4C24GxisLDzjF4EHHCMXcubzjCyWuST8
	 MvI5WoSrfQ50PTX/7HKHBEo+4k+cqznzXU2w8AVFEw+GtQrMMoxUMGqPjBpfMUyLvYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793253897;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=MI842OMXovR+56TJ0REGTtFqRIUEY+IlN9+CViJwxzw=;
	b=EqyrL3CPdaicFb/w07mT85+TYgJyCfkynvyyG0ulTxdHeE24onnAT/I2AmeNia4k0oKO
	 wpIM9pSyrgEVSXgDwSlT1xLfOjPJs0bUxdTGrj6BG8e540SGer7kJBxZu4xcs68SFCCLt
	 InOFZsxpAsCFMCoOjOH3N15xaHyvHISxek1qY4rGdE9tT22HzEHW2QjZctIATlha/KJ7v
	 WpL/6viplPCZfr1vIIHi/3Hhj6oS53vCLItfRz8ngLD6iqkW/8WZ6Ofk7IMOGErB8S7EI
	 RzDX4rPG+Is0ybURfKmhqcrlHcykTC0Pr7ixtKl0nTd1Q9v0rbN15XRxShkVXRgAXbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codewreck.org;
	spf=pass smtp.mailfrom=codewreck.org;
	dkim=pass header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b="UXvP/VSH";
	arc=none smtp.remote-ip=62.210.214.84
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46598606A320;
	Thu, 29 Oct 2026 06:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46598606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=UXvP/VSH
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 1E2C414C2D6;
	Thu, 29 Oct 2026 07:04:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1793253894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MI842OMXovR+56TJ0REGTtFqRIUEY+IlN9+CViJwxzw=;
	b=UXvP/VSH/0Ypf7ybIVsUs4dH0dcJu8xdRx8p6bv71T2W+9P9S5MPPdQa21fDkriLMzH79n
	YgXVSvwDD3B6VIToAcTj9ClfADPEw+QLwxvsYbrY880y8rdVvTcm5LfKjc/HWxFF3DdOr3
	GWwL1WbDj02//nRSIwOm96KLU7Pab/QiA5J8C1igm6ed1aSTnUD89VLa/9E5awWQH3cDC+
	+jvX8Ddwo27UwQwWbnqN5k8TPxWYPdZQ8CZomU5dBgEtWiRurRhFu0d+QYimFkPBeCOcaf
	BRsc0LRMvnKMz9S18l14u3WN5OOji5fX5WqVMnrHSIjSD19Y8VE5SjVFzcdAVg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 9ad4268e;
	Thu, 29 Oct 2026 06:04:50 +0000 (UTC)
Date: Thu, 29 Oct 2026 15:04:35 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Barret Rhoden <brho@google.com>
Cc: David Howells <dhowells@redhat.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] 9p: treat read return values of 0 as EOF
Message-ID: <auLh89BhlBRC2G6E@codewreck.org>
References: <akfHGcqke9qixd3Q@codewreck.org>
 <20260702090941.1298188-1-brho@google.com>
 <2237820.1783934942@warthog.procyon.org.uk>
 <f7005841-80a9-4c21-a114-6cfd6ee63a58@google.com>
 <aqbGBMJ6bntYB1t2@codewreck.org>
 <3d5f70fa-64e6-4df5-bda9-6d3cdd00682b@google.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3d5f70fa-64e6-4df5-bda9-6d3cdd00682b@google.com>

Barret Rhoden wrote on Fri, Oct 23, 2026 at 08:19:33AM -0400:
> On 9/13/26 11:49 AM, Dominique Martinet wrote:
> > Sorry for dropping the ball here, I haven't had any time to do 9p stuff
> > at all recently and the wave of LLM generated patches hasn't helped...
> 
> no problem.
> 
> as far as resolving the underlying netfs stuff goes, i don't know how much
> of the logic about "are we at EOF" should be in netfs or in the servers
> (9p).

Right, I don't either which is why I was hoping for David to follow up
:-D

> would you be OK with merging my original patch so that at least 9p works?

Well, it's certainly better than returning ENODATA to userspace, so
let's go forward with that.
It still leaves much to be desired (cache enabled, symlinks...), but
that can come later if someone has energy to fight this windmill

Thank you for your time,
-- 
Dominique Martinet | Asmadeus
