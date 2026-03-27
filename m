Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8FA285CA3
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 00:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774572653; cv=none; b=o2+Oq96jIGyt7oTOhXujkq4QDuVtURBFOpxXsHatPYMj5P+/5LNuql25toN7MhUKnsJmpXxYV0v1y/zaAGqWF6TcGxHjM8P9kPO9lIwvx+x3e9mzexyRh/W0R9epCv6bu8iLFZjXZnRN+SbgzU0KYB9SVpKrXtcJLxUhKZbClr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774572653; c=relaxed/simple;
	bh=KkXQvPzPwbE2ulwwTtCgJ705N/C/D+U1v1MM1+vxmYc=;
	h=Date:From:To:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RVq9Lg2ICLRLgqS1J0mEyxHYui4rjQ1srZHGWQurwdMGwsAqCezd7GNx7q+7yJAoAfu73uZocwE4ePeqW4+spH1r5dlXmljKQsGQl0Fa6o+DqpjQXMhMVvHBqVmyAnsnz1VNY9vt7vnzMMWbfkDsMmoaew3SmFf9D99kKygi050=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Dsd3gqOS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Dsd3gqOS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54271C2BC87;
	Fri, 27 Mar 2026 00:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774572653;
	bh=KkXQvPzPwbE2ulwwTtCgJ705N/C/D+U1v1MM1+vxmYc=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=Dsd3gqOSRXZ5UsSv8d3py1AIUe+z3FVQfH0fFjtGWfXn6vhRptl+6Vl8d4aLxzr97
	 4MV9awn5Lk+G+Zpja7/4+grOQ2pMIBw1JS4QCpT9Ap4jUBjRA4j2GV3PCmpnFpo3C6
	 r0vMaUGt/Lwb4F40XPw19lgEkJ13Fxg2BA+GotHk=
Date: Thu, 26 Mar 2026 17:50:52 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Joanne Koong <joannelkoong@gmail.com>, jack@suse.cz,
 willy@infradead.org, miklos@szeredi.hu, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mm: start background writeback based on per-wb
 threshold for strictlimit BDIs
Message-Id: <20260326175052.06871e1fe76af965a114bb3d@linux-foundation.org>
In-Reply-To: <20260326174237.0ad75b578219aad36f137e4b@linux-foundation.org>
References: <20260326234629.840938-1-joannelkoong@gmail.com>
	<20260326234629.840938-2-joannelkoong@gmail.com>
	<20260326174237.0ad75b578219aad36f137e4b@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Mar 2026 17:42:37 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> > fio runs on fuse show about a 3-4% improvement in perf for buffered
> > writes:
> > fio --name=writeback_test --ioengine=psync --rw=write --bs=128k \
> >     --size=2G --numjobs=4 --ramp_time=10 --runtime=20 \
> >     --time_based --group_reporting=1 --direct=0
> > 
> 
> Thanks.
>
> [bunch of nonsense]
>

argh, sorry, I didn't read your [0/N].  Ignore.

btw, a [0/N] isn't really needed for a singleton patch - best to just
put everything into the patch's changelog.

Transient info such as "this depends on my other patch" can be placed
below the singleton patch's "---" separator.
