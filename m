Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78358490BEE
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818149; cv=none; b=TeQSsIV4eTtp29Xd8rqTW3Dj+jCmBBpm3CZUMB1QHvpdqsz0Qo31hpNLYxb0E08Af5TSqIlK2GAwcyCW4AHxDmHbfTr7iI9m9LhhHyN8z7g9+ybnCZR4jA2J95rViRvPuO/hHhKLSPevaLlDt0FgdIDM2OXm2o8ItF4V2AFlUGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818149; c=relaxed/simple;
	bh=AEH2va6iOCXqTJFNoLtai9BPvzPtP2b0LlMRaAMRVlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyRMauLovUxtKOylm+yuKcBjnZV9lm4NBNAOzElr2rz4y3GL5VgyreZ1AKNYyXzXBkNT6Vt1n2qiMLeQX1mEmkVyMsOKEoU7gg1ER7UlVo0uGzZgxHl55eUzMrDgccsXX9zSoq3XaxE3b+5oD9QTw68vxaONXzK9wJE5bA5+iQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aDl9ZDR8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aDl9ZDR8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791818147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AEH2va6iOCXqTJFNoLtai9BPvzPtP2b0LlMRaAMRVlM=;
	b=aDl9ZDR8eT3oM1xemoPNzWdi082N3ZeOMwMbpMGlxuErMeKOQoO12px9+/x6ZPwfqXPV47
	xDVYH60ecI+migAHP/wfpf6pHEytuZdLePRw+1+IhBiAtIKJTKd6tCdfmP3q7x4b5hCLpT
	FAHB/oygY6UPaAJI/4KbVUJQ+TzJo8M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-_9OIp1axOH-kjk9ybcme6g-1; Mon,
 12 Oct 2026 15:15:45 +0000
X-MC-Unique: _9OIp1axOH-kjk9ybcme6g-1
X-Mimecast-MFC-AGG-ID: _9OIp1axOH-kjk9ybcme6g_1791818144
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 689C3195FCEA;
	Mon, 12 Oct 2026 15:15:43 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 34D5E1956040;
	Mon, 12 Oct 2026 15:15:40 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Mon, 12 Oct 2026 17:15:43 +0200 (CEST)
Date: Mon, 12 Oct 2026 17:15:39 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: w15303746062@163.com, David Laight <david.laight.linux@gmail.com>,
	chuck.lever@oracle.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	alex.aring@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: Re: [PATCH v2] fs/fcntl: fix SOFTIRQ-unsafe lock order in fasync
 signaling
Message-ID: <asz5m2nR1PfOqTUN@redhat.com>
References: <d15a25fe784b5d4449c7ce4e56f1428d7ff28885.camel@kernel.org>
 <20260523135210.590928-1-w15303746062@163.com>
 <asI5Fn87_SoEd4G5@redhat.com>
 <asuxzwl4iWjjEjRD@redhat.com>
 <73b5a5174d98a3ae1dada32684e453debb8dfcd3.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73b5a5174d98a3ae1dada32684e453debb8dfcd3.camel@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 10/12, Jeff Layton wrote:
>
> We probably should
> revert this patch for now, until the problem and potential solution are
> more clear.

Agreed... I'll send the revert for now.

Hmm. The "if (type <= PIDTYPE_TGID)" case in send_sigio/send_sigurg looks
wrong too. send_sigio_to_task() -> ... -> lock_task_sighand() can fail if
we race with de_thread().

Oleg.

