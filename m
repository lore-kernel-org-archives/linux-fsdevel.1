Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879D563CB
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2026 10:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781864382; cv=none; b=Aex2I/d+jWyBUqrDGJU6cQ7F7wXSKh1+zM1np39cD/UCL2dSAXIp5WpI9gfgF2eDuXq4uGQujP6MxHVUBmwu1p7FhOz8hTyBN8Hcnq2X1vxxWigWCXbLc9YM8Y4hp61RKO6RPH58JW+BpSxl101w3whOCFG1ibQcDIF8f1AsuOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781864382; c=relaxed/simple;
	bh=RtOPucsviSW6bMsSyQ5bnTlYr3LefSNhRjhr1dEN4mc=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=QKKSKAnI+kRLcmTRo8CMASPoi5t1mXzbnR6IMsHGJ0rP0D7TOMcqG5SKvdALOZ/A8Z1caoIiPgCl+Ij0WSGFGg+EM11vFllOMpnBdh6THcH0p5TunIVpSf3l2Noe2qXwJl54V7Rg8vmsLmJjHR4g6u0fB9ZvDWnkWuIDHvVFgsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=KlLhGdxT; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="KlLhGdxT"
X-KPN-MessageId: 607f6795-6bc8-11f1-9e8e-005056999439
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 607f6795-6bc8-11f1-9e8e-005056999439;
	Fri, 19 Jun 2026 12:19:38 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 607d270d-6bc8-11f1-ae4a-0050569981f5;
	Fri, 19 Jun 2026 12:19:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=VVTM1RZulTvHLqiM7HQkieZqZDuDXRLqL2UxchHPQLk=;
	b=KlLhGdxTsMoXWNmtfXYMSA7G3oqsWffdC/uvy7Vt9FwHpGhkA3OW9kmUc6jE92aZwk56zVLV8GWGN
	 GMcxmM2HLmkVir9nbNNXJu67+FhFrgwql4UqAtimo5eIGBsqNyAbG4mkkknyMJ6M34hOsigJ3C/ahQ
	 SF47jFG+YM6Id4VAJljN5dNVSp+GjGY4NxqNf6pPT9L/7vn7tbeLgnNvY3NKsGgw0uHHllGwXe+D2W
	 bgJfsE3WORS4Mx0GFpcrnblvSTs5KVTIT6MU4T2/uHMQ8mr6bStzX7Qqsv8g8I/fxY0X/ftSln0/Xs
	 dQja26hYiuyrzPMFFm7GEqv6BMQqh5Q==
X-KPN-MID: 33|fpHr5zhsTN3rqJ0JOoZYvJ9tJTbWGAw6blMCN0wV4531fm/6X7+2ZzQaTNfS1rS
 75kHy8zvsOovTnSxrHQjZ6L3fkSynHz1lOyL5AqIbyO4=
X-CMASSUN: 33|4DS7wOIcJaL7AZSKbUCmOXoZBoKVFlFLONK1IutezHXJc01So2YVrTmmUmQ8ZIH
 H6aUbpE6mHXTOh+KCVdrSXA==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh03 (cpxoxapps-mh03.personalcloud.so.kpn.org [10.128.135.209])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 607654ec-6bc8-11f1-916a-005056995d6c;
	Fri, 19 Jun 2026 12:19:38 +0200 (CEST)
Date: Fri, 19 Jun 2026 12:19:38 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Pedro Falcato <pfalcato@suse.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <christian@brauner.io>,
	linux-fsdevel@vger.kernel.org
Message-ID: <2099505714.2289513.1781864378114@kpc.webmail.kpnmail.nl>
In-Reply-To: <ajUSQ30oi-fyh0NH@pedro-suse.lan>
References: <20260618211822.3599089-1-willy@infradead.org>
 <ajUIMvi5Nyjp6t2v@lt-jori.localdomain> <ajUSQ30oi-fyh0NH@pedro-suse.lan>
Subject: Re: [PATCH] efs: Remove EFS
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


> Op 19-06-2026 12:06 CEST schreef Pedro Falcato <pfalcato@suse.de>:
> 
>  
> On Fri, Jun 19, 2026 at 11:28:03AM +0200, Jori Koolstra wrote:
> > This seems like a good idea. A couple of thoughts: should this maybe be
> > CC-ed to Linus? He has in the past been critical of removing old
> > filesystems. There is also something arbitrary about removing efs, but
> > not minix for instance. It would be great if we had some more objective
> 
> I'm fairly sure minix is staying for the same reason alpha is staying[1]. I
> don't think it's productive to unearth that particular debate at this
> moment.

I wasn't around back then, but why was ReiserFS removed? I'm just curious about
to what degree the arguments used back then apply to all kinda-maintained-but-not-really
filesystems. jfs is totally unmaintained, despite its MAINTAINERS file entry. And
David has said multiple times he would rather get rid of it.

> 
> > criteria for removal. I have also been thinking whether there is some
> > use to keep at least one old simple filesystem maintained and up to date
> > with modern API. It could function as a reference.
> 
> We already have one - it's fs/ext2.
> (modern API? maybe not so much. still has buffer heads, uses mpage, etc.
> alas.)

When I wrote this I was also thinking about ext2, but it is significantly
more code. Still, I think you're right. I have a special attachment to fs/minix
because it was the first kernel code that I studied in detail :)

> 
> [1] or that our old simple reference filesystem is ext2 and not e.g fat[2] :)
> [2] i may or may not feel sick after suggesting that
> -- 
> Pedro
