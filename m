Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795777190;
	b=Ux0SN0aUyxdNUnNcfr+VluXrpBxw7UJ1RFXCaXAHU1ku37O3wYBcZ1V2BFhE6mJj7hxB
	 zsmIKzFj9xHBys5amQPUWuwg77nT+vwLACZh1JqR29Oe92js1f6Orpm9gpIpBtBEi229T
	 neV0HHofx18RkPeuZ+lBN+P9UIHmQLOBwRLmoYm4Yut5Bvr3FOG9g7j5fLpnk1bWOU7N8
	 yo8FB2VfW5Q4cWepwBqDIpX+ULUQW57YUEHEPvlUsd9mpjYZBg05Wc87zmVBUMfeWS995
	 9KDAoRKExulDE7qpJUL3Xph2m9dULtRKW+oZ45Z7Bny1My2FjyhPBmFnyRnU4gWWg3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795777190;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=eDmbQxvOAV6AoLiIpCNO1W0wBoR3l1azQOV++NzOhOg=;
	b=V5v4hJ+c5glxMyIzblBcC206jJZM8l03w/tr+V7nB7lMcLxPtWqEtOiw/l2h0HgxQ1qI
	 rcATsDa7qMgzwVAehcccOIIAzA6Jlpvs7oIZVhkyRY2rBxI1DhQ+yQebeZPpP17/flOf1
	 UQYryPAowsc/qit4DWNDb5beWIr2AGaip5Z8SLpPEIAk5D945000y7mHZwJNrxCDBLSit
	 p4NZcyySDe58WDvOA7aISfr6cGxRg7sOoqFH7Y3oObqOg5KJ4ZwiI53Qz6BlaZIou2R4R
	 UnDvcKq2vClnIiD/+ODGztOqjIDCttglT2wBzIaCbXDVtsnHA369ICiXSOSxv6UZxeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fbARPRoI;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99CE606A31C
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 10:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B99CE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fbARPRoI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795777188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eDmbQxvOAV6AoLiIpCNO1W0wBoR3l1azQOV++NzOhOg=;
	b=fbARPRoIaVRTBDstDaS/FIoukjSSxgNchdj0BP3ocBq4kUK69EVRod8mkNgAEyS6PSdFAk
	Du2l/aRP61vyTa+P05rF/82MMWNesA17mkUnWc1tpkrbs1S0+dylPpLE1iMnwycn9o23j+
	/Qcb0kRbRm6TuibAbAO7xFkfmfHuQL8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-oodBcF41MqmwaMAc8hNtZQ-1; Fri,
 27 Nov 2026 10:59:42 +0000
X-MC-Unique: oodBcF41MqmwaMAc8hNtZQ-1
X-Mimecast-MFC-AGG-ID: oodBcF41MqmwaMAc8hNtZQ_1795777180
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 956741800548;
	Fri, 27 Nov 2026 10:59:40 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E9DBB30000D3;
	Fri, 27 Nov 2026 10:59:37 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Fri, 27 Nov 2026 11:59:40 +0100 (CET)
Date: Fri, 27 Nov 2026 11:59:36 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, adobriyan@gmail.com,
	jannh@google.com, jack@suse.cz, sforshee@kernel.org,
	me@black-desk.cn, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: also check the opener's capability for
 oom_score_adj and oom_adj
Message-ID: <awlimNsIKMMa6vN-@redhat.com>
References: <20261126045222.20770-1-dennylin0707@gmail.com>
 <awgPDmEbGpJsT_iS@redhat.com>
 <awhFQzXfWnDh1mKe@redhat.com>
 <CAGEkeHeWU1=HjMX=GETdRnWkr-xqTBZp7p8RDdtTiUVw3+qBfQ@mail.gmail.com>
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
In-Reply-To: <CAGEkeHeWU1=HjMX=GETdRnWkr-xqTBZp7p8RDdtTiUVw3+qBfQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 11/26, Hungyu Lin wrote:
>
> On Thu, Nov 26, 2026 at 03:42:11PM +0100, Oleg Nesterov wrote:
> > I just noticed that __set_oom_adj() has more CAP_SYS_RESOURCE checks below.
> >
> > Shouldn't we unify them or even factor out?
>
> The checks below only decide whether a successful write also sets
> oom_score_adj_min. The checks above already prevent a write through
> an fd opened without CAP_SYS_RESOURCE from lowering it, so I left
> them as they are.
>
> I can factor out the common check in the two rejection paths in a
> separate patch on top of this one if you like.

No, up to you, I don't really understand this code anyway,

Oleg.

