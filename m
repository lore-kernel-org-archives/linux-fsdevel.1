Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F77346E7D
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Apr 2026 02:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775182312; cv=none; b=JkFqASIyqhMVOFpyTtSJjkZTg8yMy9o6XQ0LNnNa5y2uCxAqPQbanF8nzHQcSLCDaniI3i2lMPeEckgz8Q1jITw4b5FgbkYYLTw2h97Ee0YwZuhwc3itHFV51ZVT0ej0xDsYJoWC5E29zOsZFErUrLjlfO1lcivX5WbKUjDRhJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775182312; c=relaxed/simple;
	bh=Awp8z4vNVcT1QQN5ibEqEhOs/+ENnTnUEC5q9IsCCTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8L8HwC1dcPQQw03xq5S290rPxRBWD6Ad8nl9XF9xuxspyuWcVORlrWqkFCQZvpWr18ZGSMFXaVA2NlFka8jJ9V58l9OAkr/IPgjpkc9vdWf8FP6sIcPMY5rpTjGa6NqFZIzi63Et1IXeCgz1quKzwdXVVCrt1SXmkml/6yAYN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=SLpQQnuG; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="SLpQQnuG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vmz7zTPa8eQmcjBs+rXljONJcOGG7shnQ9yLFtEO1Kg=; b=SLpQQnuGXxDfX6DAI0A2KQXu71
	Myq/ObjwPtfO5JqouSq/c+iD7sBLWvD8fWVbmhii5MEatHyqDMtcCV19BIYPdJuK92RN2THU2DL8G
	w3ZUSomFVRvUPjaN1dVRxvxwEQ1P+pcA5ZHSv0Lmw9Ls0hIDmm8ZTRK932OJc/ie9xKXQ5KiCuwAa
	gAOEP1fH5HrdAY1pHt9QL/F72Pdo3l+h04Kg7PU8K4JXIjOkluh+KEO4aIwVbUstviH+cX7+YZdAF
	Z4PsoppdF49btL9Zi4IBdfqptyJO07ZWyhl3Hy3H2FSWT0TiedbiD9rc9dZUZKeVwSDP/HmuFZmTe
	+4b2csYg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w8U4A-00000007tb6-4AZo;
	Fri, 03 Apr 2026 02:15:23 +0000
Date: Fri, 3 Apr 2026 03:15:22 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Eric Sandeen <sandeen@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Subject: Re: [RFC PATCH v2 4/4] get rid of busy-waiting in
 shrink_dcache_tree()
Message-ID: <20260403021522.GK3836593@ZenIV>
References: <20260122202025.GG3183987@ZenIV>
 <20260402180850.3729310-1-viro@zeniv.linux.org.uk>
 <20260402180850.3729310-5-viro@zeniv.linux.org.uk>
 <CAHk-=wjR66-0qL08k9p10Lt9vuvmddFT5WvfnG+xXf4Xv3-VhA@mail.gmail.com>
 <20260402224439.GI3836593@ZenIV>
 <CAHk-=wg7O-p8L7384myYTus6NH5aYdoS=y=+iALL_8DLT3=ZLw@mail.gmail.com>
 <20260402231643.GJ3836593@ZenIV>
 <CAHk-=wg5HkyPCFsfXS6u2xe5h=dV5WT9zaeqt-fRQyE+OxKGYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg5HkyPCFsfXS6u2xe5h=dV5WT9zaeqt-fRQyE+OxKGYA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Apr 02, 2026 at 05:29:28PM -0700, Linus Torvalds wrote:
> On Thu, 2 Apr 2026 at 16:13, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > The incremental I've got right now is
> 
> LGTM.

Force-pushed...
