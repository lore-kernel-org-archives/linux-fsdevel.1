Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEE83B2FE4;
	Thu,  9 Jul 2026 06:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783578269; cv=none; b=agX1xClWWuc4KpLF6FWT9f16WPphL7fS7OqcvTBcm/4P5Z0GuQlukXLagTQXTqYNfsEmCoNfdx+iMqDO41/tEfODIsF0XDU69Qu0GkTP5nChathPIqIdv9cgANtgE3meS+MRXPt/dYJegRsYxRaMKsleTJSBLENUAj5nGpFInzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783578269; c=relaxed/simple;
	bh=0Q6aCgZD5NZhEbbekRWxpDEd0tHlsaeYptMJJPzDoXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUf4FeQeb8i83UZozh811j0UmLHpUHv1ios2FOg6dPaEaTi3wSVslcnmXD8eLmpqBYP8AylsLO5O4XwIPnkVlVAZ1wkItcE8YzxEiOKUYnxw5MPVwIPjwlwjQ3XaR1eGJA8bV8qWkvDgyo1bP9tT/XbbcpJ9hPrm7D0+EOrgMSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W+qXhSiu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W+qXhSiu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AkuTJKyJs6+w/jmQ1TO2HwS3psOFgANSyhhhMRiZBaI=; b=W+qXhSiuOFm3XZJ53iGpdaQfIt
	1FfggNE0aNtM/4NvEylrbcQZ6inXv7BrLVUGQCsuWO2zrxxamwtrGleWeJeSwrGqj2OZAHGuCKCuc
	0SEZzX79JWaehyHxJ3ZFalnowI2sTGAobTlt1qgESoIl9OMbnUcKfqOugozhkQkp0kIc0MDI7p3mD
	gF878BQ/7CXA5AI9RXUXRd4pC1+rsyQaYoAWmUgOYalNEHeFkWWWXvGgaDJCghIrVwZZ3xQozrj7n
	knH8dFXVDcxKIyDC/c7zwdO2yVVQP0KIKZrUi9wteBdG6CV6t/4o1YOY60LO/Pg/BpE6cKk9FgS/v
	9lGT9FJg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whiBJ-000000018xG-49Sj;
	Thu, 09 Jul 2026 06:24:22 +0000
Date: Wed, 8 Jul 2026 23:24:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, Aleksa Sarai <aleksa@amutable.com>,
	Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/14] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Message-ID: <ak8-lSfOy0oL78N9@infradead.org>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
 <20260704164149.3480051-10-jkoolstra@xs4all.nl>
 <akyyqnv9EpY7xVdC@pedro-suse.lan>
 <1464441345.181098.1783418805206@kpc.webmail.kpnmail.nl>
 <akz_Ik8_eTnXav1H@pedro-suse>
 <1400609680.217714.1783433931054@kpc.webmail.kpnmail.nl>
 <ak5rHOsvtMX1j7S3@pedro-suse>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak5rHOsvtMX1j7S3@pedro-suse>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 08, 2026 at 04:39:54PM +0100, Pedro Falcato wrote:
> Because it's a black box:
> - Maybe this feature lands in 7.3 or 7.4 and enterprise kernels (and Android)
>   backport it to older releases on request (as a random example, XFS atomic
>   writes were added in 6.16, but were backported to 6.12 in SLES, and UEK 8,
>   and possibly RHEL/Ubuntu too)
> - Maybe the feature is posteriously reverted, disabled, changed
> - Upstream LTS also does its backports, so the O_CREAT | O_DIRECTORY EINVAL
>   only landed in 6.4, but was backported to 6.1, but not to 6.2 or 6.3, and
>   not to 5.15 or 5.10, and the behavior will again change as soon as this
>   lands
> - Sometimes the kernel perfectly supports a feature but you're running under
>   a tight seccomp filter that rejects unknown syscalls (or ones that it can't
>   filter, like SYS_clone3), so you get a mysterious -ENOSYS that uname() will
>   not be able to explain.
> - You can technically even be running under the uname26 personality and now
>   your uname() is completely nonsensical

Exactly.  NEw features need  to be discoverable, and O_ flags that
get ignored by old kernel are not.

