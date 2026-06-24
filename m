Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F35F30BF68;
	Wed, 24 Jun 2026 22:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782339502; cv=none; b=sNdkUelIqWWh1baJ9fhG/Nc4opgTA/P6x253XZ1P4X3j8ZxJUr/QygemdOtLwEGd4briB3lRMuIY/mFZ+yIDLtEoq/dsGQIc6qIwdWmBkDFX0fmgsHFqtTgKlkW+ka6DKf2eM4pr3hJ8zkUaEVJ50bukg6jqwvZ6hu/rXl2+WjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782339502; c=relaxed/simple;
	bh=93YSEFnQYrGLeszqhcD0JorvOrOxXXEGXIHPabGlgFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lce3MVf5N/ICccJipl4KsfjOiDSdqwvKfbs8Y6tdGqNBV3RF4Mm2buqkqdxxrsnKLZQY6XX9w37k3PtVKvK+6LSlnRXGr4yYWQwC9bcbvnhhErnQSqfs/+LZPtHo910DBGNAAgJ5VKSMNEXan+vAXtA6PzH6pKOSPdaFLQWLIuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fM93r5sp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fM93r5sp"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id F0F621F000E9;
	Wed, 24 Jun 2026 22:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782339501;
	bh=2NkXmCgsiwfGyGtFEFVTMXDs1VhzcYdTWW4sr6XJP3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fM93r5spqZiOuukVy9ctz8QbeKToE3OBrwiSTk9r5GVVWMG0nNigRHDNu97iywDgx
	 I8s2rBRK+/gQGLYguS4pTJDsjBanGJNwxNrXchnf+uHMcVetNke/LeJkauJBFWHIjp
	 ysGjddm3jCXxQdsVOR+wZdaMq0ERKL4ClEhB7r9E0SeSGIRNbOudiqiGLoPP7X1lJh
	 dezdImAfh369ZLNmkm6gQUtyShDsEIHrzw6fY9D9GSNoVYZH55NBjv2gTr+NWjF1ZZ
	 3p73CH2B4p2kzhXgypJxbraBHCVgJo7QFa4nqMDqR0OIqLGdwTeY4RWajJko65XW5n
	 6bkNibm2C4Kiw==
Date: Wed, 24 Jun 2026 15:18:20 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, willy@infradead.org, hch@lst.de, miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
Subject: Re: [PATCH v2 2/2] fuse: use iomap helper to mark folio uptodate
Message-ID: <20260624221820.GB6095@frogsfrogsfrogs>
References: <20260624212925.1668662-1-joannelkoong@gmail.com>
 <20260624212925.1668662-3-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624212925.1668662-3-joannelkoong@gmail.com>

On Wed, Jun 24, 2026 at 02:29:25PM -0700, Joanne Koong wrote:
> When fuse enables large folios, a large folio will be backed by
> iomap_folio_state that keeps track of uptodate and dirty state in an
> internal bitmap.
> 
> Fuse writethrough and notify store paths currently set folio uptodate
> state with folio_mark_uptodate(), which touches only the folio-level
> flag, but on an iomap-backed folio, that leaves the uptodate bitmap out
> of sync.
> 
> Use the iomap_folio_mark_uptodate() helper to update both the folio
> uptodate state and the iomap uptodate bitmap.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/file.c   | 2 +-
>  fs/fuse/notify.c | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index e052a0d44dee..26f27e113e9c 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1335,7 +1335,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
>  
>  		/* If we copied full folio, mark it uptodate */
>  		if (tmp == folio_size(folio))
> -			folio_mark_uptodate(folio);
> +			iomap_folio_mark_uptodate(folio);
>  
>  		if (folio_test_uptodate(folio)) {
>  			folio_unlock(folio);
> diff --git a/fs/fuse/notify.c b/fs/fuse/notify.c
> index 29578104ae6c..1ba763705d91 100644
> --- a/fs/fuse/notify.c
> +++ b/fs/fuse/notify.c
> @@ -2,6 +2,8 @@
>  
>  #include "dev.h"
>  #include "fuse_i.h"
> +
> +#include <linux/iomap.h>
>  #include <linux/pagemap.h>
>  
>  static int fuse_notify_poll(struct fuse_conn *fc, unsigned int size,
> @@ -192,7 +194,7 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
>  		if (!folio_test_uptodate(folio) && !err && folio_offset == 0 &&
>  		    (nr_bytes == folio_size(folio) || file_size == end)) {
>  			folio_zero_segment(folio, nr_bytes, folio_size(folio));
> -			folio_mark_uptodate(folio);
> +			iomap_folio_mark_uptodate(folio);

I wonder, if a fuse server stores to a range of dirty pagecache and
completely over-stores the dirty range, can that folio still get
scheduled for writeback?  I guess it's no big deal if that writeback
happens since the fuse server already knew about that content.

--D

>  		}
>  		folio_unlock(folio);
>  		folio_put(folio);
> -- 
> 2.52.0
> 
