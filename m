Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA74B3AA1A8
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 09:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775725853; cv=none; b=onuau91DdeCyQsk+LRKLhEcp+Z4KaFcAmIDO109WmQ16Ib0jC52jI8JM0agiuMsyNSBYliJIoUi1eEGQbbdpan5RI6Hcjx/d4CQmUaGXjo/VsRrn9RGO9EgYCjI2kh77O/8liIIGcYuBj1KIjkdZ3yQZRP38isIgz0Xdu61wKzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775725853; c=relaxed/simple;
	bh=xrl7j4pdgg7HIMOKaWryyzLoarEs9/7FlBQ+2lwC9Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIELc2mrTcv2T59xSO60w54Oc3L8rwCNzt05V9YTGWp6N3CmBoIzIKCKxGvE1jbLP2QfljnskuGVR+ng2Ew620xOS6oswOhUFPPGVeOzC+uDeaB4CgI2W+nSWpocEosvhHzfaZwNgCok6wbeAOmZdmOleWVUomIIRbKfIUSikfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=vSUBw92K; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vSUBw92K"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8y7U8OmnHIYGcgc/++tXEYlFKfETUjSAJFJdoPQkvUM=; b=vSUBw92K/6OgQ6l9eXO7oQtCt5
	FfNjlqyIVHSCFUT2K4RFy6bd7zcSITBy1syxl59Gi+khmV200EdL5DjppCRbpLmlpa9xE6vu0O+jj
	8RV70c7PMaa6E9UWwU2W+fYHHugvW0kiIbLxTKLnh9A7eqqfbBjUsuSrcJj6Z2wRq/irztxKh87N7
	nEMYlyF0CRsIJA3urlTkayCtXp97FHrFh03rkzSjd7SyRttqllTD4tfmMyYOQgC4S/dGFMiWZstqK
	Nv3ZkqR7V4cHk7iRnf6A+Y/8QCU2gAdZ4fO+uwUMviLIImaPeyoWkqHOZRyQuANklHJkoAEuvWRzz
	mq8HWInQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wAlTA-00000002Qfa-2qr9;
	Thu, 09 Apr 2026 09:14:36 +0000
Date: Thu, 9 Apr 2026 10:14:36 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Rohit <rsingh.ind.1272@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: Missing Null Pointer check in seq_open
Message-ID: <20260409091436.GO3836593@ZenIV>
References: <CAD+278XmGAdCDL46vxhTuVLoVE4uSNXTz0LGSivjctyUDhWZMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD+278XmGAdCDL46vxhTuVLoVE4uSNXTz0LGSivjctyUDhWZMA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Mar 05, 2026 at 03:27:08PM +0530, Rohit wrote:
> Hi,
> 
> I would like to report a missing NULL pointer check in the fs/seq_file.c APIs.
> 
> The seq_open(struct file *file, const struct seq_operations *op) function
> does not check whether the second argument is NULL or not.
> 
> Other functions, such as seq_read_iter(), directly dereference seq_operations
> pointers, possibly resulting in a kernel NULL pointer dereference.

It also does not verify that argument is not (void *)0x6969696969696969
and passing that would lead to massive clusterfuck in aforementioned
seq_read_iter().  Your point being...?

Should we check that caller is not passing BS values to arguments to functions
and if we should, where do we stop?

Why is NULL any different from e.g. ERR_PTR(-ENOMEM) in that respect?  Or from
any random invalid value, for that matter?
