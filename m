Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493455;
	b=311V6n7qIYOHNfC44ks8yFT05rHi8bJ3pi6KFPcD83nr2PFLTwWV9YF08OrwJlXzADr6
	 GSeALuA638XdgSelB7as03E9KPoJkgDk0N3qDbYXGMbCwT4vkmCu1puMbebHj/tiiYLVD
	 oci5y7CFNhDJbjt5hc/pwFiBOEt598H7sZuX+zlgCpHEYDootkknURYV0jr3fC2XTuf2V
	 3XBw48qIJgrXOySkEk0mh6rx7VGfR0uBgXLRh5WDWkcPeqZYa5IKf5ecVMW2CrEXYA6v8
	 ZsYA/uvDC1D0g02S2fIS8pOUQhkmvlAefWgeTK8qg2TAd8xvPKe2q0IXxuLs4p0h6ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493455;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Scanned-By;
	bh=JANbW0OsMsiIZhYIihCc20hPsaNmoKXg98JEd0I6bjw=;
	b=IfTFl4TV90JcrO1Ev94GUhN6F7kEQy65LGau9iWnqZH6hTxA4g50ayjx+WHu0h2qWcem
	 Fs6M07XqKZT3Dd6bo0Px7lIr+iD7ywKFK/Ko44Whm23XTbsO65WJCPgPxIsnn46PonF2i
	 YAWOwe6YUF468M/gz3cy0ptbtDnl2k3tR3GcTW9jooihBz3xHcx3Qjk8ex+G/ICTJk2VA
	 4F1K9tGk33cw6r0cb8qe8sl6v80VC+wUGOzxYeXdliOu0x0a3mP8AnFfANwGW/7I3effP
	 eajlsHb12PkTC6F3kQGMJ4d/Om03dgI8tTPFyKtm+fwjxP65mwfPC0r3uxMJVVsqK5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="I/eySZnY";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBB1606A331
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 10:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FBB1606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I/eySZnY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JANbW0OsMsiIZhYIihCc20hPsaNmoKXg98JEd0I6bjw=;
	b=I/eySZnYhvSK4q3f9XD0XqVpk1V2XNc4RIsTPxqWkPAc4lxMZ0if7tZsrnbjBE86m+ggkK
	Eu2TsTVrOftqASVeCDKIKRkbub8fCNnE4Vn/vOIfsogKQQkhJT0O4X46q4okKfd8Xa4xY6
	Igi63C/m71hRg8sDjq7fnPPdkLN8UC8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-d1ZaYW2ONtaZUUzoThD6KQ-1; Tue,
 20 Oct 2026 10:50:50 +0000
X-MC-Unique: d1ZaYW2ONtaZUUzoThD6KQ-1
X-Mimecast-MFC-AGG-ID: d1ZaYW2ONtaZUUzoThD6KQ_1792493449
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 513181800655;
	Tue, 20 Oct 2026 10:50:49 +0000 (UTC)
Received: from bfoster (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CEF391956088;
	Tue, 20 Oct 2026 10:50:47 +0000 (UTC)
Date: Tue, 20 Oct 2026 06:50:45 -0400
From: Brian Foster <bfoster@redhat.com>
To: Nickolai Zeldovich <nickolai@csail.mit.edu>
Cc: Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm/truncate: fix the zeroing end of
 pagecache_isize_extended()
Message-ID: <atdHhW7JU8j5pozl@bfoster>
References: <20261016222721.791785-1-nickolai@csail.mit.edu>
 <atZw_gtMIIKXgc1q@bfoster>
 <CADGQE7H91ZwPgUzPHoAJmF3WjzRKxeQkQcV8+BLdGn7+kkEduA@mail.gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADGQE7H91ZwPgUzPHoAJmF3WjzRKxeQkQcV8+BLdGn7+kkEduA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Oct 19, 2026 at 03:54:14PM -0400, Nickolai Zeldovich wrote:
> On Mon, Oct 19, 2026 at 3:35 PM Brian Foster <bfoster@redhat.com> wrote:
> > > --- a/mm/truncate.c
> > > +++ b/mm/truncate.c
> > > @@ -878,8 +878,7 @@ void pagecache_isize_extended(struct inode *inode, loff_t from, loff_t to)
> > >               unsigned int offset, end;
> > >
> > >               offset = from - folio_pos(folio);
> > > -             end = min_t(unsigned int, to - folio_pos(folio),
> > > -                         folio_size(folio));
> > > +             end = min_t(loff_t, to - folio_pos(folio), folio_size(folio));
> >
> > Good catch...
> >
> > folio_size() returns size_t and folio_zero_segment() expects size_t for
> > the offset params. Perhaps we should that instead of loff_t?
> 
> size_t is (unsigned int) on 32-bit machines, like i386, which has the
> same issue (reproducer from the patch).
> 

Ah, Ok. So loff_t makes sense for the min_t(). I do still wonder if it
makes sense to switch offset and end to size_t while we're here though.

Brian

