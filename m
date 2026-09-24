Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B7547DFA9
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 12:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790251874; cv=none; b=jAYMlCxJ+ex8CJ+UC/6G/l49R8KJLF/wyE6DiWuug9/Th+qtTdQcrQ6j22q8rjrxPeRDG9D0A0+A5lTy+JVaMnHuk13WZCGPOSQj9ptKKgjwDXrSlA+f87rYQqlPAmmO4jJ0bt/HdYOzNTHMDOr9X/Gfl8c+Cj3xydENaAZke08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790251874; c=relaxed/simple;
	bh=g5CtYMn7BUdq9EjtrwVG1R151TfCfskjR7kt/iRI+xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aj/g0zx9IbPEFjM2kAtwouLhGXsf2qkWophizdKKadbnaE8afKuGW0aZKX+r+GrX6SX8G0QTAbkHOp3k++zXqvuWxGPGkSkSRzq23h/a9VK7a/gD6rX3esYpolgifEO5vLmuIY++xHoYjWNn0W5ZnguTnKBsdy/AgSyCouLAY4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JhQzEFhQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JhQzEFhQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790251870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JDrK6jWmSv04P1PCELJaUCtzX+TaKcO7dGIXMzIhumY=;
	b=JhQzEFhQOXnZLtvmEExSrC9c47KB66vMj5GKnbrbknMxQWAiyUlDkGbwXDPJZV2cmz+H8n
	lH9osGhQzDHRsbolwGwQeXrvHZ82+kt5HtbykDdUo2VkLJKOMde7Osd/Ijq7fkQildb6dO
	zbibCEpZ7OhPFNqKqa+/wNKix8J6IK8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-5BP1BdFpOxKT_Wmpq3Yv0g-1; Thu,
 24 Sep 2026 08:11:07 -0400
X-MC-Unique: 5BP1BdFpOxKT_Wmpq3Yv0g-1
X-Mimecast-MFC-AGG-ID: 5BP1BdFpOxKT_Wmpq3Yv0g_1790251865
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1B8C1801317;
	Thu, 24 Sep 2026 12:11:04 +0000 (UTC)
Received: from fedora (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B2EC31956054;
	Thu, 24 Sep 2026 12:11:00 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 24 Sep 2026 14:11:04 +0200 (CEST)
Date: Thu, 24 Sep 2026 14:10:59 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Chris Mason <mason@kernel.org>, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
	io-uring@vger.kernel.org
Subject: Re: [PATCH v3 08/17] exit: hang up the tty before closing the files
Message-ID: <arUTU8oO1pce4bd-@redhat.com>
References: <20260921-work-coredump-fixes-v3-0-8e4adb1619e6@kernel.org>
 <20260921-work-coredump-fixes-v3-8-8e4adb1619e6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-work-coredump-fixes-v3-8-8e4adb1619e6@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 09/21, Christian Brauner wrote:
>
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -1003,10 +1003,11 @@ void __noreturn do_exit(long code)
>
>  	exit_sem(tsk);
>  	exit_shm(tsk);
> -	exit_files(tsk);
> -	exit_fs(tsk);
> +	/* Hang the tty up before the last close of it can clear the session. */
>  	if (group_dead)
>  		disassociate_ctty(1);
> +	exit_files(tsk);
> +	exit_fs(tsk);

Acked-by: Oleg Nesterov <oleg@redhat.com>

