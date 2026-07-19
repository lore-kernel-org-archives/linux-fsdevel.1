Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C482C15BE
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jul 2026 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784480041; cv=none; b=fex/xWMsGC7UQ72W/94csyb9rxM32S2Xdf5egaZH3m/EMPMv8id3Fx2/5AVCmwuqJ7WC7ukzCpyVsw/EU8hEU/nWYs2/xMn3KRnUmoj00DglhDjqsut+YykHoKUPqgfijNlG6oYWTOK3eyS+132X0noHZ0i0Zd5wZ5HghZzG4lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784480041; c=relaxed/simple;
	bh=OR6238KyDI7VBDKNv/XrlL9jFcMKRTOny5+F5ErJlOI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOURvJdIJjrSlppIPJEPsY/Jk4rs63DwMFFfpSM36Zsklzh5VmmXSYvqdAAZz5M87j7JaBE0nITgJJLxcl1npRP4loj+YqaQL485oqqfvpAdBq0++uNi9t1KKq1tJ9g47NVKBi34CzC6Eh6EG1ZE600iUxJsAFYl36g8DBKY1Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=GR4EOGzH; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="GR4EOGzH"
Received: from macsyma.thunk.org (pool-108-49-65-18.bstnma.fios.verizon.net [108.49.65.18])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 66JGrpBI008589
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jul 2026 12:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1784480033; bh=XFg10I3KOcDI21xuB3OqUiEPcvRIr7GNlWX72motYo0=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=GR4EOGzHCgpG6OaD93br5/huFmiHSEmi2lPYCF52gAAotznaZnOhgoy0P2W2NgKgs
	 gfhQ3qsuGQCx/kqciCCX2gtzGEpPQmCHJzyCcc+a3AOU5T3eTIIIXcVog5lc3F5EBp
	 dlk1v+VomtmWFCA0iuyxgSHk+u6AVI7d2FWLf0tMivXmrw7VFi95rVLqZku/U4uggI
	 JDzKWTriVwWb8QBlhEt5ggck1j5QMNcIyWj8Em3to47UOw5uaFfrpiFDtt941MJond
	 Sh//ISMajIG6syPNp8Tf09SKptL9GBfpu3phLIwYXal67U0Y2S1lqaCEqG25Z92ctD
	 ktduQjaWT4KCA==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id B9302AD0152; Sun, 19 Jul 2026 12:52:50 -0400 (EDT)
Date: Sun, 19 Jul 2026 12:52:50 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>
Subject: Re: Should we consider disable generic/563 for file systems that do
 not support cgroup2?
Message-ID: <alz_HixXWhKTIfRV@mit.edu>
References: <ff1c0710cbb31f8ebf51457c0629a496ea6f658e.camel@ibm.com>
 <alpUADtQccA2zmWh@zlang-mailbox>
 <alzYSGVz86d7wDXn@mit.edu>
 <alzzQA9SR55FynDu@zlang-mailbox>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alzzQA9SR55FynDu@zlang-mailbox>

On Sun, Jul 19, 2026 at 11:57:04PM -0500, Zorro Lang wrote:
> Thank you for your reply. You are right. I was just listing some
> possible options, and I did not mean we must change the kernel for
> testing. Changing the kernel just for a _notrun is indeed not worth
> it. If there is no simple way to implement the _require_* function,
> we can `_exclude_fs hfs` directly :)

I wouldn't necessarily rule out changing the kernel so that file
systems can declare whether they can support cgroupv2.  The advantage
is that we wouldn't need to keep adding "_exclude_fs xxx" each time we
try to make fstets work on the simpler file systems.  It also means
that if a file system adds support for cgroupv2, we wouldn't need to
change fstests --- also, if the patch gets backported to an older
kernel (either an LTS or an enterprise distro kernel) we don't need to
try to modulate the _exclude_fs using kernel version numbers (which
isn't guaranteed to work given the backporting possibility).

This is a philosophical issue, and reasonable people could disagree on
this approach.  For my part, I created /sys/fs/ext4/features/*
precisely so that userspace (and fstests) so we can test if a
particular feature is available on a particular kernel.  Otherwise, a
test to see whether a particular feature "works" might have a false
positive if the feature is broken, and the way we test whether the
feature is present is basically what was accidentally broken with by a
regression.

Cheers,

					- Ted
