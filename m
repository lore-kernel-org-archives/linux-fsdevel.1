Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921751C84BC;
	Wed, 10 Jun 2026 22:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781131479; cv=none; b=hWzv05ieuBYE8OygdkYGjnSJdG86fS9CdiB5bo8sF/RgM90LHQPMUPH9dThkeATGbWfg87M3PvGKv5eJITx/mIJKlTK/7q/F9NGehysZWXwSE/s0/xY1pYC/dmRZtraj6Nn+a9JxX5esL8dRZPdMpzvwQH1HxXKefk8U4hMz9u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781131479; c=relaxed/simple;
	bh=yMLLgWOLJTDZNBCNSM2edglktVvSMzVCIPjZgrgU21I=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ph6hNvb8TtJdZ3VrQKdPp2oUQnYD1cHxVGD56+D5ORrcJyy8L/4KuGZb5pfh7phc4GVUTuA8dZPP8QLdK7O6bh+45e+hrHjZOQNgPZYAjCjp6Anaenm8U5QqQkf2SDSWxRUHc1LepHpOtqAzeP81DGvmSsfjc99cWNA70OjVbLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=LaWsitAF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QlZaJQ3f; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="LaWsitAF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QlZaJQ3f"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D5D0C14000F1;
	Wed, 10 Jun 2026 18:44:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 10 Jun 2026 18:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1781131476; x=1781217876; bh=Zr8idB+Vx/4vqVugYp1ZxeHzsUwPnfBtMi2
	S8n8/ZpQ=; b=LaWsitAFmWG/uaLMLnBBAueFr7bBk8V6FsLzD29Z4aiwfL7yPq3
	ahczL1zwTLcSXwsxlwEcNu7njGFSirYNPrSeJpCY8dm+VRya0ZobrzJYNDi1A8IK
	mzEZwHIc001856Wu4VH3WzIETOxQJVeXea4Fa/C80lmFVVGdbpjGUNWl6egOos7s
	jctDzeNKXxdlBuxhBqtG44bksaN2f1PgeLlNzIwhps2cOzDrf5p7t1/NVJlhBlVh
	UMHu3W7ohFO8PEAe1xRM3a/UpUXiM3NBTFHFgjmhNq7sJ1VJ53Yi//Hj/4OmUR5p
	ctZOwsWMtn8EpGGLJUzUaKz5vsvKIwutxKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781131476; x=
	1781217876; bh=Zr8idB+Vx/4vqVugYp1ZxeHzsUwPnfBtMi2S8n8/ZpQ=; b=Q
	lZaJQ3fDn666ASv1C6fjvjRn3EZCAfv8mr3ZN0QdpuPNkK04GSxv62brgn7Slx2p
	wcVDJ0lEHlbB2Iq/C9r0gUACY/CW77pjUoSckqB7B4phBXfSbaLjz3d0l3cdXW63
	DnoSg5KmM2qgezE8CpTcZjPr8R0I0Hb1EuDCllMKhWEJLZRHbhpWjTiXJS86XDqY
	jIUu0nrr0vuN6QkCsgfhLgKXKEH5evyela1P2b0TUUOsxl9QI1nVZvPQaF4cibrs
	gQxYSZ+k6a9vBSjZzDKyCbJ4lPZrHy2VyVdXfYldOBHQD4au3ynCx5i11Ar49liE
	HLkxg0T1dJyw7vcmAMPgQ==
X-ME-Sender: <xms:1Ogpam2Qz_XDsV1mFj6qet0CP-mJUlsAgQrsgS89S_IALv3JaZIcdQ>
    <xme:1OgpaiDGmtObx49erAhdZuBcisCLbCg2WVa9qxNt1wyvWhFFo_tovjELhDVK5vQYC
    iT8z-HZx1EA8Pm2CdcUGQHK6pOGIaUqh8BK2oZVkEAxGKvpEQ>
