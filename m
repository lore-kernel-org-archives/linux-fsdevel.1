Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE245389118
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Oct 2026 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792253415; cv=none; b=MmB9o3mZsBw+OUh/dr2Evf+SlLchl9fv0iVUgqRkHUJ7pjAOHoaIoyioZcaErXHpkGwwSbZFTgp5ZNIkW8gjbWVDg68z3y1Jh+bMFvDZ9BZsHd9gvGCBpCrZRazRNF+0pIjHlTuGoxZSpDLgNw+JVb8AcGL0aRRx4lo4MeMugUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792253415; c=relaxed/simple;
	bh=CBJIMtV+q8fJ/U/jmSoMIwuQ7z8eMt8j3oy5XGf/Uj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgQApV/ndeS9NtBVByHPuJoZo5EdH2N3STZBFRcpM5OwVsfcKsIhaNXZ5auSDh5Yd0u6/Pba+UlpQ7Tppqq4hOsQg8hHEdxc6b2XDyGlt1I6mqKJTly8D0/6w4TD0tzfmnmNGfJDLG0gj3RaGO6T5smTtHVBdta1oKdpq0iuhiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MJs17Xvv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJs17Xvv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792253412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CBJIMtV+q8fJ/U/jmSoMIwuQ7z8eMt8j3oy5XGf/Uj0=;
	b=MJs17Xvv+TV/j2+UjT5t32AysZWPlp1BJhflv9rCrxuRF+d905vbJrC+3+nJAP18RK3zD8
	g/sMNIpfHiGZwHR7MBuFg4b6VwkM8GN4PcyMB0O9P0BEOzp/OpQmFnsxYTNcraBdnpjQ1i
	+7QFudguGXJXqKb1ujzF/gXYljfiUls=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-xh8a3FtMObiu6ianXQtmGg-1; Sat,
 17 Oct 2026 16:10:08 +0000
X-MC-Unique: xh8a3FtMObiu6ianXQtmGg-1
X-Mimecast-MFC-AGG-ID: xh8a3FtMObiu6ianXQtmGg_1792253407
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D2661956042;
	Sat, 17 Oct 2026 16:10:06 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 595BE195608A;
	Sat, 17 Oct 2026 16:10:03 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Sat, 17 Oct 2026 18:10:06 +0200 (CEST)
Date: Sat, 17 Oct 2026 18:10:02 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Cc: alex.aring@gmail.com, jack@suse.cz, viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] add pid::tasks_lock to fix send_sigio() and
 send_sigurg()
Message-ID: <atOd2kfmyDJEf66f@redhat.com>
References: <atOY-5ZjqVTQw2JE@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atOY-5ZjqVTQw2JE@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 10/17, Oleg Nesterov wrote:
>
> Not for inclusion yet, just RFC. In particular, I'd like to have
> a review from sashiko, I am sure I missed something ;)

https://sashiko.dev/#/patchset/atOY-5ZjqVTQw2JE%40redhat.com

Indeed I missed something obvious. I forgot that attach_pid() is called
under siglock. So this change needs more work.

Thanks Sashiko.

Oleg.

