Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C29509EEC
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 15:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745328; cv=none; b=TCJQJOdGlyptcVHbUyFu8eY5toONeUBhqYqm8K53I2FXfZdv3W/0DdQVCROIHoIubZl+JTZzuY29tM8RIzPXZ+ewpTRKDav/tXGv4duY8vNFNXH9h5hte31idVSsQq5BScG8D4XhsN6qB6P+riymHvJQbPyPK/3PF/LBCIz5ZuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745328; c=relaxed/simple;
	bh=8ILAL3bayvoxsTKdCfsUP+/fgfT9t+6NzeYaooULTAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdSJRvBns5U1mlwW0pOmMF6b7Gglc9Hdr3uv6AwCriH4b0NibA/+WpMX1Y7vvzIt/9n+fDJf6/d5u7VmcINtEBc7b4PEnwKs8oP0+ZX9rz7NbPKHAZYPK7eIObwFURP8Xi7hnYa363ZJAOOLAHDc0ScOooWxgFuw7OvBBv59Qik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H7jsBmCY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H7jsBmCY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789745326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KTa5dNBMtLMbqJuICHOdAxEdGAM6oHsJ+w/pWPbR580=;
	b=H7jsBmCYsZDzJZUEUCyAXJjo97/VOLULuOAgQVWvyZNZo3rzIGHyzqc0YDEaLJAi8ochVn
	ZitbUEQRwjh0r16gZb4nfYHuJPuvOiFCGkGsO7xaRV7h95cx386sclB/BQx5sX7Q+kH8I3
	pw3bPhiYn4giHO1Qd014yyRAjeoUdx8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-oVWIackBOVqwZoBNA5lM6g-1; Fri,
 18 Sep 2026 11:28:44 -0400
X-MC-Unique: oVWIackBOVqwZoBNA5lM6g-1
X-Mimecast-MFC-AGG-ID: oVWIackBOVqwZoBNA5lM6g_1789745322
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6884E1935DF7;
	Fri, 18 Sep 2026 15:28:41 +0000 (UTC)
Received: from fedora (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1ADB130001A2;
	Fri, 18 Sep 2026 15:28:37 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 18 Sep 2026 17:28:41 +0200 (CEST)
Date: Fri, 18 Sep 2026 17:28:36 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
	io-uring@vger.kernel.org
Subject: Re: [PATCH v2 4/7] coredump: parse a snapshot of core_pattern
Message-ID: <aq1YpFX4ZNsgWbfR@redhat.com>
References: <20260917-work-coredump-fixes-v2-0-f3787fcda051@kernel.org>
 <20260917-work-coredump-fixes-v2-4-f3787fcda051@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-work-coredump-fixes-v2-4-f3787fcda051@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 09/17, Christian Brauner wrote:

> +	/* Publish the validated pattern whole. */
> +	scoped_guard(spinlock, &core_pattern_lock) {
> +		changed = strncmp(pattern, core_pattern, CORENAME_MAX_SIZE);
> +		strscpy(core_pattern, pattern);

Perhaps
		if (changed)
			strscpy(core_pattern, pattern);

will look more consistent... but this is purely cosmetic.

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

