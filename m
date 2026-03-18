Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C57E343216
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 20:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773866497; cv=none; b=tcfhFzo/uZWNQVa7rzIUKz7Dmk/gA+uD51ZaaeXavIHbI+Wt9D3oih0jkj0Fh3vA9B2F2FvtH9Cwkbk35/9ttfszaZXVuDFNKcwYUzXbewpL/a4AMzB/ykQXjVjY1DGEA25LGN8RzDrt5YWpcunf2aeXzfj6UHjSaDmiQ3CqQwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773866497; c=relaxed/simple;
	bh=CByJmT3DQExiMbAmmK35ulvZydkgQWCR1x9C1wPue5g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=deh3g3L/tcGrFqU+l39loIYlM3goAQRFJVmmX+s9Z/zEJn8Cy1v0ABvpMPEB4pM+CY39D22vH4xY/2o92Mrd9flVpR5fpvhWfXNNpGYSkei5wj7Aq1WjeM5oG/h6MqDjBpIwjdJrnJkA3BzNUwnegXIcZKuLADDOwZvU2zKMDP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=sewRKIrV; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="sewRKIrV"
X-KPN-MessageId: d700b192-230a-11f1-bea2-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.188])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id d700b192-230a-11f1-bea2-005056992ed3;
	Wed, 18 Mar 2026 21:41:28 +0100 (CET)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id d6fdf7f8-230a-11f1-80eb-00505699693e;
	Wed, 18 Mar 2026 21:41:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=+h52xEWvVBlalLPE42zcONvTrYVFiN6vuVAIFLj/uPA=;
	b=sewRKIrVgDxft+3TnQn/oIme+L+nlGKuFYOWJPBDl0Y6bHTYqMOve7H6o0lrEveKgPzWNSpxHHrVi
	 ZRqnithss68DvI3CnX2bWvnb4wZLaCkcrff1kz5LTO8pKQwc8E+otNHoIb7mBKdWjNLD22Pqok1S7x
	 uRS0SuzP2L6YKqxxqrLK3m39Foaco9LVF3BlgBG2b4DAxnoPqV1LlBMewpQS3MOsDQUhZgfSMgT356
	 9UEMBPCCn6aaHAm5W72QlnU0xKkzsRDbbFvj4u7L6VHlARRssUgN+g12swrU4pVlUL07ubXelq2Tdf
	 Luw/Qaf9la+HAW6Q8SpZA57HsGdmdRw==
X-KPN-MID: 33|dsMbRn0HmVW75rnXgmscLpvUuJ50qXPpWIbBZwyHyqeh8HjiORpDuRrILLU2ri2
 kQR9I05CiwXKJcsb2lTQrsEOZuaziwCT5td4adVZmUco=
X-CMASSUN: 33|j8maq2D6pYCsut0nlowX85TxDxcr1CjMWEBtbyAgO0JB0fvxUFooTCRUxfekoJ6
 aNaX9WdpNMJYa+xlc9LS5+w==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh01 (cpxoxapps-mh01.personalcloud.so.kpn.org [10.128.135.207])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id d6f0cd08-230a-11f1-b8d7-005056995d6c;
	Wed, 18 Mar 2026 21:41:28 +0100 (CET)
Date: Wed, 18 Mar 2026 21:41:28 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"open list:FILESYSTEMS (VFS and infrastructure)"
 <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Message-ID: <761566493.2262498.1773866488791@kpc.webmail.kpnmail.nl>
In-Reply-To: <3d42elzgtl5igw3xswvo4nc6bygho6oe6zuijqwy2kjpurbv2k@w42aryoa7v2w>
References: <20260312112823.2801-1-jkoolstra@xs4all.nl>
 <3d42elzgtl5igw3xswvo4nc6bygho6oe6zuijqwy2kjpurbv2k@w42aryoa7v2w>
Subject: Re: [PATCH] vfs: fix docstring of hash_name()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal


> Op 17-03-2026 09:43 CET schreef Jan Kara <jack@suse.cz>:
> 
>  
> On Thu 12-03-26 12:28:22, Jori Koolstra wrote:
> > The docstring of hash_name() is falsely reporting that it returns the
> > component length, whereas it returns a pointer to the terminating '/'
> > or NUL character in the pathname being resolved.
> > 
> > Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> > ---
> >  fs/namei.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 58f715f7657e..d020b077591b 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -2437,8 +2437,13 @@ u64 hashlen_string(const void *salt, const char *name)
> >  EXPORT_SYMBOL(hashlen_string);
> >  
> >  /*
> > - * Calculate the length and hash of the path component, and
> > - * return the length as the result.
> > + * hash_name - Calculate the length and hash of the path component
> > + * @nd: the path resolution state
> > + * @name: the pathname to read the component from
> > + * @lastword: if the component fits in a single word, the component bytes,
> > + * otherwise 0
> 
> The @lastword description is what the function does but not really the
> point of the parameter. I think more understandable description would be:
> LAST_WORD_IS_DOT, LAST_WORD_IS_DOTDOT, or some other value depending on
> whether the component is '.', '..', or something else.
> 
> Otherwise the fix looks good.

Thanks, Jan. I incorporated your suggestion and sent it again. I really appreciate it!

> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
