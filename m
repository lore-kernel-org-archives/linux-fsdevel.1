Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABB03ADB92
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 14:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789741456; cv=none; b=A6/2lc2QN2BWxE6BxgLnpq7UYPTuAxitZi/1InJE5nq1jlRcnuS81BRCa8F+ZxADP5HABKimmfHHPF6Uk7gRkgeqrcqrz6mQ15AyUw1aGFGKrYMKcqAK1h3fRdAd6IR98f1SQhivVnpAvXKRT79OfZ/fqEOVNxan6o4aFDzxaJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789741456; c=relaxed/simple;
	bh=1H1osbXaC7JZx474r3JdopArxaI4SmiR3L4D7z0R4JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrT4SMAXFZ6SDUoFaB+ioRmEtw2tq8A3d6PkeA/AFpyWt7J4IcMDyEHyRFo25PCX0A4VBNKfGl0o63HK0Ch78GqrbxoxEF+qKyhuQGPwicioxUG/5NvZwBPOOyWJTSAJyITuYZjVsNtItyVO8rZH7mnIi1VVJLQtc+Wa8fxbB1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fi6FJ5BL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fi6FJ5BL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789741454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=COGJ2JvndcwpiY85nNJ0ortnJmNdGWOwG92Ky7RrAcw=;
	b=Fi6FJ5BL/3t1jXtWseT7SXTOCqEvyneSqAT/cijAWhQ0FIhJI8plAPBjuwoqEDQy628se+
	prBQjqF3rjiS0g7mau3pWbGi2owDSgODZ1SCdraF2+TTu1rMMyltXQlrsDFPF29iGtDS3h
	6u/5GZGgal5zsMK5xqDKzzSK8Qx6SgA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-_WEziOAXOlWM0WqjR88tKg-1; Fri,
 18 Sep 2026 10:24:12 -0400
X-MC-Unique: _WEziOAXOlWM0WqjR88tKg-1
X-Mimecast-MFC-AGG-ID: _WEziOAXOlWM0WqjR88tKg_1789741450
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 811BE188307C;
	Fri, 18 Sep 2026 14:24:09 +0000 (UTC)
Received: from fedora (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6FDD5195604D;
	Fri, 18 Sep 2026 14:24:05 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 18 Sep 2026 16:24:09 +0200 (CEST)
Date: Fri, 18 Sep 2026 16:24:04 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
	io-uring@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 6/7] signal: don't retarget shared signals in a dying
 thread group
Message-ID: <aq1JhBwfJKSKNNCU@redhat.com>
References: <20260917-work-coredump-fixes-v2-0-f3787fcda051@kernel.org>
 <20260917-work-coredump-fixes-v2-6-f3787fcda051@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-work-coredump-fixes-v2-6-f3787fcda051@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 09/17, Christian Brauner wrote:
>
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -3117,6 +3117,10 @@ static void retarget_shared_pending(struct task_struct *tsk, sigset_t *which)
>  	sigset_t retarget;
>  	struct task_struct *t;
>
> +	/* Nobody dequeues them in a dying group, see get_signal(). */
> +	if (tsk->signal->flags & SIGNAL_GROUP_EXIT)
> +		return;

Acked-by: Oleg Nesterov <oleg@redhat.com>

