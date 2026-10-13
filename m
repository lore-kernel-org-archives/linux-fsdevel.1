Received: from mta0.migadu.com (out-156.mta0.migadu.com [91.218.175.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DECD37A83D
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 08:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791880847; cv=none; b=oMHEjz20D+W5W4tsl3DXvfGDnkHxu8f1LO6iQ5yCseaBUxPWd0V41znJnbQA4MtksUWZEiOsjYj1dHnE7nm/2c3nivbdkLObrf8fG9JTTqQKKoJnw1ouLSPftlDXYCIa/UxQAshTKvBKMLaQtkvLkG/e93ARzxM+8MqSLuNwjPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791880847; c=relaxed/simple;
	bh=YOL/7WJfxHmwLvZpmThwvlfPLOa9o0yfUqTDeDDxNdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmHX/G7tdaJniBgTgVETvK9kze/fBnpicf2xJ+GjQ9Xc9J+366neEyUlsD6sDMs6IafOCXs9c85y7kYSvVdhov3qu/ojbRCJlne+FvpAbFIHtO695xtyfGY28RPsXxOyBvYCseTlwuieKOioopIUZSIwMg6kJPZYYyiEb8hB0Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pbyf7Z2H; arc=none smtp.client-ip=91.218.175.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pbyf7Z2H"
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=YOL/7WJfxHmwLvZpmThwvlfPLOa9o0yfUqTDeDDxNdU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791880844; v=1; x=1792485644;
 b=pbyf7Z2HdCVXaoI9fyHQ8ArFBeZoeexs3jGDc3IlAS52lc08Q4dSHhGERHsOnO7IFThEkvRB
 dV4fETr2UBsyEB+9YVSfrxBYwjITjTvcocQJ0NIAqYCGeJC2MiUpnq+MDpz0vUBrBrSjeIjPjE0
 +z+1N6AHKoIoj8v0mZkXU+ns=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8cf670064a0202ad;
	Tue, 13 Oct 2026 08:40:42 +0000
X-Mizu-Trace-ID: 8cf670064a0202ad
X-Migadu-Flow: FLOW_OUT
Date: Tue, 13 Oct 2026 10:40:32 +0200
From: "Pankaj Raghav (Samsung)" <pankaj.raghav@linux.dev>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	"Darrick J . Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Ritesh Harjani <ritesh.list@gmail.com>, 
	Zhang Yi <yi.zhang@huawei.com>, Christoph Hellwig <hch@lst.de>, 
	Dave Chinner <dchinner@redhat.com>, Daniel Gomez <da.gomez@kernel.org>, Theodore Tso <tytso@mit.edu>, 
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Andres Freund <andres@anarazel.de>
Subject: Re: [RFC PATCH v4 12/12] iomap: Handle deadlock due to repeating
 folios in RWF_WRITETHROUGH
Message-ID: <as3t7j3P3mQhsr7p@quentin>
References: <cover.1790596383.git.ojaswin@linux.ibm.com>
 <5159efdec832e8179e9f689a9292f9bf47d9a0fa.1790596383.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5159efdec832e8179e9f689a9292f9bf47d9a0fa.1790596383.git.ojaswin@linux.ibm.com>

On Mon, Sep 28, 2026 at 05:33:13PM +0530, Ojaswin Mujoo wrote:
> In iomap_writethrough_iter() we might encounter repeating folios across
> multiple iterations. Repeating folios can occur if, example,
> copy_folio_from_iter_atomic() does a short copy due to userspace pages
> not faulted in. This is an issue because a previous loop might have
> started writeback on them but not yet issued the IO. In the next
> iteration trying to get the same folio with FGP_STABLE will result in a
> deadlock. Since repeating folios will always be encountered back to
> back, we can just use a simple cur != prev check to detect them.
> 
> Use this to avoid waiting for writeback or starting writeback on folios
> we have already processed. Note that in ->endio() we might end up
> calling folio_end_writethrough() twice on the same folio which can cause
> issues with folio_xor_flags_has_waiters(). For simplicity, just change
> the folio_xor_flags_has_waiters() call to an idempotent variant.

Is this an outdated comment?

> 
> Reported-by: Pankaj Raghav <pankaj.raghav@linux.dev>

Thanks for fixing it. I think I was able to trigger this in a VM with
limited memory where the chances of short copy is probably higher. The
fixes makes sense to me.

I will run some tests this week and report back if there is an issue.

--
Pankaj
