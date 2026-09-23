Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B603D953B
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 15:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177268; cv=none; b=Mow5+XtYx9nZ2PDi27uj7TTdzNEvdY6lIdKFw1Ek044J9TUH8gALNR6AbcCQyHxUPD0ttKHlTtPnIQnM3X546FbcDtNzUhDYccwxWBdtO8Yk/196vc/cf21164x/BPNWm8uE6Po17310Q8J60TbbzgcDDtXWewudOZ4OrPGAobw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177268; c=relaxed/simple;
	bh=cOFYizl3LhO/0Wpqi4ibs/gem3NAOtut/1a8ikWL0+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T59swbagFaeQNgfTGblsma8UDR9ZS/e7mRU6tTFBRQLeH528nChDgT3nlxPHTyKMLbgf5MHpcNRCF5rFGtz6TIjRRjH/j9HQ2OuDr5kkoIS6QEEHv3DpP7K4r2aofUZHuxl9jMb6zm/N+3PQ/cmMkppzxmEqtn0SMgYPs/8jtmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SHENUTdi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHENUTdi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790177260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YUBBpSWh5YYNvOXBnG9voP/RxvJ39i/2AhMo1OGJ9TI=;
	b=SHENUTdimqxlG7/xGXqIPRLK+/rjco0uZBrE4qw25c8+eVPXuUbEZOw/wEejzKi/BhYywO
	GQVTOvv7AZAZhZp8bN423erSlQkDRvwmV494yAR+PkQXBdVshGAUJrLJWnH5RaJs4vYS3t
	FGJHjbMsbZKjwSDaUN9mtHWW0aJ4KfY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-8sBPeyH5NtO5mLIEhA5hXQ-1; Wed,
 23 Sep 2026 11:27:34 -0400
X-MC-Unique: 8sBPeyH5NtO5mLIEhA5hXQ-1
X-Mimecast-MFC-AGG-ID: 8sBPeyH5NtO5mLIEhA5hXQ_1790177253
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 12C08193E8DD;
	Wed, 23 Sep 2026 15:27:32 +0000 (UTC)
Received: from fedora (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E797D1956042;
	Wed, 23 Sep 2026 15:27:28 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 23 Sep 2026 17:27:31 +0200 (CEST)
Date: Wed, 23 Sep 2026 17:27:27 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: NeilBrown <neil@brown.name>, linux-fsdevel@vger.kernel.org,
	Jann Horn <jannh@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Xin Zhao <jackzxcui1989@163.com>, Mateusz Guzik <mjguzik@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	NeilBrown <neilb@ownmail.net>
Subject: Re: [PATCH RFC v4 10/18] coredump: drop core_state->dumper
Message-ID: <arPv3yGvnHleV-K8@redhat.com>
References: <20260910-work-coredump-unlock-self-v4-0-a5c1800dc930@kernel.org>
 <20260910-work-coredump-unlock-self-v4-10-a5c1800dc930@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910-work-coredump-unlock-self-v4-10-a5c1800dc930@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 09/10, Christian Brauner wrote:
>
> The core_state->dumper field isn't used anymore. Only its ->next pointer
> is. The current task is always the dumping thread and the ->task pointer
> is never read. Replace it with a plain pointer to the list of parked
> threads.

...

> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -1504,7 +1504,7 @@ static bool elf_fdpic_core_dump(struct coredump_params *cprm)
>  	if (!psinfo)
>  		goto end_coredump;
>
> -	for (ct = current->signal->core_state->dumper.next;
> +	for (ct = current->signal->core_state->tasks;
>  					ct; ct = ct->next) {

(purely cosmetic, but the extra line looks strange)

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

