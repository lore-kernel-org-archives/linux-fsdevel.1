Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B3A397E98
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 11:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774266467; cv=none; b=oL9OhYVyGEekGGIz9r4/NZ9U8SH7sAeicpI4SeJDyp4lQhtprbV9rDPOWhYyKwIWcl/4eH18Jb4W552k9dbpINhbmnVC8AzS3WilTPfNyj8ivMge/PKZzkYHVeIrim4ih3+SRV6Dv90w00e21T0a6CLb70C5Qz+qdbLUqSj9eYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774266467; c=relaxed/simple;
	bh=E8XsWkoRWM/wfljSkl3O9VPrjp8dDAjtkEmj3fkWt50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdcyaZFwyiFFpYiFmQug7eOYCQ7GseZmabWE0691yOo19oFs0UF6w0nwxaBtykNCzFGgaQQ7Z238zQq0FpUjw+r0KMa0dbnwcyNebnOKs3QZBjl0laaxMnTYaNA+V0jcUINhRvGNLmPDvFydecYNCTsnFuoG2h0seKfC3sSsv/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z5/eCwGo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5/eCwGo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774266465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E8XsWkoRWM/wfljSkl3O9VPrjp8dDAjtkEmj3fkWt50=;
	b=Z5/eCwGorWAkHFbChKif7hPpF6M9KM6ik+E8Qojmyyx0orRndXDZTEg8Rn2psAa7sq4BlB
	qXxNkrK4IKyrwc5eZaIPb4jCphrGaWnw/BvjmZBqFyJFlq+2hBkXVhrRzkuLVMKFmo/hAz
	Aa/eBu7kn+WnBHGP+oQ8f8Giqglj/t8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-IYJJ8AwXOEanSgjsUPT0jA-1; Mon,
 23 Mar 2026 07:47:40 -0400
X-MC-Unique: IYJJ8AwXOEanSgjsUPT0jA-1
X-Mimecast-MFC-AGG-ID: IYJJ8AwXOEanSgjsUPT0jA_1774266459
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A212118005BA;
	Mon, 23 Mar 2026 11:47:38 +0000 (UTC)
Received: from fedora (unknown [10.44.32.25])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 67324300019F;
	Mon, 23 Mar 2026 11:47:35 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 23 Mar 2026 12:47:38 +0100 (CET)
Date: Mon, 23 Mar 2026 12:47:33 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Emanuele Rocca <emanuele.rocca@arm.com>
Cc: linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH v3] pidfds: add coredump_code field to pidfd_info
Message-ID: <acEoVeBaP7bQRHLT@redhat.com>
References: <acBRj-DSCpqlKt6t@NH27D9T0LF>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acBRj-DSCpqlKt6t@NH27D9T0LF>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 03/22, Emanuele Rocca wrote:
>
> The struct pidfd_info currently exposes in a field called coredump_signal the
> signal number (si_signo) that triggered the dump (for example, 11 for SIGSEGV).
> However, it is also valuable to understand the reason why that signal was sent.
> This additional context is provided by the signal code (si_code), such as 2 for
> SEGV_ACCERR.
>
> Add a new field to struct pidfd_info called coredump_code with the value of
> si_code for the benefit of sysadmins who pipe core dumps to user-space programs
> for later analysis.

FWIW, the changes in pidfs.c and pidfd.h look good to me.

Acked-by: Oleg Nesterov <oleg@redhat.com>

