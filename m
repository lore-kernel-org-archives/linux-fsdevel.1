Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9795A372689;
	Wed, 15 Apr 2026 06:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776234904; cv=none; b=tZvFx6+UAN+8qWdCwHDJk5cCVgbHo2IQ/Ahvak7L0QjUzQgKPDxOqK5uL1ivGoFRJ+eoPOvUT+7HtDgX3O9fDUq+N6bI2dwGKn0gzhAh+ap4jCDSz2iUSuQM5f2QZojS4BRhjgEV8dWvI12C4CBijp1A+7pXlhk62clq9EgdANo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776234904; c=relaxed/simple;
	bh=IBIFChv5u3e0gIoiVcTtrpvSVwZSCR7TwcaW0HD50Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LegCuOWHl1zvUPkM91WjPRQF8J9gCD5UXYR5fL/SeAQOkwLShefkAmopXGOr+VrwL/OaeP3ikTIWGg/35Qa2bLTW7u0r/tDigIRLqK1n5+KDHkawJ60LQhqbQNMe7GwxOzbHQ9HmTc5aAiAHWA8pB9Yaql9jQ7BqE6QfDmBoeF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuMkoXWf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuMkoXWf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED810C19424;
	Wed, 15 Apr 2026 06:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776234904;
	bh=IBIFChv5u3e0gIoiVcTtrpvSVwZSCR7TwcaW0HD50Jc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CuMkoXWfeYctFAhHSaDWr5eVIyKNfEmBqUXxPkd77WB12jVHe77dVOsSCvU9F/z+H
	 1ANcgUsodUH8A/f6bEh4rIfIHuqVhJ/Ds082W739oju9QtvT8gnHwKuuuLGn+bwOZx
	 hZ3gSgXwPsBXqJQb2PEdiPW4GMDvR5g+LjuezSw0EN6/5dCniB4tD55ZM8dNNFzp/o
	 VNfCPu96Qwr1+cnEtRlW5t2fEh0GVIxF1oVGFB3ucKA+olleQi1021qVU7aJUq4g/W
	 1IZiItoyll9lYZvslFLKUD1TffeuRbrmhL1wLdexX3/0nOeyiMcH6LxMPJ9hJ3o/S8
	 M+Yl5a+eNTdNQ==
Date: Wed, 15 Apr 2026 07:34:58 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David Hildenbrand <david@kernel.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH mm-hotfixes] mm/vma: remove __vma_check_mmap_hook()
Message-ID: <ad8xfnn05PtejbMP@lucifer>
References: <20260413105713.92625-1-ljs@kernel.org>
 <20260413221724.c939e483e83304fb40e3d6da@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413221724.c939e483e83304fb40e3d6da@linux-foundation.org>

On Mon, Apr 13, 2026 at 10:17:24PM -0700, Andrew Morton wrote:
> On Mon, 13 Apr 2026 11:57:13 +0100 Lorenzo Stoakes <ljs@kernel.org> wrote:
>
> > Commit c50ca15dd496 ("mm: add vm_ops->mapped hook") introduced
> > __vma_check_mmap_hook() in order to assert that a driver doesn't
> > incorrectly implement both an f_op->mmap() and a vm_ops->mapped hook, the
> > latter of which would not ultimately get invoked.
> >
> > However, this did not correctly account for stacked drivers (or drivers
> > that otherwise use the compatibility layer) which might recursively call
> > an mmap_prepare hook via the compatibility layer.
> >
> > Thus the nested mmap_prepare() invocation might result in a VMA which has
> > vm_ops->mapped set with an overlaying mmap() hook, causing the
> > __vma_check_mmap_hook() to fail in vfs_mmap(), wrongly failing the
> > operation.
> >
> > This patch resolves this by simply removing the check, as we can't be
> > certain that an mmap() hook doesn't at some point invoke the compatibility
> > layer, and it's not worth trying to track it.
>
> Cool, thanks.
>
> > Fixes: c50ca15dd496 ("mm: add vm_ops->mapped hook")
>
> That's presently in flight mm.git->Linus, So I'll include this fix in
> next week's second batch of MM updates into Linus.

Ack thanks!

>
>
> > c50ca15dd496 is in mm-stable, so thought best to do as fix-patch? Will
> > leave a small bisection hazard (unfortunately) so putting this as close as
> > possible to the patch it fixes would be ideal.
>
> Yep, I did that.

Thanks!

>
>

Cheers, Lorenzo
