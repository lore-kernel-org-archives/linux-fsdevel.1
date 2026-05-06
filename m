Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8CE283C93;
	Wed,  6 May 2026 02:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778033534; cv=none; b=e3dDa3ws+uUcdF+/UpAVM+P0+gCWwthPZCSc2gGdI+KfvDzgzMhRk8HQfnFRpCHm4aIpESufPOiiQ6TwdTz7+SCH2ET3zYN6myAzJdvgXOgehxONPLHdPodmfjuZoiw3wO27/Ljl0+jPv+b2kaa5GGqb4ABlpPDfJ5pjVvG4zSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778033534; c=relaxed/simple;
	bh=yilvhPrj1ju5FDA3bMjHi5yMWu5wgOhp1w9KaDp8XfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhtDQB9BBbHZbdZXlyHSGtWz7SAW8EM7/bdlDq+12osZzahXOdHid4QuZScBsTt6uvEAdWGlLXyn9iTZeezbyaZvkRkbnu+DZ2pQxkgYcEjNNvJBzTEYg+4KnPMwwFYyYQTLGJ2F6RlEamPQowGqbNYrPHoZ/PdfTPQ1UPp2gyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=tOPtOkxx; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="tOPtOkxx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=w0GmS+KMCGmyK5nzG4Ia3M28fDWOzW1rTr8rMiQPklQ=; b=tOPtOkxx6s1Ue2LGi55sT1bWSl
	TDXsNRTfu0VVy6oPwg81BhzMi9ySn1W6dxWimuauEjAeZI5lCi+NfgRkkQmqrr/ERp4vDuG0lvP1E
	UlgdRRoyNqbDpAJ01sNCI+m7R6bYqgd1fdb2zpmlBrO8eY1wexwLLA9HnX/q8oIH8ZNxVv7ZzdRS3
	hBYlG5b8B71KRqpHubvtNsWonct0iTT+hi5rg3/rGvLgOR/6fvgcu76lT2HD2RmIShFPB1bN0c8qJ
	P84PuMFJoyTXBjbgXxcN10zqrWMl/A1L1QJpvNLFagaAyWa8BQWafCt6hP1reKXBbGcL4GY7rD6hd
	fM+9JmZA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKRkU-0000000BOzx-1XCg;
	Wed, 06 May 2026 02:12:30 +0000
Date: Wed, 6 May 2026 03:12:30 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Vineet Agarwal <agarwal.vineet2006@gmail.com>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot <syzbot@syzkaller.appspotmail.com>
Subject: Re: [PATCH] fs/namespace: fix NULL pointer dereference in
 do_lock_mount()
Message-ID: <20260506021230.GJ3518998@ZenIV>
References: <20260505095156.178351-1-agarwal.vineet2006@gmail.com>
 <afn88B9Z5TM-0d0T@lt-jori.localdomain>
 <CA+rjy8fM+8ahj7dcBWjnACU8xBWBqW4ssQFpi68dqRc-F-V3Xg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+rjy8fM+8ahj7dcBWjnACU8xBWBqW4ssQFpi68dqRc-F-V3Xg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, May 05, 2026 at 11:32:45PM +0530, Vineet Agarwal wrote:
> Hi Jori,
> 
> Thanks for the review.
> 
> >From the syzkaller runs, the NULL dereference in do_lock_mount() is
> reproducible across multiple VMs, which suggests a real race rather than
> a one-off condition.
> 
> The suspected window is between where_to_mount() and inode_lock(). While

Suspected by whom or by what?

> where_to_mount() returns a dentry under mount_locked_reader, that
> protection is dropped before inode_lock() is taken. During this window,
> concurrent mount topology changes (e.g. rename, move_mount, or unmount)
> can occur.

Which of the exits from where_to_mount() has it taken?  And which
of your conditions does it trigger?

> As a result, the dentry obtained from where_to_mount() is not revalidated

"revalidated" in which sense?  "Has that local variable suddenly become
NULL while we hadn't been looking"?

> before use, and may no longer be in a state suitable for inode_lock(),
> leading to the observed NULL pointer dereference.
> 
> I’m still investigating the exact sequence that leads to this, and also
> whether retrying (similar to the existing -EAGAIN path) would be more
> appropriate than the current handling.

Do you have a reproducer?  Which kernel it is and what .config is used?
Incidentally, do the checks in your patch actually trigger on the setup
you are testing?
