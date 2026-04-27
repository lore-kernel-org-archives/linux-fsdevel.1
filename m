Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E304B40DFDF;
	Mon, 27 Apr 2026 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777297607; cv=none; b=j5VcUzUhqSMiTkmYKK4pumNXCZ6eJOri8uppPxxsGZcLqiwulxZTSXBlONeOlzRPVpMYFAa1KbRO7bK9+PZuYtfD0Kin7q33qHaFVq3vvhQAWi+kCOOAsbhUnl9UYYwFBLuCeaZTf2cI0dVgMhkoL0bQJoc4+rNrELxmbAv2Uu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777297607; c=relaxed/simple;
	bh=b1v9zCDL2cRq2Ry/N0tP7LrOi4K6gtq2cTIcm21DIKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DcnAT8+ZlAymRaecWAuiD+P1m3V80/YOpHI724JB05XIPc7hmiP+DFBPzy7oQ03c/IERVRh20TczPvpbTa26DNQ7OBcRkAZmQwk3vBNvkWRWLWUMKyyQBPESZvwvRgs57uRRKFIlZRvd624U13ASmKKDItQLYnX3LFZ2+6XOXFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nnivH3zk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nnivH3zk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sCmmmwqgBuNaPeI1bq2jxwmv/keIRJ0vi8hLOaI5hEI=; b=nnivH3zkgV1Ov1QWh6C2FYTUue
	xMrOvW02GwgsQv8HN4+M06Q5vYBj6llNYneQTmnGMFiWwtIG2xGzy4MrTWC8gK0qk5eDvZNfgYpBm
	a5tKp97rWE3CDq0qK/LcziNMBy8FVch4iAyjt+jO9DJbiiIAP4OQvnBaobqqh8e/2eJ210EZY5q7H
	92A4wXMyiPvFnh/qQTilKJML3wFw99Vdf/3BN1vjpCdrgFhBNPYRPlVtX10Yl/GRyD+JvOisGPtRz
	JcbbvXegOx65f1fl1gZ6aRADbi/LzWWZr9bxcmU0vaJVxvFCzM5P5jzN8KnGyG1Eg/gSzIDAfFWQ1
	Prf2/l4g==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHMIL-000000029Xr-471M;
	Mon, 27 Apr 2026 13:46:42 +0000
Date: Mon, 27 Apr 2026 14:46:41 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Chao Shi <coshi036@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [RFC PATCH] fs/buffer: serialize set_buffer_uptodate against
 concurrent clears
Message-ID: <ae9owdaK6f-wFgom@casper.infradead.org>
References: <20260426020137.1221985-1-coshi036@gmail.com>
 <ae17nszpQA7Eqbc6@casper.infradead.org>
 <mxlij3dhmnqnile7hm2t4ixomaumibooydo6puym3edt2o2zyg@toyj4j5yid2e>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mxlij3dhmnqnile7hm2t4ixomaumibooydo6puym3edt2o2zyg@toyj4j5yid2e>

On Mon, Apr 27, 2026 at 01:24:45PM +0200, Jan Kara wrote:
> On Sun 26-04-26 03:42:38, Matthew Wilcox wrote:
> > Why are we calling clear_buffer_uptodate() in end_buffer_async_read()?
> > If the buffer is uptodate, we shouldn't be reading into it.  If it's
> > not uptodate, we don't need to clear the uptodate flag because it's
> > already clear.
> > 
> > I've been deleting calls to ClearPageUptodate and folio_clear_uptodate()
> > from filesystems; it's almost always the wrong thing to do.  But the
> > buffer cache does have slightly different rules from the page cache,
> > so this may not translate well.
> 
> Right, I think the clear_buffer_uptodate() call in end_buffer_async_read()
> is indeed superfluous and we can just remove it - possibly replace with
> WARN_ON_ONCE(buffer_uptodate(bh)) - to deal with this race.
> 
> That being said block_commit_write() could possibly race with
> end_buffer_write_sync() as well and there the clear_buffer_uptodate()
> should stay (well, unless we want to do a serious rework of IO error bh
> handling). So the changes to block_commit_write() might still be needed.

Well, I don't want to do a serious rework of io error bh handling, but
I do have questions!  Let's say we take this patch, so we do:

	lock_buffer(bh);
	set_buffer_uptodate(bh);
	mark_buffer_dirty(bh);
	unlock_buffer(bh);

That means we don't hit the warning, but we do hit an error in
end_buffer_write_sync() anyway:

	mark_buffer_write_io_error(bh);
	clear_buffer_uptodate(bh);
	unlock_buffer(bh);

We now have a buffer which is marked as write_io_error, dirty and
!uptodate.  That's a logically incoherent state -- dirty means "is
newer than what is on disc" and !uptodate means "on disc is newer
than this buffer".  I don't know if we have any assertions that
check for this, but we probably should?

So I think what we need here is (in addition to this patch):

+++ b/fs/buffer.c
@@ -169,7 +169,8 @@ void end_buffer_write_sync(struct buffer_head *bh, int uptodate)
        } else {
                buffer_io_error(bh, ", lost sync page write");
                mark_buffer_write_io_error(bh);
-               clear_buffer_uptodate(bh);
+               if (!buffer_dirty(bh)
+                       clear_buffer_uptodate(bh);
        }
        unlock_buffer(bh);
        put_bh(bh);

This makes sense to me since we need to retry the write anyway.

And of course, now I'm looking at buffer.c, I found another whoopsie.
Remember 7375f22495e7 where we called put_bh() on a stack buffer
after unlocking it?  Don't we have the same problem in
end_buffer_write_sync()?  I can't find anyone calling it with a
BH that's on the stack, but it's a bit of a nasty footgun.
