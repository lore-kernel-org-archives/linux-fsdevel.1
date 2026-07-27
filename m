Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69056411F89
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 22:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785189606; cv=none; b=JgwpJe+u8vgSZLP7ulmvgESvf+iYMTd+8FpBEXVVtqc/wDDlWKGngxDNLmB3xRNt6FJwW5QrgJxN7v+gpIbsU7X0KU+GMwG0QNI4fflxybEIAAIFulPMokAfLtDSUj1Nv5cyAjavRQOGk+W9Ha4aUSNfJWjRvnhjjTueTRs72Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785189606; c=relaxed/simple;
	bh=b2W7tvFifpLuAIezdFVc8H0jlxVfNFDzTuTeRWQVjGk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=j9LjsynDgwOps6hcqW8xt2+Y1Wlab5FUzStA+1Sc86xeth6vHEDlAez0CpFx1goowqyuTKVHZIPlTegWV6Q9QVQeSmbQSpV5NEll2y5cXzrRf3Dl2MHnuyjfOa6YWpvBJlNBMhBoDpaj3WcUT3Zt0ImzISmBjpcEVPT+FTRsHrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=lKbExGJh; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="lKbExGJh"
X-KPN-MessageId: 7ff306a7-8a06-11f1-8f54-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.188])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 7ff306a7-8a06-11f1-8f54-005056992ed3;
	Mon, 27 Jul 2026 23:59:54 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 7ff1db31-8a06-11f1-9b10-00505699693e;
	Mon, 27 Jul 2026 23:59:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=5b1Pj744jRHl08iu9UDz0RrQPSYCcmKFTQpU/N/+qXs=;
	b=lKbExGJhsVp2Gqx308y8PwxfGNQL2g4qoNJlr/a+TgOfGrrfxenf5BqsqE937BfWdLNbW06mDS396
	 sp9X1xz4wv9wiAqYiuvdjNXMX7SwfDiJ3NyQkVssf1NDzJweAHhrT/7N6jF4bkYgJrSEiYm4Sc84Iv
	 rjAbrf7aOfdZfj/ByY95Q0+rJ05Z4Z6me4OyjrdsssJcltU2IbKK2eNgayqlbBx+qqdoRrypApL47J
	 V4axcuuW8UA3Q5C87HjtoarYX/revHGN7/kD5pejZzFtM6azxZgNKSGblTTfzQAF8IYYil95EN5+a1
	 ktHQR+5ZbeNpgzBz8joFFmZoQbh+Mpw==
X-KPN-MID: 33|vmUliEan/pcFr/Y98GkvwBkhIvosOUr8Q18N/e66VdgL+Okp2t+txLRwQR7dT2U
 uhIxnRC4tTfrSaej8NwhSmw==
X-CMASSUN: 33|WvdvQ8irtgqCVFz4LUZi6/rDNo+8O6KV6/fbqS416a7EaxD5D485BaN88PYu1Vo
 avW4/ZqDU7P0FMI1QyNQp4w==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh08 (cpxoxapps-mh08.personalcloud.so.kpn.org [10.128.135.214])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 7fe00657-8a06-11f1-916a-005056995d6c;
	Mon, 27 Jul 2026 23:59:54 +0200 (CEST)
Date: Mon, 27 Jul 2026 23:59:54 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Paul Moore <paul@paul-moore.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Eric Paris <eparis@redhat.com>
Cc: Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>,
	linux-fsdevel@vger.kernel.org, audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-ID: <1214391705.317168.1785189594499@kpc.webmail.kpnmail.nl>
In-Reply-To: <c2985096f8d2b03e0b1cca7006a71be9@paul-moore.com>
References: <20260710164233.827744-3-jkoolstra@xs4all.nl>
 <c2985096f8d2b03e0b1cca7006a71be9@paul-moore.com>
Subject: Re: [PATCH 2/3] vfs: call audit_inode_child() in lookup_open() on
 failure
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


> Op 24-07-2026 23:10 CEST schreef Paul Moore <paul@paul-moore.com>:
> 
>  
> On Jul 10, 2026 Jori Koolstra <jkoolstra@xs4all.nl> wrote:
> > 
> > audit_inode_child() is called in may_create_dentry() so that failed
> > filesystem operations still register an audit entry. On success, the
> > entry is overwritten when, for instance, fsnotify_create() is called.
> > This is the calling convention in vfs_create() and vfs_mkdir().
> > In lookup_open(), however, when atomic_open() should have created a
> > file but didn't, no call to audit_inode_child() is made. The same is
> > true for the regular ->create() path.
> > 
> > Fix the calling of audit_inode_child() in lookup_open() to match the
> > vfs_create() path. For the ->atomic_open() filesystems this logic has
> > been pushed into atomic_open(). This function is also reordered a bit
> > to make the case distinction of the possible returns from
> > ->atomic_open() more explicit (i.e. finish_open() or finish_no_open()).
> > 
> > When retrying delegation breaking, audit_inode_child() could be called
> > more than once, but this is OK because those entries are reused.
> > 
> > Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> > ---
> >  fs/namei.c | 92 ++++++++++++++++++++++++++++++++----------------------
> >  1 file changed, 55 insertions(+), 37 deletions(-)
> 
> I didn't dig into the directory lease/delegation changes because there
> are better people on the To/CC line to comment on that, but the audit
> changes look good to me.  Thanks for working on this, help is always
> appreciated :)
> 
> Acked-by: Paul Moore (audit) <paul@paul-moore.com>
> 

Thanks for the review, Paul.

@Christian, will you take this up into the vfs tree or does this go through
audit?
