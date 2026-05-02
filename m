Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF1B38DD3
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 May 2026 23:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777762862; cv=none; b=BA+nbTHOuoyjLs7tSQFWAApv0+FahqhCSLIbgLP7WTj8i59H1sSEKxGcska3/RXm3XbRZdQ6KfvVtVsXFRY18MGxa+Qln4WbqNlO2UyFZ8s/TLxZcjGZUgdGEwYcQXvvolTcZmhLycoK128jO47Rz+P8fsEbqLK6eJ31HqhO7kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777762862; c=relaxed/simple;
	bh=bPgI/OKQIcJH1CZbPPwoqDzyndIfEa8Kd8jw9Jh+Dkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iL9/Ao4nGJAHYjUwiRe1d0u3nU/LXM3RPxd7A4XKTEOsBoS3znM78aCLzC5D6TswRNq/WSVXgAWk4YQpCzy9vh6Vg62zRpxHig3zpENTaZUoi3ircauZP72D4XYjP6lqmaUN9+vDOPaK8L7ly1I/GDiqLuHIjE7HwyLsflHUrTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MAbP9RNQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MAbP9RNQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YbQjRQde+bKLJhuMJWLB/NASASENw+79xEXblY67pNo=; b=MAbP9RNQrJif9lV6Xgf0otFK05
	EtWhk3dU04NkNHulHcK79tcwJ6rFENGf4E8tuwOZEYB1dLVS22463scSRS8DaY8QjJfN4rrTIMFCq
	UnPVJgUkQZXQymHeomjQbdbRT/Bsg52+/vUlS+E6M7+BNeon/BYi+nD0O5qw8Y0BUUbh0mSl11IGs
	/IdGiuHRd4b9KxyA4y9CVcgiiagaIsHMgCYBoJ/nhCBJu+ygn29QSjmUhhK9246iS/Aiu+GDSYwxo
	QczMzrMldWN72ItN01ftai46Nq3EQ8+ztgWTmUPT7oAnItI5UJ4ArzcmcIZYZuYaUMh5DycJmgcGX
	0jjhb4BA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJJKK-0000000GCTO-1GuU;
	Sat, 02 May 2026 23:00:48 +0000
Date: Sun, 3 May 2026 00:00:48 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Gregory Price <gourry@gourry.net>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	lsf-pc <lsf-pc@lists.linux-foundation.org>,
	Bharata B Rao <bharata@amd.com>, Donet Tom <donettom@linux.ibm.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>, linux-mm@kvack.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [LSF/MM/BPF BoF Session] Numa-Aware Placement for Page Cache
 Pages
Message-ID: <afaCICnrkTEJN562@casper.infradead.org>
References: <h5ossmwe.ritesh.list@gmail.com>
 <afNV5wbhsFQJLzxi@casper.infradead.org>
 <afYQz3YJdWB2R-1q@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afYQz3YJdWB2R-1q@gourry-fedora-PF4VCD3F>

On Sat, May 02, 2026 at 03:57:19PM +0100, Gregory Price wrote:
> On Thu, Apr 30, 2026 at 02:15:19PM +0100, Matthew Wilcox wrote:
> > Ideally, no, the kernel should observe the task and get it right.
> 
> Out of curiosity, a use case i've been exploring is something like
> 
> fd = open()
> buf = mmap(fd, ...)
> mbind(buf, device_node)
> /* fault file pages directly onto device memory */

Could you be explicit what _kind_ of node you're talking about here?
My initial thought went to something like DAX where the node actually
contains persistent memory and the fd is a reference to some chunk
of that storage.  But I don't think that's what you're referring to.
You might be thinking about a presentation of DRAM over the CXL fabric.
Or you might be thinking about memory presented by a graphics card
(perhaps over CXL, perhaps some other way).  The meaning of "device
memory" has become thoroughly confused (thanks Jerome!) so I sincerely
don't know what you're talking about.

> this obviously breaks if there are concurrent accessors of said file
> with read() (filemap will just fault onto the local node - clear race).
> 
> Do you think there's a world where we can hang a mempolicy off the
> address_space via an fctrl() call with CAP_SYS_NICE?

I don't hate the idea.  Presumably we'd document that it overrides any
mempolicy applied to the process?
