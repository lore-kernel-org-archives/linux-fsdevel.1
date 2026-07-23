Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D3D4D8D85
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 15:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784819449; cv=none; b=V+i027xHDgvUzIzW8pxtoU9lx+S7uMWyNRKT2yn4+WGRVWzSFVW5qamR0RQU6xvXZyya+7xr/GpgZ4N2ctjKOKNfEPi7fHnD10z3n3S7RmaZzy8acAi9vdtxt51S8TRzLx/4wGTw9pqTqR3ilFdl44DY9tlCYhcEq+Nuunpunk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784819449; c=relaxed/simple;
	bh=j2L5Y2364x9HbZqjg04HaiVqcTFo6/VqwZV4qYu1lsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKwrWTsC1oBnAU/ScS9PYuomkLGSaV6MqznAb31rJzhTs63/SrM6uHxEnevGELzM/dcmvegtvEl3kErQet/I0C1bDiX72XRj937FAX9ahPk9Ky8BFah1V0VKQLxp0lf2lz/sK8xKKaB5vAkBsAoWtbNTv6wrzFcxHOO2LH3jCF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G09M21SJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G09M21SJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784819437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7rAIkDElkv6CTIBkt4dAxAAEJYX+7wxVwooCFV3gCDc=;
	b=G09M21SJ4EF+PY6UhjrflYw9aZJBizT7br4RA/nuIPV0I3AwwjPHNH3AOdMIqqzTueCQ9a
	w1MkF5uwq+mFCm1synRpt151WBA1TLpEWgZvTgLIiIFYlNpnbHTxNZeSB0z2TvAqXHMWmR
	gtWabvIZUEOobl0179VyXaZ8mTacpxc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-NhL0uMv6MCmcn0UXjz7Elg-1; Thu,
 23 Jul 2026 11:10:35 -0400
X-MC-Unique: NhL0uMv6MCmcn0UXjz7Elg-1
X-Mimecast-MFC-AGG-ID: NhL0uMv6MCmcn0UXjz7Elg_1784819434
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B4D41956065;
	Thu, 23 Jul 2026 15:10:34 +0000 (UTC)
Received: from fedora (unknown [10.44.33.21])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 61972158B;
	Thu, 23 Jul 2026 15:10:31 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 23 Jul 2026 17:10:33 +0200 (CEST)
Date: Thu, 23 Jul 2026 17:10:29 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] pipe: only enable the extra wake_up(rd_wait) when
 epoll is actually used
Message-ID: <amIu5WWgTNkdvqIz@redhat.com>
References: <amIqfCo25rLtM2U0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amIqfCo25rLtM2U0@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

OK, sashiko has some concerns

	https://sashiko.dev/#/patchset/amIqmbbZx3NlzUsX%40redhat.com

As for READ_ONCE(), I agree, I just forgot to add them.

But so far I don't understand the note about io_uring...
I'll try to check later.

Anyway, I'd like to know your opinion.

On 07/23, Oleg Nesterov wrote:
>
> Breno, Christian, Mateusz,
>
> To be honest, I am not sure this change makes a lot of sense.
> But somehow the extra wakeup in anon_pipe_write() looks annoying to me.
>
> Can you take a look?
>
> Plus I'd like to know what sashiko.dev thinks.
>
> I have no idea how to test it wrt performance...
>
> Oleg.
> ---
>
>  fs/pipe.c                 | 23 +++++++++++++++++++----
>  include/linux/pipe_fs_i.h |  6 ++++--
>  2 files changed, 23 insertions(+), 6 deletions(-)

