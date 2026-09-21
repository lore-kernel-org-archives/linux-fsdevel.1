Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F3D4A7C95
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 14:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000145; cv=none; b=u5rNsjdty43N15MojjT8BOo0EXsl5BJMrlX+7Qy1/xw5ZJ85rEQXLv5Q+JmfwDDhn9OSo71GM8G8qxq4TOLF8yj+5WJqguir2K0mZgVBfOoU/ZT4Tyym+r6eCGh1gAn51PJ+W3TmD+wMIAsSfx2DKccUY3e8G/23tX3Y3pRp9E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000145; c=relaxed/simple;
	bh=He3JUgJDhPmHquTyYpRnLK1Iq8NSorYwIL+s1QGdGOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjJmy96PwQFexm7QC/kEqwH9pn7I+ZhcNIm8Oe/h00Gbho0sQHw/9QIXuqd0bnUnyzl6bj5vzf6joKbus19BG5TLcZxA2QjCiKYTqcUk3QMe7ApmveyWdCpRDDCbka42pTI64N3vHeD3dzZp6M9h6yQJwGfhxqlWIr5uwEBA89Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I0bW4cWv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I0bW4cWv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790000141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xCfJQWWrymkpBCCuzcDQp38cBUvHqaHF57c7ldLBjfY=;
	b=I0bW4cWvc8yGLnji3k2dV/2Z2/mCQgfoOeQiozODs5w396y5GpRGGk8R0dd7gepZzdU9Kp
	kHkMzvOje4lfjkY8ccKkGotmAXi6KWn/tpK/GUgvdOwpHNH1cRMRZKZ7Zxn6XrrRYcayEh
	TcmNAGuqQc2OWWI3w3mpG62vcKz3pgU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-nnOlowmtPSWcbtsMAlShDA-1; Mon,
 21 Sep 2026 10:15:36 -0400
X-MC-Unique: nnOlowmtPSWcbtsMAlShDA-1
X-Mimecast-MFC-AGG-ID: nnOlowmtPSWcbtsMAlShDA_1790000133
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C60D180061E;
	Mon, 21 Sep 2026 14:15:33 +0000 (UTC)
Received: from fedora (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1FB2A180034F;
	Mon, 21 Sep 2026 14:15:29 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 21 Sep 2026 16:15:33 +0200 (CEST)
Date: Mon, 21 Sep 2026 16:15:28 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Chris Mason <mason@kernel.org>, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
	io-uring@vger.kernel.org
Subject: Re: [PATCH v3 13/17] fork: move the coredump and exec checks into
 create_io_thread()
Message-ID: <arE8AJIB6UeDUV8n@redhat.com>
References: <20260921-work-coredump-fixes-v3-0-8e4adb1619e6@kernel.org>
 <20260921-work-coredump-fixes-v3-13-8e4adb1619e6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-work-coredump-fixes-v3-13-8e4adb1619e6@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 09/21, Christian Brauner wrote:
>
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2706,6 +2706,10 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
>  		.user_worker	= 1,
>  	};
>  
> +	/* A creator past its fatal signal gets no thread. */
> +	if (current->flags & PF_SIGNALED)
> +		return ERR_PTR(-EINTR);

Acked-by: Oleg Nesterov <oleg@redhat.com>

