Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3CB287503
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 20:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776801753; cv=none; b=RBuGY19uKDlFesyajieTh+LEpRfLEdRl/1HENmVM8v9fhu29AQKFjkSjMH6zqIRFO4kY7jJSi94+fIK7g4R4M/VorYv06qj1C0pH3OnS639Gxhb8ItfBv87l8wM384US4w9OdioHkznjM885Pzn2dz1VV+O5T9AQCR8uVlLDeYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776801753; c=relaxed/simple;
	bh=xyR+WOyntxI4ii8MgQyfMbkOUve3502bGIlgn8G81rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAgJMsJShT2Ijxx8hKxd9Cz/GyjfSkWKfhntjgG7/ns47eXLpgL0ssu4L2FkvNfWSZQFtVpIHBWCNZvUK3nHAMkF3A+lRetzZGsChoddd5lxgt80z4jMiCmVip+y6VMpGhK86LdnVCTK2MUWZhLr//RLCK+9RCkqHAKFo/D8D8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=GPi0jmao; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="GPi0jmao"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wmeHFrGwqItBqioD0dWv3w5g2DLbuhL5Sq9X1/xK3EI=; b=GPi0jmaoDwMzNLkbaKFLI8giPH
	O3nBmvwT7qrwNflCyPq5IUxzBfC4qD+XQy3T1vrzyWqW2+ecZsQfcqv8lNGOGM9QbJ4pUTpyPIzFs
	TIXO+R0DymVVW+ffGZTqPh4B52+S+rFGoVSabA72Hl3YOZEXjxUSXSj0x+91hYpmah+OcvxG0ilwW
	NXre08pDy5j+GkQP/TqcBv3KUD34cZsUPsgdYFbBUu/DM/F8lG7lcyVeVb3yqf69l0Obm+5eqQKAb
	SYnx4PElE8mkx0Hzw26bWGNdPjW6uWG97tHc8IKIwE5fY222kak/obxgLYA4jI+WW28ZzPmul/8gX
	PP3aYpsg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wFHMi-00000004qWM-1gyw;
	Tue, 21 Apr 2026 20:06:36 +0000
Date: Tue, 21 Apr 2026 21:06:36 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Jan Harkes <jaharkes@cs.cmu.edu>
Subject: [git pull] coda dcache-related cleanups and fixes
Message-ID: <20260421200636.GE3518998@ZenIV>
References: <20260405021515.2866402-1-viro@zeniv.linux.org.uk>
 <20260407220427.326lgx22n4jgsy6b@cs.cmu.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407220427.326lgx22n4jgsy6b@cs.cmu.edu>
Sender: Al Viro <viro@ftp.linux.org.uk>

The following changes since commit 7aaa8047eafd0bd628065b15757d9b48c5f9c07d:

  Linux 7.0-rc6 (2026-03-29 15:40:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-coda

for you to fetch changes up to e252ed8988578f01da5a4f5aa4c2269f96f03951:

  coda_flag_children(): fix a UAF (2026-04-04 21:03:13 -0400)

----------------------------------------------------------------
coda cleanups and fixes

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (3):
      coda: is_bad_inode() is always false there
      sanitize coda_dentry_delete()
      coda_flag_children(): fix a UAF

 fs/coda/cache.c |  2 ++
 fs/coda/dir.c   | 15 +++------------
 2 files changed, 5 insertions(+), 12 deletions(-)
