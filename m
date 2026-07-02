Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EA81DED5B;
	Thu,  2 Jul 2026 00:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782952332; cv=none; b=YuhzgeakPDzR2uSw8uLKwLgIvmin2LokALfEV2k+fqcndcCR1plUCbIyhgk16uKH/uiQinc8Bd4H6K81wbwwmbXbfhOv/pPbdMkm85jAsMSXEBUGxU3RApnLgyveuvw1ANXxI6/LcZWPV938P9fo5o53qJCcQdzrRjAJNrmqrBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782952332; c=relaxed/simple;
	bh=Tn0/RYfPKaiFWmqTUdrvChPR8tIqTUyomgsm9wsVTBc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qF0Wp6iwt4cDLpWVaXGH0PKGKLGGB/FxWTNBwv6RhmiyOj8r45AXo765ZyVQm7sVgKrDdPw69+7osxXB3yJXQw91UZTZsp/zQgm7auYF+ysmvDNUmWPHQpVGbAnFEhgsWB4z5TIGN8zuhaM+qwKp223i2i66zWnxl2+1OEp6yCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OdyS2rou; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OdyS2rou"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0B21F00A3A;
	Thu,  2 Jul 2026 00:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782952331;
	bh=ajpptq58tGkB5pIMrTq9IEdGdKZzcCoOEkOQj/yYZUg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OdyS2rouh2AxXKHg4lnEJL2iZeLeYsTvBhbq6MpAdXNrBpraRzx14huk6mqqF7D/i
	 lz2AzKU5NmPuTyrUFQhD/K/wqKGak0fPwsBgqaUXRYfOvY9Xe0z5/5jV4szysFyqA/
	 MYAKmgEGEo+CNCSS36TQ8OiOsGqtpyJoIkHIidro=
Date: Wed, 1 Jul 2026 17:32:10 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jan Kara <jack@suse.cz>
Cc: Zhen Yan <yanzhen20011121@163.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, Matthew Wilcox
 <willy@infradead.org>, Christian Brauner <brauner@kernel.org>, Hugh Dickins
 <hughd@google.com>
Subject: Re: [PATCH v2] mm: fix mapping_seek_hole_data() overflow on last
 page
Message-Id: <20260701173210.a7e74a41a8d6f8e97b2b379c@linux-foundation.org>
In-Reply-To: <hhrt7iy4rgv33wxghhhwryiw3jjgorvmbw4tvxenhmin7z52z2@njm2bn273f26>
References: <tikbuxxazkmz5obcf6llp342vn7bi5tlgbbnuliw4jlwndj63e@jkp5g5oj6ug7>
	<20260630125047.703170-1-yanzhen20011121@163.com>
	<hhrt7iy4rgv33wxghhhwryiw3jjgorvmbw4tvxenhmin7z52z2@njm2bn273f26>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jun 2026 15:27:25 +0200 Jan Kara <jack@suse.cz> wrote:

> On Tue 30-06-26 20:50:47, Zhen Yan wrote:
> > A local unprivileged process can create a shmem/tmpfs file with
> > i_size == LLONG_MAX using memfd_create() and fallocate().  If the last
> > page is present in the page cache, lseek(SEEK_HOLE) on that page
> > returns 0x8000000000000000 as a successful offset, which is LLONG_MIN
> > when stored in loff_t.
> > 
> > The same file has readable data at the last byte, but SEEK_DATA from
> > that offset returns ENXIO.
> > 
> > The overflow is in mapping_seek_hole_data():
> > 
> >   pos = round_up((u64)pos + 1, seek_size);
> > 
> > For the final page below LLONG_MAX, the next page boundary is
> > 0x8000000000000000, which is then used as a signed file offset.
> > When assigned to the loff_t pos, this overflows to LLONG_MIN, so
> > a subsequent "pos > end" comparison does not catch it.
> > 
> > Keep mapping_seek_hole_data() inside its documented [start, end)
> > search range: compute round_up() into a u64 variable and compare
> > against (u64)end so the overflow is detected, then clamp pos to
> > end when the rounded-up value goes past the search limit.
> > 
> > Signed-off-by: Zhen Yan <yanzhen20011121@163.com>
> 
> Thanks for the patch! It looks good. Feel free to add:
> 

Thanks.  I'll queue this for 7.3-rc1 with a cc:stable - no rush, as the
issue is presumably very old.  

(Do we think the cc:stable is even needed?  It's very obscure and the
effects aren't very harmful).

AI review might have found a couple of unrelated pre-existing issues in
the surrounding code:

	https://sashiko.dev/#/patchset/20260630125047.703170-1-yanzhen20011121@163.com
