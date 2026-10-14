Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8174E8DEB
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 12:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791981960; cv=none; b=rK+6rv+wsPF3RB0PRiztMeBN+PD+ReUN7c6yW2QvwdUg6abbY0kSJ1boy+TaUdrt2d01jhxYHHTtiquuvuFUJ7Z7nnR1z0vCF7dHxQWWwxDCNRxxOABgLcq47dltXy3t1c/fovH3HLEXQve0C/4qrGwuOO2t/0zl5G5PkwewV8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791981960; c=relaxed/simple;
	bh=j9MUTwqFk696YLuYmKyKYHrHXmQBfhqUQLDsULixeQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfWUj92lpVySiRDch9wEVags2BmlujNWD4jPuF1tFR98vMYX9/L2CptLHz5/H+uez7w5lF/2UnHHkC9p6SxZzDNa8HZNdfZTTfI7fR3aHOLpfJlciVERyEa61bafDORh6utPn9fm1YEfW3vzZcSOZ+cHNI0BRk7DIq/PEnZ2ALo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H1LOm1OY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H1LOm1OY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791981943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yl2rD0Yy4BRKtnCRp+987lNfML7qiSxkvQz9gYi0hCQ=;
	b=H1LOm1OY9hf/y43IJlIQW1T67BFLMIBX+5z/ituR5vQDP0c4EBVSxb+DpSzwksENkDIHhy
	W0E9y6ktaA78LIzVOtesHTbUavtvoMaHe4phIPajrMJ9IdAiREtTsnGzl/j+xAlqIJ75WR
	lgWXZ5bO7SDv4RrqTfnAqadWwXhwyXE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-P4L6LNQbMS2xXUcim6x-xg-1; Wed,
 14 Oct 2026 12:45:41 +0000
X-MC-Unique: P4L6LNQbMS2xXUcim6x-xg-1
X-Mimecast-MFC-AGG-ID: P4L6LNQbMS2xXUcim6x-xg_1791981940
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C2D0195604B;
	Wed, 14 Oct 2026 12:45:39 +0000 (UTC)
Received: from bfoster (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0645630000E7;
	Wed, 14 Oct 2026 12:45:35 +0000 (UTC)
Date: Wed, 14 Oct 2026 08:45:33 -0400
From: Brian Foster <bfoster@redhat.com>
To: jianyungao89@gmail.com
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jan Kara <jack@suse.cz>, Dan Williams <djbw@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	"open list:FILESYSTEM DIRECT ACCESS (DAX)" <linux-fsdevel@vger.kernel.org>,
	"open list:FILESYSTEM DIRECT ACCESS (DAX)" <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v2] dax: fix wrong error code returned from
 dax_dedupe_file_range_compare()
Message-ID: <as95bXy1IfqNUCFo@bfoster>
References: <20261012144925.6728-1-jianyungao89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012144925.6728-1-jianyungao89@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Oct 12, 2026 at 10:49:24PM +0800, jianyungao89@gmail.com wrote:
> From: Jianyun Gao <jianyungao89@gmail.com>
> 
> When dax_range_compare_iter() returns a negative error code (e.g. -EIO),
> dax_dedupe_file_range_compare() incorrectly returns 'ret' which holds the
> positive return value from iomap_iter() indicating more iterations remain.
> This positive value leaks to the caller, where vfs_dedupe_file_range()
> interprets it as success (bytes_deduped = len), causing userspace to
> incorrectly believe deduplication completed.
> 
> Return 'status' instead to propagate the actual error code.
> 
> Fixes: 39eb05112987 ("dax: advance the iomap_iter on dedupe range")

Hmm.. the patch looks fine to me, but the above commit basically just
renamed compared to status in this function. I.e. before that commit we
did:

	if (compared < 0)
		return ret;

... which seems to me has the same problem. So I'm a little curious if
either the Fixes: is wrong, or I'm just missing something..?

Brian

> Cc: stable@vger.kernel.org
> Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
> 
> Changes in v2:
> - Add Fixes tag and Cc stable
> - Add Reviewed-by tag from Jan Kara
> 
> v1: Link: https://lore.kernel.org/lkml/20261010021010.19575-1-jianyungao89@gmail.com/
> 
>  fs/dax.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 6ba50142eeb2..1f6a4fbb97bd 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -2261,7 +2261,7 @@ int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
>  		status = dax_range_compare_iter(&src_iter, &dst_iter,
>  				min(src_iter.len, dst_iter.len), same);
>  		if (status < 0)
> -			return ret;
> +			return status;
>  		src_iter.status = dst_iter.status = status;
>  	}
>  	return ret;
> -- 
> 2.34.1
> 

