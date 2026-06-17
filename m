Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BDE3909AB
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 15:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781711128; cv=none; b=l2DglpxgnKyqCt2Dslqxxo16SCpRl3crrFnaFBd0D9kydsEwJdFp/3XXQowoUsWfOT4sYQsgEL8KXwwr9hboP3nUrPqic4XM3BjKYfoSCFUGvadqnVR/6MGoxWwY/mXzjmGmf7d4KPpl3EklVZh5wdtYo0lEygqUlGxgt2nqZl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781711128; c=relaxed/simple;
	bh=9R3Hhcnuf6VMO/UcfQ6Whdfy6m+JpQX1F6wD26z19Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvLGVVSgYfkuQCZ7xXxeHwZsvu9ZS9YMAShTdE/EH00yBFT5SW06NPgVMjEWENdSLqhstd8y9zEWoSzaBpt4yd/rd05gwhHU5sk/qwNSgpex/Q7F9iAimxkLEgBGwi1Ly0vH21yC+GPUtEdEX8sJQfNLiyjqpZYE1jIiBvhoj6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NV7i4iQB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NV7i4iQB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781711114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9R3Hhcnuf6VMO/UcfQ6Whdfy6m+JpQX1F6wD26z19Us=;
	b=NV7i4iQBVwxQTTnKa8ZxOoBB0FprzsyEoJF2EbMLfKXjabGTS3GnN4De2D57UrXhs2ecbY
	kHVxWlsmSNYkPKcnbONFM0erS71HMi+6TVmjYPrRZwyCS3DWrf50Efj2Un9GmDPUYg3QBC
	F9xRxa2vOaHwrG1Yg37Qs3AAVvIa6a4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-ZpeGR43oPau3MysE_WBgjQ-1; Wed,
 17 Jun 2026 11:45:12 -0400
X-MC-Unique: ZpeGR43oPau3MysE_WBgjQ-1
X-Mimecast-MFC-AGG-ID: ZpeGR43oPau3MysE_WBgjQ_1781711111
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A15531800BE7;
	Wed, 17 Jun 2026 15:45:10 +0000 (UTC)
Received: from fedora (unknown [10.44.33.75])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 35729180056E;
	Wed, 17 Jun 2026 15:45:04 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 17 Jun 2026 17:45:10 +0200 (CEST)
Date: Wed, 17 Jun 2026 17:45:03 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Breno Leitao <leitao@debian.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	shakeel.butt@linux.dev, jlayton@kernel.org, axboe@kernel.dk,
	kernel-team@meta.com
Subject: Re: [PATCH v3 0/2] fs/pipe: reduce pipe->mutex contention by
 pre-allocating outside the lock
Message-ID: <ajLA_zxsYyKISkwp@redhat.com>
References: <20260524-fix_pipe-v3-0-bb4a75d23a90@debian.org>
 <ajG2bmhu6j9UWvh4@localhost>
 <ajJgWBCFYwz9OIo3@redhat.com>
 <ajJ1Xi1p9UhQvILi@gmail.com>
 <CAGudoHEyDz-Tbj=CZFK5XMLuLyE8B17NumdFVLf6MTTekFgRRA@mail.gmail.com>
 <ajKxJM5k9U5L05AF@redhat.com>
 <ajKy5ghjlgyN4tFv@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajKy5ghjlgyN4tFv@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 06/17, Breno Leitao wrote:
>
> Hello Mateusz,
>
> On Wed, Jun 17, 2026 at 04:37:24PM +0200, Oleg Nesterov wrote:
> > On 06/17, Mateusz Guzik wrote:
> > >
> > > There are trivial touch ups which can be done by adding a bunch of
> > > predicts and inlining kill_fasync if someone can be bothered.
> >
> > I was thinking about another change, see below. It assumes that in the
> > likely case another writer won't steal the pages from ->tmp_page[]
> > before we take pipe->mutex.
>
> Do you think we could eventually eliminate the tmp_page[] array and
> consolidate everything into the prealloc pages? That would unify the two
> page pools currently used in the pipe write path.

Cough... When I saw the 1st version of your patches, my first thought was:
we need to unify prealloc and tmp_page[] somehow.

But nothing simple came to my mind ;)

Oleg.

