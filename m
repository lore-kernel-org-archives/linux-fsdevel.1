Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F06B3CF041
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779785309; cv=none; b=oWszJ7/I3S/Sljt+LyLVZVXhqRV06EZFJBqNwT+eanES174Ej+8r83zgzNymrnUsvJ6KWz71CIZ1sNAXXhWulwujW3D1iBFIijGM2SUYm8NAP/mB9tSsH5q2x2kmoug8UDDEwARMbkcP75QrNk7da2BCbHN+V7MrAyAQSjoQKpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779785309; c=relaxed/simple;
	bh=e53dW1lgkBr21B4ubZXnT2Vq7AtiyRGtSeeKA6C628M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqLb0RgXpyphPYlAvgQUiKjw8f5/XZ9jnqoNFc9wL31R2CEoGGwGMz9CtjRLptfoBezuDRi3faNB1OUNASb3TOVIjSsiyPXi8MzkpBxkNhhOtFEAMAscfRTNwpfEXs2MoKUohBGebdifNL5s3dQgiA207Xds7w9OKYjtEVwo6fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dwESkcHp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dwESkcHp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779785307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e53dW1lgkBr21B4ubZXnT2Vq7AtiyRGtSeeKA6C628M=;
	b=dwESkcHplW888UEJjzaVRpzNC1vfNjsniW3quIb4VEtLP1vFbTje/vUv4A8RAAOaoNeRNW
	XDyrWpW5mCusnJ8Ok3vpNr8T0dPVbYQ6eF/1A3tmnfRL+I4V4q/QUJuSTL3xyt/T5dLomo
	+Udxu0VSe7qNijJX0qJrlgu+ozSVRxM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-XcDve9TPN2CGtz6hsLNwSw-1; Tue,
 26 May 2026 04:48:24 -0400
X-MC-Unique: XcDve9TPN2CGtz6hsLNwSw-1
X-Mimecast-MFC-AGG-ID: XcDve9TPN2CGtz6hsLNwSw_1779785302
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 576BA1956088;
	Tue, 26 May 2026 08:48:21 +0000 (UTC)
Received: from fedora (unknown [10.44.48.14])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3FEFA1684;
	Tue, 26 May 2026 08:48:16 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 26 May 2026 10:48:20 +0200 (CEST)
Date: Tue, 26 May 2026 10:48:15 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jann Horn <jannh@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Arjan van de Ven <arjan@linux.intel.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Jake Edge <jake@lwn.net>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/2] proc: protect ptrace_may_access() with
 exec_update_lock (part 1)
Message-ID: <ahVeT9TTxlJiW2Qu@redhat.com>
References: <20260518-procfs-lockfix-part1-v1-0-5c3d20e0ac33@google.com>
 <20260518-procfs-lockfix-part1-v1-1-5c3d20e0ac33@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518-procfs-lockfix-part1-v1-1-5c3d20e0ac33@google.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 05/18, Jann Horn wrote:
>
> Fix the easy cases where procfs currently calls ptrace_may_access() without
> exec_update_lock protection, where the fix is to simply add the extra lock
> or use mm_access():

I thought about this too, but I do not know if it is fine performance wise...

And what about proc_coredump_filter_write() which doesn't use ptrace_may_access() ?

AFAICS, we can't rely on the open-time checks. /proc/$pid/coredump_filter can
be opened for writing, the task can do suid exec after that, the file remains
writable.

Not a big deal, but still.

Oleg.

