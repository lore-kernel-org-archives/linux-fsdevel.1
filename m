Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BBE4D37BA
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 16:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792340724; cv=none; b=NojSaa7sEQ2NRN+/cHFzbU2iDYCm4n/FK34Yay1uw7TkumRdKQUVCwaKGuEYwi0iA4r0uIyMRbzbC4XOZv8ALyyz5FdwtbbisCnQMnGQHQS9WWtuB1RRkWZIz3sntaX5qwOUC7ntM4gKZ8UOIeylJa4jVo/aTIirDnRRypF0hbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792340724; c=relaxed/simple;
	bh=LVOU5EN0nNuE5SUEFfDRgCwZFML2wpcdMdaY84tmA7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJOLGEF6oEmxrpEJXW/pZMLyLU2vSqiHq2myrhxVgXBwGs+SVDLvN06zR1wyyRpGfVDbAaDmNMIz8XeSrnkGVRrmqn7O+lR9G2Bam86NAx4OFtqpzQDbqOimFYbaPHeOZ/BkfxOkZocmm9HRvwBo+DrNLJP9p/WwWb9lkuImQS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BlZwxIr2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BlZwxIr2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792340721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IzymMu6E66uKcf31alfKQY1FkHLHkmWyAc8j0DZ4tZY=;
	b=BlZwxIr2A3WdIR/udjWewlF6qC5PTVpezKIL6kDBUXEFed4Fw8cBXYNOfNouYwhJgaYFl8
	qnOf1w+P2uswOTF3YeIM1x4KqgC+csmsyyNjGCJq15XTDXkbBUYwvyOq8uALBzPIu+Ubr0
	rtDHiH22Yfzi3+f1rZe3yrLvTlY5fRg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-aAr_mqBBPm-jPG_96NKjYg-1; Sun,
 18 Oct 2026 16:25:17 +0000
X-MC-Unique: aAr_mqBBPm-jPG_96NKjYg-1
X-Mimecast-MFC-AGG-ID: aAr_mqBBPm-jPG_96NKjYg_1792340716
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 20BA81955EAC;
	Sun, 18 Oct 2026 16:25:16 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 30EEB30000E3;
	Sun, 18 Oct 2026 16:25:13 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Sun, 18 Oct 2026 18:25:15 +0200 (CEST)
Date: Sun, 18 Oct 2026 18:25:12 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: fujo <hooyan2024@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/pidfd: wait for POLLHUP before reading exit
 info
Message-ID: <atTy6LziL5fdGTkn@redhat.com>
References: <20261017054356.7874-1-hooyan2024@gmail.com>
 <179226499044.847.17334319321039510150@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179226499044.847.17334319321039510150@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 10/17, fujo wrote:
>
> @@ -799,7 +799,7 @@ TEST(autokill_pidfd_open_no_effect)
>
>  	/* Verify child is still alive by polling the clone3 pidfd. */
>  	pfd.fd = pidfd;
> -	pfd.events = POLLIN;
> +	pfd.events = POLLHUP;
>  	ret = poll(&pfd, 1, 0);
>  	ASSERT_EQ(ret, 0) {
>  		TH_LOG("Child died after closing pidfd_open fd — should still be alive");

This chunk doesn't look right, POLLIN makes more sense in this case.
Unless I am confused, this poll(timeout = 0) tries to verify that the
child does not exit and report POLLIN, with or without POLLHUP.

Oleg.

