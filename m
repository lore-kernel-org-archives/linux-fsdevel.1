Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440104;
	b=zLtHi/uGE+AFxAdbZoMWrhnVCnxlFvFLlZcklGjiEhGuRYYqFdLxjEZ7oVxPWUrlJOgu
	 r6EQ2rQTNB5PTeYDr1ZC7hN5kOj6ZIP5+yBNXKCYGOloKW4tf1ZLtec4n6+ymEkxxyf/m
	 FHS3qR2AlVKR/AgzXwFrPnCguRTuGDwYg/dszcNrkWkJooErEwkZTaahmVVzCxHVhm/WP
	 iGUX4NTNyJ98fE8n5a2xkcvRvhcROY91HugSSRVq/oBy4ad8lzP1VCz1vaQGEEeoN3T9t
	 MSD4aQEkyACmsIZoxyY0Cy4tvyRrDRoGfRqOuWfOylgh27ap48S+esSwjm3y4WZgOcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440104;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=/saIjk+/mSYq8iZPgFXOiIKZ5cwgIKJ/PXOQnMC6enM=;
	b=mNwxmGs9Aok75m/iAZxxuWbBTgXkJpbIhlJ1zQjZC7s5DjAL8yckY0RN7xFVw5WM5yHj
	 LZ7C5eKniv5N7Ilw++9Mt0sFlGLTSGw5stoDwJi4hJvJdQkzcVGZUPKM5dZE+tevaVnbY
	 1nsNz0BTBDMKEE2+DYUW0RyJrgu/1IGF3wm0Oyde+eplo8k0UFuwOvtjQic+lekx5W3h5
	 GayKKlWDuiHSWaCOJH43nD3JaAYxyWx6S1JMOSrCkGV5V/lVfi9oRigIwVdMcGW8Dtr6S
	 nxnPuQHbwfEHPRiLGvsdfAuLrDBDeTvPvax5G84KdL3RW2kX/wFIUg+EEQaaDrNsUAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vfh4mTKb;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1388606A31C
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 23:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1388606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vfh4mTKb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794440102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/saIjk+/mSYq8iZPgFXOiIKZ5cwgIKJ/PXOQnMC6enM=;
	b=Vfh4mTKb6Rdo0odmsBlJW780CKEnWzhzGTnkUOVwyNRRv/Y6hP7+AqFNdP7Nhs5lCZEfvB
	V4l4YQumXw2E3NFB/ttRnQrnfw/mtTBdKnTChnWnsLWzm01GMSEECvCcXUO1pr+19jqpCP
	D64tA1N6ApNXvcZJigoU6YKyYypGWJ4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-pXEQOR1MOveyCYTcvZquSA-1; Wed,
 11 Nov 2026 18:34:59 -0500
X-MC-Unique: pXEQOR1MOveyCYTcvZquSA-1
X-Mimecast-MFC-AGG-ID: pXEQOR1MOveyCYTcvZquSA_1794440097
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4670719560B5;
	Wed, 11 Nov 2026 23:34:57 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id BBD27410;
	Wed, 11 Nov 2026 23:34:54 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Thu, 12 Nov 2026 00:34:56 +0100 (CET)
Date: Thu, 12 Nov 2026 00:34:53 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	tz2294@columbia.edu, stable@vger.kernel.org,
	Mani Tofigh <mt4022@columbia.edu>
Subject: Re: [PATCH] pipe: keep per-write wakeups for EPOLLEXCLUSIVE consumers
Message-ID: <avT7nQs7zYseYtMw@redhat.com>
References: <20261111-pipe-epollexclusive-wakeup-v1-1-0af6283e9fda@columbia.edu>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111-pipe-epollexclusive-wakeup-v1-1-0af6283e9fda@columbia.edu>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 11/11, Mani Tofigh via B4 Relay wrote:
>
> From: Mani Tofigh <mt4022@columbia.edu>
>
> A task blocked in read() on a pipe can sleep while the pipe holds data,
> when an epoll(EPOLLEXCLUSIVE) watcher of the read end was added before
> it.  The watcher's entry on ->rd_wait is exclusive and sits ahead of the
> reader, so a write into an empty pipe wakes only the watcher.

I am already sleeping, but at first glance this is already wrong?

I mean, a WQ_FLAG_EXCLUSIVE waiter should not sit ahead of non-exclusive
waiter, no?

Oleg.

