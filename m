Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123FC3BB133;
	Sat, 29 Aug 2026 17:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788025980; cv=none; b=oTZ7dVi1tS5ATnvVIOurfOU20aTW0j+64uDtrPjQCdNL62naW85MGs4b0ikI+ITwJy+/E8/yXZ7NRfpsHt4X750Ey17j1ZHF1TxFQwX0923BLfJrJkf03OnteyjhVvt+TCQHhUyYoKjTInoW1PBB/D3JQc+o0ByY/AHwBDksjKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788025980; c=relaxed/simple;
	bh=sHREmlvJb2WeXAnZ4PhpTlb3U15pqrL1Eosbn8DbHho=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ueewOgBXk7bnzAohURm0FMOhCLoGolE9lSP7/aBJhu2kLHO7lBUJ23vpYw4zOhFVumQv0GkBJVFsW1SgYBvWLJTVK2sIITKH0IYUudBgoh3UcDlgDuMxTuNS6p/at5z0/poJ0iwLkMDDjopT8/e8RPF5wVyWnUOF30sMwsPhmwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YZPmrERc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YZPmrERc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A921F000E9;
	Sat, 29 Aug 2026 17:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1788025978;
	bh=SabKoUp8tCvFd7/IWwQJhIB7+BXnhKbHAfpjl/C5Zd8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YZPmrERcwLciJIXhx2qCIYiECTFCvkvz0NRgHTrCbyaDpbKxatT3sCwF2FhLkbs1J
	 xlQgo1K94TebA06tG6W5xatN29xsyu3qN+DjgugdcoOj1dW0U/SbdE6LwE6aq3Y3pb
	 UfeHuWkoktZhvN8A7A7maTYQTHO5XFd2RVIVfodg=
Date: Sat, 29 Aug 2026 10:52:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] squashfs: harden fragment index table sizing
Message-Id: <20260829105257.0a9f07041246c1d1e10690cc@linux-foundation.org>
In-Reply-To: <918464087.420455.1787971711604@eu1.myprofessionalmail.com>
References: <20260822143328.68867-1-kmehltretter@gmail.com>
	<20260828163727.748343f2c87610ac6cd89dfb@linux-foundation.org>
	<918464087.420455.1787971711604@eu1.myprofessionalmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 29 Aug 2026 03:48:31 +0100 (BST) Phillip Lougher <phillip@squashfs.org.uk> wrote:

> 
> > On 29/08/2026 00:37 BST Andrew Morton <akpm@linux-foundation.org> wrote:
> > 
> >  
> > Sashiko review of this series claims to have found a whole bunch of
> > similar issues which you may choose to address:
> > 
> > 	https://sashiko.dev/#/patchset/20260822143328.68867-1-kmehltretter@gmail.com
> > 
> > I don't know how useful this report will be - the first part seems
> > wrong in lots of ways, as if Sashiko was using an ancient copy of the
> > code.  But the things it claims aren't there have been present since
> > 2018.
> > 
> 
> I have been receiving a lot of AI generated issues similar to these on the
> Squashfs-tools code and the Squashfs kernel code over the last month.
> 
> I have not been idle and ignoring them, and I have been spent the last
> couple of weeks fixing them full-time in the Squashfs-tools code, and
> the kernel code.
> 
> In the Squashfs-tools code I have reviewed about 20,000 lines of code so
> far, and this has generated over 50 commits.  These commits I have
> committed to the Squashfs-tools git-hub repository here
> 
> https://github.com/plougher/squashfs-tools
> 
> I am also most of the way through reviewing the Squashfs kernel code, it
> is about 70% complete.  So far it has generated 12 patches, and there
> will be more.  Obviously the kernel patches are queued up for a posting
> next week.

Cool, thanks for the diligence.  Lots of projects appear to be in the
same boat at present - hang in there!

> So I am not asleep at the wheel here, I know about them and I am
> addressing them.

I hope it didn't sound like I was implying such a thing!

For a patch series like this: it looks correct enough to me so my
approach is to push it out for external testing and to sit on it
indefinitely until I hear from Maintainer.
