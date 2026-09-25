Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C8037882B
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 14:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790348287; cv=none; b=uJ84oMvlqhN6oFNOqAOBbmkQTHC4a/jY5wkcDp0oP74fLe91rxEF1JKqIxGIyWP2sH3o/VmqK2KUF+AmT0E4O5xwhBgbQT1f8RopdX+fobwmLqdM6PL6r5CN13o07O1MYJzU1K6wwwCRw74WPDGEQPIB7u9Xf8GTPX1hlfVXe0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790348287; c=relaxed/simple;
	bh=6/Vejtm8JEvbDkzbaBumS2AVg80DZNbVLieC8pxyGCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZQfgtZmFYPJc7oQyApnC7yv5muf2+1rKyqvyPbtFk2R+Sp9RPiAIUEsJrAfkDR+TOt6qnUJMHzTCX/8AkabQ3bY+1z+acX/paIpjpMWnbUn/zOi6M3VuPPOV4Hs/u3ebf7G/vYbNRV2A6Q/FxORXpNkdlmZCl0GuyS4iGDLXQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5jreAWA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5jreAWA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012321F00893;
	Fri, 25 Sep 2026 14:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790348271;
	bh=Lsi+EgsBddXuCSSGcS0KiAJ5OiBieLDwCJiDP0TrsVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C5jreAWArD18s4PbBwOqhSA69UhC9BV+S/12k8eWCZFm/9BSCHqZPR9AMCW1SXHJV
	 rMewVyezeMQKybRxQ8ZYxpnTcrZvjzOMCOpBQXabqGWS67N1b6k5nmVMLJEwCYhzUG
	 LvNcQvc+9kefPFwhzrkwQ6Bbrhb/1gPTolDzekS1mI4tx0dh7J9jjTQOtocQsTBJEO
	 HwfokO228YSiR4AJS4TTEOP3KNnAQvqwq641bac//WodfM0VgaKIGzBcvxzta3lBqk
	 SEGSt5YyG+Yy0/70MQoecassNOrMHiIOOHBKjRNFMa3C6ETmHxduti8F1likGF9PaL
	 ti+RmrVsguTAQ==
Date: Fri, 25 Sep 2026 16:57:47 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: linux-fsdevel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Neil Brown <neil@brown.name>, 
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 08/10] file: let dup_fd() drop only close-on-exec
 descriptors
Message-ID: <20260925-randalieren-bahnen-halbzeit-95cb647bee3f@brauner>
References: <20260921-work-file-close_range_except-v1-0-c20d0b49270d@kernel.org>
 <20260921-work-file-close_range_except-v1-8-c20d0b49270d@kernel.org>
 <CAG48ez23cnVa9kia8z+ny9-vMRxuNtCcoG0hV4Vy6YUvkC4xDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez23cnVa9kia8z+ny9-vMRxuNtCcoG0hV4Vy6YUvkC4xDw@mail.gmail.com>

On Mon, Sep 21, 2026 at 06:24:25PM +0200, Jann Horn wrote:
> On Mon, Sep 21, 2026 at 4:16 PM Christian Brauner <brauner@kernel.org> wrote:
> > Add FD_RANGE_CLOEXEC_ONLY. When set dup_fd() leaves everything behind
> > except for fds that are close-on-exec. Without FD_RANGE_EXCEPT the
> > clone loses the close-on-exec descriptors in the range. With it the
> > clone keeps the range and loses the close-on-exec descriptors everywhere
> > else. Descriptors without the flag are carried over either way.
> [...]
> > @@ -393,15 +396,37 @@ static unsigned int sane_fdtable_size(struct fdtable *fdt, struct fd_range *rang
> >
> >         if (last == fdt->max_fds)
> >                 return NR_OPEN_DEFAULT;
> > -       /* Only words up to the last open descriptor can hold a kept one. */
> > -       i = last / BITS_PER_LONG + 1;
> > -       while (i--) {
> > -               unsigned long dropped = dup_fd_dropped_word(i, range);
> > +       if (!range)
> > +               return ALIGN(last + 1, BITS_PER_LONG);
> > +
> > +       if (range->flags & FD_RANGE_CLOEXEC_ONLY) {
> > +               /* The close-on-exec bits decide what is dropped, walk the words. */
> > +               i = last / BITS_PER_LONG + 1;
> > +               while (i--) {
> > +                       unsigned long dropped = dup_fd_dropped_word(fdt, i, range);
> > +
> > +                       if (fdt->open_fds[i] & ~dropped)
> > +                               return (i + 1) * BITS_PER_LONG;
> > +               }
> > +               return NR_OPEN_DEFAULT;
> > +       }
> >
> > -               if (fdt->open_fds[i] & ~dropped)
> > -                       return (i + 1) * BITS_PER_LONG;
> > +       if (range->flags & FD_RANGE_EXCEPT) {
> > +               /* Only the range is carried over. */
> > +               if (last > range->to) {
> > +                       last = find_last_bit(fdt->open_fds, range->to + 1);
> > +                       if (last > range->to)
> > +                               return NR_OPEN_DEFAULT;
> > +               }
> > +               if (last < range->from)
> > +                       return NR_OPEN_DEFAULT;
> > +       } else if (last >= range->from && last <= range->to) {
> > +               /* The last open descriptor goes, the kept ones sit below the range. */
> > +               last = find_last_bit(fdt->open_fds, range->from);
> > +               if (last == range->from)
> > +                       return NR_OPEN_DEFAULT;
> >         }
> 
> Maybe integrate this part of the patch, except for the
> FD_RANGE_CLOEXEC_ONLY branch, into "file: let dup_fd() leave the
> punched hole behind", which introduced the loop in sane_fdtable_size()
> that is being removed here, and "file: let dup_fd() drop everything
> outside of the range", which introduces FD_RANGE_EXCEPT?

Done in-tree!

-- 
