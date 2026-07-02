Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F003F356770
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 08:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782982470; cv=none; b=s/ncQviD9b3keSHf8Vn9VxATJt/lyEY9kFZ5SjGa6RWMHCA2vjCp04zBEPhfCk24Wa4Wv/2zm3tgd+roIriQHo7HLV2xmwGyzYtBInHVCwpvfRFZ75N3rv0fuW8o5v16ptwNk6C6qR0qQlbMYCEJHnWcJgAA/OPuRlfrL5+0i48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782982470; c=relaxed/simple;
	bh=UDxb16AXt3qHrF1Q/moSGeEEuR0vyLr1TR/rBQvyznY=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=FS/hUvBPVmKPGkjiNzg/039KeEzN2FzZuOH3iPqvHn97QrmrBcJrZB0ob8pGobhQO+GGTK95KnScb1I3aSeEU0j8clm3p/QS5SbYSc/ylvv266wTXTE9ElImYfn/xQMD7/GzhtgPOk7G4p9EQbmb+mS5kkzeQlqjR6HPYSXfPHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JVSYs6JA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JVSYs6JA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782982468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7K/A5ilrlqJqkJotmMKVc7GnR26ahpXCs/t4+YctDV8=;
	b=JVSYs6JAC9BQdxKNEw+tLr/2KyALdeZSfxaiVdO9RuEU32WgUuxk10+GtqgOzr3f3UHpr8
	BcZzA1EHqhS/Bo+c5T5IiY4qym5Z18+5QLWvNb0CnNS2wi0iEj2ka8HKz0ol3LSJx0oE55
	r1MjUr4fdxbJ73lrZDpW16YpJhpO6Ac=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-tqbKJb-nM2ypf_ZEowTuJA-1; Thu,
 02 Jul 2026 04:54:25 -0400
X-MC-Unique: tqbKJb-nM2ypf_ZEowTuJA-1
X-Mimecast-MFC-AGG-ID: tqbKJb-nM2ypf_ZEowTuJA_1782982464
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 542AB1945CB5;
	Thu,  2 Jul 2026 08:54:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.159])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CFD9718007F3;
	Thu,  2 Jul 2026 08:54:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260702020350.3403907-2-neilb@ownmail.net>
References: <20260702020350.3403907-2-neilb@ownmail.net> <20260702020350.3403907-1-neilb@ownmail.net>
To: NeilBrown <neil@brown.name>
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] afs: use d_time instead of d_fsdata
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <139683.1782982460.1@warthog.procyon.org.uk>
Date: Thu, 02 Jul 2026 09:54:20 +0100
Message-ID: <139684.1782982460@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

NeilBrown <neilb@ownmail.net> wrote:

> afs uses ->d_fsdata to store version information for the parent
> directory.  ->d_time is arguably a better field to store this
> information as the version is like a time stamp, and ->d_time is an
> unsigned long, while ->d_fsdata is a void *.

It wasn't clear that ->d_time was available for private use by the filesystem.

> This will leave ->d_fsdata free for a different use ...  which
> admittedly is also not a void*, but is certainly not at all a time.

Are you going to use ->d_fsdata for something generic?

> Interestingly the value stored in ->d_time or d_fsdata is u64 which does
> not fit in "unsigned long" or "void *" on 32 bit hosts.  Maybe that
> doesn't matter.

I know.  I just have to hope that someone triggers revalidation on a dirent
before 4 billion changes have been made to the directory on a 32-bit machine.
I could use both d_time and d_fsdata on 32-bit, I suppose.  I really don't
want to allocate an 8-byte blob for each dentry.

Maybe I should switch to a single-bit flag and "invalidate" all the dentries
attached to a directory if I detect a jump in the directory's version number
due to a third-party modification (the version is monotonically incremented
for each modification committed).

I'm not sure how to do a mass invalidation without risking deadlock, though,
because I'd quite likely be starting from a random dirent in a directory and
then have to walk through all the other dirents of the directory.  I suppose I
could lock the directory (probably using dvnode->validate_lock) and then walk
through d_children.

David

