Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2426D25785C;
	Thu, 25 Jun 2026 18:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782413872; cv=none; b=Tkh1WG1jV+KDJqjeVKwfDgPsd/4ne2PsqZs6QqDwpYOAiAm1Rvd5h+unycITclgFyezfJ4neKZVhSC1UQniswYvTnTt006u5pedgLlMsJxUqirIyv/VC/IOrcj5crizWGldCJlNCQ7CTAAHlAjSP9pz9HiEoZUwYRwerG8S1l9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782413872; c=relaxed/simple;
	bh=65JIBAApE+sSiOUoTRUXpmMzW7x84SYB+v8gJ3u/IsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9iDjPHOJrzQtYawdGMjF9O82uLXnjMzD86vVSMN/pM5i/bY3lFytEi0b2v5SH9OobX3ZB5zhg5PZsG0hEv7YDoBtAYzudBeoS3yHd5ZLs5IfR2HvOR667Vfybpz1J7tcUrlvK1FyhlwRyZUclL+Hu47RxCoyCU4WhEMcrB0bFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZh5wPo5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZh5wPo5"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A1D9F1F000E9;
	Thu, 25 Jun 2026 18:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782413870;
	bh=egFueH757GQdkrmZ7WAdXu/CEp4Go/BzoCA8A4OkfWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JZh5wPo5VysqVVSduPdGDPr3g90l46R2M/X2HfzdDeXqzeMW7tVz1C9WhL9Ydv5tQ
	 F9RrzpMhccrVFfIh2gsMeXvdNyY/cFF2Iyw3L15XKVpFUC0lKAIWpUVSkTL/Hysqug
	 FZmmeZoCKowOYwDAD+31PtfkeIxSl7E+NvJs0iwVrYs6y4uUiC4q7/1eSwQ7qmmtKz
	 STrn102udIAObPzlztK9GoCF7+XkMwI/MMIzrwi+5Wi9hZKhp4l5u4kxRf7b8cPaU1
	 TteMtwdKysghUm5gh3rWshZx4wpegE7oFkt9bj/PW/FFiOCVMFewx9q/zws55TXvMs
	 74QQxR19MbglQ==
Date: Thu, 25 Jun 2026 11:57:50 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, willy@infradead.org, hch@lst.de, miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
Subject: Re: [PATCH v2 2/2] fuse: use iomap helper to mark folio uptodate
Message-ID: <20260625185750.GU6070@frogsfrogsfrogs>
References: <20260624212925.1668662-1-joannelkoong@gmail.com>
 <20260624212925.1668662-3-joannelkoong@gmail.com>
 <20260624221820.GB6095@frogsfrogsfrogs>
 <CAJnrk1aMe09bYZ_MiR-tr=umZ1nJxDx0B7DCs751zhxEyCL-7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1aMe09bYZ_MiR-tr=umZ1nJxDx0B7DCs751zhxEyCL-7A@mail.gmail.com>

On Wed, Jun 24, 2026 at 05:35:13PM -0700, Joanne Koong wrote:
> On Wed, Jun 24, 2026 at 3:18 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > > --- a/fs/fuse/notify.c
> > > +++ b/fs/fuse/notify.c
> > > @@ -192,7 +194,7 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
> > >               if (!folio_test_uptodate(folio) && !err && folio_offset == 0 &&
> > >                   (nr_bytes == folio_size(folio) || file_size == end)) {
> > >                       folio_zero_segment(folio, nr_bytes, folio_size(folio));
> > > -                     folio_mark_uptodate(folio);
> > > +                     iomap_folio_mark_uptodate(folio);
> >
> > I wonder, if a fuse server stores to a range of dirty pagecache and
> > completely over-stores the dirty range, can that folio still get
> > scheduled for writeback?  I guess it's no big deal if that writeback
> > happens since the fuse server already knew about that content.
> >
> Yes I agree, I believe it still gets scheduled for writeback since it
> still has the dirty bit set.

Ok, seems fine to me then.  I hope there isn't a fuse server somewhere
depending on the "sorta immediate writeback of what I just stored via
this backchannel" behavior?

I mean, it would be crazy to implement an RNG based on jitter between
dirty->store->writeback, right??

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D
