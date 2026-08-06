Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E593C6A57;
	Thu,  6 Aug 2026 09:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007084; cv=none; b=WFSqaetpUHc/SQDO7pB0zWNGIP/fLR2aYJIbw2gEKEueT6HoxjTlbyikGG3CkUBJsdppQWR9ZhW3diT1YloN/9uZrd9nv4JD5qmHI/nb4L/WImyHdZA/Smf8FG4iXfEl9CIKSJts07OeGWvglMotABUiI9HUTzUyJ7R9PGlq0zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007084; c=relaxed/simple;
	bh=KQYPk7juaTeXMbRBfcT+ushrM01kmqtPUXKvCGFve74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjKoxmSPUdpRWxH94l++WAVBlQwZQtrvL/sMOqr597rpIYV7kg8WGsTv/j5lav1RtMyl612RGHMdTXQvQxcPtejPw45vRnvTQnrwA+E3kNruK0HzA3iKZ2VTCtPCY6q+taUiLNox2Q4dGIbQylVO3F51pCzkgE68sGO0mzA4M1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=pWBj080r; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="pWBj080r"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=tyI6T7e5Pmidp240o5CobdzH++3HaW0lNZsls1jFB2c=; b=pWBj080rrG7J13i6988IKw0xuI
	9DZD4TlXwDLCZJxYSKVtj41Gn4Akve9HmdXJGtBGnddQybo188OJQMM6uju/l6IFdSGN72Cd6b3O2
	u40v7LBuhknGtSGC8SZ43A8A3PyQabFQPu5dr7YRLVrYNfTL3l2glgVZ7O7jQ+AVjlC6DMYJUcOH2
	JRgnm1J5rMCAHJan9WfFRj4oG+KjWxCCtu4LvTZ02jpb1tQjoUsf+akU0+e+1lJq2YT1sXVWK67/i
	tuZbm3jZdlnJY+nQl8uU0Zz5xujlKwCHibqS7kpmdXozk7i6uVLSq+QiYWG2fdvzHKuZPfXImi9pX
	DR1J8l3Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wru1m-00Ea91-2d;
	Thu, 06 Aug 2026 09:04:39 +0000
Date: Thu, 6 Aug 2026 02:04:34 -0700
From: Breno Leitao <leitao@debian.org>
To: syzbot <syzbot+2f6a3b7dc3b442ef515c@syzkaller.appspotmail.com>
Cc: a.hindborg@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] general protection fault in do_getname_kernel
Message-ID: <anRNVC1S58v5OYbd@gmail.com>
References: <6a73bcd5.01d0871a.3a0d52.0004.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a73bcd5.01d0871a.3a0d52.0004.GAE@google.com>
X-Debian-User: leitao

Andreas,

On Wed, Aug 05, 2026 at 03:44:37PM -0700, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:

This looks related to the recent configfs changes — we've had several
similar reports. 

The fixes I've seen so far don't look right to me, and are coming from
people that are just using AI to fix it, causing more mess than help.
See the comments for those that I've reviewed.

Do you have something in the works, or should I dig into it?

--breno