X-ME-Received: <xmr:1OgpaqdjoOIy9zrCIA2SWwA6__pKs8yDxJnCicVzbyyoxyvXCIrAQ5LAJddmQZsK6Bj7z5x0J-fnXeFSepwqOhqYCXlS0Vo>
X-ME-Proxy-Cause: dmFkZTFJn4NQ2kGNDLSgbNrVispyctOY720tX6xlgK3mt3dlSkgau7pftpB72ht8MomSUL
    ttr7VU2c8WaybP/g983mUuWZ0udjP9+NRoylRdlrbbOFYHb0qaCpvDd+JCU6t2kqhFGeqB
    7jZdaYvOyVovLZrXphRaBfMJH1wQh5HxtTQLQcb/aIbU+cG1BWL2aTGRZrL2X3M8aMIDCe
    5Y3rPNtxw4KoEh7Hdb/fJNQ96ioFPTHPE8uLW5PZ6QkJVJdmBf+8xnfmdJ7ZVa5WdnlCoU
    rLSWzNtyaG+Hfr0GRaILu6k15PDIrSCqEGyMGxTMzhEEB9JxS1TUbpLG1qx2UWT6N49DkK
    r4Y/SXj7GF2VWUwtoch04bQNkYnrltzKMns4c/xmq/HO2K6l3d1MSEvpYLRrIRZoIm5yuu
    jy+ucDXmJTDQFL8ViRV20k7gaQsfcMNUWHGHTLOHXWDa8FppnTAaxn0hviziLeLte9ZWjc
    myvpLnn6YxfAKxuqjd2oPvOEdnHwRjNYZ6Sa8uRXJZ7BAdUW8dhI82RD3kGYtwlmaKt39A
    vKM+NYGxHqinMFXJTG8BsaWaSYY6XBDJyhDnoi9hvLTEVanCNhKmWKr4pSTCC4KeE6fq4P
    lqqOIXgMQra/OjPTUyNvfzlKpBHBSldXfkE8bEhuJoVVYp3hnxu7znMNUFrQ
X-ME-Proxy: <xmx:1Ogpan65Nz8n7S6RieHmGGCshaDi8bkjnA1W7tJZQ3jn8Nb6_Da98g>
    <xmx:1OgpalWJTIiHQXXf8NnKdfuVJDpQo6Un6fzHeEXvzPxXabUpb5YdFg>
    <xmx:1Ogpau5GQgAeXeW14rB0FkrxlSCopKN_QNSFHkynEEHySXrha9nC9A>
    <xmx:1OgpaorWz9VF7yQZEx0cSLn54KumTrAmINqzcEFz9ULUTmPKPCIzCg>
    <xmx:1Ogparq0184oZBW6rPO13nJ2560FEnXs9D4_NPlJoQfDiGfSgow2Vr3u>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 18:44:34 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Miklos Szeredi" <miklos@szeredi.hu>
Cc: =?utf-8?b?0JDRgNGC0LXQvCDQm9Cw0LHQsNC30L7Qsg==?= <123321artyom@gmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
Subject: Re: PROBLEM: FUSE_NOTIFY_INVAL_ENTRY leaves stale negative dentry
 after c9ba789dad15
In-reply-to:
 <CAJfpegt4mAXDFOr47XaYPgeN1LFm_BNC_8SX-2A8kHEztWdNHw@mail.gmail.com>
References:
 <CAFbF8N7++zopZuEcsKRxBV_sgOGCbzCY0hOyMw1SiGAtuzGhyQ@mail.gmail.com>
  <CAJfpegsCJnMfn_BzzTK7m9ndCGVsnPit8ZsT0fzAhYoY+yOsKQ@mail.gmail.com>
  <178035740095.2923901.5908691318688917347@noble.neil.brown.name>
  <CAJfpegswAZv8OmDAcK-5u8kssAF1vZKe4gdDB2XPErAnoGFSYg@mail.gmail.com>
  <178056619459.3392745.3091041855723132411@noble.neil.brown.name>
  <CAJfpeguDUS_3X-AFZD6XCJB1SjVkFGu2aJ+p1BK574Scu-ASdA@mail.gmail.com>
  <CAJfpegt4mAXDFOr47XaYPgeN1LFm_BNC_8SX-2A8kHEztWdNHw@mail.gmail.com>
Date: Thu, 11 Jun 2026 08:44:31 +1000
Message-id: <178113147143.2249772.1308183110159200568@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 10 Jun 2026, Miklos Szeredi wrote:
> On Thu, 4 Jun 2026 at 15:59, Miklos Szeredi <miklos@szeredi.hu> wrote:
> 
> > Okay, so this is about making VFS more scalable?  Can't we just leave
> > filesystem code alone in that case?
> 
> Unless there are strong objections I'm going to revert commit
> cab012375122 ("fuse: fix conversion of fuse_reverse_inval_entry() to
> start_removing()") and revert the fuse part of commit c9ba789dad15
> ("VFS: introduce start_creating_noperm() and
> start_removing_noperm()").

I think that is a good idea at this stage.  Hopefully I'll come back and
revisit this in another cycle.

Thanks,
NeilBrown


> 
> Thanks,
> Miklos
> 

