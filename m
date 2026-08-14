Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A531A36B905
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 18:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786730630; cv=none; b=LHB3Yk3QPduV/ZaYF1BZfCjMxFWD7jiJ0fJCUe4jBk6fP22U3rKGWd5bvdHd45cVVg7hYqNcqo0f8A13ydkbCG9a9F9azE4Zd5nhllUk7q2Jb+b9PEyPpwvnRZESlaFZpnIbOvL6FNr7IWqmrt6kofHYWH5HqUzk8XNt2Pv5ppQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786730630; c=relaxed/simple;
	bh=MHcf0h1jdj+yq7jbMQVJMENFfR7ve4IWOyG1p7JDbEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUj7oevKs3HNgAChbMbnEWhSjkGHDnrvmApppRGIvhZL2Ri8aQTBDhl7Kg53QBPuPZ1VE9A6YTAY5Lwa9d3HEZLuzzAR7KburbPgtqSQ/KgLALzZIFNyMBLyD8LQGc/EhbtvqV5dOlt+AMguODukR0pkr9uqe4TUHin+JWOs+Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HtXZ8kq8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HtXZ8kq8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786730628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=edsu6JjTslrS34Fvloj+0+8/jlXFMGCx8PgXRPDwZjg=;
	b=HtXZ8kq80GSLVePsto7y9/PuycccqqZ62q8UUbp4tYnZSD5c+kRuGYgc1CDUtDqW7kDy7B
	iDVGJlqgqUeb8xIojPti0UvO5U4AcQed5M9dq15ghR0d7NBasJzGl+O3J5bs9LIwF2W91q
	Ak4mEJX5YewNuOaa/pY2/UWE9h1K3h4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-MroS2QNnPgSGJQeO6ZoXTg-1; Fri,
 14 Aug 2026 14:03:33 -0400
X-MC-Unique: MroS2QNnPgSGJQeO6ZoXTg-1
X-Mimecast-MFC-AGG-ID: MroS2QNnPgSGJQeO6ZoXTg_1786730609
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A8B8E18002F8;
	Fri, 14 Aug 2026 18:03:28 +0000 (UTC)
Received: from fedora (unknown [10.44.32.2])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A2453180034C;
	Fri, 14 Aug 2026 18:03:19 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 14 Aug 2026 20:03:28 +0200 (CEST)
Date: Fri, 14 Aug 2026 20:03:15 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: joel.granados@kernel.org, kees@kernel.org, brauner@kernel.org,
	mingo@redhat.com, peterz@infradead.org, akpm@linux-foundation.org,
	jack@suse.cz, avagin@gmail.com, ptikhomirov@virtuozzo.com,
	mjguzik@gmail.com, include@grrlz.net, ebiederm@xmission.com,
	legion@kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com, kys@microsoft.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] reboot: fix cad_pid use-after-free race
Message-ID: <an9YY8DzjiDLa2tr@redhat.com>
References: <20260814040944.16561-1-blbllhy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814040944.16561-1-blbllhy@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 08/14, Cen Zhang (Microsoft) wrote:
>
> v4:
>  - Rebase on sysctl-next after Oleg's cad_pid sysctl placement change.
>  - Fold the two-patch v3 series into a single lifetime fix.
>  - Move kill_cad_pid() implementation to kernel/signal.c.
>  - Export kill_cad_pid() and stop exporting the raw cad_pid pointer.
>  - Update proc_do_cad_pid() in kernel/reboot.c.
>  - Add explicit includes for the RCU API and kill_cad_pid().
>  - Preserve the original unprivileged impact context while noting that
>    the namespace permission path has been fixed separately.

I don't see other changes in this version, so

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

